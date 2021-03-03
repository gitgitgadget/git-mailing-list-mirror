Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B0C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DCF64E56
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhCDAWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842958AbhCCKXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA6CC0698DA
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 01:22:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d2so3946854pjs.4
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0eElYIkS8xTp/3sYRFw97ZWV9e6e/AA2QtB232yunk=;
        b=nT/6eXQ2L4AxEt0LxR0ezL6QoboANX6iFGByHKIScr0g8DwRHj/dH3JTfDoedqe9vf
         /c+OWmmGQ6N+wxawhG6sUWWUUacXV1OPicbn2a7JzBut4VNHs2FlMxqpIymCZHIqLPSo
         x8HPdcLbJvsfwDAouAaPNx+gvAp0/p3H0P9Nmw25/Z7fHPOS2+nQYurXjdFuHNj9ac8g
         Cp1djNr+CAKUvuqsIrPhdfHkF83CXHU8Pcf7LQi1eCdbHCnnsa9Q58+PsDTZuksoH4zu
         sZaX5rkKx9sKmLXdZGmcqtE7jf8atbnvNqGpmfLRpB9Xare5+3q9C5uy1iTZMnwMSyAV
         CMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0eElYIkS8xTp/3sYRFw97ZWV9e6e/AA2QtB232yunk=;
        b=L0cNojsdsMLQZFZY5FmxD4APB6k+ohCllvZ+WkWVaSWuOaOJxz2YAishS/D4KlsEDu
         dt9PbFPMnIV8b+kKcxvetpjpr5f/bmiEmYn4+P8aJUy4BDi6ByQPpYoxiROjEQSPIdQD
         OzcUcL/X7aGRcyMviN79jaoY4ADcNd8FNQMSQmNOhAgWi4vvwHRuuUC35CLBgXNK1GIy
         Z/+geoUu0RkMAzJ+qvOqERe3+9603UQ1R7rwmrE8QLcBrC2DJzAEfhYrgNICZ3M6/lZw
         qpzSxa00oLprWnZux1oZwE8ITc/Q2mzIMFFbrvnOpddvq+uK4Y/22EnnBmwjxbj3y/5E
         bWjw==
X-Gm-Message-State: AOAM531f+JD94B/T+Hi/4z9Tdsle+gVow5qJvCO0MHJCz01mwYPEC5mi
        R5kMtNAgi8ZlW+I61yzd0FlwKeiZQhA=
X-Google-Smtp-Source: ABdhPJypNPS6oKXm5bMY9oEnzMAlrWV8/o+JiipaGNpP77BTPbdD2ZdhR+xOs9KVKsdSt5aFIUInGA==
X-Received: by 2002:a17:902:e781:b029:e4:3bd3:3b00 with SMTP id cp1-20020a170902e781b02900e43bd33b00mr7434524plb.70.1614763329156;
        Wed, 03 Mar 2021 01:22:09 -0800 (PST)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a11sm13986861pfk.109.2021.03.03.01.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 01:22:08 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] git-cat-file.txt: doc cleanup
Date:   Wed,  3 Mar 2021 01:21:54 -0800
Message-Id: <cover.1614763281.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.1.823.g0a3b79fd18
In-Reply-To: <cover.1614062288.git.liu.denton@gmail.com>
References: <cover.1614062288.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of fixes that I've noticed in passing.

Changes since v1:

* Drop 'i18n.txt: camel case and monospace "i18n.commitEncoding"' (it's already
  merged to 'master')

* Change "object ID of the object" to "object name"

Denton Liu (2):
  git-cat-file.txt: monospace args, placeholders and filenames
  git-cat-file.txt: remove references to "sha1"

 Documentation/git-cat-file.txt | 67 +++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 33 deletions(-)

Range-diff against v1:
1:  cc48b12516 < -:  ---------- i18n.txt: camel case and monospace "i18n.commitEncoding"
2:  7dab69ce23 = 1:  6d044cf540 git-cat-file.txt: monospace args, placeholders and filenames
3:  4030a678b9 ! 2:  1b57fdad97 git-cat-file.txt: remove references to "sha1"
    @@ Documentation/git-cat-file.txt: object, with placeholders of the form `%(atom)`
      
      `objectname`::
     -	The 40-hex object name of the object.
    -+	The full hex representation of the object ID of the object.
    ++	The full hex representation of the object name.
      
      `objecttype`::
      	The type of the object (the same as `cat-file -t` reports).
    @@ Documentation/git-cat-file.txt: newline. The available atoms are:
      	If the object is stored as a delta on-disk, this expands to the
     -	40-hex sha1 of the delta base object. Otherwise, expands to the
     -	null sha1 (40 zeroes). See `CAVEATS` below.
    -+	full hex representation of the object ID of the delta base
    -+	object. Otherwise, expands to the null OID (all zeroes). See
    -+	`CAVEATS` below.
    ++	full hex representation of the delta base object name.
    ++	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
    ++	below.
      
      `rest`::
      	If this atom is used in the output string, input lines are split
-- 
2.30.1.823.g0a3b79fd18

