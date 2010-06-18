From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Subject: Re: [PATCH] Fix 'git clean' failure on NFS.
Date: Fri, 18 Jun 2010 16:01:07 +0300
Message-ID: <4C1B6E13.1030309@gmail.com>
References: <loom.20100618T122039-876@post.gmane.org>	<1276859235-13534-1-git-send-email-edwintorok@gmail.com> <AANLkTimm1XMmDORpnezYHSNPrKFup2H5ODQLrgJivDwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	git <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 18 15:01:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPbCA-0007BH-AI
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 15:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761194Ab0FRNBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 09:01:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52144 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761190Ab0FRNBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 09:01:12 -0400
Received: by fxm10 with SMTP id 10so594161fxm.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=BRHfoRYdtd4IkQ4CvQHQym4idE088z3LWhUy6aBO3CI=;
        b=rPGJEzN9HGTI8FdYG/hTYsg4fjciIhPyD/kLnmV0KLO3JWrE9Xm+z7kUyDD0V3RGnA
         AS1nQ25EemSwRM1jwWoGgC+rgo5J2pHigyjeFu9DIQbMWNavMbbjmrmSHK3F7wg/H1pL
         G3ruW821y4Dr3jTuObj88PekstSaYWGctJLRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=O4C9TZefhX0GpFmn75FWeohzDo33ntzPHgNFZPrfuCeBeBjF5FRNMxi2X9OH0mThAQ
         3rJrbrdncGYhOGA+yU3TEq5RGQK/GvrZZzQFDM84di1JVjBEyNI52TrEup6xS37667gR
         EMCRsq+AYeIOnRy31KVHYasDlLE0ng8IyfUd8=
Received: by 10.223.56.27 with SMTP id w27mr860087fag.37.1276866070382;
        Fri, 18 Jun 2010 06:01:10 -0700 (PDT)
Received: from debian ([79.114.67.113])
        by mx.google.com with ESMTPS id k14sm17318689fav.24.2010.06.18.06.01.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 06:01:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by debian (Postfix) with ESMTP id 079F626D58;
	Fri, 18 Jun 2010 16:01:08 +0300 (EEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
In-Reply-To: <AANLkTimm1XMmDORpnezYHSNPrKFup2H5ODQLrgJivDwg@mail.gmail.com>
X-Enigmail-Version: 1.0.1
OpenPGP: id=5379965D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149344>

On 06/18/2010 03:29 PM, Erik Faye-Lund wrote:
> 2010/6/18 T=F6r=F6k Edwin <edwintorok@gmail.com>:
>> readdir() used to do a single pass, which is not always enough.
>> If you unlink some files/rmdir some subdirs then there might be some
>> files you haven't seen yet *before* the readdir cursor (files get re=
arranged
>> in the directory, etc.).
>>
>> The fix is to do an additional readdir() pass if we unlinked/rmdired=
 something.
>> This is easily accomplished by using rewinddir.
>>
>=20
> Won't this break on Windows? mingw_readdir() doesn't seem to have a
> maching mingw_rewinddir() in compat/mingw.c/h....
>=20

rewinddir() is used in ClamAV too, and it builds natively on win32.
I think we have some compat function that map rewinddir to the Win32
API, somebody will probably have to do that for git too.

Another possibility is to do closedir/opendir again on mingw.

Best regards,
--Edwin
