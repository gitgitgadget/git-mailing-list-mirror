From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH 0/3] teach --histogram to diff
Date: Tue, 12 Jul 2011 07:19:47 -0700
Message-ID: <CAJo=hJu5ubkzUyyPM0nqP+J9CU3hBtAHfuzaLSuN214Hux4qTA@mail.gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 16:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgdov-0004CD-7E
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 16:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab1GLOUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 10:20:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42252 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab1GLOUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 10:20:08 -0400
Received: by bwd5 with SMTP id 5so4077249bwd.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 07:20:07 -0700 (PDT)
Received: by 10.204.37.75 with SMTP id w11mr596bkd.108.1310480407190; Tue, 12
 Jul 2011 07:20:07 -0700 (PDT)
Received: by 10.204.165.130 with HTTP; Tue, 12 Jul 2011 07:19:47 -0700 (PDT)
In-Reply-To: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176940>

On Mon, Jul 11, 2011 at 23:10, Tay Ray Chuan <rctay89@gmail.com> wrote:
> (Shawn, I was held up with the patch messages, sorry for the delay.)
>
> Port JGit's HistogramDiff(Index) over to C. This algorithm extends th=
e
> patience algorithm to "support low-occurrence common elements" [1].
>
> Rough numbers show that it is a faster alternative to its --patience
> cousin, as well as to the default Meyers algorithm:
>
> =A0$ time ./git log --histogram -p v1.0.0 >/dev/null
>
> =A0real =A0 =A00m12.998s
> =A0user =A0 =A00m11.506s
> =A0sys =A0 =A0 0m1.487s
> =A0$ time ./git log -p v1.0.0 >/dev/null
>
> =A0real =A0 =A00m13.575s
> =A0user =A0 =A00m12.101s
> =A0sys =A0 =A0 0m1.468s
> =A0$ time ./git log --patience -p v1.0.0 >/dev/null
>
> =A0real =A0 =A00m14.978s
> =A0user =A0 =A00m13.508s
> =A0sys =A0 =A0 0m1.464s

Nice!

Not the big difference that it is for us in JGit (between histogram
and Myers), but its nice to see an improvement here, even if it is
only 0.5s for the entire 1.0.0 history. How do the diffs come out? One
of the arguments for patience diff is the formatting can sometimes be
more readable for certain changes, but its slower. Histogram tries to
apply a similar algorithm as patience in order to get the formatting
benefits, but also some performance improvements.

Have you looked at a patch that differs in output between Myers and
patience, and then compared those to the histogram version?

> The first patch implements JGit's HistogramDiff(Index) proper. The
> second and third patches aren't essential but yield performance gains=
=2E
=2E..
> [RFC/PATCH 1/3] teach --histogram to diff
> [RFC/PATCH 2/3] xdiff/xprepare: skip classification
> [RFC/PATCH 3/3] xdiff/xprepare: use a smaller sample size for histogr=
am

Do we need sampling at all for histogram? Can you skip it?

--=20
Shawn.
