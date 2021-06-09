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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F06C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1BB61351
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhFIN4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhFIN4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:56:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721FC061760
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 06:54:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q5so25628181wrm.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eSwTqLxlz//8yRp07gls5fQcj/wK9ouflgr+iT5pjGU=;
        b=YJEZWJFJp90CSeTwzbTluAyhWQLQwtVhpnO/5oVTcYrORFdjetRpR4oh5iWX5N3ojp
         SY8E2EhfOg8h8PtbG9zGaQAkfsPEK6Dv6UhFkUhrxxB0l5Qj8eCH41y4WgHH6w523oQ9
         bP3R09OkeHT9Ik8gmaf1hqkHgjVdY7tHGzH69NvWqnhewxsVTylRP7rVatB+CPDTj5N0
         5U1ohNctuT8sqLmDZHvvnVyKiHBBtYVcSkTILU+5R+i2I4W8+XtMWRv4MK8zGg2OX3rV
         ointNVvIY2o1N7LQ646lZCdV+UD0daRFzv6K9Qn0w1BVKV7KzTw4wiSRvm1rwhoaD2VG
         jXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eSwTqLxlz//8yRp07gls5fQcj/wK9ouflgr+iT5pjGU=;
        b=gZyrq05g9PttG5k1Ud57XiIYnA2PejKj0MN806v0o1oTV1QqXyJsW1prORkXm/JwR4
         ZDDgl74sEkb6LFt2EuSTxuk2nW22FH/8DC3Somb3ZzoARSVmLS6P7fFhZmMkZq6WiM5i
         YpUQBg7Ng/FTVpuyMGSDhQu1CD8+26RbI5vnshLWooa3ZP6URnlw0QsOvQrXsyb0wT6V
         W05ei12q8oTwEfTLSLJud+a8dm7CQP5GgH2YR5JPM2Fpu4fX6OSrWCIVU+9W7sAtXKd5
         Dvm6zyN7TnJRgFv5LI9HsStG776dfUkuhHO3d/cARE+w0y7jur6jFgpHR696HgE2jsSt
         eGiQ==
X-Gm-Message-State: AOAM5307fI3QgC/m9wgsMGtPwnHIG+2Mjxz6UsqnbzhiC5FEoQcyQlHp
        ZjWnhA+B4fzmN9riaawZLBwda9Mpljc=
X-Google-Smtp-Source: ABdhPJzVtWZMzHh9SsXpHTplthp0MGPW5697js0rorhoUnYP2iaMO4GYtK07arNoufWwhYRjyIpwrg==
X-Received: by 2002:a5d:6e92:: with SMTP id k18mr28647866wrz.94.1623246882742;
        Wed, 09 Jun 2021 06:54:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5sm8697083wmk.11.2021.06.09.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:54:42 -0700 (PDT)
Message-Id: <065e2fdeb151b1672954a1133795b0e7744c465e.1623246879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 13:54:38 +0000
Subject: [PATCH v2 4/4] CodingGuidelines: recommend singular they
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

If we use singular "they/them" pronouns instead of "he/him" or "she/her"
pronouns, then we can avoid this congitive load on the reader.

Using singular "they" is also incredibly efficient. Choosing a gendered
pronoun is usually arbitrary between "he" or "she". Using constructs
such as "he or she", "s/he", or "(s)he" are more complicated than
singular "they".

When choosing a gendered pronoun, that pronoun no longer applies to
nearly half of possible readers. Even if we alternated between "he/him"
and "she/her" perfectly evenly, we would still expect male and female
readers to experience an incorrect pronoun half the time. However, some
readers will not prescribe to either of these binary genders. Those
readers hence suffer an incorrect pronoun the entire time. Singular
"they" applies to every reader.

Perhaps due to similar reasons, official style guides have changed their
stance on singuler "they" in recent years. For example, the APA style
guide changed their official recommendation in 2019 [1]. The MLA
handbook also references helpful ways to use singular "they" [2]. While
not fully endorsing it, the Chicago Manual of Style has removed its
blanket ban on singular "they" [3] (the previous recommendation was to
only use "it" as a singular non-gendered pronoun).

[1] https://apastyle.apa.org/blog/singular-they
[2] https://style.mla.org/using-singular-they/
[3] https://libraries.indiana.edu/chicago-manual-style-singular-pronoun-they

While not all styleguides are updating their recommendations, we can
make a choice as a project to adopt the concept because of the
efficiencies above, as well as the benefits of increased inclusion.

To futher justify singular "they" as an acceptable grammatical concept,
I include the careful research of brian m. carlson who collected their
thoughts on this matter [4] (lightly edited):

  Singular "they" has been used by native English speakers as part of
  the language for over half a millennium and is widely used and
  understood. This usage is specified in Merriam Webster[5]:

    The use of they, their, them, and themselves as pronouns of
    indefinite gender and indefinite number is well established in
    speech and writing, even in literary and formal contexts.

  Wiktionary notes[6] (references omitted):

    Usage of they as a singular pronoun began in the 1300s and has been
    common ever since, despite attempts by some grammarians, beginning
    in 1795, to condemn it as a violation of traditional (Latinate)
    agreement rules. Some other grammarians have countered that criticism
    since at least 1896. Fowler's Modern English Usage (third edition)
    notes that it "is being left unaltered by copy editors" and is "not
    widely felt to lie in a prohibited zone." Some authors compare use of
    singular they to widespread use of singular you instead of thou.

  Linguists fit roughly into two camps: prescriptive and descriptive.
  The former specify rules for people to use, and the latter document
  language as it is actually used without forming a judgment.

  Some prescriptivists think it is acceptable, and some do not. But
  descriptivists will rightly note that it is and has been commonly
  used in English across countries, cultures, and contexts for an
  extended period of time and is therefore generally accepted by most
  English speakers as a normal part of the language.  Since we are
  writing text for an English language audience who are mostly not
  linguists, we should probably consider using the language that most
  people will use in this context.

[4] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/
[5] https://www.merriam-webster.com/dictionary/they
[6] https://en.wiktionary.org/wiki/they

Since singular "they" might be unfamiliar to some, we also list an
option to rephrase writing to use singular "you" or plural "they". We
can use singular "you" to refer to the reader instead of an abstract
user. Plural "they" works if we refer to multiple abstract users instead
of one. The English language does not have gendered versions of these
terms.

If we refer to a specific person, then using a gendered pronoun is
appropriate. There can also be other cases where it is inappropriate for
us to update the existing examples within the Git codebase, such as:

* References to real people (e.g. Linus Torvalds, "the Git maintainer").
  Do not misgender real people. If there is any doubt to the gender of a
  person, then use singular "they".

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

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index e3af089ecf26..c75da9d131cb 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -648,3 +648,10 @@ Writing Documentation:
  inline substituted text+ instead of `monospaced literal text`, and with
  the former, the part that should not get substituted must be
  quoted/escaped.
+
+ Refer to an anonymous user in a gender neutral way. Singular "they/them"
+ pronouns are preferred over "he/him" and "she/her". Do not use more
+ complicated constructs such as "he or she" or "s/he". When in doubt about
+ how to use this pronoun, then change your sentence to use singular "you"
+ (e.g. "When you want to do X, do Y") or plural "they" (e.g. "When users
+ want to do X, they can do Y.").
-- 
gitgitgadget
