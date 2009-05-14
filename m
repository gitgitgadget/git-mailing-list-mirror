From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Thu, 14 May 2009 09:57:30 -0400
Message-ID: <76718490905140657h4f4544fdrc5b9ce15ca36c8a5@mail.gmail.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
	 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
	 <alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de>
	 <200905130724.44634.robin.rosenberg@dewire.com>
	 <7viqk4z4cv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 15:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4bRT-00045m-Sc
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 15:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760672AbZENN5c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 09:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760833AbZENN5b
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 09:57:31 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:1913 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760941AbZENN5a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 09:57:30 -0400
Received: by yw-out-2324.google.com with SMTP id 5so722394ywb.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kDsAKPe69rPpyq7klwsNZ+bnwINXlpVMs+0kJzAK9Mc=;
        b=bx2/XtQ8TRPB+A9OksitJsRiuTvC7pRI7VK5lzfL1jn/cOKK3MChuwQyI7TMuDkqFL
         U7Pb4NmjnxkSd/x+o4lJNrua3U1UZmk25am56Asgw15DXLkp066k9zULaXEyj95KtV3S
         ZiIZ4yZV44Tb8vfwCmVAHgeUPqJR3MQpn09y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XVAt0ZzWWMFciYWHsD85saqP5k+uWvc0wt6GpYLiPWR6OeCulQjZBtYLrWGv4MsyqU
         G//IUKKbVmj0kwaOECYSEbkIdDdLZ/ltiYGku3CKQQo+vq86401nBFeiITXbS9K1SWCd
         Kujb4jXW0AY6kO+wytwJldDEccRc/Tg8wgMjs=
Received: by 10.150.211.7 with SMTP id j7mr3612562ybg.263.1242309450892; Thu, 
	14 May 2009 06:57:30 -0700 (PDT)
In-Reply-To: <7viqk4z4cv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119194>

On Thu, May 14, 2009 at 12:38 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> It is rather sad; I suspect that the core of the series is buried in =
too
> much cruft deep enough to discourage many potential reviewers. =C2=A0=
I think
> the entire series look incoherent because attacking two largely unrel=
ated
> things at once.
>
> =C2=A0(1) Normalizing pathnames internally to UTF-8 and possibly conv=
ert it
> =C2=A0 =C2=A0 back to native upon use (e.g. creat(), lstat(), unlink(=
)) and output.
> =C2=A0 =C2=A0 As Linus analyzed, this shouldn't be done too early in =
the callchain
> =C2=A0 =C2=A0 for performance reasons, but I think your patch would g=
ive us a good
> =C2=A0 =C2=A0 set of starting points to follow where the result from =
readdir(),
> =C2=A0 =C2=A0 user input and other things that are pathnames come fro=
m and go.
>
> =C2=A0 =C2=A0 This part of the patch series was inspiring. =C2=A0You =
have to worry about
> =C2=A0 =C2=A0 gitignore, gitattributes and readlink() vs contents of =
a blob object
> =C2=A0 =C2=A0 that records a symbolic link values, which I think eith=
er escaped
> =C2=A0 =C2=A0 analysis people have done so far or being ignored as a =
small detail,
> =C2=A0 =C2=A0 but they are important;
>
> =C2=A0(2) Passing cat-file output through iconv to convert it.
>
> =C2=A0 =C2=A0 I think this is unwarranted, even if the object given t=
o cat-file
> =C2=A0 =C2=A0 happens to be a commit or a tag object and you want to =
convert their
> =C2=A0 =C2=A0 messages in native encoding.
>
> =C2=A0 =C2=A0 I am not sure what should happen to "cat-file tree", "l=
s-files" and
> =C2=A0 =C2=A0 "ls-tree". =C2=A0The output from these plumbing does sh=
ow pathnames, but I
> =C2=A0 =C2=A0 tend to think it is Porcelain's job to turn them into w=
hatever
> =C2=A0 =C2=A0 encoding they want to use. =C2=A0So are input to "updat=
e-index --stdin",
> =C2=A0 =C2=A0 but I am still just thinking out loud.

I definitely do not have the time to work on unicode/utf-8/i18n
support for git right now, but as an OS X user, it is something that
interests me. When this topic periodically pops up, I squirrel away
the useful messages into my "someday" folder. So even though it may
seem that reviewing these patches is wasted effort, comments like the
above are helpful. I say this because I expect someday someone will
work on this topic, even if it is not me, and hopefully they can
locate prior discussion in the mailing list archives and as such it
will be of some use.

IOW, your comments are useful and appreciated, even if it doesn't lead
to improved patches right away.

j.
