Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52218C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbiBIS0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiBIS0s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:26:48 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D71C0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:26:49 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B77AD17675F;
        Wed,  9 Feb 2022 13:26:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l/fON05bklIZtlV8ZNBEFVSvyybFUFKvI66C2q
        dEfkY=; b=Rwb6akxPhsz2F6JM60Pq5b+BJpxASBNxGfNV2D4pzZv5laDSzY5w33
        QuQMq2G5oXsexQ93BHdPU9Tv2LtPHOB3gysQLj0kvxxYWakom+iwNxcbNgkiq7ut
        itbumkltWgO1/wl2j4Kml0nsYMmio0QwjStG18Ve2Jn6vsk4J7o/o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFFAC17675E;
        Wed,  9 Feb 2022 13:26:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3D1A17675D;
        Wed,  9 Feb 2022 13:26:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Subject: Re: [PATCH 3/3] gitk: set log.graph=false when running `git log`
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
        <20220209162350.169971-3-alexhenrie24@gmail.com>
Date:   Wed, 09 Feb 2022 10:26:43 -0800
In-Reply-To: <20220209162350.169971-3-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 9 Feb 2022 09:23:49 -0700")
Message-ID: <xmqqzgmz7v6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5B619DA-89D5-11EC-9698-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  gitk-git/gitk | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

This may handle "gitk", but what about thousands other scripts
people have developed around "git log", I have to wonder.



> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 23d9dd1fe0..1d8a5ff622 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -411,8 +411,9 @@ proc start_rev_list {view} {
>      }
>  
>      if {[catch {
> -        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
> -                        --parents --boundary $args "--" $files] r]
> +        set fd [open [concat | git -c log.graph=false log --no-color -z \
> +                        --pretty=raw $show_notes --parents --boundary $args \
> +                        "--" $files] r]
>      } err]} {
>          error_popup "[mc "Error executing git log:"] $err"
>          return 0
> @@ -559,8 +560,9 @@ proc updatecommits {} {
>          set args $vorigargs($view)
>      }
>      if {[catch {
> -        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
> -                        --parents --boundary $args "--" $vfilelimit($view)] r]
> +        set fd [open [concat | git -c log.graph=false log --no-color -z \
> +                        --pretty=raw $show_notes --parents --boundary $args \
> +                        "--" $vfilelimit($view)] r]
>      } err]} {
>          error_popup "[mc "Error executing git log:"] $err"
>          return
