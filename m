From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v3] git-completion.bash: add support for path completion
Date: Thu, 20 Dec 2012 00:43:25 +0100
Message-ID: <50D2511D.3020705@gmail.com>
References: <1355943496-5533-1-git-send-email-manlio.perillo@gmail.com> <7vzk1995mx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:51:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlTQ6-0003UL-6R
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 00:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab2LSXvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 18:51:08 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35930 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2LSXvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 18:51:07 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so1259648wge.22
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 15:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=VDmBKyOUlsqCu6yjvV2o0uY6tU3eq/IhLRuvfhJ51to=;
        b=SDy62PzQqO70dg3axcKJ97TAD20cw+y/71fOx+jjLWUn3uew18qXJYPk2tLSZEk9b6
         9++vTsQ7Rc4veMvHVapPVjPyWgoi0oaF05KXpBCuNfkmEItApReBEc1yvadPtfPB4gej
         Nj7R7k3rG9ayMS4wrlNuulY/jG/DYVDdxKhrNrnbSU2FK2Wfpqwf5RfZT2GkcReDCHI0
         vqq2q9VFZWNoz68YKOkMxZZqscQ1TH0Ab0DFudOxVDvbJjshyt9GSvsbnrwb3gY42rnc
         gQouaDCAut7zPrstk8oV4Vr7AuIljuUtHHacIJ62DmdSqB9hsZRCb4HfdPKPZMy8iAJl
         kOfg==
X-Received: by 10.194.235.100 with SMTP id ul4mr14561813wjc.7.1355960616747;
        Wed, 19 Dec 2012 15:43:36 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id t17sm10367936wiv.6.2012.12.19.15.43.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 15:43:36 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vzk1995mx.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211865>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 19/12/2012 20:57, Junio C Hamano ha scritto:
> [...]

I just found a serious bug with "git commit" path completion.

When doing the first commit on an empty repository, completion will
cause an error:

$git commit -m init <TAB>fatal: ambiguous argument 'HEAD': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

The problem is that for a newly created repository there is no HEAD.

If HEAD does not exists, code must use ls-files instead of diff-index
to get the completion list.

Another change is to always call git commands with stderr redirected to
/dev/null.


By the way, this is also a bug of current bash completion code:

    $ git show does-not-exists:<TAB>fatal: Not a valid object name
      does-not-exists

I will write a patch (based on master) to fix this.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDSUR0ACgkQscQJ24LbaUSkRwCfVKk9JhSD4sKDFm4heAkVbN0o
KAAAn3paTXyUiFlfY/UBpnkwiARegLsE
=7Q5s
-----END PGP SIGNATURE-----
