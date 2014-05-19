From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] git related v0.3
Date: Mon, 19 May 2014 12:11:07 +0200
Message-ID: <CACBZZX6gOeTrLJwL-Zp5hEEbWCipioPgNKt7Tc41ixcQLQshiw@mail.gmail.com>
References: <537952234b691_10da88d308d8@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 12:11:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmKY1-0000s9-17
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 12:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbaESKLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 06:11:48 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:47232 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbaESKL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 06:11:27 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so5930734obc.0
        for <git@vger.kernel.org>; Mon, 19 May 2014 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Lz5qJFY6to3iyr7puFImepIOlZITbimh2EhMizcOZ9Q=;
        b=kHD5HmDiy9TtispyARr+Tg/D9AfPyRF3OTJBGiV8NhZr7pwQ5TQQ8Us1PgL08mWdD3
         s2Gblye0c4La3GLams8cIq8XDjFuJXf3fHzpyQswh7HQP9AJ04VzymfC0hpNQhK2CUbD
         ejhR1+/TOYSvk6kk5Gy9uy0VRivH0uB2BtnjdEVsEqpELlhpZ4H8BPrMcfdZTrtyWOSc
         tgd/H+uZoLpRKtSQA9eDT2kpUjko3Pm5p8wdQtJl+hzJjVIdbfv8xWt1RvWLAiwLKcfN
         H4xsloBM05yRmY+QlxhePuBE8QNqhINuOSH80bHyw9wG7yJKBMx7XB8ng/l7tJei77cd
         BUEQ==
X-Received: by 10.60.58.71 with SMTP id o7mr7457408oeq.67.1400494287326; Mon,
 19 May 2014 03:11:27 -0700 (PDT)
Received: by 10.76.34.166 with HTTP; Mon, 19 May 2014 03:11:07 -0700 (PDT)
In-Reply-To: <537952234b691_10da88d308d8@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249573>

On Mon, May 19, 2014 at 2:36 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This tool finds people that might be interested in a patch, by going
> back through the history for each single hunk modified, and finding
> people that reviewed, acknowledged, signed, or authored the code the
> patch is modifying.
>
> It does this by running `git blame` incrementally on each hunk, and
> finding the relevant commit message. After gathering all the relevant
> people, it groups them to show what exactly was their role when the
> participated in the development of the relevant commit, and on how many
> relevant commits they participated. They are only displayed if they pass
> a minimum threshold of participation.
>
> It is similar the the `git contacts` tool in the contrib area, which is a
> rewrite of this tool, except that `git contacts` does the absolute minimum;
> `git related` is way superior in every way.

The general heuristic I use, which I've found to be much better than
git-blame is:

 1. Find substrings of code I'm directly removing/altering, and
functions I'm removing/altering
 2. Do git log --reverse -p -S'<substr>' (maybe with -- file) for a
list of substrings

I've generally found that to be a better heuristic to start with in
both git.git and non-git.git code, blame tends to bias the view
towards giving you people who've just moved the code around or made
minor changes (are you at least using blame -w?).

We recently discussed having a tool like this at work to aid in our
review process, but I pointed out there that you had to be careful
with how it was written, e.g. if you rank importance as a function of
the number of commits you're now going to bother people more with
review requests if they make granular commits, whereas what you
actually want is to contact the "significant" authors, which generally
speaking can be defined as the original authors of the code you're
altering or replacing.
