Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF1C433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4B422A84
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgL1RS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgL1RS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 12:18:26 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0240C061796
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:17:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g185so10346007wmf.3
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNkHwK7e1CgjdLyB6R4cLBGYof4YMyEBvj9GGtuazKU=;
        b=U9EsexgluIfmtqAEWM6sn18UpWRTnH0GeWauBfpDndOT4OKnT2Dx/kBR6wh1ySmxmI
         XUxqS2uUN3lF66Pvtu08B8PhOrWXmJDO5D4mYBhQUmvjrshPmkPllFTSKzoUBPkQ/GeQ
         do3W2LABDykahohNFZtCeFyfIrhKH9xGoaoriXsUyOJUFUzJj+RDnmltOe8DDbZ7knZi
         HgSMAx2UhGcEkxU39qg5rEZxqKGI/KaKPPQjELkkDP0VoHK1bclhhd/rfHbfn1syCe7B
         PFW9J2t/92L2eNHYzA7pi4Iu8VY2oc92itQEmCL0sUudorL7Rzm1pGtzgkb55weXVed1
         ylDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNkHwK7e1CgjdLyB6R4cLBGYof4YMyEBvj9GGtuazKU=;
        b=kHc8WMsBCMTqaNBSwHUd6XZWllIOM5ZOdAMEZPr+qnx7UdMAfQXnjN++LSylLjH8at
         4IaVQrPxFbltL4V4RZ7H5KI8lvYypUj039v0XBGuS75yCZmBw6+UqQZtL3oQg4a105+a
         nrz5bDrxM/zrQBJlnmqZz2GyV5PwLVOUAuHfKkG77Bn4AbMzlwblmxLluouQH7xUbKnh
         SxcZLGI7ztG+ZFzKfXt9LZ2ynRAdkMu7hczYUXuWtcC5+zcIz/rluhp631QOnVZBK2hY
         xtMUYRGQOhNwV95W0+j+5EQyO9ax0fXPy8tLkRN+NBcmnsJE5I1jZ3mNA4G2QI3cXVDs
         kiDA==
X-Gm-Message-State: AOAM530zpk+Ls+5pS3uw2F5wI88DWUgtcRwi0SsnyoFX4lmMIElwndB+
        S1HziFj6nVtrVsyNy6fKrL7d5SM9V846tQ==
X-Google-Smtp-Source: ABdhPJxYNpLlagDVrQq5koGqOuZLofcetAClQGWtUJUKSYXgS7Dzv5Xde30ubNHrdiIUK8tH+gJr6w==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr21473004wma.3.1609175864353;
        Mon, 28 Dec 2020 09:17:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20072834wmj.28.2020.12.28.09.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:17:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] CoC: update to version 2.0 + local changes
