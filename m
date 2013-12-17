From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 20:58:18 +0100
Message-ID: <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com> <20131217140746.GB15010@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 20:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt0nK-0008IR-5M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 20:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab3LQT7B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 14:59:01 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:49390 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab3LQT7A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 14:59:00 -0500
Received: by mail-wi0-f176.google.com with SMTP id hq4so4285371wib.9
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PnP0c2o8tCPfd0y75JsXUMYhthrsVChVT3MLSxB739M=;
        b=E6AbDsLiJRbUxOK7btvHA/p5x3A2j2TbWD1v1IIlI/Rs1iM5+xMn6ymQVdoxAZP8QR
         QPkWYQj8PMlADXhocwnuPc7o4Yis6zi3TkFFXNJkF+HPC8ijdF5ViqrdeDbCiRx+MQ0j
         r8C10r1t8EGEJ+1fKtrle5h/gSWfkKiorsHzYz+5a0cqQ708dNjLOGg+wRXn4ppTrVqe
         XjN3OkvJP/PdO6WDtEuH5oQRcPOlx27/K/8nREslMcYGIm2tKkrfkTNk/QsTgAglwB77
         gogA5VeWaL+6cYV9KCC3msQiSeYGq6xgHO1YZ0HCYGcG1hftXIbukYslEe+u/6s3KXG+
         O0VA==
X-Received: by 10.180.205.205 with SMTP id li13mr4928856wic.12.1387310339012;
 Tue, 17 Dec 2013 11:58:59 -0800 (PST)
Received: by 10.227.86.201 with HTTP; Tue, 17 Dec 2013 11:58:18 -0800 (PST)
In-Reply-To: <20131217140746.GB15010@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239401>

On Tue, Dec 17, 2013 at 3:07 PM, Eric S. Raymond <esr@thyrsus.com> wrot=
e:
> Jakub Nar=C4=99bski <jnareb@gmail.com>:

>> I wonder if we can add support for incremental import once, for all
>> VCS supporting fast-export, in one place, namely at the remote-helpe=
r.
>
> Something in the pipeline - either the helper or the exporter - needs=
 to
> have an equivalent of vc-fast-export's and cvsps's -i option, which
> omits all commits before a specified time and generates cookies like
> "from refs/heads/master^0" before each branch root in the incremental
> dump.

Errr... doesn't cvs-fast-export support --export-marks=3D<file> to save
progress and --import-marks=3D<file> to continue incremental import?
I *guess* that 'export' / 'import' capabilities-based remote helpers
use 'export-marks <file>' / 'import-marks <file>' capability for increm=
ental
import, also known as "fetch", isn't it? But I might be mistaken, I don=
't
know enough about remote helpers...

I would check it in cvs-fast-export manpage, but the page seems to
be down:

  http://isup.me/www.catb.org

    It's not just you! http://www.catb.org looks down from here.

> This could be done in the wrapper, but only if the wrapper itself
> includes an import-stream parser, interprets the output from the
> exporter program, and re-emits it.  Having done similar things
> myself in reposurgeon, I advise against this strategy; it would
> introduce a level of complexity to the wrapper that doesn't belong
> there, and make the exporter+wrapper combination harder to verify.

Right.

> Fortunately, incremental dump is trivial to implement in the output
> stage of an exporter if you have access to the exporter source code.
> I've done it in two different exporters.  cvs-fast-export now has a
> regression test for this case

This is I guess assuming that information from later commits doesn't
change guesses about shape of history from earlier commits...

--=20
Jakub Narebski
