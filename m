From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] commit: loosen ident checks when generating template
Date: Thu, 11 Dec 2014 15:26:17 -0500
Message-ID: <CAPig+cTQBgDVoR-YG-WU_mJHR_NjdA6=5Lre_n4YMFawcSRwVw@mail.gmail.com>
References: <20141210153952.GA14910@peff.net>
	<20141210154209.GA20771@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Simon <simonzack@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:26:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzAJb-0007zV-Ce
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 21:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872AbaLKU0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 15:26:19 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:56933 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758460AbaLKU0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 15:26:18 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so2829913yhl.37
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fWaVMC7w7JZdlKwr2j8TH9j/L9oGpt7qVTjTfsQ+5fg=;
        b=gFkZJ/XxtXxIPY7HyolyEcgWJztrSkei6CDso/v70Or6vKQGaYHeYnJjOkmBC2er04
         QffDAiX/g2p1w3sZFg0Pg/F22iNCd7Y9icaAIUr9i2e9dyzJpJ/H4T8oV0eejPVDJDAj
         X4dyGFJKVAf2CwDs1PvMDRqWC/rPiYvAUAqJ1LyYvbhrz1YowtODwqnq58x6C9K1uB5G
         Ss07FTjlgifuIcplMhyWd+EVliNvi2POCn8Bsv8DX+o+drrpwYUrntkZ5+SPSDvVqGZ/
         RNIyF/cwAjZ8kuqAgSTMrM3Wb8VI4KpY0tdKgelmlSPuyuKg+AYYD9Ce8F/67Xs1BNoy
         Mu6Q==
X-Received: by 10.170.130.21 with SMTP id w21mr9988233ykb.22.1418329577728;
 Thu, 11 Dec 2014 12:26:17 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Thu, 11 Dec 2014 12:26:17 -0800 (PST)
In-Reply-To: <20141210154209.GA20771@peff.net>
X-Google-Sender-Auth: 1lDw3sTeUkf6KnMhxyWtvIri2z4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261290>

On Wed, Dec 10, 2014 at 10:42 AM, Jeff King <peff@peff.net> wrote:
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d1c90db..2be5506 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -822,8 +821,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>                         status_printf_ln(s, GIT_COLOR_NORMAL,
>                                         "%s", only_include_assumed);
>
> -               split_ident_or_die(&ai, author_ident);
> -               split_ident_or_die(&ci, &committer_ident);
> +               /*
> +                * These should never fail because we they come from our own

s/we//

> +                * fmt_ident. They may fail the sane_ident test, but we know
> +                * that the name and mail pointers will at least be valid,
> +                * which is enough for our tests and printing here.
> +                */
> +               assert_split_ident(&ai, author_ident);
> +               assert_split_ident(&ci, &committer_ident);
>
>                 if (ident_cmp(&ai, &ci))
>                         status_printf_ln(s, GIT_COLOR_NORMAL,
> --
> 2.2.0.454.g7eca6b7
