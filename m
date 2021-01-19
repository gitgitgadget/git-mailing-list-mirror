Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC4C433E9
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEAC22E01
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbhASQSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392014AbhASQN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 11:13:29 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AEAC061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 08:12:49 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id l14so9369508qvh.2
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 08:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2uGNV/jcuCEwbFdc1NOj9QEKU5yN8yKmuh9xfY93ZTo=;
        b=ET9eh9UuLNfFisK1S7nNu68njUO72NJLDckzezd1jBgd5mndha9hrODo5EVJnFOzUN
         XC1Pisns25PZQQ8sNxb5++DfH66LELVSmJGuwuIcCAZyviV5XEeBASAn2K4ujfzP+Pxu
         lDKVxdzyVYDL+8wMG5Nc5F06b7N03WilCL4MK7soErZ4aWLqt4/EcLYfoBj0pALaP5nE
         Ird8anXA+MQGMefw5fFRHi9mKvWWTxCQuU3VpdVVxA2rPbJYSM3u6bhPvqWSMq3x2MYl
         hY89Gwf5VHsw1ykl9/R3H+cEXYu4yrnGkPYdRE3DCf37kYPC0Xis0njQ8bcMeQffr/Wo
         vlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2uGNV/jcuCEwbFdc1NOj9QEKU5yN8yKmuh9xfY93ZTo=;
        b=s98KAOrEhGavwA97b4QDJ9/CcB+i0FQWvjemwihPhovgeAJAtBr5MCGOVs36rNPdma
         ROl/H5AZ3OhuuVvHBPJlWDZqhifnz9xoOqExzG//euPYYDdtsH3HF7j7kCihnV7f71Ty
         pdztLcdxya1vJmxrdpZ/6IJDCX40btXs7ZPdj7TI0iw5R/AkvvkuSKAoRnZ9MsuJP6JO
         v9985ouOj6O4U4nIj3ar2L+s6PQ6Ly7+9vKSfobXVuOL0ML31zk/XKHO6GmJVsVl1RIb
         4ehkfPRIsXyQpfa+KfMi6S7cZRALkIU0R0vmQxX69SV80GLeL77es4Z7DGIWqN2ELD1y
         PPCg==
X-Gm-Message-State: AOAM533i9LzHvTaa9a4+tdwvivO8bwJUAciNjHb0z8VX10ImyZtMZTyW
        39rmquWPSPIYhyMdq2ABVxcmhQ==
X-Google-Smtp-Source: ABdhPJx6qgN0xzdCFv7PlWGT7pd4pj3huXvf0Kl3hk4IXYVBsGBl8FaoOINYlkmG28nEkKIEusJ7Nw==
X-Received: by 2002:a05:6214:6a1:: with SMTP id s1mr4898398qvz.20.1611072768482;
        Tue, 19 Jan 2021 08:12:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id v67sm201276qkd.94.2021.01.19.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:12:47 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:12:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAcE/dTuOB9PbGQU@nand.local>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119144251.27924-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Tue, Jan 19, 2021 at 03:42:51PM +0100, Jacob Vosmaer wrote:
> The previous implementation of ls-refs would perform exactly one ref
> walk, matching each ref against the prefixes (if any) provided by the
> user. This can be expensive if there are a lot of refs and the user
> only cares about a small subset of them.
>
> In this patch we analyze the prefixes provided by the user and build a
> minimal set of disjoint prefixes that contains all of them. We then do
> a ref walk for each of these minimal prefixes.

This reminds me of b31e2680c4 (ref-filter.c: find disjoint pattern
prefixes, 2019-06-26), where we solved a very similar problem for 'git
for-each-ref'. The difference here is that we are operating on a set of
prefixes, not a set of refs.

But, I think that we could get pretty far by treating the prefixes as
refs so that we can call ref-filter.c:find_longest_prefixes(). For its
purposes, it doesn't really care about whether or not the arguments
actually are references. It simply returns the longest common prefix
among all of its arguments (delimited by '/' characters).

> It is tempting to have just one strvec for the prefixes and use it
> both for matching and for iterating. But every time I tried that, it
> made things more complicated. I settled on leaving the existing ref
> matching (using &data.prefixes) alone, and I added a new layer around
> it for the ref walk optimization (using &iter_prefixes).

I think the implementation in b31e2680c4 deals with this nicely: it
takes a pointer to a strvec and dumps prefixes in there.

> This commit also fixes a bug in ls-refs.c that was not triggered
> before: we were using a strvec set to zero, which is not how you are
> supposed to initialize a strvec. We now call strvec_init after zeroing.

Good.

> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  ls-refs.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index a1e0b473e4..6d5f0c769a 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -84,12 +84,44 @@ static int ls_refs_config(const char *var, const char *value, void *data)
>  	return parse_hide_refs_config(var, value, "uploadpack");
>  }
>
> +static int cmp_prefix(const void *a_, const void *b_){
> +	const char *a = *(const char **)a_;
> +	const char *b = *(const char **)b_;
> +	return strcmp(a, b);
> +}
> +
> +static void deduplicate_prefixes(struct strvec *prefixes) {
> +	int i;
> +
> +	QSORT(prefixes->v, prefixes->nr, cmp_prefix);
> +
> +	for (i = 1; i < prefixes->nr;) {
> +		const char *p = prefixes->v[i];
> +
> +		/*
> +		 * If p is "refs/foobar" and its predecessor is "refs/foo" then we should
> +		 * drop p, both to avoid sending duplicate refs to the user, and to avoid
> +		 * doing unnecessary work.
> +		 */
> +		if (starts_with(p, prefixes->v[i - 1])) {
> +			MOVE_ARRAY(&prefixes->v[i], &prefixes->v[i + 1], prefixes->nr - (i + 1));
> +			prefixes->v[prefixes->nr - 1] = p;
> +			strvec_pop(prefixes);
> +		} else {
> +			i++;
> +		}
> +	}
> +}
> +

Indeed, this and the below code are very reminiscent of b31e2680c4. So,
I wonder if it's possible to use the existing implementation rather than
implement what is roughly the same thing twice.

Below is a completely untested patch to try and reuse the code from
b31e2680c4. (It compiles, but that's the extent of my guarantees about
it ;-).) It's all smashed into one huge patch, so if you're happy with
the direction I'll take care of cleaning it up. The new function in
ref-filter.h really belongs in refs.h, but I left the implementation in
ref-filter.c to avoid creating more noise in the diff.

Let me know what you think.

Thanks,
Taylor

--- >8 ---

Subject: [PATCH] ls-refs: iterate longest common refs prefix

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ls-refs.c    |  4 +++-
 ref-filter.c | 46 ++++++++++++++++++++++++++++++++--------------
 ref-filter.h | 10 ++++++++++
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..6a3e11d45c 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -6,6 +6,7 @@
 #include "ls-refs.h"
 #include "pkt-line.h"
 #include "config.h"
+#include "ref-filter.h"

 /*
  * Check if one of the prefixes is a prefix of the ref.
@@ -109,7 +110,8 @@ int ls_refs(struct repository *r, struct strvec *keys,
 		die(_("expected flush after ls-refs arguments"));

 	head_ref_namespaced(send_ref, &data);
-	for_each_namespaced_ref(send_ref, &data);
+	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
+				     send_ref, &data, 0);
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
 	return 0;
diff --git a/ref-filter.c b/ref-filter.c
index aa260bfd09..c34bf34d06 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1987,6 +1987,36 @@ static void find_longest_prefixes(struct string_list *out,
 	strbuf_release(&prefix);
 }

+int for_each_fullref_in_prefixes(const char *namespace,
+				 const char **patterns,
+				 each_ref_fn cb,
+				 void *cb_data,
+				 int broken)
+{
+	struct string_list prefixes = STRING_LIST_INIT_DUP;
+	struct string_list_item *prefix;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0, namespace_len;
+
+	find_longest_prefixes(&prefixes, patterns);
+
+	if (namespace)
+		strbuf_addstr(&buf, namespace);
+	namespace_len = buf.len;
+
+	for_each_string_list_item(prefix, &prefixes) {
+		strbuf_addf(&buf, prefix->string);
+		ret = for_each_fullref_in(buf.buf, cb, cb_data, broken);
+		if (ret)
+			break;
+		strbuf_setlen(&buf, namespace_len);
+	}
+
+	string_list_clear(&prefixes, 0);
+	strbuf_release(&buf);
+	return ret;
+}
+
 /*
  * This is the same as for_each_fullref_in(), but it tries to iterate
  * only over the patterns we'll care about. Note that it _doesn't_ do a full
@@ -1997,10 +2027,6 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       void *cb_data,
 				       int broken)
 {
-	struct string_list prefixes = STRING_LIST_INIT_DUP;
-	struct string_list_item *prefix;
-	int ret;
-
 	if (!filter->match_as_path) {
 		/*
 		 * in this case, the patterns are applied after
@@ -2024,16 +2050,8 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_in("", cb, cb_data, broken);
 	}

-	find_longest_prefixes(&prefixes, filter->name_patterns);
-
-	for_each_string_list_item(prefix, &prefixes) {
-		ret = for_each_fullref_in(prefix->string, cb, cb_data, broken);
-		if (ret)
-			break;
-	}
-
-	string_list_clear(&prefixes, 0);
-	return ret;
+	return for_each_fullref_in_prefixes(NULL, filter->name_patterns,
+					    cb, cb_data, broken);
 }

 /*
diff --git a/ref-filter.h b/ref-filter.h
index feaef4a8fd..f666a0fb49 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -146,4 +146,14 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
 				      const struct object_id *oid);

+/**
+ * iterate all refs which descend from the longest common prefix among
+ * "patterns".
+ */
+int for_each_fullref_in_prefixes(const char *namespace,
+				 const char **patterns,
+				 each_ref_fn cb,
+				 void *cb_data,
+				 int broken);
+
 #endif /*  REF_FILTER_H  */
--
2.30.0.138.g6d7191ea01

