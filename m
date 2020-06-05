Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E977C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA1A2074B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 16:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KVwp86KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgFEQ3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:29:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59924 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFEQ0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 12:26:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 960407EA4E;
        Fri,  5 Jun 2020 12:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fO7xIzQz/zumiFBfWkIxEoHSus4=; b=KVwp86
        KCp+BYAwpATkuyE/mgzoxVa1PQOn6q375cvyhmgZNMqP+7XkG9i2skSRiEawrSY7
        Bo7NBRzzRbu+fgHqMtevtPp0xrhjHgExZauTo03X2p+URaS/DwZOeLyiomaBwhRO
        7st4LcjVyFpn6dFgD1T9yeQW7mv4vrZp1qoRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I20S86qWo69Ns+A0lov/eavz8YC8DEtL
        2zEvppsv7p3BsiYUuCRFuUM6iA+I73gg67QmRLZWOolpLFty0WJMjp6/Q6t1EJxi
        i6EXJK21XaWPR8UdEbuogQQGS8W8WquaBTFQ11w7FgQskixIqVruD0Ut+jWrwljG
        hNeKJrbIPTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 872887EA4D;
        Fri,  5 Jun 2020 12:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7E967EA4C;
        Fri,  5 Jun 2020 12:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 20/24] fast-import: permit reading multiple marks files
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-21-sandals@crustytoothpaste.net>
        <xmqqimg5o5fq.fsf@gitster.c.googlers.com>
Date:   Fri, 05 Jun 2020 09:26:02 -0700
In-Reply-To: <xmqqimg5o5fq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 05 Jun 2020 09:14:49 -0700")
Message-ID: <xmqqeeqto4x1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F8F5EDC-A749-11EA-821C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> @@ -1745,12 +1747,12 @@ static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintm
>  		e->pack_id = MAX_PACK_ID;
>  		e->idx.offset = 1; /* just not zero! */
>  	}
> -	insert_mark(s, mark, e);
> +	insert_mark(&s, mark, e);
>  }
>  
>  static void insert_oid_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
>  {
> -	insert_mark(s, mark, xmemdupz(oid, sizeof(*oid)));
> +	insert_mark(&s, mark, xmemdupz(oid, sizeof(*oid)));
>  }
>  

Actually the above "fix" still has the same issue; we may have made
the on-stack copy of 's' that are parameters these two functions see
as callees, but the caller of these two functions would not see the
effect of the munging done deep in the callchain by insert_mark().

The read_marks() function calls read_mark_file() with "marks", but I
think you'd need to pass pointer to that global singleton and teach
mark_set_inserter_t function to take a pointer to a pointer to
struct mark_set throughout, so that the instance the top-level
caller (read_marks in this callchain) gets updated.

Here is another try.

 fast-import.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0dfa14dc8c..ed87d6e380 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -150,7 +150,7 @@ struct recent_command {
 	char *buf;
 };
 
-typedef void (*mark_set_inserter_t)(struct mark_set *s, struct object_id *oid, uintmax_t mark);
+typedef void (*mark_set_inserter_t)(struct mark_set **s, struct object_id *oid, uintmax_t mark);
 typedef void (*each_mark_fn_t)(uintmax_t mark, void *obj, void *cbp);
 
 /* Configured limits on output */
@@ -534,13 +534,15 @@ static char *pool_strdup(const char *s)
 	return r;
 }
 
-static void insert_mark(struct mark_set *s, uintmax_t idnum, struct object_entry *oe)
+static void insert_mark(struct mark_set **sp, uintmax_t idnum, struct object_entry *oe)
 {
+	struct mark_set *s = *sp;
+
 	while ((idnum >> s->shift) >= 1024) {
 		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
-		s->shift = marks->shift + 10;
-		s->data.sets[0] = marks;
-		marks = s;
+		s->shift = (*sp)->shift + 10;
+		s->data.sets[0] = (*sp);
+		(*sp) = s;
 	}
 	while (s->shift) {
 		uintmax_t i = idnum >> s->shift;
@@ -958,7 +960,7 @@ static int store_object(
 
 	e = insert_object(&oid);
 	if (mark)
-		insert_mark(marks, mark, e);
+		insert_mark(&marks, mark, e);
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
@@ -1156,7 +1158,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	e = insert_object(&oid);
 
 	if (mark)
-		insert_mark(marks, mark, e);
+		insert_mark(&marks, mark, e);
 
 	if (e->idx.offset) {
 		duplicate_count_by_type[OBJ_BLOB]++;
@@ -1731,7 +1733,7 @@ static void dump_marks(void)
 	}
 }
 
-static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
+static void insert_object_entry(struct mark_set **s, struct object_id *oid, uintmax_t mark)
 {
 	struct object_entry *e;
 	e = find_object(oid);
@@ -1748,12 +1750,12 @@ static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintm
 	insert_mark(s, mark, e);
 }
 
-static void insert_oid_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
+static void insert_oid_entry(struct mark_set **s, struct object_id *oid, uintmax_t mark)
 {
 	insert_mark(s, mark, xmemdupz(oid, sizeof(*oid)));
 }
 
-static void read_mark_file(struct mark_set *s, FILE *f, mark_set_inserter_t inserter)
+static void read_mark_file(struct mark_set **s, FILE *f, mark_set_inserter_t inserter)
 {
 	char line[512];
 	while (fgets(line, sizeof(line), f)) {
@@ -1786,7 +1788,7 @@ static void read_marks(void)
 		goto done; /* Marks file does not exist */
 	else
 		die_errno("cannot read '%s'", import_marks_file);
-	read_mark_file(marks, f, insert_object_entry);
+	read_mark_file(&marks, f, insert_object_entry);
 	fclose(f);
 done:
 	import_marks_file_done = 1;
@@ -3242,7 +3244,7 @@ static void parse_alias(void)
 		die(_("Expected 'to' command, got %s"), command_buf.buf);
 	e = find_object(&b.oid);
 	assert(e);
-	insert_mark(marks, next_mark, e);
+	insert_mark(&marks, next_mark, e);
 }
 
 static char* make_fast_import_path(const char *path)
@@ -3340,7 +3342,7 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	fp = fopen(f, "r");
 	if (!fp)
 		die_errno("cannot read '%s'", f);
-	read_mark_file(ms, fp, insert_oid_entry);
+	read_mark_file(&ms, fp, insert_oid_entry);
 	fclose(fp);
 }
 
