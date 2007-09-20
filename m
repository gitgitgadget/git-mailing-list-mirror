From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/7] nfv?asprintf are broken without va_copy, workaround them.
Date: Thu, 20 Sep 2007 06:53:26 +0200
Message-ID: <200709200653.26490.chriscool@tuxfamily.org>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org> <1190241736-30449-3-git-send-email-madcoder@debian.org> <7vwsumkll8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 06:46:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYDvl-0002Pj-B2
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 06:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbXITEqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2007 00:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbXITEqT
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 00:46:19 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:32798 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXITEqT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Sep 2007 00:46:19 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A60A11AB2C5;
	Thu, 20 Sep 2007 06:46:17 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 86BCD1AB2C4;
	Thu, 20 Sep 2007 06:46:17 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vwsumkll8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58754>

Le jeudi 20 septembre 2007, Junio C Hamano a =E9crit :
> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 9b74ed2..c0f954e 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -97,7 +97,8 @@ int execv_git_cmd(const char **argv)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tmp =3D argv[0];
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0argv[0] =3D git_command;
> > =A0
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0trace_argv_printf(argv, -1,=
 "trace: exec:");
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0trace_printf("trace: exec:"=
);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0trace_argv(argv, -1);
>
> This used to be a single call into trace.c which would format a
> single string to write(2) out. =A0Now these two messages go
> through separate write(2) and can be broken up. =A0I think the
> atomicity of the log/trace message was the primary reason the
> original had such a strange calling convention.

That's right.

Christian.
