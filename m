Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706DE1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeD0Vje (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:39:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:42141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759084AbeD0Vjd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:39:33 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MGEv5-1f84td3795-00F8DN; Fri, 27 Apr 2018 23:39:26 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 01/11] argv_array: offer to split a string by whitespace
Date:   Fri, 27 Apr 2018 23:39:25 +0200
Message-Id: <178058d887281fc87e5008367bbee5677a619320.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:1jGjp51pgpaAOHjGCVsOvEZ9UBloiyG0t6Wl8QjdW8bGmwOriAD
 0jRVNiVMysmvrxSATmgipICZ2FCAHuDgbMHq8HMZtUcCBA+BB7Fg1/JPDDfNwsUzAZE/XYc
 Uq1Ih3KBITqcN9h5xLHnRHhkz70fNMUJ70q5NIRkFBdb4sqtqIUbQekLoOVZQ/eMz5PAo1A
 RvUJ3omDldcF3EF7czyog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CInzXJqwhew=:tDppzQF6a9bl8LHc7Gfe7V
 bkji5xklItkCJpu0wCmUpWwSMF6j09DnYdAidCvhX9RJflwB7EPpYvKhTvfHUohpopOR+o3rG
 86cVIRMd4MQKXJbtOBzPU/Ox9iGTfC3sTBI0bfplA2tcYMRo2A2qjwcNJtI/LSaU7U6Ttj9W/
 T8We8UPbNHqZ/bw2KLbKhXtjO3ASCSQD52FJ04Q9ujWR8NjeFHEfpouUA5VYZpD1WszO2bMB9
 O1HQ+OVYLOj8rkQiOg7F5EtS19Go8nW1qzFYeyWp6ci+klJtvvz7QmmRYHpOw6CHOUrbkNlKJ
 BV7nKWz6GqhovXdnlkWg0JVxQD1Hf9gfuVwn6SdkzKx3V6wS5IETiekFH9JUWk9GS/4HurVrU
 YVtdsIA/H0PC7qAsmRehbVGgqL4RNnG+uEiz7/KnCeb4nI8CgyzUefBh2+Om3suvzYAPs3dlJ
 X+Sxy0GIEqU1LCeSBbBTNHp3oWGmZyFbG4LqxmipBA1364u1mCsbD24k07Sjw53/YRi7hFF+s
 7vRcPUaWqkqZe7EUhocnGImCQYZlHKI5NdMGdmDze4TeQb9S5fL0UpiBJYaVrs1vev9sqSgJA
 CFAct46KDmaLJTaaZ4sZPyUlEq6P5lmGllGV0ZB6egmSilobOJt7/8LvQz4g1UwwfTVropvId
 TP48MiepwDM5Y2e7skUBdMhxTnAtg+/yZoM2qbQoaXFGtx08gFr+THp+7T8xF1Ws8DxKAmVTd
 HVsRrbpDp1diUl2IzaMlsDFIN9XgeyI2KN2kfUve7TDRw5cHxkEwSgks2c+GbfN0Y2C1G8mxg
 AkIWSW3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a simple function that will interpret a string as a whitespace
delimited list of values, and add those values into the array.

Note: this function does not (yet) offer to split by arbitrary delimiters,
or keep empty values in case of runs of whitespace, or de-quote Unix shell
style. All fo this functionality can be added later, when and if needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 argv-array.c | 20 ++++++++++++++++++++
 argv-array.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/argv-array.c b/argv-array.c
index 5d370fa3366..cb5bcd2c064 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -64,6 +64,26 @@ void argv_array_pop(struct argv_array *array)
 	array->argc--;
 }
 
+void argv_array_split(struct argv_array *array, const char *to_split)
+{
+	while (isspace(*to_split))
+		to_split++;
+	for (;;) {
+		const char *p = to_split;
+
+		if (!*p)
+			break;
+
+		while (*p && !isspace(*p))
+			p++;
+		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
+
+		while (isspace(*p))
+			p++;
+		to_split = p;
+	}
+}
+
 void argv_array_clear(struct argv_array *array)
 {
 	if (array->argv != empty_argv) {
diff --git a/argv-array.h b/argv-array.h
index 29056e49a12..750c30d2f2c 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -19,6 +19,8 @@ LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
 void argv_array_pop(struct argv_array *);
+/* Splits by whitespace; does not handle quoted arguments! */
+void argv_array_split(struct argv_array *, const char *);
 void argv_array_clear(struct argv_array *);
 const char **argv_array_detach(struct argv_array *);
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


