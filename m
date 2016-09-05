Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEAD20193
	for <e@80x24.org>; Mon,  5 Sep 2016 09:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932588AbcIEJpe (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:34 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57963 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932416AbcIEJpa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:30 -0400
X-AuditID: 12074412-1afff70000000931-b3-57cd3eac5dad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 5C.04.02353.CAE3DC75; Mon,  5 Sep 2016 05:45:17 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtU008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:14 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 7/8] parse-options: add parse_opt_unknown_cb()
Date:   Mon,  5 Sep 2016 11:44:52 +0200
Message-Id: <963d6e9bce6348af0d5a7ad1284b64e97d28a2a2.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqLvO7my4wSY1i64r3UwWDb1XmC12
        L+5ntlhxdQ6zxZmtQNbtFfOZLX609DBbzLxqbbF5czuLA6fH3/cfmDx2zrrL7rFgU6nHs949
        jB4XLyl77F+6jc3j8yY5j9vPtrEEcERx2aSk5mSWpRbp2yVwZbw48oq14Bh/xbW9jUwNjPd4
        uhg5OSQETCQuf7zB0sXIxSEksJVR4uCBF1DOSSaJr8v+MYJUsQnoSizqaWYCsUUExCXeHp/J
        DlLELPCXSWLxo7tsIAlhAUeJbd9fsYLYLAKqEl0zHrCA2LwCURK3rsxjhVgnJ3Fp2xdmEJtT
        wEJiyZc+dhBbSMBcYt68ZuYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluil
        ppRuYoQEn9AOxvUn5Q4xCnAwKvHwWmifCRdiTSwrrsw9xCjJwaQkylugejZciC8pP6UyI7E4
        I76oNCe1+BCjBAezkghvji1QjjclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaG
        g0NJgnc+SKNgUWp6akVaZk4JQpqJgxNkOA/Q8Gdgw4sLEnOLM9Mh8qcYFaXEea+AJARAEhml
        eXC9sOTwilEc6BVhXlFgqhDiASYWuO5XQIOZgAav230aZHBJIkJKqoFx0eqDfNOjNS9K9l+u
        eCXzSlVevv2+c/eEhFKJrNaDt4PmrXynt6nH9dbSJw6ecpqfjQSK+VurLMozg6fOK1349Iis
        itDNpxvWa35g65i+2dRoXfH+L5KGd8uiU0X+FO3ymebodMU9oOqt+8+1NXN+X4nN9z1/WXpH
        /p6vK6t+rfj5oKpnKqOhEktxRqKhFnNRcSIAOIshaukCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new callback function, parse_opt_unknown_cb(), which returns -2 to
indicate that the corresponding option is unknown. This can be used to
add "-h" documentation for an option that will be handled externally to
parse_options().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
See the next patch for the reason I implemented this change. Let me
know if there is an easier way to do this.

 parse-options-cb.c | 12 ++++++++++++
 parse-options.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 9667bc7..b5d9209 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -159,6 +159,18 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 }
 
 /**
+ * Report that the option is unknown, so that other code can handle
+ * it. This can be used as a callback together with
+ * OPTION_LOWLEVEL_CALLBACK to allow an option to be documented in the
+ * "-h" output even if it's not being handled directly by
+ * parse_options().
+ */
+int parse_opt_unknown_cb(const struct option *opt, const char *arg, int unset)
+{
+	return -2;
+}
+
+/**
  * Recreates the command-line option in the strbuf.
  */
 static int recreate_opt(struct strbuf *sb, const struct option *opt,
diff --git a/parse-options.h b/parse-options.h
index 78f8384..dcd8a09 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -228,6 +228,7 @@ extern int parse_opt_commits(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
+extern int parse_opt_unknown_cb(const struct option *, const char *, int);
 extern int parse_opt_passthru(const struct option *, const char *, int);
 extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 
-- 
2.9.3

