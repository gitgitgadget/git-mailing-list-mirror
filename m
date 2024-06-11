Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2E2628D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136340; cv=none; b=Y5Id3VZ5DvDeBdl6UB/x+vGzebaq40ShRzJbxLV4f4xdTrAvGv2giUCsKObpjCRBh0NlM/VNx9bHxjegJ+JANmxpxN04PmiBzrP1thajk1Vi70MddSMRoG/M5hBuRlRTcpI9EYDB16wTdiwCI3SSbgtEUmEedzpfnM2XL0yTHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136340; c=relaxed/simple;
	bh=rzsSmqLuHh/ySs1DRuGq6jTozPR8OgHNTIaP2tZv450=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVre1IUmntziuZX7tYSZ2QcIeA59/t4q0kTI8EcCQhxVSoUfpp2/h1unOwMmyMZsca2GEqe2CvGOig6zyANc74lkzI8tGk8vEgVupvEpKmTLosJtlBb95tTdw6EjTivMCeoXRFPCteCn4XCrwHF6TN1WsdjevF3twze6gLT24Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=meEJCqNd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="meEJCqNd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E6E92A017;
	Tue, 11 Jun 2024 16:05:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rzsSmqLuHh/ySs1DRuGq6jTozPR8OgHNTIaP2t
	Zv450=; b=meEJCqNdz16keP11H8j90fHkSKz9rv8QBeqOKKftTTkmIY9xIYWrwa
	+F5Auyib1mibWgv/onv40/paJ9+SRpBhpsT1V1hS6GCWa+Cs+Y0uKcCfZ4R+UJHH
	+shQbaoyOSLbhfUSYm56qfV35vGhAP73MkWgfM+GLbmzXgoxsbXqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64C192A016;
	Tue, 11 Jun 2024 16:05:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C62522A013;
	Tue, 11 Jun 2024 16:05:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v6 3/3] unbundle: support object verification for fetches
In-Reply-To: <53395e8c08a8487f3e53dca15766307854a24b3b.1718109943.git.gitgitgadget@gmail.com>
	(Xing Xin via GitGitGadget's message of "Tue, 11 Jun 2024 12:45:43
	+0000")
References: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
	<pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
	<53395e8c08a8487f3e53dca15766307854a24b3b.1718109943.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 13:05:35 -0700
Message-ID: <xmqqsexjtfcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F7D43C88-282D-11EF-9754-965B910A682E-77302942!pb-smtp2.pobox.com

"Xing Xin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Xing Xin <xingxin.xx@bytedance.com>
>
> This commit extends object verification support for fetches in
> `bundle.c:unbundle` by adding the `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`
> option to `verify_bundle_flags`. When this option is enabled,
> `bundle.c:unbundle` invokes `fetch-pack.c:fetch_pack_fsck_objects` to
> determine whether to append the "--fsck-objects" flag to
> "git-index-pack".

Please start your proposed log message by stating what the perceived
problem without this patch in the current world is.  Without it, you
cannot easily answer the most basic question: "why are we doing this?"

The name VERIFY_BUNDLE_FSCK_FOLLOW_FETCH does not read very well.
VERIFY_BUNDLE part is common across various flags, so what is
specific to the feature is "FSCK_FOLLOW_FETCH", and it is good that
we convey the fact that we do a bit more than the normal
VERIFY_BUNDLE (which is, to read the prerequisite headers and make
sure we have them in the sense that they are reachable from our
refs) with the word FSCK.

But is it necessary (or even a good idea) to limit its usability
with "FOLLOW_FETCH" (which does not look even grammatical)?  Aren't
we closing the door to other folks who may want to do a more
thorough fsck-like checks in other codepaths by saying "if you are
not doing this immediately after you fetch, you are unwelcome to use
this flag"?

> `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` is now passed to `unbundle` in the
> fetching process, including:
>
> - `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
> - `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.
>
> This addition ensures a consistent logic for object verification during
> fetch operations. Tests have been added to confirm functionality in the
> scenarios mentioned above.
>
> Reviewed-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>  bundle-uri.c                |  2 +-
>  bundle.c                    |  5 +++++
>  bundle.h                    |  1 +
>  t/t5558-clone-bundle-uri.sh | 35 ++++++++++++++++++++++++++++++++++-
>  t/t5607-clone-bundle.sh     | 33 +++++++++++++++++++++++++++++++++
>  transport.c                 |  2 +-
>  6 files changed, 75 insertions(+), 3 deletions(-)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 65666a11d9c..e7ebac6ce57 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
>  	 * the prerequisite commits.
>  	 */
>  	if ((result = unbundle(r, &header, bundle_fd, NULL,
> -			       VERIFY_BUNDLE_QUIET)))
> +			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
>  		return 1;

OK (modulo the flag name).

> +	if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
> +		if (fetch_pack_fsck_objects())
> +			strvec_push(&ip.args, "--fsck-objects");
> +

OK, that's quite straight-forward.  We are running "index-pack
--fix-thin --stdin" and feeding the bundle data to it.  We just tell
it to also work in the "--fsck-objects" mode.

> diff --git a/transport.c b/transport.c
> index 0ad04b77fd2..6cd5683bb45 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -184,7 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  	if (!data->get_refs_from_bundle_called)
>  		get_refs_from_bundle_inner(transport);
>  	ret = unbundle(the_repository, &data->header, data->fd,
> -		       &extra_index_pack_args, 0);
> +		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_FOLLOW_FETCH);

OK.

I wonder if something like this is a potential follow-up topic
somebody may be interested in after the dust settles.  That is
exactly why the name of this bit matters.



 builtin/bundle.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git c/builtin/bundle.c w/builtin/bundle.c
index d5d41a8f67..eeb5963dcb 100644
--- c/builtin/bundle.c
+++ w/builtin/bundle.c
@@ -194,10 +194,13 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	int bundle_fd = -1;
 	int ret;
 	int progress = isatty(2);
+	int fsck_objects = 0;
 
 	struct option options[] = {
 		OPT_BOOL(0, "progress", &progress,
 			 N_("show progress meter")),
+		OPT_BOOL(0, "fsck-objects", &fsck_objects,
+			 N_("check the objects in the bundle")),
 		OPT_END()
 	};
 	char *bundle_file;
@@ -217,7 +220,8 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
 	ret = !!unbundle(the_repository, &header, bundle_fd,
-			 &extra_index_pack_args, 0) ||
+			 &extra_index_pack_args,
+			 fsck_objects ? VERIFY_BUNDLE_FSCK_FOLLOW_FETCH : 0) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:

