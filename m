Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70FC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiCCAV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiCCAVr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:47 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99C108749
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:02 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id b23so3272499qtt.6
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CIKN/CB83u6sQ1/KE0vEIeyTEwD5VnDa2rxArL8gDJ0=;
        b=ibV0CIchzVnBUieKpmpQcvk16m4H+GsHXI3qGRkXjCq3FM5ix0LnMZKUxmmWADhHjH
         IbGmWRc85aTwGMzzzUsn4zly8UUekdARDjUo3Wp+CanRI++5KaOVGTpo8K/woXzTgRbx
         9HzHk7C7cLhC2wjVH3b4AhD5Wdwh2ZE4TETMs3q1rGoSurOhkkTMuvPzeNkRhhXiJbsX
         3OvP184qISTu8XCLUazv5l3LZdYRl032S8CPh6kYaSTmhl65NedCZu4yqKxr3O0zwDs8
         6dITAew9jv+ziM/dBNzDoletSnGWqNry6FgNSqaxZtF0mGwP+VZRrEUC+P3TzN9jhPCi
         Sdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CIKN/CB83u6sQ1/KE0vEIeyTEwD5VnDa2rxArL8gDJ0=;
        b=NihEO8+je1Ar90MAFZr0Dba5JOHqAvdesQmQDUjpj/omiZUeDCYlwgdWh6j4L+HfAO
         8F0JJIyCeOXM2T+4c9zp+aSGiRQZHnIGWkAjqfsy0ECq/E6NbApsUMCYsXKEu6VlZKJN
         REJaBOSM7JnVouFkvqGYlVWX7S3CSbDD2TdhWv+2QtDCi+QJIZMJTnKGyvFWfCZ8qFhN
         8OZD1Lr58dk6ptOyo3/+IwAiL3E9h/w6sIBjRtAxy7/wU/ZD/ZY3x/Z9GcgVzAPn++Js
         W8nkqoWGwBto/RMBClIifKMVEj2AqXIpavO1BmXjQMFzox9SlTlfqcop1cs1yFo+fgf+
         3fng==
X-Gm-Message-State: AOAM530FXHg9vw1TK+G2fOGMh7U1IiMAehyktdFkTcsuMXFqTmi7y/us
        v/XXs9tDlcJ7ZxE3aWBcvRrUYXgNpmTCGITg
X-Google-Smtp-Source: ABdhPJyNZyW3J5IvvPcbKxFoBq/PO+XDqCCP0JD7Y3BOcXh6pez+es6jj8zNtnci2POJ/bfQza1H2w==
X-Received: by 2002:a05:622a:1394:b0:2de:6af2:406e with SMTP id o20-20020a05622a139400b002de6af2406emr26081959qtk.527.1646266861036;
        Wed, 02 Mar 2022 16:21:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t9-20020a05622a148900b002de2dfd0ee2sm359139qtx.70.2022.03.02.16.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:00 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 07/17] builtin/pack-objects.c: return from
 create_object_entry()
Message-ID: <33862a07c927184a40ccbfe5182404923a392c4a.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new caller in the next commit will want to immediately modify the
object_entry structure created by create_object_entry(). Instead of
forcing that caller to wastefully look-up the entry we just created,
return it from create_object_entry() instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 385970cb7b..3f08a3c63a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1508,13 +1508,13 @@ static int want_object_in_pack(const struct object_id *oid,
 	return 1;
 }
 
-static void create_object_entry(const struct object_id *oid,
-				enum object_type type,
-				uint32_t hash,
-				int exclude,
-				int no_try_delta,
-				struct packed_git *found_pack,
-				off_t found_offset)
+static struct object_entry *create_object_entry(const struct object_id *oid,
+						enum object_type type,
+						uint32_t hash,
+						int exclude,
+						int no_try_delta,
+						struct packed_git *found_pack,
+						off_t found_offset)
 {
 	struct object_entry *entry;
 
@@ -1531,6 +1531,8 @@ static void create_object_entry(const struct object_id *oid,
 	}
 
 	entry->no_try_delta = no_try_delta;
+
+	return entry;
 }
 
 static const char no_closure_warning[] = N_(
-- 
2.35.1.73.gccc5557600

