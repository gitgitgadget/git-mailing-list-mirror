From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 1/5] Introduce bulk-move detection in diffcore.
Date: Thu, 25 Nov 2010 09:02:18 -0600
Message-ID: <20101125150218.GA16049@burratino>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
 <1288303712-14662-2-git-send-email-ydirson@altern.org>
 <AANLkTi=Ekoe+RSrRFj63S___Vsa5kTsDKJVPamFsz0c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@free.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 16:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdLY-0000k7-4I
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 16:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab0KYPCa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 10:02:30 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39601 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0KYPC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 10:02:28 -0500
Received: by qwb7 with SMTP id 7so1050427qwb.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 07:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ti5zDeVvZJnw460Lsc82Fq2td/3x0IyEmpbBSd2GDPw=;
        b=HSDpv00XWLPa8ss29TPEHxFQTF/1KdbyXNuX56+sePXXT+wPl9soM9Tr/oY0M0lzQ3
         NwXVDW7DuZsfZ9kncw2HINkrVE3sHsxbb9Vyhz1DP499KjLSWnxg5f9vzz2PM52B0ELh
         Z+OJhpf/V/vbcMjvPuQS43phB4XurtdruU5g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F+MIt7xEPTC7G/9xFFns2eOGQbWpYlDA4MmAzO9bk1kxF97jKzOka6le0OmIlcp1AY
         8pWOncjUbdxj7vFU1v3O9gO/UZ+f+WqZd5OmYDdw5HKdvaMyT40dvjDY5CjBJ8f324NT
         6o1xMEyVxQeEy0uPwhF5IeV0CXiqqIRSbKels=
Received: by 10.224.204.134 with SMTP id fm6mr818236qab.325.1290697348247;
        Thu, 25 Nov 2010 07:02:28 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm503851qcb.15.2010.11.25.07.02.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 07:02:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Ekoe+RSrRFj63S___Vsa5kTsDKJVPamFsz0c2@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162134>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Oct 29, 2010 at 00:08, Yann Dirson <ydirson@altern.org> wrote=
:

>> + =C2=A0 =C2=A0 =C2=A0 slash =3D memrchr(src, '/', len);
>
> I can't compile pu now on Solaris due to this bit. Are you planning o=
n
> picking up the patch / configure / Makefile detection discussed in th=
e
> "[PATCH] compat: add memrchr()" thread? Just wondering what the
> progress was on that.

BTW, remember that the configure / Makefile detection is only an extra
nicety.  [1] teaches git to rely on the system memrchr on glibc
systems only; on other systems (unless they define memrchr as a macro,
which would be a strange thing to do), gitmemrchr is used.

Upshot: it should be safe to use [1] without the configure / Makefile
support.  Later, an interested person can write a patch for improved
memrchr[2] on *BSD and Plan 9.

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/159081/focus=
=3D159121
[2] Lower code size.  Maybe faster.
