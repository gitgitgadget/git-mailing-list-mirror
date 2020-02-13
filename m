Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F74C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 05:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3A1206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 05:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj2o8anL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgBMFXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:23:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39892 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgBMFXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 00:23:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so2436174pfy.6
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 21:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=86pe5nRweq1poKj9GQiWdL3AZAx62KVdp8/Z/FZKLKA=;
        b=fj2o8anLRfuPvi4ExDBAEoS99wLqonPk9WdELaZz8Vhs8x/Z0HQunUbjzBU2OrxWgB
         WgEMkJ3m/dW7mpv0b4PgCyzsXFkqbf5vxXVyKUWA9d7g9T1lNxuN4Nw7kSpdMeTKUMZG
         axWngy20MtsykQjh3s7EcTCl5EPptAR8aBFAzqffkFPXIt8Kuaw0P/eg7MiA8jSVGGBF
         r9fTI44jTA9pw2fkBNdKJ6G1pqdE80b2SNZ/9Lsj3U+VM6u0hH7pDNqErCuD2bsNE7lI
         Ynj0FoS3UkAJbKXOOOvULRqclKLmm/xtmbQTw+ZMxuuaSSHkKAE/4sKxJXitIj8MNitS
         bNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=86pe5nRweq1poKj9GQiWdL3AZAx62KVdp8/Z/FZKLKA=;
        b=ITINY+/LQoDDzMvt5Brmi/pBocB5dupk8i54KDUNxakgS6cM901FmLnNjpwxLSL8Mw
         ZXxQzlFLR/s8nNYM4k94kFw48UmQcp8ZuE+YHzIXTe+/b13VFEDy3TMzeTerudNkmfT2
         BZNXFRujbBRGDWdjpFrRW9IUI2JNF9/OyOVRggo/GVO2OYrxB+qHahDXvEtvOZlRpJyJ
         3kPeeCGdgWhq0ah/nHi4M8vQiv5LwDRiC12h6HBdZlQuYBw7NpskTT5S/akEaFVIKlEu
         JiAKCuysXHrDK4bZOAFqipMjKWN1zEJC2hCImQUv7msFzslqgaGqS30WL4SSnb/p03I0
         ydxg==
X-Gm-Message-State: APjAAAXcsW31w7UB9VNM9I4Y5Zru2AB8WJx4Q9SZfrTi3IMznvuKi/zW
        giEdMVMxhI3CdJWslB+7kp9c7oxy
X-Google-Smtp-Source: APXvYqzuS5BRnyLfZ1WBMOu24e+v4ZVnnKe01DbNzcaPMLO54nqtvPh53CBC0NwVhZb35+wcaI7uzA==
X-Received: by 2002:a62:14e:: with SMTP id 75mr12267596pfb.54.1581571402244;
        Wed, 12 Feb 2020 21:23:22 -0800 (PST)
Received: from [192.168.0.113] ([27.106.79.123])
        by smtp.gmail.com with ESMTPSA id w5sm1086935pfc.24.2020.02.12.21.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 21:23:21 -0800 (PST)
Subject: Re: [PATCH 1/5] object.c: get_max_object_index and get_indexed_object
 accept 'r' parameter
To:     Taylor Blau <me@ttaylorr.com>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
 <d98b7caff56cc839f251ac43c36826ecf800cf2f.1581535151.git.gitgitgadget@gmail.com>
 <20200212202210.GC4364@syl.local>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   parth gala <parthpgala@gmail.com>
Message-ID: <f153f247-fd5a-7a1f-9cd6-fa65e59e6f00@gmail.com>
Date:   Thu, 13 Feb 2020 10:53:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212202210.GC4364@syl.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 13/02/20 1:52 am, Taylor Blau wrote:
> On Wed, Feb 12, 2020 at 07:19:07PM +0000, Parth Gala via GitGitGadget wrote:
>> From: Parth Gala <parthpgala@gmail.com>
>>
>> Currently the two functions use global variable 'the_repository' to access
>> the values stored in it. This makes 'the_repository' to be existent even
>> when not required.
> Nit: please wrap your commit messages at 72 characters instead of 80.

Alright.

