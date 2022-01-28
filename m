Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60317C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 16:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbiA1QzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:55:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:40091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245711AbiA1QzO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 11:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643388908;
        bh=CFj8Mg/gUsZ/XGvy7+hFv4cjOWZ1RWv5PQRQZnChVsk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UBlFj03ZeH2hNECJ1Uu6H9URpn/5FLcZz4cYoZGmhLpXnkiRtCDZhs9y9psdcxEN9
         QZbgSljuWXgBZfCl/eNVYqacVL9c//P4liV57Fsvt0w92GlNcj8yq8J86tWRHvGGN8
         H5ZLi9L786g4A0whnYnYDIqnJjonMOgeHwWwPjJo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1mFUo52cMH-013RKA; Fri, 28
 Jan 2022 17:55:08 +0100
Date:   Fri, 28 Jan 2022 17:55:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CyIYG3kKDAbSYI/ZzX8/KoDC6MhIO0Ui1K86J2HzOG9guWqD03u
 7Bazq4ezXl4crwlMsFzN+ukq1cTC9Ty739SAiMobvBgkX2u+UZCLVIMCx35ye2a8vYxii9m
 JKjObCL94QvDkfVf38WC1ip/0A9BiOsghPjmQoXTl/ie0mxCig5u1MxhutgJqd44SxgOiq+
 5MdEsC1C5rsDg0LK9tNgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hn3GT+Jq7sQ=:m4luKOhwHpF2Vlp2wJEb0v
 lZfc7m+TcGM+rHyccvDyaJE3FQwsqYG98Hs1qtRPqnWfsTq4LbOE/e5evVIGwEB3RblI47sDa
 jObnFKd85rCpwC5IdwxyBW/jQEF9oLpXdZ25b2//k2qRoRTi0w096J0tKFx+5D4gVAMi9wE8c
 wfnvI+S7gZ9fauiXsEQlsMlpxEbAxgtoYp4A5YH+UdWDMNC1p1gYilnBLrwps8QmgBYJW3fIu
 u2eYiVfrKyr6V5cLogwP9DpOU/jWsUhNo+t0ROnvIxZ8DmE+blNBvzxgdFrcn44m3cjwNuuX8
 TbrOKdzz/4lG2HcogF2S8AFz6p3CKHJ25wOGMInlbWS9oXAF1BTHk9fcfntEcYP99lKdY83Pq
 ap8uRggOrgGz9eSsgLPc+7p3BPeaD7KA+1EIeBAhrFk83h6UaVv+qdPTu3HTdeDIjOjEfSf62
 OunRBYCMFhINH7jbE/MiaKY1v7dzpo2XokMjChPjUWCy7CAWA1NcW8CIA1i8BSu7/U5tjtnWy
 zCjIv7pAm6OgTp7KvAhlyc5E+/EBp80TlFDyAylH0y2afmNmPxhKgdUKSRVNPUQ4dhjXpB3cE
 cxHJSS7VmDZ9BYj789FACiSfQM2A88APtm2O8bkx6xL0N2CV+891F3psfDKoGpBjfuKlp+lxh
 MdFNQQFgV3YeDWa+BO4eN8ahr+SJTv8CpFskY6GdwYweTnkY8bh/qkljJ37VnwSPLDLA6CoQs
 X1Uvz9zxqrOs98dflWRLgvEh6131d9+YUqX+uzIvkXsJ9Xu1ProBEmtiNWEDgGGZ3xre92WEK
 mfJPGz9yClGUO9m1ddUESFux3MDg+wlrfNjNGv/TNzeHh6c/tabxOGmPbVNXQqTv5sMam4OMK
 DMHwcOjno79cDvdgNPTu+N0Gr0JoR/Mrja+g9dExb3WpUlCCVSXbr4dFux+4HTZ+nSD1oNr2A
 GmiU4S1ByAGthQ9G1BiK2wC9MmexM0tBHGUDwz0UreNv9wZKG1Vz9zRPF5ZglZkg2IcSrtZ+e
 fTgPo3qJi9dpSSwlxVTLuN8LQiwvVTxG6HYm05H2YpqrwxvCaEmqnrmLCCab/Xduirkuqq46y
 YCvxSg1RCFWol8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> After a merge, this function allows the user to extract the same
