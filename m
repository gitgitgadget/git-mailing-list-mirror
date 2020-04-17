Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F20C2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 13:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E849D2076D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHDFKh6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgDQNgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730351AbgDQNgu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 09:36:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521E6C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 06:36:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so1059923pfc.12
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l2Jd1l6t3IswWTI0rVm/TvKkLaS7sxXcX1tqyNO7ZE0=;
        b=ZHDFKh6sCw4riiygZYgd5MsRTj/SQQvT3KbcgCNAEyUH41E+SY+dKlgNja/SbuavNu
         k1rKY7DYCBNatykh/L9ncPA1RThex0tEDPy0gO84/PBJCKcnth5xXanD97tcITxZKj8S
         QjUmftLgmBWE4hW5MOSp9xGy6kNUuuovKcSVOVJ1jv0Ri1vlu78YVj4YSPPDDvk5Qfqw
         tdpQAJye87Q1bk5zMRPzftP8RV7XMKAbn5+FUZ9We3I+wzCTl+Gs/Q7k5iq8ci04ELgN
         /10nIIyNvNCx2mCHhMYqUAI/WQ5RQatWOFph9lWd7+0LOSF5gXi/JuXnzspRvh+HuVaT
         3s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l2Jd1l6t3IswWTI0rVm/TvKkLaS7sxXcX1tqyNO7ZE0=;
        b=IY77iwDvDhYljrawUoJ/1WgijpR8nR40NqYALcqXpKnZ9qT44y5LD1He50VFzn6NAx
         97eNHP87b1GQaSZyeedW8BonYql5obABn21cUpqtczypug6GzFRLOF0QBeEknLpMnEOH
         /VK+czYD6q79iBavotyAbsUXZC/XiTbFKUfY4pjcXe7PDzgi8otC+O0SGBGZZM+KVE7D
         1E5SPI1kNiEvYmqUPjsTTAn9srAdHeW1wg3FUrKRuu7O/rpMicuOuXvsVFhkMHppK/tf
         MZjNk+IgADDB0dobhc1W/PH/nuRL6cUjfpzFnIFMzAmc1duYlw7CwifOycdMAzCVExXT
         YX3A==
X-Gm-Message-State: AGi0Pub2iT83EpSAgikvBHlL3gFc2Dj0eSClq/rA/JTgHJMIpEl6H6PF
        pJibTjO4+TdqIqTGAv4Q0ArQMDFM
X-Google-Smtp-Source: APiQypIKrDl1FSnFo9atsziD6TF2tGYgyp8JedxWMI9wdxUE3smTRly5dlz1hoSZVsj812end2csbQ==
X-Received: by 2002:a63:fa0e:: with SMTP id y14mr2927645pgh.13.1587130609519;
        Fri, 17 Apr 2020 06:36:49 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id l15sm18385438pgk.59.2020.04.17.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 06:36:49 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:36:47 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200417133647.GA26701@danh.dev>
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
 <20200417022416.GE2285@danh.dev>
 <xmqqr1wmwu2f.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr1wmwu2f.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-16 22:38:16-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> 
> > On 2020-04-15 16:01:52-0700, Junio C Hamano <gitster@pobox.com> wrote:
> >> * dd/iso-8601-updates (2020-04-15) 2 commits
> >>  - date.c: allow compact version of ISO-8601 datetime
> >>  - date.c: skip fractional second part of ISO-8601
> >> 
> >>  The approxidate parser learns to parse seconds with fraction.
> >> 
> >>  Will merge to 'next'.
> >
> > I thought we haven't gained enough concious for "12:34:56.7.days.ago"
> > Current code will treat it as "7 days ago at 12:34:56"
> > New code will treat it as 12:34:56 (today?)
> 
> Yup, it clearly is a regression, and I do not think there is an
> agreement that the regression matters in real life.
> 

Well, I _think_ we should keep it in pu to see other's feedback for now.
Even if we want to advance it to next, I would like to have this fixup
for the documentation the first patch.

--------------8<-------------
Subject: [PATCH] fixup! date.c: skip fractional second part of ISO-8601

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/date-formats.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 6f69ba2ddd..7e7eaba643 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -20,7 +20,10 @@ RFC 2822::
 ISO 8601::
 	Time and date specified by the ISO 8601 standard, for example
 	`2005-04-07T22:13:13`. The parser accepts a space instead of the
-	`T` character as well. The fractional part will be ignored.
+	`T` character as well. Fractional parts of a second will be ignored,
+	for example `2005-04-07T22:13:13.019` will be treated as
+	`2005-04-07T22:13:13`
+
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
-- 
Danh
