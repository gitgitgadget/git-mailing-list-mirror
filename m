Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1193DC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 21:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5D7206F4
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 21:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FtcfyGRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGOVIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:08:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51487 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVId (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 17:08:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6381070B16;
        Wed, 15 Jul 2020 17:08:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vJHspEMK7vMTB64dOhW78NWlPwY=; b=FtcfyG
        RFCq8jFY4Wn6zEcJW4bYvkouHJkAE7L0RXHapKUou+FhdtVabWQM7E2M3S3vt7Zz
        Vh4Podw6iPP88jOTUNiirEixOoV9zDY7//ymGu304dr2GGnf0TR8OZILI1J6iyDO
        Xso9QyERc0VLb4ShYW5IhNBNqD010ZSZAaupU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WLTJFAzKVqwP5jPCo4U6RJWreGNELZnr
        88+eDqBBFwefnVOcsvA+KlDs/AVmtSHGJK6FxmRCzEiQd9jG5/hkkIb7oatELdCC
        BiRQzU2G/NbpW2JVQYcD4GiwQyejY7czI900b4p/Mj2G6vxVP66TKn4B8XRju7Iq
        4sZi5lu0Pi8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59D7C70B15;
        Wed, 15 Jul 2020 17:08:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0A9B70B14;
        Wed, 15 Jul 2020 17:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal Privoznik <mprivozn@redhat.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br, kolyshkin@gmail.com
Subject: Re: [PATCH] completion: add show --color-moved[-ws]
References: <da0bef7b856388d7f4613c30d3a7c962ddba96b2.1594712582.git.mprivozn@redhat.com>
Date:   Wed, 15 Jul 2020 14:08:30 -0700
In-Reply-To: <da0bef7b856388d7f4613c30d3a7c962ddba96b2.1594712582.git.mprivozn@redhat.com>
        (Michal Privoznik's message of "Tue, 14 Jul 2020 09:44:51 +0200")
Message-ID: <xmqqtuy8ij01.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55E5F5B4-C6DF-11EA-A8A2-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Privoznik <mprivozn@redhat.com> writes:

> The completion for diff command was added in fd0bc175576 but
> missed the show command which also supports --color-moved[-ws].

A block line this

> +	--color-moved=*)
> +		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
> +		return
> +		;;
> +	--color-moved-ws=*)
> +		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
> +		return
> +		;;

appear twice in the file, once in _git_diff and again in _git_show.

It is disturbing that we need to keep duplicating these same options
over and over again.  Granted, the duplication exists before this
patch (the case arms for --diff-algorithm=* and --submodule=* are
already duplicated), but this patch makes it worse X-<.

And the next person who notices that this patch only added these to
"show" would want to further duplicate them to _git_log.  Yuck X-<.

Will apply as-is for now, but at some point we may want to clean
these up.  With a new helper, along the lines of this, perhaps?

Thanks.


 contrib/completion/git-completion.bash | 79 +++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0fdb5da83b..e2d6d17bfe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1683,23 +1683,12 @@ _git_diff ()
 {
 	__git_has_doubledash && return
 
-	case "$cur" in
-	--diff-algorithm=*)
-		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
-		return
-		;;
-	--submodule=*)
-		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
-		return
-		;;
-	--color-moved=*)
-		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
-		return
-		;;
-	--color-moved-ws=*)
-		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
+	if __git_complete_common_diff_option_args
+	then
 		return
-		;;
+	fi
+
+	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index
@@ -1949,6 +1938,29 @@ __git_log_shortlog_options="
 __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
 
+__git_complete_common_diff_option_args ()
+{
+	case "$cur" in
+	--diff-algorithm=*)
+		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
+		return 0
+		;;
+	--submodule=*)
+		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
+		return 0
+		;;
+	--color-moved=*)
+		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
+		return 0
+		;;
+	--color-moved-ws=*)
+		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
+		return 0
+		;;
+	esac
+	return 1
+}
+
 _git_log ()
 {
 	__git_has_doubledash && return
@@ -1971,6 +1983,12 @@ _git_log ()
 		return
 		;;
 	esac
+
+	if __git_complete_common_diff_option_args
+	then
+		return
+	fi
+
 	case "$cur" in
 	--pretty=*|--format=*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
@@ -1985,14 +2003,6 @@ _git_log ()
 		__gitcomp "full short no" "" "${cur##--decorate=}"
 		return
 		;;
-	--diff-algorithm=*)
-		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
-		return
-		;;
-	--submodule=*)
-		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
-		return
-		;;
 	--no-walk=*)
 		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
 		return
@@ -2893,28 +2903,17 @@ _git_show ()
 {
 	__git_has_doubledash && return
 
+	if __git_complete_common_diff_option_args
+	then
+		return
+	fi
+
 	case "$cur" in
 	--pretty=*|--format=*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
 			" "" "${cur#*=}"
 		return
 		;;
-	--diff-algorithm=*)
-		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
-		return
-		;;
-	--submodule=*)
-		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
-		return
-		;;
-	--color-moved=*)
-		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
-		return
-		;;
-	--color-moved-ws=*)
-		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
-		return
-		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature --patch
