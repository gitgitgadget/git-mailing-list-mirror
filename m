Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C2120189
	for <e@80x24.org>; Sun, 19 Jun 2016 20:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbcFSUCK (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 16:02:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34886 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbcFSUCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 16:02:01 -0400
Received: by mail-io0-f194.google.com with SMTP id n127so16153932iof.2
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 13:02:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZBpDUFXTIJN3GGtpZIeMs4u8OaAjNlSc6hwdaxYI8tw=;
        b=fNvYLecLyLx9ZhZKi6ZQz034k2rbTS/sZm1sEk/0wfIeHvbrH0xpKzSQ32Nyi85W7m
         qRq2fxpJwHnEywZurxunI5+N3bmLvNb7erYfHjSSZfoNsf6jBIpZIoXipFSa4lczoO4U
         +VRNS03A+SxCJmSij1S5NgJMVW9ouWejc+iQ/VcVh/rB/LB3oi7liUN7W0p06VkhtAFK
         h6ylGkP7H89D8qONSqtR5Qi6K+Q3D36lDJByR+/4h6Zsz6OM4k1f4Ta5jd7KlV/Ca4SO
         R60l66N7ZnxFWf737hPT0hVDPW727X4IAKacBgqWetXDL99X1X+RadZQsoAsapXeclEW
         70sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZBpDUFXTIJN3GGtpZIeMs4u8OaAjNlSc6hwdaxYI8tw=;
        b=AS0tSIpWU6pkNWPrVnpJ+iTEewpngqDVotQnM3Ets+eAmF5UakpHmDrrfVm5oi1BzS
         RFMI0vwBhT68ahsvCEL53pLF1cyz5mOU30q7ziLRizEEmihogC9fweh/eNuHnwAj2pVB
         HVPh7lq7T6Ih6rQSBkwKYu5tpZ03B2gGh3PomoBePvkZBieR3fw8VuisKrK4prhMfbTC
         dj+1kvfl5se4POMvlLjjP4CH3Ou2rp5K0ArwqmEdC2G5EIs0TUUsqdiXpG2WyF5v32gc
         j3TwLamXUDjpJAQQJ2Lwe6rmzMw/dBZnAORe8UbFsDCTVrDyERhfkvictwZwt8P3Ojcp
         YnHg==
X-Gm-Message-State: ALyK8tLH76oRrhg5ak0pEg50+DEE2fYChavBVespHHPYxfXn8208IBpdStcZlirnHgfJR5F8gdaBiyFWpmbBTg==
X-Received: by 10.107.47.41 with SMTP id j41mr17047400ioo.168.1466366520255;
 Sun, 19 Jun 2016 13:02:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Sun, 19 Jun 2016 13:01:59 -0700 (PDT)
In-Reply-To: <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Sun, 19 Jun 2016 16:01:59 -0400
X-Google-Sender-Auth: rfIEoGUaPR1IJDcSkHbvvuu7b-Y
Message-ID: <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 6:04 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> We just taught the relevant functions to respect the diffopt.file field,
> to allow writing somewhere else than stdout. Let's make use of it.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -1569,6 +1570,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 setup_pager();
>
>         if (output_directory) {
> +               rev.diffopt.use_color = 0;

What is this change about? It doesn't seem to be related to anything
else in the patch.

>                 if (use_stdout)
>                         die(_("standard output, or directory, which one?"));
>                 if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