>> This commit replaces it with 'r' which is passed as a parameter to those
>> functions
> Makes sense.
>
>> Signed-off-by: Parth Gala <parthpgala@gmail.com>
>> ---
>>   builtin/fsck.c       |  5 +++--
>>   builtin/index-pack.c |  5 +++--
>>   builtin/name-rev.c   |  5 +++--
>>   object.c             |  8 ++++----
>>   object.h             |  4 ++--
>>   shallow.c            | 10 ++++++----
>>   upload-pack.c        | 10 ++++++----
>>   7 files changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/builtin/fsck.c b/builtin/fsck.c
>> index 8d13794b14..d2b4336f7e 100644
>> --- a/builtin/fsck.c
>> +++ b/builtin/fsck.c
>> @@ -375,6 +375,7 @@ static void check_object(struct object *obj)
>>   static void check_connectivity(void)
>>   {
>>   	int i, max;
>> +	struct repository *r = the_repository;
> Is there a reason that you assign use/assign 'r' here? I can find a few
> other such instances of it in:
>
>    $ git grep -l 'struct repository \*r = '
>    builtin/merge-tree.c
>    builtin/sparse-checkout.c
>    builtin/update-index.c
>    fetch-pack.c
>    read-cache.c
>    t/helper/test-reach.c
>    tree.c
>
> but I'm not sure that it's necessary here. Could you instead pass
> 'the_repository' directly to the functions that now require it?

This was the more convenient thing to do, given that the ultimate
goal is to actually use the `r` that is passed to these caller
functions rather than defining them locally, which would require
another layer of refactoring.

Besides it is what was decided in the issue.

Also, it would be easier to differentiate whether or not a
function has been refactored, upon seeing an `r` rather than
`the_repository`(which is otherwise commonly used in a global
scope) ie. you would be confused whether `the_repository` used
here was passed to the function or not(especially in longer
functions where you'd have to scroll up to the function
definition to check).

>>   	/* Traverse the pending reachable objects */
>>   	traverse_reachable();
>> @@ -400,12 +401,12 @@ static void check_connectivity(void)
>>   	}
>>
>>   	/* Look up all the requirements, warn about missing objects.. */
>> -	max = get_max_object_index();
>> +	max = get_max_object_index(r);
> For example, changing this line to:
>
>    max = get_max_object_index(the_repository);
>
>>   	if (verbose)
>>   		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
>>
>>   	for (i = 0; i < max; i++) {
>> -		struct object *obj = get_indexed_object(i);
>> +		struct object *obj = get_indexed_object(r, i);
>>
>>   		if (obj)
>>   			check_object(obj);
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 60a5591039..d2115535bc 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -218,14 +218,15 @@ static unsigned check_object(struct object *obj)
>>   static unsigned check_objects(void)
>>   {
>>   	unsigned i, max, foreign_nr = 0;
>> +	struct repository *r = the_repository;
>>
>> -	max = get_max_object_index();
>> +	max = get_max_object_index(r);
>>
>>   	if (verbose)
>>   		progress = start_delayed_progress(_("Checking objects"), max);
>>
>>   	for (i = 0; i < max; i++) {
>> -		foreign_nr += check_object(get_indexed_object(i));
>> +		foreign_nr += check_object(get_indexed_object(r, i));
>>   		display_progress(progress, i + 1);
>>   	}
>>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index 6b9e8c850b..afe9f6df01 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -456,6 +456,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
>>   int cmd_name_rev(int argc, const char **argv, const char *prefix)
>>   {
>>   	struct object_array revs = OBJECT_ARRAY_INIT;
>> +	struct repository *r = the_repository;
>>   	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
>>   	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
>>   	struct option opts[] = {
>> @@ -553,9 +554,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>>   	} else if (all) {
>>   		int i, max;
>>
>> -		max = get_max_object_index();
>> +		max = get_max_object_index(r);
>>   		for (i = 0; i < max; i++) {
>> -			struct object *obj = get_indexed_object(i);
>> +			struct object *obj = get_indexed_object(r, i);
>>   			if (!obj || obj->type != OBJ_COMMIT)
>>   				continue;
>>   			show_name(obj, NULL,
>> diff --git a/object.c b/object.c
>> index 142ef69399..549fbe69ca 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -10,14 +10,14 @@
>>   #include "packfile.h"
>>   #include "commit-graph.h"
>>
>> -unsigned int get_max_object_index(void)
>> +unsigned int get_max_object_index(struct repository *r)
>>   {
>> -	return the_repository->parsed_objects->obj_hash_size;
>> +	return r->parsed_objects->obj_hash_size;
>>   }
>>
>> -struct object *get_indexed_object(unsigned int idx)
>> +struct object *get_indexed_object(struct repository *r, unsigned int idx)
>>   {
>> -	return the_repository->parsed_objects->obj_hash[idx];
>> +	return r->parsed_objects->obj_hash[idx];
>>   }
>>
>>   static const char *object_type_strings[] = {
>> diff --git a/object.h b/object.h
>> index 25f5ab3d54..5a8ae274ee 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -98,12 +98,12 @@ int type_from_string_gently(const char *str, ssize_t, int gentle);
>>   /*
>>    * Return the current number of buckets in the object hashmap.
>>    */
>> -unsigned int get_max_object_index(void);
>> +unsigned int get_max_object_index(struct repository *);
>>
>>   /*
>>    * Return the object from the specified bucket in the object hashmap.
>>    */
>> -struct object *get_indexed_object(unsigned int);
>> +struct object *get_indexed_object(struct repository *, unsigned int);
>>
>>   /*
>>    * This can be used to see if we have heard of the object before, but
>> diff --git a/shallow.c b/shallow.c
>> index 7fd04afed1..4537d98482 100644
>> --- a/shallow.c
>> +++ b/shallow.c
>> @@ -510,6 +510,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
>>   		       unsigned int id)
>>   {
>>   	unsigned int i, nr;
>> +	struct repository *r = the_repository;
>>   	struct commit_list *head = NULL;
>>   	int bitmap_nr = DIV_ROUND_UP(info->nr_bits, 32);
>>   	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
>> @@ -563,9 +564,9 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
>>   		}
>>   	}
>>
>> -	nr = get_max_object_index();
>> +	nr = get_max_object_index(r);
>>   	for (i = 0; i < nr; i++) {
>> -		struct object *o = get_indexed_object(i);
>> +		struct object *o = get_indexed_object(r, i);
>>   		if (o && o->type == OBJ_COMMIT)
>>   			o->flags &= ~SEEN;
>>   	}
>> @@ -608,6 +609,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
>>   	struct object_id *oid = info->shallow->oid;
>>   	struct oid_array *ref = info->ref;
>>   	unsigned int i, nr;
>> +	struct repository *r = the_repository;
>>   	int *shallow, nr_shallow = 0;
>>   	struct paint_info pi;
>>
>> @@ -622,9 +624,9 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
>>   	 * Prepare the commit graph to track what refs can reach what
>>   	 * (new) shallow commits.
>>   	 */
>> -	nr = get_max_object_index();
>> +	nr = get_max_object_index(r);
>>   	for (i = 0; i < nr; i++) {
>> -		struct object *o = get_indexed_object(i);
>> +		struct object *o = get_indexed_object(r, i);
>>   		if (!o || o->type != OBJ_COMMIT)
>>   			continue;
>>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index a00d7ece6b..cb7312268f 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -450,6 +450,7 @@ static int do_reachable_revlist(struct child_process *cmd,
>>   		"rev-list", "--stdin", NULL,
>>   	};
>>   	struct object *o;
>> +	struct repository *r = the_repository;
>>   	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
>>   	int i;
>>   	const unsigned hexsz = the_hash_algo->hexsz;
>> @@ -472,8 +473,8 @@ static int do_reachable_revlist(struct child_process *cmd,
>>
>>   	namebuf[0] = '^';
>>   	namebuf[hexsz + 1] = '\n';
>> -	for (i = get_max_object_index(); 0 < i; ) {
>> -		o = get_indexed_object(--i);
>> +	for (i = get_max_object_index(r); 0 < i; ) {
>> +		o = get_indexed_object(r, --i);
>>   		if (!o)
>>   			continue;
>>   		if (reachable && o->type == OBJ_COMMIT)
>> @@ -520,6 +521,7 @@ static int get_reachable_list(struct object_array *src,
>>   	struct child_process cmd = CHILD_PROCESS_INIT;
>>   	int i;
>>   	struct object *o;
>> +	struct repository *r = the_repository;
>>   	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
>>   	const unsigned hexsz = the_hash_algo->hexsz;
>>
>> @@ -538,8 +540,8 @@ static int get_reachable_list(struct object_array *src,
>>   			o->flags &= ~TMP_MARK;
>>   		}
>>   	}
>> -	for (i = get_max_object_index(); 0 < i; i--) {
>> -		o = get_indexed_object(i - 1);
>> +	for (i = get_max_object_index(r); 0 < i; i--) {
>> +		o = get_indexed_object(r, i - 1);
>>   		if (o && o->type == OBJ_COMMIT &&
>>   		    (o->flags & TMP_MARK)) {
>>   			add_object_array(o, NULL, reachable);
>> --
>> gitgitgadget
> Otherwise this looks pretty good.
>
> Thanks,
> Taylor
