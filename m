Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63AC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 23:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjARXYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjARXYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 18:24:34 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A442315563
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:24:32 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b6so157438pgi.7
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjSFcqbri33rNC1QkPIpQUHZBddUfD8DBr4MCZJEDcQ=;
        b=UU9hjtCuUsusoWqKB+TkqjVwF+5CyDgPC2ADu0z2CiTb9XtHMIp+kgOPrnBmOhU8Og
         yiR+UcWn8YpxAyHu/q/lDH6YxWeHqUEV98vsoQqXOZnV9bCzRJ7althltMUHWvIxArZS
         ogEDJvOllTtigtNkcs+neDM8J+VivlaN8fog7PX+69wrzDFVMSJKv9LLn3EFYI1jdtew
         Y6eLm+BUGTicDxcz2qd7fTw6BkcB9xN7yjMXllhmj/24681d0gsLynfa+DEFxXXnS9QH
         uCZFfEuZt3rqxOwde/Dfj2e3LieAjiPQS3HJgZjCquNruSJtfeq51YZe5eJumu8TIDzx
         n2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjSFcqbri33rNC1QkPIpQUHZBddUfD8DBr4MCZJEDcQ=;
        b=ceD91ZzcHjAWi2le3sZV5AoOt120fg4tqhSIHcehY2yK/zJEBbSuzAMBNOBC2cUSEn
         vQzuJ0DtSBdNAAeFAX+bNBBImdII9QnmgGCLb5sI4OI6gg8NNtD2dlvJ1kWm507dF6Vv
         smBVwa8zKokNhHkE8wZ2NB6I0Mam1IKeMh62tEh5B2srPeHjjsF1bisnlSe+vepz99Dq
         YTN5m3SI9MBuLMB1ogEPriNrPxd/aurS5LrymVmwVmirnbVJpo2Dpdp8SFoc5GCjBOoU
         j/8Ej1Fn0IAgakJKGrTBorKsHsvQJd3tqZpUWB44nnxOFBT3CyUV/q/cAziWDXcea9SO
         HXrQ==
X-Gm-Message-State: AFqh2krMA9T4klPLx6zjM/KWqsxawzwSrF00NIrD8qO9IOwZUTE32yQD
        9g+AWh//q8i5oobk3xWoLws=
X-Google-Smtp-Source: AMrXdXvqDErbDYiAvAFKWRYuMQHi3GWyy8ufumcOLSqxj8/04X6icqAnR+9W4NFAVk1aXuKdYJ0O/w==
X-Received: by 2002:a62:6104:0:b0:588:a156:6a3d with SMTP id v4-20020a626104000000b00588a1566a3dmr9431198pfb.26.1674084272020;
        Wed, 18 Jan 2023 15:24:32 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x5-20020a628605000000b0058bca264253sm8338897pfd.126.2023.01.18.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:24:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        Diomidis Spinellis <dds@aueb.gr>
Subject: Re: [PATCH v3] grep: correctly identify utf-8 characters with
 \{b,w} in -P
References: <20230108155217.2817-1-carenas@gmail.com>
        <20230117105123.58328-1-carenas@gmail.com>
        <230117.865yd5z4ke.gmgdl@evledraar.gmail.com>
        <xmqqr0vt9oj9.fsf@gitster.g>
        <CAPUEspgzrW63GgbjXhKuvjpKXjEhiKaC7jtupiB-3AhcKTba8A@mail.gmail.com>
        <230118.86tu0ovyvj.gmgdl@evledraar.gmail.com>
        <xmqq7cxj6chn.fsf@gitster.g>
        <230119.86cz7bwign.gmgdl@evledraar.gmail.com>
Date:   Wed, 18 Jan 2023 15:24:30 -0800
In-Reply-To: <230119.86cz7bwign.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 19 Jan 2023 00:06:43 +0100")
Message-ID: <xmqqzgaf2zpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> In short, it sounds to me that the earlier one that added PCRE2_UCP
>> unconditionally would be the best alternative among those that have
>> been discussed.
>
> I agree.

So, ... we'll mark cb/grep-pcre-ucp, ea8bc435 (grep: correctly
identify utf-8 characters with \{b,w} in -P, 2023-01-08), to be
merged to 'next' and see what happens.  I'll add your Acked-by
while at it, if you do not mind.

---- >8 --------- >8 --------- >8 --------- >8 ------
From: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Date: Sun, 8 Jan 2023 07:52:17 -0800
Subject: [PATCH] grep: correctly identify utf-8 characters with \{b,w} in -P

When UTF is enabled for a PCRE match, the corresponding flags are
added to the pcre2_compile() call, but PCRE2_UCP wasn't included.

This prevents extending the meaning of the character classes to
include those new valid characters and therefore result in failed
matches for expressions that rely on that extention, for ex:

  $ git grep -P '\bÆvar'

Add PCRE2_UCP so that \w will include Æ and therefore \b could
correctly match the beginning of that word.

This has an impact on performance that has been estimated to be
between 20% to 40% and that is shown through the added performance
test.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                              |  2 +-
 t/perf/p7822-grep-perl-character.sh | 42 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p7822-grep-perl-character.sh

diff --git a/grep.c b/grep.c
index 06eed69493..1687f65b64 100644
--- a/grep.c
+++ b/grep.c
@@ -293,7 +293,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		options |= PCRE2_CASELESS;
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && !literal)
-		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
+		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
 
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
diff --git a/t/perf/p7822-grep-perl-character.sh b/t/perf/p7822-grep-perl-character.sh
new file mode 100755
index 0000000000..87009c60df
--- /dev/null
+++ b/t/perf/p7822-grep-perl-character.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description="git-grep's perl regex
+
+If GIT_PERF_GREP_THREADS is set to a list of threads (e.g. '1 4 8'
+etc.) we will test the patterns under those numbers of threads.
+"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+if test -n "$GIT_PERF_GREP_THREADS"
+then
+	test_set_prereq PERF_GREP_ENGINES_THREADS
+fi
+
+for pattern in \
+	'\\bhow' \
+	'\\bÆvar' \
+	'\\d+ \\bÆvar' \
+	'\\bBelón\\b' \
+	'\\w{12}\\b'
+do
+	echo '$pattern' >pat
+	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+	then
+		test_perf "grep -P '$pattern'" --prereq PCRE "
+			git -P grep -f pat || :
+		"
+	else
+		for threads in $GIT_PERF_GREP_THREADS
+		do
+			test_perf "grep -P '$pattern' with $threads threads" --prereq PTHREADS,PCRE "
+				git -c grep.threads=$threads -P grep -f pat || :
+			"
+		done
+	fi
+done
+
+test_done
-- 
2.39.1-231-ga7caae2729

