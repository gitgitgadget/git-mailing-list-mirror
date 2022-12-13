Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3511C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiLMLQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiLMLP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:15:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F309178BA
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:14:24 -0800 (PST)
Received: (qmail 14507 invoked by uid 109); 13 Dec 2022 11:14:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:14:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4322 invoked by uid 111); 13 Dec 2022 11:14:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:14:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:14:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 8/9] list-objects-filter: mark unused parameters in virtual
 functions
Message-ID: <Y5hej4EQU3l68rgT@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct filter" abstract type defines several virtual function
pointers. Not all of the concrete functions need every parameter, but
they have to conform to the generic interface. Mark unused ones to
silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects-filter.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index b9543545ca..2bbac622be 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -70,13 +70,13 @@ struct filter {
 };
 
 static enum list_objects_filter_result filter_blobs_none(
-	struct repository *r,
+	struct repository *r UNUSED,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
-	const char *pathname,
-	const char *filename,
+	const char *pathname UNUSED,
+	const char *filename UNUSED,
 	struct oidset *omits,
-	void *filter_data_)
+	void *filter_data_ UNUSED)
 {
 	switch (filter_situation) {
 	default:
@@ -112,7 +112,7 @@ static enum list_objects_filter_result filter_blobs_none(
 }
 
 static void filter_blobs_none__init(
-	struct list_objects_filter_options *filter_options,
+	struct list_objects_filter_options *filter_options UNUSED,
 	struct filter *filter)
 {
 	filter->filter_object_fn = filter_blobs_none;
@@ -159,11 +159,11 @@ static int filter_trees_update_omits(
 }
 
 static enum list_objects_filter_result filter_trees_depth(
-	struct repository *r,
+	struct repository *r UNUSED,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
-	const char *pathname,
-	const char *filename,
+	const char *pathname UNUSED,
+	const char *filename UNUSED,
 	struct oidset *omits,
 	void *filter_data_)
 {
@@ -274,8 +274,8 @@ static enum list_objects_filter_result filter_blobs_limit(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
-	const char *pathname,
-	const char *filename,
+	const char *pathname UNUSED,
+	const char *filename UNUSED,
 	struct oidset *omits,
 	void *filter_data_)
 {
@@ -554,12 +554,12 @@ struct filter_object_type_data {
 };
 
 static enum list_objects_filter_result filter_object_type(
-	struct repository *r,
+	struct repository *r UNUSED,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
-	const char *pathname,
-	const char *filename,
-	struct oidset *omits,
+	const char *pathname UNUSED,
+	const char *filename UNUSED,
+	struct oidset *omits UNUSED,
 	void *filter_data_)
 {
 	struct filter_object_type_data *filter_data = filter_data_;
@@ -675,7 +675,7 @@ static enum list_objects_filter_result filter_combine(
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	struct oidset *omits,
+	struct oidset *omits UNUSED,
 	void *filter_data)
 {
 	struct combine_filter_data *d = filter_data;
-- 
2.39.0.546.g5ea984bc66

