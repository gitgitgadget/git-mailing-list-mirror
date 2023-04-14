Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655ADC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 15:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDNPLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNPLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 11:11:51 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B019C4
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 08:11:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E23481EB400;
        Fri, 14 Apr 2023 11:11:48 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=USck0APKgGdG+GDQl3l/pS9WwIQXA1UyqOPoX0D
        SNvA=; b=W57d1K9Q7atA8SNmc+QQJ5t/xH6KLZyTfqhoq1E/5DF3zCK1ShiNCi9
        YYQfF00oWQm0yH3u5fSb6JiO8MViShkb+OZ+GNUQHx1ryhN4KNKbe3fhZuk96gi7
        Pm5f9AANSx4GPgmX4GKreyLlC6gD38rlnD651/Q12o65iqKt9DAY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB1331EB3FD;
        Fri, 14 Apr 2023 11:11:48 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A61F31EB3FC;
        Fri, 14 Apr 2023 11:11:44 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 14 Apr 2023 11:11:41 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/18] version-gen: remove redundant check
Message-ID: <ZDltLSTxBCWRoMjK@pobox.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
 <20230414121841.373980-7-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414121841.373980-7-felipe.contreras@gmail.com>
X-Pobox-Relay-ID: AB490F4C-DAD6-11ED-AD36-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> If we are not in a git repository `git describe` will fail anyway.

The parent directory may be a git repository though.  The
current code ensures that we're running `git describe` in
the proper repository.

If we drop this, aren't we breaking things for someone
building a git tarball which is in a subdirectory of a git
repository?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  GIT-VERSION-GEN | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 34f561752b..cd94a7902e 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -26,7 +26,7 @@ describe () {
>  if test -f version
>  then
>  	VN=$(cat version)
> -elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
> +elif describe
>  then
>  	VN=$(echo "$VN" | sed -e 's/-/./g')
>  fi

-- 
Todd
