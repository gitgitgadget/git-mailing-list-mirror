Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC3C208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 07:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdHIHFI (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 03:05:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54142 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750820AbdHIHFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 03:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC7AAA1DF3;
        Wed,  9 Aug 2017 03:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H5HmGgLRCeGZBhpgzy+ELa9+LzU=; b=uPUtf2
        b0I7x1I1zTZmEBUVFNeAS2ozOFxTLK9IN1Co8zfSDQ3VSkZpZsY4XCPVni1vG7eI
        RcvAfP3ynabu+EmQNW/QqwFGalXhxmzPtQgkv8HZxtEE3u+ubNxLnuj7dqGWc84K
        1QpTU986qSLroYjyaNdiSdh23xlEJ2ZYuZ+Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qGLuk81H8hy+ID8jwL8bgaxtq8HLzcgr
        3TiBQPderrShYyVu/lyxbXawuCpHPp6fjHKHcrHWac8FM4V8EgN1sbKvl3C+vXPi
        AoC0ZJW7Q+lhTmqRPrvkSjtc2lN25GbJsYUurrDg0HIPVCebOXK//T5W9IdPQGRC
        +yMYYoydFY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2CB9A1DF1;
        Wed,  9 Aug 2017 03:05:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B02BA1DF0;
        Wed,  9 Aug 2017 03:05:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
        <xmqq3792c5sb.fsf@gitster.mtv.corp.google.com>
        <20170808180317.GA73298@google.com>
        <xmqqy3qtc3x4.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 09 Aug 2017 00:05:04 -0700
In-Reply-To: <xmqqy3qtc3x4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 08 Aug 2017 11:25:43 -0700")
Message-ID: <xmqqpoc56x27.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12AA9C24-7CD1-11E7-808C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> > +# Insert a space after a cast
>>> > +# x = (int32) y;    not    x = (int32)y;
>>> > +SpaceAfterCStyleCast: true
>>> 
>>> Hmph, I thought we did the latter, i.e. cast sticks to the casted
>>> expression without SP.
>>
>> I've seen both and I wasn't sure which was the correct form to use.
>
> We do the latter because checkpatch.pl from the kernel project tells
> us to, I think.

Before I forget, there are some rules in checkpatch.pl that I
deliberately ignore while accepting patches from the list.  

I appreciate the tool for pointing out overlong lines, but I often
find them easier to read as-is than split into two lines, as the
ones the people send in real life rarely excessively exceed the
80-col limit.  We also use things like SHA_CTX that trigger "avoid
camelcase", which I also ignore.

One thing we probably should standardize is the way the width of
bitfields in struct is specified.  I think checkpatch.pl wants to do

	struct {
		unsigned int three_bits : 3;
	};

with SP around the colon, but our codebase does not always have the
spaces there, and I see no technical reason not to follow suit, as
long as we are following most of what checkpatch.pl wants us to do.

By the way, I do not recall seeing a rule about this in your clang
format rules.  Can we spell it out in there?

I also see this:

    WARNING: __printf(string-index, first-to-check) is preferred over
    __attribute__((format(printf, string-index, first-to-check)))

but I think it is specific to the kernel source (the macro is
defined in include/linux/compiler-gcc.h and expands to the latter),
so I also ignore it.

checkpatch.pl also warns a SP immediately before HT, which I do pay
attention to, as well as trailing whitespaces.  If clang-format can
be told to check that, I think we would want to have such a rule.

For a reference, here is a sample set of changes to cache.h to
squelch most of the warnings and errors checkpatch.pl points out
that I do not ignore.

 cache.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 4e390e6af8..dec807b3b0 100644
--- a/cache.h
+++ b/cache.h
@@ -25,7 +25,7 @@
 #define platform_SHA_CTX	SHA_CTX
 #define platform_SHA1_Init	SHA1_Init
 #define platform_SHA1_Update	SHA1_Update
-#define platform_SHA1_Final    	SHA1_Final
+#define platform_SHA1_Final	SHA1_Final
 #endif
 
 #define git_SHA_CTX		platform_SHA_CTX
@@ -260,7 +260,7 @@ static inline void copy_cache_entry(struct cache_entry *dst,
 
 static inline unsigned create_ce_flags(unsigned stage)
 {
-	return (stage << CE_STAGESHIFT);
+	return stage << CE_STAGESHIFT;
 }
 
 #define ce_namelen(ce) ((ce)->ce_namelen)
@@ -317,7 +317,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 	return S_IFGITLINK;
 }
 
-#define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
+#define cache_entry_size(len) (offsetof(struct cache_entry, name) + (len) + 1)
 
 #define SOMETHING_CHANGED	(1 << 0) /* unclassified changes go here */
 #define CE_ENTRY_CHANGED	(1 << 1)
@@ -373,7 +373,7 @@ extern void free_name_hash(struct index_state *istate);
 #define read_cache_unmerged() read_index_unmerged(&the_index)
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
-#define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
+#define cache_name_pos(name, namelen) index_name_pos(&the_index, (name), (namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
@@ -1483,10 +1483,10 @@ struct checkout {
 	const char *base_dir;
 	int base_dir_len;
 	struct delayed_checkout *delayed_checkout;
-	unsigned force:1,
-		 quiet:1,
-		 not_new:1,
-		 refresh_cache:1;
+	unsigned force : 1,
+		 quiet : 1,
+		 not_new : 1,
+		 refresh_cache : 1;
 };
 #define CHECKOUT_INIT { NULL, "" }
 
@@ -1534,7 +1534,7 @@ extern struct alternate_object_database {
 	char path[FLEX_ARRAY];
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
-extern void read_info_alternates(const char * relative_base, int depth);
+extern void read_info_alternates(const char *relative_base, int depth);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
@@ -1587,10 +1587,10 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
-	unsigned pack_local:1,
-		 pack_keep:1,
-		 freshened:1,
-		 do_not_close:1;
+	unsigned pack_local : 1,
+		 pack_keep : 1,
+		 freshened : 1,
+		 do_not_close : 1;
 	unsigned char sha1[20];
 	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
@@ -1767,10 +1767,10 @@ struct object_info {
 	union {
 		/*
 		 * struct {
-		 * 	... Nothing to expose in this case
+		 *	... Nothing to expose in this case
 		 * } cached;
 		 * struct {
-		 * 	... Nothing to expose in this case
+		 *	... Nothing to expose in this case
 		 * } loose;
 		 */
 		struct {
