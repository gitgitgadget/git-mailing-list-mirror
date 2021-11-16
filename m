Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD6C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 23:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D719E63214
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 23:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhKPXJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 18:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhKPXJU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Nov 2021 18:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637103982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xrslhCs3EcdxPMvhlFzSZ+0yrMhobwJjXgqc6ofglM0=;
        b=CbEjr67nmJBCHWNMT3+sSO31qWAczzu3oovqvnHVKAqoJAixEgbLWpsUQQYJO5gHSwYJE7
        cU+yPn2+Ct12gt+GgwdAAc51ZoudBDUH/WkSg5hGF0/clrHZZOwU2xGCH7hh5sd5eOBKWx
        LCYfjWHFeZqNutq8B0E3I2jdh7rM1Wk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-B_3pPjIaMe-bdzFLycD4WA-1; Tue, 16 Nov 2021 18:06:21 -0500
X-MC-Unique: B_3pPjIaMe-bdzFLycD4WA-1
Received: by mail-pg1-f198.google.com with SMTP id j18-20020a63fc12000000b002dd2237eb1cso291279pgi.5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 15:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xrslhCs3EcdxPMvhlFzSZ+0yrMhobwJjXgqc6ofglM0=;
        b=kHUEuLuUgLclM00POBk/iaJGtVi7M51ox/g03Dl+w8j9tWQ1rzEyzX+V8VJLHCyjMY
         CYLo8QS97c5JJZJaoJj0kUVN1d8xqcGgLs3agH32WARGYxgA03U5vMH4LmCbyeoNaS2E
         WpuJb9EekRt8DkeAQiM3ZyITl6hjSInhSs1Tr1YkGbnNcMByKwyL3VkMbMowKENIyZn1
         VWLsvboMR6BNg0W5GqnOkMFkw5l72vZtQ7j9V/TURo57YQF/s4W+mRxThwsfgobQ+NNh
         nN8xpTKxW0W/ubD4BIC3rzLPIR1bhd0XM7uHktMTTuQlzQsDo/n9UQyvg1TDXCPS5e9o
         4fnQ==
X-Gm-Message-State: AOAM530TI+0cyC2yY2F8nsulQZ/7zudBr4WK3SNto/HVyFytDKnLGOM+
        N+VlDDlaKMv5XEmNPGcg+zs6bP57YMgWCQ0KO8pz0AfD3O6/o1vh9cybwGuAFPUIhJ3vncWK8wf
        cSzPZStcBPguOTfnxXu6xW23vMKLR4aB6RpIQZ5RGSbLdptn+HbSTQj8l+lA0OnGC
X-Received: by 2002:a65:46ce:: with SMTP id n14mr1966707pgr.89.1637103979556;
        Tue, 16 Nov 2021 15:06:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2GVSkqSarQ0yrPDXlUuYOHzrEVfqbFNYwIrPXeOfnNV10DxqbFPbAzbg0/S8OlQzMysuHHQ==
X-Received: by 2002:a65:46ce:: with SMTP id n14mr1966669pgr.89.1637103979197;
        Tue, 16 Nov 2021 15:06:19 -0800 (PST)
Received: from fedora19.localdomain (2001-44b8-4132-5a00-03c7-087f-fa32-45c8.static.ipv6.internode.on.net. [2001:44b8:4132:5a00:3c7:87f:fa32:45c8])
        by smtp.gmail.com with ESMTPSA id o129sm20146227pfg.44.2021.11.16.15.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:06:18 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:06:14 +1100
From:   Ian Wienand <iwienand@redhat.com>
To:     git@vger.kernel.org
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Ian Wienand <iwienand@redhat.com>
Subject: [PATCH] submodule: separate out not-found and not-empty errors
Message-ID: <YZQ5Zk0ItWvfr8sF@fedora19.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After upgrading past 505a2765963 a long-working script to cache git
repos started failing with

 Could not access submodule '...'

for every updated submodule on each fetch [1].

Ultimately this turned out to be using "--git-dir=" from outside the
repo; i.e. we really wanted "-C" in this script (the man page does
warn about this -- but it was working for a long time).

Although obvious in hindsight, this was very difficult to diagnose
from the error message.  It required me adding debugging to these
functions to determine why it was falling into this path when
everything looked right on disk.

This proposes separate messages for the directory missing v. being
present but having unexpected contents.  Both messages are modified to
give the path that is being examined.

[1] https://review.opendev.org/c/openstack/diskimage-builder/+/818053

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 submodule.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index c689070524..910ee6ba7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1521,9 +1521,16 @@ static int get_next_submodule(struct child_process *cp,
 			if (S_ISGITLINK(ce->ce_mode) &&
 			    !is_empty_dir(empty_submodule_path.buf)) {
 				spf->result = 1;
-				strbuf_addf(err,
-					    _("Could not access submodule '%s'\n"),
-					    ce->name);
+				/* is_empty_dir also catches missing dirtectories, but report separately */
+				if (!is_directory(empty_submodule_path.buf)) {
+				  strbuf_addf(err,
+					      _("Submodule directory '%s' not found (incorrect --git-dir?)\n"),
+					      empty_submodule_path.buf);
+				} else {
+				  strbuf_addf(err,
+					      _("Submodule directory '%s' is not empty\n"),
+					      empty_submodule_path.buf);
+				}
 			}
 			strbuf_release(&empty_submodule_path);
 		}
-- 
2.33.1

