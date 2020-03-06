Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094F2C10F25
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73B5206CC
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VHzD9igz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCFWOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:14:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55843 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFWOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 17:14:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC5CBB36F4;
        Fri,  6 Mar 2020 17:14:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oGR/BH1IBUlIqUdH7/4lim2+yq4=; b=VHzD9i
        gz/urAzzvaRnRv45p/maFXi2qhJoxnvyW85whvlPRdfa+FSPAug1yivdtaFvllzs
        VSh2AwXFhToxw+mVjT8LZxZi1gqufzF5GLIdvgPBP7xHtweZARu053+hnTVP3L2f
        jHr/T6P+mEdYJwC93qkOTGECJpn681WRtm0z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KuWrkIl9f8tdB6mAjURgYv6he5+LsEkd
        Y9G0f23fbQHi5WccHeyIFKGGr9i1CNjCJPzuam8Rz0me1+pa2EM9roGB+/J/N/g6
        EVfOn7VEPRdEs8Fl2XFg7RP9rdLATUtjHWQQjtlO1NtNSChGEYTIfELWpSZRtyZq
        GRPlwyqimjI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4EA6B36F3;
        Fri,  6 Mar 2020 17:14:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC777B36F2;
        Fri,  6 Mar 2020 17:14:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 3/4] real_path_if_valid(): remove unsafe API
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <59af49ad9f6b2ffc87e350f9bc00d233f2a9010f.1583521396.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 14:14:44 -0800
In-Reply-To: <59af49ad9f6b2ffc87e350f9bc00d233f2a9010f.1583521396.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Fri, 06 Mar 2020
        19:03:15 +0000")
Message-ID: <xmqqzhct167f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3B1767E-5FF7-11EA-8B05-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/sha1-file.c b/sha1-file.c
> index 616886799e5..f2b24654895 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -676,20 +676,15 @@ void add_to_alternates_memory(const char *reference)
>  char *compute_alternate_path(const char *path, struct strbuf *err)
>  {
>  	char *ref_git = NULL;
> -	const char *repo, *ref_git_s;
> +	const char *repo;
>  	int seen_error = 0;
>  
> -	ref_git_s = real_path_if_valid(path);
> -	if (!ref_git_s) {
> +	ref_git = real_pathdup(path, 0);
> +	if (!ref_git) {
>  		seen_error = 1;
>  		strbuf_addf(err, _("path '%s' does not exist"), path);
>  		goto out;
> -	} else
> -		/*
> -		 * Beware: read_gitfile(), real_path() and mkpath()
> -		 * return static buffer
> -		 */
> -		ref_git = xstrdup(ref_git_s);
> +	}

It is amusing to see that rewriting not to use the unsafe function
makes the code a lot easier to follow ;-)
