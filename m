Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21FD203C1
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbcLGPhD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:03 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34500 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so23775713pgc.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Arle+dxSQm9OYrN3lHNAMxr6+0l1OQQ3WSH1l8yuYes=;
        b=kWb/X5GqsKI1Ao2hc4YLKe9oZ1O3EHCws5JxEt1Mq4k5ZTQbwlvsYIdOMax4tzELNx
         gbDg9kPB4ApIxxNMAuZVa1ly1DLG+AN6LyLSdLl40Ny4S34zbWqt3SVSWE3qXznnUVGB
         hop1taAly1PfVIl/rd4IV6UijnKRYGnbb3FK0u0niawasW2yRvCLRywY+d4hbo2DRP2l
         Cz+6WOVQd0cvsBMFKXqf8gi+w9cIF1B+zbnhiM/YVBryHJ926mMIbx0g9Fqd5U3CtpsS
         NAmNGY2o5jEgLnGW0KU3AtBU1dvc81juel2OIpFNGwMMT0TYVdb1ZRu/F5hCtqBS8T6a
         u39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Arle+dxSQm9OYrN3lHNAMxr6+0l1OQQ3WSH1l8yuYes=;
        b=EmeU0R8G8ilz0BjotAAoTKqkog4dMuRMtia0GH4R6wJTQdmNQof7JRFDT/NL//x3Bu
         58dmU+iqATv27yDVqhYOzh2NgS1jkjuPJZR7hCZDvDj73j2RJZMJiKSmbdEMB3W+hOVV
         2YuI/T/8pqQ/GGPeYG3VA76aeLxb2kRX/JVIgDSQnOnPgxInw5NVIWlKvwnHOZ2/FBbE
         5wTGYbteamJsJ4lBF08AVxFEU+Ey/UNDHsqD0kaD8JUoEBeZlsqXwEqMcCa4XHFiiUBU
         eL6TUp1L3vP2ASLlt5aqNlxOqWYAV8xcRuoi/8nF+usPekHBEDqDutoxnSt79rUljR0S
         Sx7Q==
X-Gm-Message-State: AKaTC00sRQggKi4qBv/ajcymb9f6e+HdDpeooB/oStWp7J6hL4ld/cs6HlzaNaPrNRjcrQ==
X-Received: by 10.98.80.140 with SMTP id g12mr68201291pfj.54.1481124994446;
        Wed, 07 Dec 2016 07:36:34 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:34 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 10/19] ref-filter: introduce refname_atom_parser_internal()
Date:   Wed,  7 Dec 2016 21:06:18 +0530
Message-Id: <20161207153627.1468-11-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
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
index 405a0e5..1a18c7d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -31,6 +31,11 @@ struct if_then_else {
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
@@ -63,6 +68,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -76,6 +82,21 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
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

