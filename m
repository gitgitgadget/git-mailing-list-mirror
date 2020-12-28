Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E1C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F73A229C5
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgL1RS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgL1RSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 12:18:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77CFC061793
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:17:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c133so10852263wme.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdwt0Eb/bIxSob2yya6PS+x9baR6ZaGdGi48GtJn83U=;
        b=bapgFhiY6BMKlGhWdsIsQW7NBETh2L4kx/t59fWBoy8uebizjzhqGzCufDlaPiymL1
         NUR5T9YLjaff/3SjfI4sY9x7A+gi504PVKOH28dIvj5g2+5EdLXxru+uY8Dhe2m8ttT4
         hqpyf+Px668y0CsRe1ZVxZ9ruvTRdgAxOc6cSs1l22NHz6TPnNZfzLqkCBtHmCHsAlp6
         zSnxltvaxHUgEieUvGK5sNSQSJFQzy5ajUdMPy833nlOgBaO5IJHZfoirq0ZKybj3xNq
         Z6pl6WEGy1yZzshqdOOA572iVueSDMmC4cFGNbyjvb5jrl1t2keHqcWIS0JWo5IQHpAH
         in/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdwt0Eb/bIxSob2yya6PS+x9baR6ZaGdGi48GtJn83U=;
        b=IaF7HuhZuA98f6cL2Nb11TwkYBNPCdXn5C8wf4j/lJIGd+Y5WO8yL6tR4vDx3g+FqJ
         gs24hBKYJOlGzAMQX72KV+guSdwrDzrDqg1Eu4J2cDvz7JfgmrvrovUxYexCQf2PxThG
         grUtSQ90Wiph+vEH8AlNqo5sgvIwm+qBLPUKe5wEf6Vd+FxO40EZkMsT/FNN/Zh41WWb
         9vucqYSf/ZJsF2KJvwHe3Qq59w/ufw6t1bDextTNccwihUKenWaf6YtUHR6E68da65YP
         pytDp3M24qjHayZazkt6aplOqNG+HakVseoOcBELswUiwVPR1+nu67+jOT6pCTO5k7pm
         /oRg==
X-Gm-Message-State: AOAM53232aG/fHfsNR/PL46gGWmfz9P5wncCif7qh/QpTPrVgSLYhjlS
        E78MjsPtme1A3drk01RiO1U+Q3FSTXXsEQ==
X-Google-Smtp-Source: ABdhPJz8f0NOERPjDSr5JlqIi1bQ8lfZ3hTwoZC0jcOrDxAIuoe8UTtqeSAp3KWuwGX22J/t7neq/A==
X-Received: by 2002:a1c:6a10:: with SMTP id f16mr21183563wmc.106.1609175863083;
        Mon, 28 Dec 2020 09:17:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20072834wmj.28.2020.12.28.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:17:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] CoC: Update word-wrapping to match upstream
Date:   Mon, 28 Dec 2020 18:17:33 +0100
Message-Id: <20201228171734.30038-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the CoC document was added in 5cdf2301d4a (add a Code of Conduct
document, 2019-09-24) it was added from some 1.4 version of the
document whose word wrapping doesn't match what's currently at [1],
which matches content/version/1/4/code-of-conduct.md in the CoC
repository[2].

Let's update our version to match that, to make reading subsequent
diffs easier. There are no non-whitespace changes here.

1. https://www.contributor-covenant.org/version/1/4/code-of-conduct/
2. https://github.com/ContributorCovenant/contributor_covenant

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 CODE_OF_CONDUCT.md | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
index fc4645d5c08..083bd872c53 100644
--- a/CODE_OF_CONDUCT.md
+++ b/CODE_OF_CONDUCT.md
@@ -10,11 +10,10 @@ this code of conduct may be banned from the community.
 
 In the interest of fostering an open and welcoming environment, we as
 contributors and maintainers pledge to make participation in our project and
-our community a harassment-free experience for everyone, regardless of age,
-body size, disability, ethnicity, sex characteristics, gender identity and
-expression, level of experience, education, socio-economic status,
-nationality, personal appearance, race, religion, or sexual identity and
-orientation.
+our community a harassment-free experience for everyone, regardless of age, body
+size, disability, ethnicity, sex characteristics, gender identity and expression,
+level of experience, education, socio-economic status, nationality, personal
+appearance, race, religion, or sexual identity and orientation.
 
 ## Our Standards
 
@@ -52,23 +51,21 @@ threatening, offensive, or harmful.
 
 ## Scope
 
-This Code of Conduct applies within all project spaces, and it also applies
-when an individual is representing the project or its community in public
-spaces. Examples of representing a project or community include using an
-official project e-mail address, posting via an official social media account,
-or acting as an appointed representative at an online or offline event.
-Representation of a project may be further defined and clarified by project
-maintainers.
+This Code of Conduct applies within all project spaces, and it also applies when
+an individual is representing the project or its community in public spaces.
+Examples of representing a project or community include using an official
+project e-mail address, posting via an official social media account, or acting
+as an appointed representative at an online or offline event. Representation of
+a project may be further defined and clarified by project maintainers.
 
 ## Enforcement
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
 reported by contacting the project team at git@sfconservancy.org. All
-complaints will be reviewed and investigated and will result in a response
-that is deemed necessary and appropriate to the circumstances. The project
-team is obligated to maintain confidentiality with regard to the reporter of
-an incident. Further details of specific enforcement policies may be posted
-separately.
+complaints will be reviewed and investigated and will result in a response that
+is deemed necessary and appropriate to the circumstances. The project team is
+obligated to maintain confidentiality with regard to the reporter of an incident.
+Further details of specific enforcement policies may be posted separately.
 
 Project maintainers who do not follow or enforce the Code of Conduct in good
 faith may face temporary or permanent repercussions as determined by other
@@ -84,8 +81,8 @@ git@sfconservancy.org, or individually:
 
 ## Attribution
 
-This Code of Conduct is adapted from the [Contributor Covenant][homepage],
-version 1.4, available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
+This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
+available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
 
 [homepage]: https://www.contributor-covenant.org
 
-- 
2.29.2.222.g5d2a92d10f8

