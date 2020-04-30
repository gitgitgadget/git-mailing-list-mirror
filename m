Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C68FC4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1C020774
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmBFMitc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgD3UzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:55:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50528 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3UzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 16:55:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 813EF608EE;
        Thu, 30 Apr 2020 16:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BBDllDogqWP74zcDFkBHPKQWQAw=; b=lmBFMi
        tcNFrlDlJ/le+/yh6PzbkSkSNU2E/S51X1+S/5hegGmnYoJf+NaNqk9kFw1TFLvC
        KkYyEPiNfx4swLfuICbLQH8rPcLqtAaKWuilYscdF6wCKulhRFMETPgLKXAIH0k0
        QicUe5srnvuvf4yW7dAh85BdiCHZfu2AhI1nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=piaJJzVOmPL543OWWcZuS/Eyh6hB6T7C
        rKbcRZFMpjplQkqhPONMQ68IKYC9Azmd8VYhBlzEpnjLSu2NR35Y9RZUAmN594xN
        ospi3vGUsd0D6rc/wlR2yFJwvZ4ZR69C9vA0pO9FFmM4bx+YSlgKwOJmCBa7Cobp
        dzeeu9aphqI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78723608EC;
        Thu, 30 Apr 2020 16:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3C53608EB;
        Thu, 30 Apr 2020 16:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/4] commit: make 'commit_graft_pos' non-static
References: <cover.1588275891.git.me@ttaylorr.com>
        <cb8dde2ae2e78d0bcfb61382fe7769c12804336b.1588275891.git.me@ttaylorr.com>
Date:   Thu, 30 Apr 2020 13:55:11 -0700
In-Reply-To: <cb8dde2ae2e78d0bcfb61382fe7769c12804336b.1588275891.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 30 Apr 2020 13:48:47 -0600")
Message-ID: <xmqqbln8r8wg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E24FEDE4-8B24-11EA-982A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> -static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
> +int commit_graft_pos(struct repository *r, const unsigned char *sha1)
>  {
>  	return sha1_pos(sha1, r->parsed_objects->grafts,
>  			r->parsed_objects->grafts_nr,
> diff --git a/commit.h b/commit.h
> index ab91d21131..eb42e8b6d2 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -236,6 +236,7 @@ struct commit_graft {
>  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>  
>  struct commit_graft *read_graft_line(struct strbuf *line);
> +int commit_graft_pos(struct repository *r, const unsigned char *sha1);

In an earlier exchange, I saw this:

>> - could include a comment saying that it's an index into
>>   r->parsed_objects->grafts
>
> This and the below are both good ideas to me. I prefer this one, since
> we'd have to duplicate yet another static function
> ('commit_graft_sha1_access()' directly above) that is called by this
> one.
>
>> - I'm usually loathe to suggest unnecessary duplication of code, but
>>   it might make sense to duplicate the function into shallow.c.  Or
>>   even to inline it there (in the single call site, that ends up
>>   being pretty readable).
>
> I am not at all offended by duplication of code where it makes sense to
> do so, but having to duplicate two functions seems like we'd be better
> off simply documenting the function in commit.h.

and I think I agree with that direction.  Forgot to add those
comments?