> information that would be printed by `ls-files -u` -- conflicted
> files with their mode, oid, and stage.

Hmm. Okay.

I am not really a fan of that output where we use a variable
number of lines per file. As in: in the regular case, where a file was
modified in divergent ways, we get three lines. But if it was deleted in
one branch, or if it was created in both branches, we have only two lines.

Frankly, I'd much rather have 3 lines for each and every conflict.

Granted, we currently only have three stages, and we can pretty much
guarantee that at least two of these stages are non-empty (otherwise where
would be the conflict?).

Meaning: Even if stage 3 is missing from the first conflict and stage 1 is
missing from the second conflict, in the output we would see stages 1, 2,
2, 3, i.e. a duplicate stage 2, signifying that we're talking about two
different conflicts.

But still. It makes me uneasy to have that much variability in
machine-consumable output.

And who knows, maybe if we're ever implementing more sophisticated merge
strategies for octopus merges, we might end up with more stages...

In other words...

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 31 +++++++++++++++++++++++++++++++
>  merge-ort.h | 21 +++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index b78dde55ad9..5e7cea6cc8f 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4275,6 +4275,37 @@ void merge_display_update_messages(struct merge_o=
ptions *opt,
>  	trace2_region_leave("merge", "display messages", opt->repo);
>  }
>
> +void merge_get_conflicted_files(struct merge_result *result,
> +				struct string_list *conflicted_files)
> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +	struct merge_options_internal *opti =3D result->priv;
> +
> +	strmap_for_each_entry(&opti->conflicted, &iter, e) {
> +		const char *path =3D e->key;
> +		struct conflict_info *ci =3D e->value;
> +		int i;
> +
> +		VERIFY_CI(ci);
> +
> +		for (i =3D MERGE_BASE; i <=3D MERGE_SIDE2; i++) {
> +			struct stage_info *si;
> +
> +			if (!(ci->filemask & (1ul << i)))
> +				continue;
> +
> +			si =3D xmalloc(sizeof(*si));
> +			si->stage =3D i+1;
> +			si->mode =3D ci->stages[i].mode;
> +			oidcpy(&si->oid, &ci->stages[i].oid);
> +			string_list_append(conflicted_files, path)->util =3D si;
> +		}
> +	}
> +	/* string_list_sort() uses a stable sort, so we're good */
> +	string_list_sort(conflicted_files);
> +}
> +
>  void merge_switch_to_result(struct merge_options *opt,
>  			    struct tree *head,
>  			    struct merge_result *result,
> diff --git a/merge-ort.h b/merge-ort.h
> index d643b47cb7c..e635a294ea8 100644
> --- a/merge-ort.h
> +++ b/merge-ort.h
> @@ -2,6 +2,7 @@
>  #define MERGE_ORT_H
>
>  #include "merge-recursive.h"
> +#include "hash.h"
>
>  struct commit;
>  struct tree;
> @@ -89,6 +90,26 @@ void merge_display_update_messages(struct merge_optio=
ns *opt,
>  				   struct merge_result *result,
>  				   FILE *stream);
>
> +struct stage_info {
> +	struct object_id oid;
> +	int mode;
> +	int stage;
> +};

... I'd rather not tack this onto a `string_list` but instead have
something like:

	struct conflict_info {
		struct {
			struct object_id oid;
			int mode;
			const char *path;
		} stages[3]
	};

where `path` can be `NULL` to indicate that this stage is missing.

Apart from this concern about the overall design, the patch looks good, of
course.

Ciao,
Dscho

> +
> +/*
> + * Provide a list of path -> {struct stage_info*} mappings for
> + * all conflicted files.  Note that each path could appear up to three
> + * times in the list, corresponding to 3 different stage entries.  In s=
hort,
> + * this basically provides the info that would be printed by `ls-files =
-u`.
> + *
> + * result should have been populated by a call to
> + * one of the merge_incore_[non]recursive() functions.
> + *
> + * conflicted_files should be empty before calling this function.
> + */
> +void merge_get_conflicted_files(struct merge_result *result,
> +				struct string_list *conflicted_files);
> +
>  /* Do needed cleanup when not calling merge_switch_to_result() */
>  void merge_finalize(struct merge_options *opt,
>  		    struct merge_result *result);
> --
> gitgitgadget
>
>
