Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93557C49EA3
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBFE6140B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhFOONm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhFOONY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:13:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B30C061283
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso1879065wmg.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EYOgHRcT6a4KIPZZUBnzGlAboF/wgwCauIODRP17fH4=;
        b=JwU5OKeu13OLwu3wzK/pJKo/1qSlOIvEBPVmYkhqXqN91+9AYpqqSzTwYIkOB5lBsB
         Ifj3TRNQryu4YWMt30dNdrfRmEGswmtc/WQZ0KMU9hQ3IhnymM3acOvgePf77AqloObG
         ZYCIhOa8gUlEfoqNDXNuwow+fKcTnQqLdIVc441pB4JHwv+bf1STLvSMGFokYBzbqAWm
         beTxRgfN6ysHsU8zSzV0dGSYDT6UBu965NLKi8wHRB/KI8dPFnVrUscVDjCr/ml6b4zO
         g6XmJYMWFKz9PpyjGyFhZE8RtXNflFuwb26b+PoDtuhZQ3Wsjag6xYaGf/99hLlVG6LZ
         cnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EYOgHRcT6a4KIPZZUBnzGlAboF/wgwCauIODRP17fH4=;
        b=n3CP38H2OU4XwDAztzr7qjjVEsgDuGuEXEIfJHSROnioPIji30AYR0gXjS/I1Uy7c2
         8Hw1UhDNbXzsMTBWU/s0PUk/8awDsFlcupRXyNcXkcs3U297ofqFAYL9UcxGnwAN3BT8
         ggyFuFE4zaPpJn3XbVSRYWpwv5WWJGjLzJbR8Ls/4QU1i0Oyv9izMAGQ8jZGJAskUpRh
         oZTJOLJIX2IXPS6Y2GB6GIW3RXow7cwKuKlyk+QCGAkEK6CoScXY6q6SX4kJaMuSvM04
         RfkkwfQAab5pb8F0rZuvQwqTFFJHkikhul5AMHwbV5fI5FcUWvUxeZ0qsXa/BCFChcjP
         nu+A==
X-Gm-Message-State: AOAM531K6WNyc1HWr7RSev3cx/psf5uWI22sYh01AVV6otqBJjq/ou7H
        fbo0y1lSrNWBSXJNZV4EbhUr5foJd8Y=
X-Google-Smtp-Source: ABdhPJx3PHrKsiIRn4xPO5EhsX7y/EM8M+q07DT61+smLBvnMoxfhag/yrazUvjnUG8MxM9F7q+1Hw==
X-Received: by 2002:a05:600c:4b88:: with SMTP id e8mr22473993wmp.107.1623766277491;
        Tue, 15 Jun 2021 07:11:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y189sm16367815wmy.25.2021.06.15.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:11:17 -0700 (PDT)
Message-Id: <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 14:11:12 +0000
Subject: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Technical writing seeks to convey information with minimal friction. One
way that a reader can experience friction is if they encounter a
description of "a user" that is later simplified using a gendered
pronoun. If the reader does not consider that pronoun to apply to them,
then they can experience cognitive dissonance that removes focus from
the information.

When choosing a gendered pronoun, that pronoun no longer applies to
nearly half of possible readers. Even if we alternated between "he/him"
and "she/her" perfectly evenly, we would still expect male and female
readers to experience an incorrect pronoun half the time. However, some
readers will not prescribe to either of these binary genders. Those
readers hence suffer an incorrect pronoun the entire time.

To make our documentation more inclusive, add recommendations to the
CodingGuidelines document. We can refer to this section when a
contributor submits a patch with a gendered pronoun and these
recommendations apply. The examples can assist in producing a new patch
with adjusted language.

As noted in the guidelines, removing an example person can make the
writing clearer and more concise. Other techniques such as singular
"you" and plural "they" are widely accepted ways to adjust the noun and
avoid gendered pronouns. Finally, an author can resort to singluar
"they" if absolutely necessary, but this can be difficult for readers
who learned English in a way that dictated "they" as always plural.

If we refer to a specific person, then using a gendered pronoun is
appropriate. There can also be other cases where it is inappropriate for
us to update the existing examples within the Git codebase, such as:

* References to real people (e.g. Linus Torvalds, "the Git maintainer").
  Do not misgender real people. If there is any doubt to the gender of a
  person, then avoid using pronouns.

* References to fictional people with clear genders (e.g. Alice and
  Bob).

* Sample text used in test cases (e.g t3702, t6432).

* The official text of the GPL license contains uses of "he or she", but
  modifying the license this way is not within the scope of the Git
  project.

* Literal email messages in Documentation/howto/ should not be edited
  for grammatical concerns such as this, unless we update the entire
  document to fit the standard documentation format. If such an effort is
  taken on, then the authorship would change and no longer refer to the
  exact mail message.

* External projects consumed in contrib/ should not deviate solely for
  style reasons. Recommended edits should be contributed to those
  projects directly.

Other cases within the Git project were cleaned up by the previous
changes.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/CodingGuidelines | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index e3af089ecf26..0282f836548a 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -551,6 +551,34 @@ Writing Documentation:
  documentation, please see the documentation-related advice in the
  Documentation/SubmittingPatches file).
 
+ In order to ensure the documentation is inclusive, avoid assuming
+ that an unspecified example person is male or female, and think
+ twice before using "he", "him", "she", or "her".  Here are some
+ tips to avoid use of gendered pronouns:
+
+  - Removing the example person might make the sentence more
+    clear and efficient.  Instead of saying "The programmer
+    chooses between X and Y as she sees fit", it is clearer to
+    say "Valid choices are X and Y".
+
+  - If you need to talk about an example person, then try using
+    second-person to allow the reader to be that example.  For
+    example, "If you want X to happen, you'd pass option Y",
+    instead of "If the user wants X to happen, she'd ...").
+    Alternatively, replace the single example with more than one
+    person and use plural "they", such as "Interested readers
+    can read 'git log -p README' to learn the history in their
+    ample spare time" instead of "an interested reader" learning
+    in "his" spare time).
+
+  - If you absolutely need to refer to an example person that is
+    third-person singluar, you may resort to "singular they" (e.g.
+    "A contributor asks their upstream to pull from them").  Note
+    that this sounds ungrammatical and unnatural to those who
+    learned English as a second language in some parts of the
+    world, so should be avoided unless the earlier techniques
+    fail to improve the sentence.
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.
-- 
gitgitgadget
