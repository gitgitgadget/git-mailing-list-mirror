Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDF6200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755538AbcL0QXo (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:44 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36149 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755511AbcL0QXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:38 -0500
Received: by mail-pg0-f68.google.com with SMTP id n5so12847480pgh.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KLU0FINiwqySSSrT3z3LT7T5P5tVKDn6oTBSU1QxYWY=;
        b=LGcExL5lP02xGRVdmB4ZJcusJ+oYWD0G/VvxrC4rCO4aCExWQtAshIhLrSkmEdPJ2K
         tTs+sBJ4EccFPQFzIxKpvnYF2w3I8WbdqYzz7iNipsxMl+FegY6cIIIAAef4UPeSn6wX
         QYFDHg4yPV9qUs6miAD+lpfXgfUUnIMg0TFtNRNhEmkLj2W23EvH3DZArQzWYPBjknJq
         p+jCZIXabWJT72lRqIicLDHuOyZmkC9a2xEbmi9QxGb7D5HNQdw09bhDRi3PMbp854PK
         8C26ePlYpegusjqOWc8IryMFeCtPSZ6qBQg6P/WH42AW7zGmsT4uWCgEYd2WOMKAAj6Y
         rxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KLU0FINiwqySSSrT3z3LT7T5P5tVKDn6oTBSU1QxYWY=;
        b=fblE0nS3Lvc4ndMuHoqrvdatQCXEPWZ8vQoruqYQT7KZBOyNj59vSDdDz1Uhe9l2gX
         oA/jYvAF1nE7z1kK/XbmwBvr/yX/gVcGBHeueUTp55uk385V9FtLOiHPpvrIiz/1VaX7
         tWt61GRjkDmt+vDo7j9H3kk2/+kTcf6cv+AXzRn8LuCDEcuveUo9RPOd22SmRlOs8AiD
         7/yjtq2EK3nxpKWQMJY2JzLod1gH2lINUvVsufD1Ue9lXj/3/mQx9ddTqDJ8OPAkEnCA
         AKDg1jEdliGvc4KFWI4SBposBJwdo4ovjb8rUHM12NdCcC4AZknz4W+haLW9OxAHnLPH
         u4kg==
X-Gm-Message-State: AIkVDXJkaOpEHEt6rSZP43wa7KkMQfcOCF0yJz1d2VS88OnzJUvcCy28ZgVZRyB/eNasnA==
X-Received: by 10.84.209.203 with SMTP id y69mr44977731plh.115.1482855817300;
        Tue, 27 Dec 2016 08:23:37 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:36 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 10/20] ref-filter: introduce refname_atom_parser_internal()
Date:   Tue, 27 Dec 2016 21:53:47 +0530
Message-Id: <20161227162357.28212-11-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Since there are multiple atoms which print refs ('%(refname)',
'%(symref)', '%(push)', '%(upstream)'), it makes sense to have a common
ground for parsing them. This would allow us to share implementations of
the atom modifiers between these atoms.

Introduce refname_atom_parser_internal() to act as a common parsing
function for ref printing atoms. This would eventually be used to
introduce refname_atom_parser() and symref_atom_parser() and also be
internally used in remote_ref_atom_parser().

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index e98ef4b..c1ebc40 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -32,6 +32,11 @@ struct if_then_else {
 		condition_satisfied : 1;
 };
 
+struct refname_atom {
+	enum { R_NORMAL, R_SHORT, R_STRIP } option;
+	unsigned int strip;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -64,6 +69,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -77,6 +83,21 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static void refname_atom_parser_internal(struct refname_atom *atom,
+					 const char *arg, const char *name)
+{
+	if (!arg)
+		atom->option = R_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->option = R_SHORT;
+	else if (skip_prefix(arg, "strip=", &arg)) {
+		atom->option = R_STRIP;
+		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
+			die(_("positive value expected refname:strip=%s"), arg);
+	} else
+		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+}
+
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
-- 
2.10.2

