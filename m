Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80702C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FFB2077D
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K8M0If3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFEQPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:15:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52725 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFEQPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 12:15:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A937D38BF;
        Fri,  5 Jun 2020 12:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H4BM8NdYLC/gd9+95A2aSrGAmEM=; b=K8M0If
        3K/mV7qPnsRO58ALyu8zQPkhRp97oglGYz9BQ08gbgQDna5fvzC60C/2Aau0zyt8
        kGXcd+Rm6oOnSVgra+BX0PxQyok+tdgXd4YUYmBAcXU0uEi8YQCXTHX8KXSBgptj
        i6aA46bfeMPWeArIM/h6swcbjzKE45yi41vM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i67FoJ8IBafh8MQWM3rVnrsdPMBdXXYV
        rt9CY3dDFFYsU902nhCX8yudmG8VjLnp1dFBivR1rRcmgg6SzgaIWT4f4JG9nRBC
        NW1LhxzX4AZajAXUjARDaqR44YQNQphyvMt4ASiQ5hfctOyR1J5OPYdmZ5OBHWgZ
        eIo7/WIXADE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43156D38BE;
        Fri,  5 Jun 2020 12:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95E0AD38BA;
        Fri,  5 Jun 2020 12:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 20/24] fast-import: permit reading multiple marks files
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-21-sandals@crustytoothpaste.net>
Date:   Fri, 05 Jun 2020 09:14:49 -0700
In-Reply-To: <20200222201749.937983-21-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:45 +0000")
Message-ID: <xmqqimg5o5fq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF72B5D4-A747-11EA-9903-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In the future, we'll want to read marks files for submodules as well.
> Refactor the existing code to make it possible to read multiple marks
> files, each into their own marks set.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  fast-import.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

This conversion looks a bit strange.  We are working off of 'marks'
that is file scope global, and the topmost caller passes the pointer
to that single instance down the callchain to this function (among
others) in "s", and it all looked no-op to my eye, but this actually
updates the global 'marks'.

> diff --git a/fast-import.c b/fast-import.c
> index b8b65a801c..b9ecd89699 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -493,25 +493,24 @@ static char *pool_strdup(const char *s)
>  	return r;
>  }
>  
> -static void insert_mark(uintmax_t idnum, struct object_entry *oe)
> +static void insert_mark(struct mark_set *s, uintmax_t idnum, struct object_entry *oe)
>  {
> -	struct mark_set *s = marks;

This is no longer needed as the caller gave the 'marks' to us in
's'.  Up to this line, this step is a no-op patch. 

>  	while ((idnum >> s->shift) >= 1024) {
>  		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));

Here we overwrite 's', and we lost the pointer the caller gave us!!!

>  		s->shift = marks->shift + 10;

And we still work off of global marks here and

>  		s->data.sets[0] = marks;
>  		marks = s;

try to swap it here.  But if our caller is also using 's' that was
passed from its caller, this assignment would not be seen by our
caller.  We'd need to pass a pointer to caller's 's' to this
function and update it around here.

>  	}
>  	while (s->shift) {
>  		uintmax_t i = idnum >> s->shift;
>  		idnum -= i << s->shift;
>  		if (!s->data.sets[i]) {
>  			s->data.sets[i] = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
>  			s->data.sets[i]->shift = s->shift - 10;
>  		}
>  		s = s->data.sets[i];
>  	}
>  	if (!s->data.marked[idnum])
>  		marks_set_count++;

I am not sure if this global also needs a separate counter and I
didn't bother to check.

>  	s->data.marked[idnum] = oe;
>  }

With this patch t9300 still seems to pass.

I do not know if this is the fix for Billes Tibor's "fast-import
oom" issue <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com> but the
change to this function stood out.

Thanks.


 fast-import.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0dfa14dc8c..f39b7890ac 100644
--- a/fast-import.c
+++ b/fast-import.c
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
@@ -1745,12 +1747,12 @@ static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintm
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
 	}
-	insert_mark(s, mark, e);
+	insert_mark(&s, mark, e);
 }
 
 static void insert_oid_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
 {
-	insert_mark(s, mark, xmemdupz(oid, sizeof(*oid)));
+	insert_mark(&s, mark, xmemdupz(oid, sizeof(*oid)));
 }
 
 static void read_mark_file(struct mark_set *s, FILE *f, mark_set_inserter_t inserter)
@@ -3242,7 +3244,7 @@ static void parse_alias(void)
 		die(_("Expected 'to' command, got %s"), command_buf.buf);
 	e = find_object(&b.oid);
 	assert(e);
-	insert_mark(marks, next_mark, e);
+	insert_mark(&marks, next_mark, e);
 }
 
 static char* make_fast_import_path(const char *path)
