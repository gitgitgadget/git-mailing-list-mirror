From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 22:58:13 +0200
Message-ID: <AANLkTikSxpXJkeneWbJQ_2g32w1bV-CEdyk2_5G2Xd+u@mail.gmail.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 22:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hG8-0002xe-EC
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab0I1U6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 16:58:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43467 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab0I1U6e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 16:58:34 -0400
Received: by gxk9 with SMTP id 9so37668gxk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 13:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=CRJJh09RPiUeq8ppy5xrteKn3Cs6/AZ5JZ7xAX1FBt4=;
        b=XEKfu3xaC1cwuDQ6e+UZCtH1fXVYGR7OsKa39j5gaZ15zYAxfvcL44STNwRyWfiD7w
         Zy3/ltNa9QOrtmosVAFH8lQiPOm2IgFquyworoMaTwLMgtAnbiQ7Fj6niugpSJRldU2v
         BuNzaTSMXQmXFyyQ0vy/i80nGzi5ctszDnucg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=OIEpwzTE6go7rZ9oSg3bV/2s7RsQrWYEXHOCHx0dLGvzicQA3kSHLsDClwHn34KcS6
         /yVSr7WH10d9jYmRxRW3e3Vvt9pDo9txaeOUaVAxH9s8jbeZtHR5+rYLeg2mXn3mkG1E
         SlYq4dudZS5IPOeZ14QaxP/ycTQyn/KopzCf8=
Received: by 10.151.40.7 with SMTP id s7mr851331ybj.33.1285707513539; Tue, 28
 Sep 2010 13:58:33 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Tue, 28 Sep 2010 13:58:13 -0700 (PDT)
In-Reply-To: <201009282252.25688.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157471>

On Tue, Sep 28, 2010 at 10:52 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> =A0 =A0 =A0 mingw: do not crash on open(NULL, ...)
>
> This one is bogus, and as it stands, it must have my Ack removed. :) =
Needs the
> same fix in mingw_fopen as mingw_freopen. (There remains an unprotect=
ed
> dereference of filename.)
>

I believe the version in for-junio already has this fix squashed in.
The following hunk, taken from
http://repo.or.cz/w/git/mingw/4msysgit.git/blobdiff/4e93566b07dcf47ecb6=
484d225418c04c1eedee6..b18500977d88b13803ecc60cf383538139ec09d8:/compat=
/mingw.c
shows that it is... Or are you thinking of something else?

@@ -346,7 +346,7 @@ FILE *mingw_fopen (const char *filename, const char=
 *otype)
 	if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
 	basename((char*)filename)[0] =3D=3D '.')
 		hide =3D access(filename, F_OK);
-	if (!strcmp(filename, "/dev/null"))
+	if (filename && !strcmp(filename, "/dev/null"))
 		filename =3D "nul";
 	file =3D fopen(filename, otype);
 	if (file && hide && make_hidden(filename))
