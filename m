Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A22271F462
	for <e@80x24.org>; Thu, 23 May 2019 20:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbfEWUYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:24:48 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:36493 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbfEWUYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:24:48 -0400
Received: by mail-ua1-f73.google.com with SMTP id a6so1761180uah.3
        for <git@vger.kernel.org>; Thu, 23 May 2019 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s+nc9sTIkL0fldspbL+xP5uBJaPQztoxELnhxPJR0Mw=;
        b=JhVf7b3SgwiAbi4wfoDXjyG83rA4VVJx+8OD3Ij+HpbeMtElQlljIx9D42xXPaDUtL
         I8k57it/7IZDdRFvuUPU3my1+4OsshsxD+i26eMY7kc2tMnjVAAN36k7mqggaVYJxQ+E
         8p+BP2VjebbS+VZsa3+536ixcqsYo6Ejw6R2bwOee270cKO3Ick8tzLpXbLJ55krtj0f
         T2+F4GvOYGNTAkC4Wu8Xi4sBLRz7Ow6NThGvhPoXm1hFL2JdxbTK9lvcXZy2T96CuRj1
         6hkBgDQM4oPws/q98iiLvklb6R98pdfYA5mexShjgc+8nSt9M9A2bXR9ErxDgwpxKW49
         P69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s+nc9sTIkL0fldspbL+xP5uBJaPQztoxELnhxPJR0Mw=;
        b=r3sBvagEpJ9IFM7dmEV6ng/Dd4lcZKgaMuExuGvBzTZ39ouE8ptjBV4bDv58E9JjDw
         daXOb2rW/z6ZBWU50QIvMlUAdwXWn64pg7+US+yP4nd4YaepGi1kg/GE697abeJXWv4r
         9DZi9NmIu2SfwrvBM5NoBQUIUyXiuLEgB/jVIi72+1/ApAenTi84Uf4GkZhQlmM+LOA+
         shbgnrkzxboCGgDjwW3wg5DbdXdOLyvAmofBw5AL40j38bATNVsIuIWb36ri9qqx4kI0
         7nso+Pd+sVeFRSmFPwVBL2yBhUACandmRTuVwutwU9mcea/adcJwOT6/T5vt5RVvGCPI
         XYJA==
X-Gm-Message-State: APjAAAVAac8G5vpSKsd1fUwkjQe2wluXW9j9XqwPxVysSWc3zT3T9YAB
        Vlo0DvU5Dpv1U93TshnC1fkAXH9ATIog2JlAt1uTMCOhe/N52Be35wz9dacwaAnTBihO6LjEyRU
        RU6y/0xEK1ml4iCCKKKXmAU0yIDGyzR3wFAA49cwNb0AraTVbUcAce6ascHSq7yd7oXCin5WBoA
        ==
X-Google-Smtp-Source: APXvYqyL+LuSg9cb1c3S/oC/oEw1kcJTJYzTPS6f1o8Q6eAsq6COXj0oFQa+6N85uWYoIZiQM+rY7ZjNEaYdO3NX0u8=
X-Received: by 2002:ab0:1849:: with SMTP id j9mr1617309uag.75.1558643087437;
 Thu, 23 May 2019 13:24:47 -0700 (PDT)
Date:   Thu, 23 May 2019 13:23:56 -0700
In-Reply-To: <20190522003402.77767-1-emilyshaffer@google.com>
Message-Id: <20190523202355.152742-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190522003402.77767-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v4] grep: fail if call could output and name is null
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep_source(), which performs much of the work for Git's grep library,
allows passing an arbitrary struct grep_source which represents the text
which grep_source() should search to match a pattern in the provided
struct grep_opt. In most callers, the grep_source::name field is set to
an appropriate prefix to print before a colon when a result matches:

	README:Git is an Open Source project covered by the GNU General

One caller, grep_buffer(), leaves the grep_source::name field set to
NULL because there isn't enough context to determine an appropriate name
for this kind of output line. In practice, this has been fine: the only
caller of grep_buffer() is "git log --grep", and that caller sets
grep_opt::status_only, which disables output and only checks whether a
match exists. But this is brittle: a future caller can call
grep_buffer() without grep_opt::status_only set, and as soon as it hits
a match, grep_source() will try to print the match and segfault:

	(null):Git is an Open Source project covered by the GNU General

For example, a future caller might want to print all matching lines from
commits which match a regex.

Futureproof by diagnosing early a use of the API that could trigger that
condition, before we know whether the pattern matches:

	BUG: grep.c:1783: grep call which could print a name requires
		grep_source.name be non-NULL
	Aborted

This way, the caller's author gets an indication of how to fix the issue
- by providing grep_source::name or setting grep_opt::status_only - and
they are warned of the potential for a segfault unconditionally, rather
than only if there is a match.

Noticed while adding such a call to a tutorial on revision walks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since v3, only the commit message has changed. Reworked based on
Jonathan Nieder's suggestions (with some modifications for readability).

 - Emily

 grep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/grep.c b/grep.c
index 0d50598acd..f7c3a5803e 100644
--- a/grep.c
+++ b/grep.c
@@ -1780,6 +1780,10 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
+	if (!opt->status_only && gs->name == NULL)
+		BUG("grep call which could print a name requires "
+		    "grep_source.name be non-NULL");
+
 	if (!opt->output)
 		opt->output = std_output;
 
-- 
2.22.0.rc1.257.g3120a18244-goog

