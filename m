Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD38E20899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbdHQRmC (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:42:02 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33772 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753647AbdHQRmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:42:01 -0400
Received: by mail-yw0-f177.google.com with SMTP id p68so45422814ywg.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KFWrnUGYlzuRyRL7z8GMsVajI/MTdBKWqUeTipgpOq8=;
        b=HrqA7iqmzZOxyin1h2zJ4dOZguUOKepsZcybdmOCqRiocDC26Ktu4fAwJ7heRGyA0B
         8356hP/44ORGe93eFbbpl+XgFmQJUjK5F1ynXd6VSdUaET8fVe9yVQhi981VCsYcNusO
         PminYLjEPe8W7/8uLsWz3RzC89mVr8GoYZkYplcSGZ8aisWuaVW1sBavr6bU89EkprIS
         JoHS3r/nrxPHOSLXWAKA6ObWWrT4TNPeQc2+zqBwpiMhgwwl1Bm7PqoUBbUYpDxcJysk
         oLBqwsNkcvr3iA7f/LDb8Xn1U73KCmo/sB9CaO7nHAVvxvwoEYNsmzPnnIitSaGTj1KS
         fTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KFWrnUGYlzuRyRL7z8GMsVajI/MTdBKWqUeTipgpOq8=;
        b=swXpI31TaI2DaGgaBxAZoZokua9BGe6Fi/BN9Mq07dTKCruPtdJmY45fbzan/+3Iwh
         dhThVdYSuOwECYp1nExmMCceRWymigfzobzOwLMg4o6THuFaVaZ1FcOSsIXK3Ds39iAj
         rlXhBIpDirq6hbO7cHv95poJU7bueCaSe/EELIPPExbT5kyT4W5hbXy82yRYJ069+uv+
         7K4WV1FwAfdJsRMFOJv5XwKzmeo0ALszTSIoug5hRual0j7p3yfEEn+m7AEV92f+tpDt
         DTffHWGHGewFODsUuKVNAoLJTQi2pH4K48ORMYj2Ls2ScgjgO9N2Z4m5jst6kN5LnidR
         gPbA==
X-Gm-Message-State: AHYfb5jstdLqX7WdXAmWS6YaeVjhLAKZIVNvmAJDYqlDlaUzcJNM0+td
        c9g6ALfVEteZ/HknhIT0XKJLwOrj622B
X-Received: by 10.13.198.6 with SMTP id i6mr2995458ywd.422.1502991720654; Thu,
 17 Aug 2017 10:42:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Thu, 17 Aug 2017 10:42:00 -0700 (PDT)
In-Reply-To: <xmqq1soahzpb.fsf@gitster.mtv.corp.google.com>
References: <xmqq1soahzpb.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Aug 2017 10:42:00 -0700
Message-ID: <CAGZ79kZgUCBd0uUjuwvKsUSaAUfpU-wxe6+nVPO_1BXroiCd4w@mail.gmail.com>
Subject: Re: [PATCH] diff: retire sane_truncate_fn
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 10:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Long time ago, 23707811 ("diff: do not chomp hunk-header in the
> middle of a character", 2008-01-02) introduced sane_truncate_line()
> helper function to trim the "function header" line that is shown at
> the end of the hunk header line, in order to avoid chomping it in
> the middle of a single UTF-8 character.  It also added a facility to
> define a custom callback function to make it possible to extend it
> to non UTF-8 encodings.
>
> During the following 8 1/2 years, nobody found need for this custom
> callback facility.
>
> A custom callback function is a wrong design to use here anyway---if
> your contents need support for non UTF-8 encoding, you shouldn't
> have to write a custom function and recompile Git to plumb it in.  A
> better approach would be to extend sane_truncate_line() function and
> have a new member in emit_callback to conditionally trigger it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This patch is
Reviewed-by: Stefan Beller <sbeller@google.com>

However while strolling around in code nearby, I do
wonder if sane_truncate_line needs to make use
of the return value of utf8_width. But that is not the case
as we're interested in the byte length, not the print length.

Thanks
Stefan
