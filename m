Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C271F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 18:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJFBsj (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 21:48:39 -0400
Received: from mout.web.de ([212.227.15.3]:48847 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbeJFBsj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 21:48:39 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzate-1fd2Bb3vH8-014mUT; Fri, 05
 Oct 2018 20:48:30 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzate-1fd2Bb3vH8-014mUT; Fri, 05
 Oct 2018 20:48:30 +0200
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
Date:   Fri, 5 Oct 2018 20:48:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181005165157.GC11254@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tKyD8tCLwOiWfGj/FAH7mCRqvNc61Et3TAnM9x+0YibULpz8zi9
 9VvfyBFdnWkpR0eJMNc9ZVE/qO0+J7/k/roFZD3rmzGnuyN6VQcNrW8pk2RuS+RUjbV/wNl
 2cIvt1YpwRDNMGdZD8RSHF7Rfo5oAHJRSuB5s8GAjTAl0mqnULvpwINHuXBZEOVETc05Gjo
 vbgoaFSMin7QqdCEbqjGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yz71LHDZjc4=:YoPNl4U+wtfBC2tQds8UPf
 HAjtTHVEiuqRA+RxEd8ULXaWg6XudJPpJKYUAj/RRftj0PqR+dg2PqCmycujwzIRPr1aDHVLh
 l3vfV/yKnwS0hpXWtzGqVaM1rmfOgWGXcDu2gqepdIm2mWDspWntR1iOpUtlFwxJfyKqcNzf3
 Aj/jR34iQk2iJdeGwkJj2ZPdzsC2Tq3W+PFHttsJuGhEGyuLo5JBXRSp9Xwtz3uj6+1KfHLqz
 EtPKXBEKqyjoTdvhS1JYbuhFAhni/H8WKJ2hP/bnoV8V6WUvvaTQ/FDMb1FRl44La+UFGg7NJ
 KJqFBm52ZSB/Hp1/1VgxjBvuxYh8HAHve3Er07lm1r6HI09jrQ3FC/bU+qLqrZYczDRhTu3cI
 I3rSiFUMy2KXMaLo/+ZQ/QL69x4evyI334jS7nqzqzAwlZSKI4KudNPuKNvMCPe3RI7vcE/L+
 lP2PvvydaT2Et64VsOiq6acihBLNnuI0PwG7DkTGkYUtlE0+xoqvjAFY4+Ya7K1neD23KZpgD
 FvXROH0x4go5dhM1ki6Lo2qKBKDC6URXxviZAgQybx75Lm2SCL1pUCqVh0zpmGWuk6l6xyJXM
 XcCYlziT+SZHPGwsoins605hJhvb0vcTARWOg/5sGeuHObjww2jm8LPLKq5RKUNM/B4pZwYl3
 baVebfal9yxcXGLFOCvYQ+s3tFNTSti88idxLZoML3HqtT+s8Kao1M1XaW/sXeLd07bxVzMmW
 ESeDErusRuIbLS5wzl5wCSXmBBlhJ+49e+5fsiL9HnyfMai4Jf36yOQyWs6h20IpQiHJ1tYTr
 EjNkLvLdrfqQMDshOHAEwTBXqF1YSFn+KBn8pgLmPralm4FNWg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2018 um 18:51 schrieb Jeff King:
> On Fri, Oct 05, 2018 at 12:59:02AM +0200, René Scharfe wrote:
> 
>> We could also do something like this to reduce the amount of manual
>> casting, but do we want to?  (Macro at the bottom, three semi-random
>> examples at the top.)
>> [...]
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5f2e90932f..f9e78d69a2 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -1066,6 +1066,18 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
>>  		qsort(base, nmemb, size, compar);
>>  }
>>  
>> +#define DEFINE_SORT(name, elemtype, one, two, code)			\
>> +static int name##_compare(const void *one##_v_, const void *two##_v_)	\
>> +{									\
>> +	elemtype const *one = one##_v_;					\
>> +	elemtype const *two = two##_v_;					\
>> +	code;								\
>> +}									\
>> +static void name(elemtype *array, size_t n)				\
>> +{									\
>> +	QSORT(array, n, name##_compare);				\
>> +}
> 
> Interesting. When I saw the callers of this macro, I first thought you
> were just removing the casts from the comparison function, but the real
> value here is the matching QSORT() wrapper which provides the type
> safety.

Indeed.

> I'm not wild about declaring functions inside macros, just because it
> makes tools like ctags like useful (but I have certainly been guilty of
> it myself). I'd also worry that taking "code" as a macro parameter might
> not scale (what happens if the code has a comma in it?)

It works fine, as long as the comma is surrounded by parentheses, so
function calls with more than one parameter are fine without any change.

> I think we can address that last part by switching the definition order.
> Like:
> 
>   #define DEFINE_SORT(name, elemtype, one, two) \
>   static int name##_compare(const void *, const void *);                \
>   static void name(elemtype *array, size_t n)                           \
>   {                                                                     \
> 	QSORT(array, n, name##_compare);                                \
>   }                                                                     \
>   static int name##_compare(const void *one##_v_, const void *two##_v_) \
>   {                                                                     \
> 	elemtype const *one = one##_v_;					\
> 	elemtype const *two = two##_v_;					\
> 
> And then expecting the caller to do:
> 
>   DEFINE_SORT(foo, struct foo, a, b)
>      /* code goes here */
>   }
> 
> The unbalanced braces are nasty, though (and likely to screw up editor
> formatting, highlighting, etc).

Adding an extra pair of parentheses if needed is also not ideal, but has
less downsides, I think.

> I wonder if it would be possible to just declare the comparison function
> with its real types, and then teach QSORT() to do a type check. That
> would require typeof() at least, but it would be OK for the type-check
> to be available only to gcc/clang users, I think.
> 
> I'm not quite sure what that type-check would look like, but I was
> thinking something along the lines of (inside the QSORT macro):
> 
>   do {
>     /* this will yield a type mismatch if fed the wrong function */
>     int (*check)(const typeof(array), const typeof(array)) = compar;
>     sane_qsort(array, n, sizeof(*array), n);
>   } while (0)
> 
> I have no idea if that even comes close to compiling, though.

If the comparison function has proper types then we need to declare a
version with void pointer parameters as well to give to qsort(3).  I
think using cast function pointers is undefined.  Perhaps like this?

---
 bisect.c          | 11 +++++------
 commit-graph.c    |  8 ++++----
 commit-reach.c    | 12 +++++++-----
 git-compat-util.h | 14 ++++++++++++++
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/bisect.c b/bisect.c
index e8b17cf7e1..1fc6278c6b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -192,17 +192,16 @@ struct commit_dist {
 	int distance;
 };
 
-static int compare_commit_dist(const void *a_, const void *b_)
+static int compare_commit_dist(const struct commit_dist *a,
+			       const struct commit_dist *b)
 {
-	struct commit_dist *a, *b;
-
-	a = (struct commit_dist *)a_;
-	b = (struct commit_dist *)b_;
 	if (a->distance != b->distance)
 		return b->distance - a->distance; /* desc sort */
 	return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
 }
 
+DEFINE_SORT(sort_by_commit_dist, struct commit_dist *, compare_commit_dist)
+
 static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
 {
 	struct commit_list *p;
@@ -223,7 +222,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		array[cnt].distance = distance;
 		cnt++;
 	}
-	QSORT(array, cnt, compare_commit_dist);
+	sort_by_commit_dist(array, cnt);
 	for (p = list, i = 0; i < cnt; i++) {
 		struct object *obj = &(array[i].commit->object);
 
diff --git a/commit-graph.c b/commit-graph.c
index 7f4519ec3b..07d302fefd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -550,13 +550,13 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 	}
 }
 
-static int commit_compare(const void *_a, const void *_b)
+static int commit_compare(const struct object_id *a, const struct object_id *b)
 {
-	const struct object_id *a = (const struct object_id *)_a;
-	const struct object_id *b = (const struct object_id *)_b;
 	return oidcmp(a, b);
 }
 
+DEFINE_SORT(sort_oids, struct object_id *, commit_compare)
+
 struct packed_commit_list {
 	struct commit **list;
 	int nr;
@@ -780,7 +780,7 @@ void write_commit_graph(const char *obj_dir,
 
 	close_reachable(&oids);
 
-	QSORT(oids.list, oids.nr, commit_compare);
+	sort_oids(oids.list, oids.nr);
 
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
diff --git a/commit-reach.c b/commit-reach.c
index 2f5e592d16..496c4201af 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -527,11 +527,11 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 	return is_descendant_of(commit, list);
 }
 
-static int compare_commits_by_gen(const void *_a, const void *_b)
+static int compare_commits_by_gen(const struct commit * const *ap,
+				  const struct commit * const *bp)
 {
-	const struct commit *a = *(const struct commit * const *)_a;
-	const struct commit *b = *(const struct commit * const *)_b;
-
+	const struct commit *a = *ap;
+	const struct commit *b = *bp;
 	if (a->generation < b->generation)
 		return -1;
 	if (a->generation > b->generation)
@@ -539,6 +539,8 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	return 0;
 }
 
+DEFINE_SORT(sort_commits_by_gen, struct commit **, compare_commits_by_gen)
+
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
@@ -580,7 +582,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		nr_commits++;
 	}
 
-	QSORT(list, nr_commits, compare_commits_by_gen);
+	sort_commits_by_gen(list, nr_commits);
 
 	for (i = 0; i < nr_commits; i++) {
 		/* DFS from list[i] */
diff --git a/git-compat-util.h b/git-compat-util.h
index 5f2e90932f..2462173790 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1066,6 +1066,20 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 		qsort(base, nmemb, size, compar);
 }
 
+#define DEFINE_SORT(name, type, compare)				\
+static int compare##_void(const void *one, const void *two)		\
+{									\
+	return compare(one, two);					\
+}									\
+static void name(type base, size_t nmemb)				\
+{									\
+	const type dummy = NULL;					\
+	if (nmemb > 1)							\
+		qsort(base, nmemb, sizeof(base[0]), compare##_void);	\
+	else if (0)							\
+		compare(dummy, dummy);					\
+}
+
 #ifndef HAVE_ISO_QSORT_S
 int git_qsort_s(void *base, size_t nmemb, size_t size,
 		int (*compar)(const void *, const void *, void *), void *ctx);
-- 
2.19.0
