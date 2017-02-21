Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0AA201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 17:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbdBURRM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 12:17:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36197 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753514AbdBURRK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 12:17:10 -0500
Received: by mail-pg0-f68.google.com with SMTP id z128so425543pgb.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QBQc0+V/oeud/zDMcv4f3+lOgXe3tkD5Pi/Duj3nOnI=;
        b=Ui0ll298Ti8/Xxk+p8m0zeD+moHx1dw10lvUOz9UJYpBSnF0fvvGNXkH1qXKJCF4AB
         s2kyYdszAwsUf5CeahOsIqE/G/CJeeI6XgWFbSEtr4lOa+y8hHqzks8Kyv/TRzEzB0jo
         zl7wjyNyb6McbzhaIrd7mFFTzmjHFECCuNC5WItDD2+mAFbnVrlHL7H0DqPvqYG8G9ZP
         h1ZfkGmzLLmaQNkxgSlBxs6KQO6bEm2JyEq8uF9AN+/Fgn4NsC8kMY6/6P74G3kfj3Xd
         Hrx8izTcBF3QmQ8vQ7ihXZBQS9o9DhhrcBuKuUqwARQ3koMwYc+Ckuwr0dP0rS8NMK2R
         bvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QBQc0+V/oeud/zDMcv4f3+lOgXe3tkD5Pi/Duj3nOnI=;
        b=o2YuruSKwA3axx5eriR2LRYrLpGzKe8+d51so4674s8YioZfLTDZmN2NR/EriJnO6L
         2kAL2vLMvDQ25k5QzE8FEafNIa7+ouFvWd66lXw6/cLXxLo+m1pxBuTe8rT3EksHMMRT
         +BlMm6QjcUtuYD0BAJFvJhmeD/egGxBIG6JOMOmZR7PFFWJvgPwfNxHt6nPvIMR0+H6n
         ESW1UgRPb1se2tw4eNyuG37JjwsmRuYDhe1Wq2uLV+/N+IkYcJR5lBo5ZxyinLGjbqjy
         MBi7PGXjhbAI8IJLEnatHsri9Jr7tYbN+l9TABAuNsR2f0e0ZnwdkuH0x8HMV5jlQQV1
         jlgA==
X-Gm-Message-State: AMke39m/U6xOLawj/crnn4Pdu0nSyaPpNbUPoSwuG/+ttOqpG4gFfK02mdttQjQtenCZuw==
X-Received: by 10.99.175.67 with SMTP id s3mr14731645pgo.185.1487697429398;
        Tue, 21 Feb 2017 09:17:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id l22sm10760776pfk.69.2017.02.21.09.17.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 09:17:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH v2] config: preserve <subsection> case for one-shot config on the command line
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <20170221073813.w4zrkky2d4drnwbs@sigill.intra.peff.net>
        <xmqqino3h3zv.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 21 Feb 2017 09:17:07 -0800
In-Reply-To: <xmqqino3h3zv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 21 Feb 2017 09:01:56 -0800")
Message-ID: <xmqqd1ebh3ak.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git -c <var>=<val> cmd" mechanism is to pretend that a
configuration variable <var> is set to <val> while the cmd is
running.  The code to do so however downcased <var> in its entirety,
which is wrong for a three-level <section>.<subsection>.<variable>.

The <subsection> part needs to stay as-is.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Diagnosed-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Changes from v1:

   - update the comment before the second loop to find the last
     dot.

   - move two new tests into existing t1300 (at least for now).

   - make it clear that the second of the new tests check two
     aspects of "three level vars" by setting up the expectation for
     the first half near the actual tests and adding comments on
     what it tests before the second half.

 config.c               | 30 +++++++++++++++++++++++++++++-
 t/t1300-repo-config.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0dfed682b8..4128debc71 100644
--- a/config.c
+++ b/config.c
@@ -199,6 +199,34 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
+/*
+ * downcase the <section> and <variable> in <section>.<variable> or
+ * <section>.<subsection>.<variable> and do so in place.  <subsection>
+ * is left intact.
+ */
+static void canonicalize_config_variable_name(char *varname)
+{
+	char *cp, *last_dot;
+
+	/* downcase the first segment */
+	for (cp = varname; *cp; cp++) {
+		if (*cp == '.')
+			break;
+		*cp = tolower(*cp);
+	}
+	if (!*cp)
+		return;
+
+	/* find the last dot (we start from the first dot we just found) */
+	for (last_dot = cp; *cp; cp++)
+		if (*cp == '.')
+			last_dot = cp;
+
+	/* downcase the last segment */
+	for (cp = last_dot; *cp; cp++)
+		*cp = tolower(*cp);
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
@@ -221,7 +249,7 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	strbuf_tolower(pair[0]);
+	canonicalize_config_variable_name(pair[0]->buf);
 	if (fn(pair[0]->buf, value, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 923bfc5a26..7a16f66a9d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1097,6 +1097,52 @@ test_expect_success 'multiple git -c appends config' '
 	test_cmp expect actual
 '
 
+test_expect_success 'last one wins: two level vars' '
+
+	# sec.var and sec.VAR are the same variable, as the first
+	# and the last level of a configuration variable name is
+	# case insensitive.
+
+	echo VAL >expect &&
+
+	git -c sec.var=val -c sec.VAR=VAL config --get sec.var >actual &&
+	test_cmp expect actual &&
+	git -c SEC.var=val -c sec.var=VAL config --get sec.var >actual &&
+	test_cmp expect actual &&
+
+	git -c sec.var=val -c sec.VAR=VAL config --get SEC.var >actual &&
+	test_cmp expect actual &&
+	git -c SEC.var=val -c sec.var=VAL config --get sec.VAR >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'last one wins: three level vars' '
+
+	# v.a.r and v.A.r are not the same variable, as the middle
+	# level of a three-level configuration variable name is
+	# case sensitive.
+
+	echo val >expect &&
+	git -c v.a.r=val -c v.A.r=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c v.A.r=VAL config --get V.a.R >actual &&
+	test_cmp expect actual &&
+
+	# v.a.r and V.a.R are the same variable, as the first
+	# and the last level of a configuration variable name is
+	# case insensitive.
+
+	echo VAL >expect &&
+	git -c v.a.r=val -c v.a.R=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c V.a.r=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c v.a.R=VAL config --get V.a.R >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c V.a.r=VAL config --get V.a.R >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git -c is not confused by empty environment' '
 	GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
 '
-- 
2.12.0-rc2-221-ga92f6f5816