Date:   Mon, 28 Dec 2020 18:17:34 +0100
Message-Id: <20201228171734.30038-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the CoC added in 5cdf2301 (add a Code of Conduct document,
2019-09-24 from version 1.4 to version 2.0. This is the version found
at [1] with the following minor changes:

 - We preserve the change to the CoC in 3f9ef874a73 (CODE_OF_CONDUCT:
   mention individual project-leader emails, 2019-09-26)

 - We preserve the custom into added in 5cdf2301d4a (add a Code of
   Conduct document, 2019-09-24)

This change intentionally preserves a warning emitted on "git diff
--check". It's better to make it easily diff-able with upstream than
to fix whitespace changes in our version while we're at it.

1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/code_of_conduct.md
---
 CODE_OF_CONDUCT.md | 153 ++++++++++++++++++++++++++++++---------------
 1 file changed, 104 insertions(+), 49 deletions(-)

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
index 083bd872c53..65651beada7 100644
--- a/CODE_OF_CONDUCT.md
+++ b/CODE_OF_CONDUCT.md
@@ -8,70 +8,64 @@ this code of conduct may be banned from the community.
 
 ## Our Pledge
 
-In the interest of fostering an open and welcoming environment, we as
-contributors and maintainers pledge to make participation in our project and
-our community a harassment-free experience for everyone, regardless of age, body
-size, disability, ethnicity, sex characteristics, gender identity and expression,
-level of experience, education, socio-economic status, nationality, personal
-appearance, race, religion, or sexual identity and orientation.
+We as members, contributors, and leaders pledge to make participation in our
+community a harassment-free experience for everyone, regardless of age, body
+size, visible or invisible disability, ethnicity, sex characteristics, gender
+identity and expression, level of experience, education, socio-economic status,
+nationality, personal appearance, race, religion, or sexual identity
+and orientation.
+
+We pledge to act and interact in ways that contribute to an open, welcoming,
+diverse, inclusive, and healthy community.
 
 ## Our Standards
 
-Examples of behavior that contributes to creating a positive environment
-include:
+Examples of behavior that contributes to a positive environment for our
+community include:
 
-* Using welcoming and inclusive language
-* Being respectful of differing viewpoints and experiences
-* Gracefully accepting constructive criticism
-* Focusing on what is best for the community
-* Showing empathy towards other community members
+* Demonstrating empathy and kindness toward other people
+* Being respectful of differing opinions, viewpoints, and experiences
+* Giving and gracefully accepting constructive feedback
+* Accepting responsibility and apologizing to those affected by our mistakes,
+  and learning from the experience
+* Focusing on what is best not just for us as individuals, but for the
+  overall community
 
-Examples of unacceptable behavior by participants include:
+Examples of unacceptable behavior include:
 
-* The use of sexualized language or imagery and unwelcome sexual attention or
-  advances
-* Trolling, insulting/derogatory comments, and personal or political attacks
+* The use of sexualized language or imagery, and sexual attention or
+  advances of any kind
+* Trolling, insulting or derogatory comments, and personal or political attacks
 * Public or private harassment
-* Publishing others' private information, such as a physical or electronic
-  address, without explicit permission
+* Publishing others' private information, such as a physical or email
+  address, without their explicit permission
 * Other conduct which could reasonably be considered inappropriate in a
   professional setting
 
-## Our Responsibilities
+## Enforcement Responsibilities
 
-Project maintainers are responsible for clarifying the standards of acceptable
-behavior and are expected to take appropriate and fair corrective action in
-response to any instances of unacceptable behavior.
+Community leaders are responsible for clarifying and enforcing our standards of
+acceptable behavior and will take appropriate and fair corrective action in
+response to any behavior that they deem inappropriate, threatening, offensive,
+or harmful.
 
-Project maintainers have the right and responsibility to remove, edit, or
-reject comments, commits, code, wiki edits, issues, and other contributions
-that are not aligned to this Code of Conduct, or to ban temporarily or
-permanently any contributor for other behaviors that they deem inappropriate,
-threatening, offensive, or harmful.
+Community leaders have the right and responsibility to remove, edit, or reject
+comments, commits, code, wiki edits, issues, and other contributions that are
+not aligned to this Code of Conduct, and will communicate reasons for moderation
+decisions when appropriate.
 
 ## Scope
 
-This Code of Conduct applies within all project spaces, and it also applies when
-an individual is representing the project or its community in public spaces.
-Examples of representing a project or community include using an official
-project e-mail address, posting via an official social media account, or acting
-as an appointed representative at an online or offline event. Representation of
-a project may be further defined and clarified by project maintainers.
+This Code of Conduct applies within all community spaces, and also applies when
+an individual is officially representing the community in public spaces.
+Examples of representing our community include using an official e-mail address,
+posting via an official social media account, or acting as an appointed
+representative at an online or offline event.
 
 ## Enforcement
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
-reported by contacting the project team at git@sfconservancy.org. All
-complaints will be reviewed and investigated and will result in a response that
-is deemed necessary and appropriate to the circumstances. The project team is
-obligated to maintain confidentiality with regard to the reporter of an incident.
-Further details of specific enforcement policies may be posted separately.
-
-Project maintainers who do not follow or enforce the Code of Conduct in good
-faith may face temporary or permanent repercussions as determined by other
-members of the project's leadership.
-
-The project leadership team can be contacted by email as a whole at
+reported to the community leaders responsible for enforcement at
 git@sfconservancy.org, or individually:
 
   - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
@@ -79,12 +73,73 @@ git@sfconservancy.org, or individually:
   - Jeff King <peff@peff.net>
   - Junio C Hamano <gitster@pobox.com>
 
+All complaints will be reviewed and investigated promptly and fairly.
+
+All community leaders are obligated to respect the privacy and security of the
+reporter of any incident.
+
+## Enforcement Guidelines
+
+Community leaders will follow these Community Impact Guidelines in determining
+the consequences for any action they deem in violation of this Code of Conduct:
+
+### 1. Correction
+
+**Community Impact**: Use of inappropriate language or other behavior deemed
+unprofessional or unwelcome in the community.
+
+**Consequence**: A private, written warning from community leaders, providing
+clarity around the nature of the violation and an explanation of why the
+behavior was inappropriate. A public apology may be requested.
+
+### 2. Warning
+
+**Community Impact**: A violation through a single incident or series
+of actions.
+
+**Consequence**: A warning with consequences for continued behavior. No
+interaction with the people involved, including unsolicited interaction with
+those enforcing the Code of Conduct, for a specified period of time. This
+includes avoiding interactions in community spaces as well as external channels
+like social media. Violating these terms may lead to a temporary or
+permanent ban.
+
+### 3. Temporary Ban
+
+**Community Impact**: A serious violation of community standards, including
+sustained inappropriate behavior.
+
+**Consequence**: A temporary ban from any sort of interaction or public
+communication with the community for a specified period of time. No public or
+private interaction with the people involved, including unsolicited interaction
+with those enforcing the Code of Conduct, is allowed during this period.
+Violating these terms may lead to a permanent ban.
+
+### 4. Permanent Ban
+
+**Community Impact**: Demonstrating a pattern of violation of community
+standards, including sustained inappropriate behavior,  harassment of an
+individual, or aggression toward or disparagement of classes of individuals.
+
+**Consequence**: A permanent ban from any sort of public interaction within
+the community.
+
 ## Attribution
 
-This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
-available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
+This Code of Conduct is adapted from the [Contributor Covenant][homepage],
+version 2.0, available at
+[https://www.contributor-covenant.org/version/2/0/code_of_conduct.html][v2.0].
+
+Community Impact Guidelines were inspired by 
+[Mozilla's code of conduct enforcement ladder][Mozilla CoC].
+
+For answers to common questions about this code of conduct, see the FAQ at
+[https://www.contributor-covenant.org/faq][FAQ]. Translations are available 
+at [https://www.contributor-covenant.org/translations][translations].
 
 [homepage]: https://www.contributor-covenant.org
+[v2.0]: https://www.contributor-covenant.org/version/2/0/code_of_conduct.html
+[Mozilla CoC]: https://github.com/mozilla/diversity
+[FAQ]: https://www.contributor-covenant.org/faq
+[translations]: https://www.contributor-covenant.org/translations
 
-For answers to common questions about this code of conduct, see
-https://www.contributor-covenant.org/faq
-- 
2.29.2.222.g5d2a92d10f8

