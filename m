Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F35C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469F16135A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFWAum (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 20:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFWAul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 20:50:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB88C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:48:23 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t4-20020a9d66c40000b029045e885b18deso296847otm.6
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WUsFCFsJg6508At+6i0VHP+sjKOF77zaWg75Fmkv8wE=;
        b=O3fpz21QKRkb9EUwalTfn3JC2ETaSPa0eQZvrlhmVG/X8B808z1nsHi1NT/Gy2rRWp
         aOdQy4PDlsuBvgB3NNAEXVDQ7Ot1+qChcf84n+g3BatKLuSqCZedCIOZpKsxU/g6jPJj
         KTEem7LEpZQNDe/gbfW2IvJVeAZgf7WzRaTEd2OqeSUSeo1txvgrWd7d0KVlICE3Eccf
         vnCihrHu8U8UVsADEbEzNbQmp1Yk4pXRffobR4BKcimRL6/m7c9ttQSaW1W7uRSkcI1n
         72P95H87p4S4o9V8h+5T0iHDYIIw3G2X06URZEW8N1orMvU+R8Rjyf4/7B98Cf/vpftS
         zvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUsFCFsJg6508At+6i0VHP+sjKOF77zaWg75Fmkv8wE=;
        b=uSX3s8DPBImeXoEZXsfcWVRwdlzSr2Q961ey6Y8Oz4Kf8nnvz9RRy0fOTPwV8mWvB/
         8AgD+NI1PTkM3HrFJriuUAuxCx6X6bzPsE/lkRCRqtiiDdRpx8zQtAUP/CcELybWXSH3
         EzLI5DDFQZ9BrX7K8JnEpwQ0LDTZndIoe7qo+bu3TPwFnjZs45JASnepqaPgrHoCTU/v
         pwIHUaVMVljl+H1epsCG1nw7httZ/DwEKCdSYYujusq2goahW+4mwLFlab8zKnrvD7eH
         k4I4tKT8NQ1mxOhOhvvTWUk+q+iX//VS91JMHGS21YVZ4MBr2+DTkdV8mkFWRkkPcP8i
         zW5A==
X-Gm-Message-State: AOAM5330ACt+sD4ZGTFVwIdDqIfzJNSK3V0PLKJ2Is4Vld/LVZ00zWdB
        LCP1/lum9oq0UikIGyX4GXRIwOCRU0TedA==
X-Google-Smtp-Source: ABdhPJyImtxUlggayVuWvw2xpZpxr+zXiUXpbFCYEPrwpStDJHgRAq7mWFhueISqBFoeaKziELNsyw==
X-Received: by 2002:a9d:6855:: with SMTP id c21mr5364196oto.56.1624409302852;
        Tue, 22 Jun 2021 17:48:22 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id a78sm4623918oii.42.2021.06.22.17.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 17:48:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] pull: documentation improvements
Date:   Tue, 22 Jun 2021 19:48:13 -0500
Message-Id: <20210623004815.1807-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621175234.1079004-1-felipe.contreras@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are the non-controversial changes from last-year series [1] which
objectively improve our documentation and don't have any reason not to
be merged.

Not everyone knows what a rebase or a fast-forward is.

Since v1 I removed one line of advice because now a second person--Alex
Henrie--objected to it. The line is still useful, but can be added
later.

[1] https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/

Felipe Contreras (2):
  doc: pull: explain what is a fast-forward
  pull: improve default warning

 Documentation/git-pull.txt | 41 ++++++++++++++++++++++++++++++++------
 builtin/pull.c             | 21 +++++++++----------
 2 files changed, 46 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  949e814b27 = 1:  949e814b27 doc: pull: explain what is a fast-forward
2:  8a72fa35ef ! 2:  cfb60a24d6 pull: improve default warning
    @@ builtin/pull.c: static int get_can_ff(struct object_id *orig_head, struct object
     +		 "  git config --global pull.rebase true   # rebase\n"
     +		 "  git config --global pull.ff only       # fast-forward only\n"
     +		 "\n"
    -+		 "If unsure, run \"git pull --no-rebase\".\n"
     +		 "Read \"git pull --help\" for more information."));
      }
      
-- 
2.32.0

