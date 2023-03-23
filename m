Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF14C6FD1D
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 14:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjCWOkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCWOkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 10:40:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E310411
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 07:40:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so87615954edd.5
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679582412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrtoCcSBkDW8QfZYCE/ntr93/lgTNME91z/24rXjd/U=;
        b=TRCl5KTG1E6Lq5BE4TFgs6ViEXoXflztBfyKCtjq/jHPh0EBSAu3F2J6G1H3MLhLjX
         uakG6ss00ZsWLfrepSXSP62/meppFy8UGgMygfNi/8axgYEVPmOD+TxpPXvbY8AfkDaR
         q4XRf2R9/5mLmN7D21vS6vodVpRWsDJqYoE2uGs/4pkqfc7RYNnD16KMlQyS2lbspfuo
         KYdwCSNd/1tg5HiULcUGsjVjLv8/bMNTTsip3dWa4dkxMGE8sgaTiJAn/cgwKoMNIEg2
         uUw9eO/ndavl91JEJDbxeSktbdGztNoQq2JrVvhyIJx4bQ6Mh1zKFLZxHYQojgPlSgVe
         zC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrtoCcSBkDW8QfZYCE/ntr93/lgTNME91z/24rXjd/U=;
        b=n3OoN2eRGILC8KjBDueeUfBF4AZEa5Qf1Z7P6Y7a3xYwaGCFpUJ6p71gy/kJELbkac
         rckQVxWkTsTIk07YGiyi+VUkCsrsEDGIaECVLw6EDuknF5KfMJ1F1+Jq5NrNwCFYk6ll
         BmGiJeSjYfs2P2zpF5Jm0a1zLBQs1mOR3LJVk9TlOsjbkfNa6U4HBS6haV1oqzjONTNQ
         m7jqj3yeMEc8EaHqcIdtplRM87VC6RE3we7NYcr43R2jfnTN69GdBapSR81I3kaidRVV
         W7uDq6whZMH/iSqEsS0ivvSglV26Tp0oS02stH7yd2tOS2Gt1bi4PRktl2kMGFOlDP7f
         kmJQ==
X-Gm-Message-State: AO0yUKXxsT2/xIV7ozb9N0f2Nz5dz+8ILJ03pHCrdbKGKjJpzHH1ysZD
        QWBvWi1Ek/CwxgIh2DRVOn9gJ6bt6UQe/P9XaX0=
X-Google-Smtp-Source: AK7set+YtOTuhPAzL47A8wbSY6wjYeLbXeM+q4irkTXf6wo6fhwhuxR9qdtGySVQfnrHPppNgVKdlg==
X-Received: by 2002:a17:907:a042:b0:92f:2c64:9d43 with SMTP id gz2-20020a170907a04200b0092f2c649d43mr11407316ejc.68.1679582412657;
        Thu, 23 Mar 2023 07:40:12 -0700 (PDT)
Received: from x1.fritz.box (p200300f6af156c00f1a90eda5efb74bd.dip0.t-ipconnect.de. [2003:f6:af15:6c00:f1a9:eda:5efb:74bd])
        by smtp.gmail.com with ESMTPSA id h5-20020a50c385000000b004f9e6495f94sm9363987edf.50.2023.03.23.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:40:12 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        Stephane Odul <stephane@clumio.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: Suspected git grep regression in git 2.40.0 - proposed fix
Date:   Thu, 23 Mar 2023 15:40:00 +0100
Message-Id: <20230323144000.21146-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <4a103812-c4c6-a010-c2e5-4e42e9855c2e@grsecurity.net>
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com> <xmqqttyejc7y.fsf@gitster.g> <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net> <51078D7E-C325-4F57-96C1-601B4E102DD9@clumio.com>, <4a103812-c4c6-a010-c2e5-4e42e9855c2e@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I looked a little further and found an interesting entry in the PCRE2's
changelog for version 10.35:

https://github.com/PCRE2Project/pcre2/blob/pcre2-10.35/ChangeLog#L66:

  17. Fix a crash which occurs when the character type of an invalid UTF
  character is decoded in JIT.

Its fix commit https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
and associated unit test is basically doing the same as what Stephane is
running into: making the JIT compiled code choke on something that's not
a valid UTF-8 string.

So it looks like we're out of luck and have to implement yet another
quirk to handle these broken versions. We can either disable the JIT
compiler completely for these versions (and exchange the segfault for a
serve performance regression) or fall-back to the previous behaviour and
ignore Unicode properties (and reintroduce the bug commit acabd2048ee0
("grep: correctly identify utf-8 characters with \{b,w} in -P") wanted
to fix).

I went with the second option and could confirm the below patch fixes
the segfault on Ubuntu 20.04 which is shipping the broken version.

Junio, what's your call on it? Below patch or simply a revert of commit
acabd2048ee0? Other ideas?

Thanks,
Mathias

-- >8 --
Subject: [PATCH] grep: work around UTF-8 related JIT bug in PCRE2 <= 10.34

Stephane is reporting[1] a regression introduced in git v2.40.0 that leads
to 'git grep' segfaulting in his CI pipeline. It turns out, he's using an
older version of libpcre2 that triggers a wild pointer dereference in
the generated JIT code that was fixed in PCRE2 10.35.

Instead of completely disabling the JIT compiler for the buggy version,
just mask out the Unicode property handling as we used to do prior to
commit acabd2048ee0 ("grep: correctly identify utf-8 characters with
\{b,w} in -P").

[1] https://lore.kernel.org/git/7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com/

Reported-by: Stephane Odul <stephane@clumio.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 grep.c | 11 ++++++++++-
 grep.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index cee44a78d044..d249beae60d0 100644
--- a/grep.c
+++ b/grep.c
@@ -317,8 +317,17 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && !literal)
+	if (!opt->ignore_locale && is_utf8_locale() && !literal) {
 		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
+#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
+		/*
+		 * Work around a JIT bug related to invalid Unicode character
+		 * handling fixed in 10.35:
+		 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
+		 */
+		options ^= PCRE2_UCP;
+#endif
+	}
 
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
diff --git a/grep.h b/grep.h
index 6075f997e68f..c59592e3bdba 100644
--- a/grep.h
+++ b/grep.h
@@ -7,6 +7,9 @@
 #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
 #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
 #endif
+#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 35) || PCRE2_MAJOR >= 11
+#define GIT_PCRE2_VERSION_10_35_OR_HIGHER
+#endif
 #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 34) || PCRE2_MAJOR >= 11
 #define GIT_PCRE2_VERSION_10_34_OR_HIGHER
 #endif
-- 
2.39.2

