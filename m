Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EA22013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755710AbdBOXs7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:48:59 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32976 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932739AbdBOXs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:48:56 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so169533pgj.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1QES49G0zmSMnNk2UJkSdk9KjLHsWk1gbj0rATmu/hE=;
        b=FAGlCHUFoueW6gpvjPo6mv0/BWcV7r1215UR5kBzZvuMcnir7AaF8hf/Daj/IsydVz
         V9YbtSnzrnNNZX4TKFsFFxFWMZ7W8jxwWvbfG8xkLsewSipZL3pddg7xUgdaPZDFqI5t
         sSLUNtuN4EOq9FF7a2PaxkYyID/C+jAajIGGfDMCbk214DrSHhnjHRoPaBg+YIBnADPy
         3gOp2YhV6FDacnYY7U6RvVn7Ki7yIUxTKXECPa4Q0C+kmbCwuyRWXq1XlWi83/Mx9dKT
         7wI7qnLzMrdgTgu36n2Nuto+xF4iLUwbsIpCmVZCRAqxG5qsF8hGTigYuej9V5zVpVq8
         KRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1QES49G0zmSMnNk2UJkSdk9KjLHsWk1gbj0rATmu/hE=;
        b=f/FyWBPB+tLHNncuP6UKfTZZT8snPd6i+1qVLDHNIzBnIN7/q1JfNcCS0hhW+Cyfks
         vCmuEqjUhxptxVlPn4IEDyAsSG8aC9dr2CRRBn6h2BKxZci2kJY5MKLnWRE3V452T41b
         BrGtfx6ue5fDEzZyOaqxFwq9XX/yI/hdvrj2APWrLbVCGrtDvii+BJFNjDaK4qr8lOnE
         E2JMYV0OvAjFs4cl6OzAzocTSkIbxSCoEUBNaS6wkGon6AqMkkWz/7DbP7pkGx6x+ep+
         IYLVDrDDxsmC+2+sfX/1g08t21otpPOJ31g1kYv/Gii48KnsPcu/3f4cwpuS0060OiFt
         To6Q==
X-Gm-Message-State: AMke39kx5is0X6WMQTuCNUMJEbgG4+Pr9xUdGxnKLOn6CVTXHt6FQiQJOTw1paZPz8IuKg==
X-Received: by 10.99.136.198 with SMTP id l189mr41447462pgd.45.1487202525480;
        Wed, 15 Feb 2017 15:48:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id e2sm9460926pga.61.2017.02.15.15.48.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 15:48:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: [PATCH] config: preserve <subsection> case for one-shot config on the command line
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 15 Feb 2017 15:48:44 -0800
In-Reply-To: <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 15 Feb 2017 15:11:24 -0800")
Message-ID: <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0dfed682b8..e9b93b5304 100644
--- a/config.c
+++ b/config.c
@@ -199,6 +199,26 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
+/*
+ * downcase the <section> and <variable> in <section>.<variable> or
+ * <section>.<subsection>.<variable> and do so in place.  <subsection>
+ * is left intact.
+ */
+static void canonicalize_config_variable_name(char *varname)
+{
+	char *dot, *cp;
+
+	dot = strchr(varname, '.');
+	if (dot)
+		for (cp = varname; cp < dot; cp++)
+			*cp = tolower(*cp);
+	dot = strrchr(varname, '.');
+	if (dot)
+		for (cp = dot + 1; *cp; cp++)
+			*cp = tolower(*cp);
+}
+
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
@@ -221,7 +241,7 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	strbuf_tolower(pair[0]);
+	canonicalize_config_variable_name(pair[0]->buf);
 	if (fn(pair[0]->buf, value, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
-- 
2.12.0-rc1-258-g3d3d1e383b

