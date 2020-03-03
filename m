Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6280C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC3F2073B
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m5ljRlda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgCCRvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:51:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51568 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbgCCRvO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:51:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A3DDC8BA6;
        Tue,  3 Mar 2020 12:51:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QSi2tyNaDpXv8AdBQiO+IKVj85w=; b=m5ljRl
        danQilZR4is0Sw9YiFq7FHLTwxXt3ekG78BQ0Mnx70p9IUHGhMoASfpH4YIL5QLP
        Vj5O/4O1d4RFGVaS5gbMAJiCwmZLopDu5kREBQC0/pH7tJ9TZtIplGjHoUwI9glt
        PsszfLKbwknWL9NlKZNwBCKxlYRFuacGk37nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WD6TaTf0HgJobcsWQhXV5EXhKjQGmqUS
        jqp5MFPizzJvIHeqGgwmPo5E1X4f8XcRZbGtil3KA6SsJtRV1nfcTHDmIqoy4h+G
        /jhff8j9GH+fFUNTeCOW4rNX6+tTFSozm2nKsKobG9iZl1J9rdUHGdTvk5sgHVZU
        MWO+tGcF5oU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82575C8BA5;
        Tue,  3 Mar 2020 12:51:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9C82C8BA2;
        Tue,  3 Mar 2020 12:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 1/2] remote: drop "explicit" parameter from remote_ref_for_branch()
References: <20200302133217.GA1176622@coredump.intra.peff.net>
        <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
        <20200303161223.1870298-2-damien.olivier.robert+git@gmail.com>
Date:   Tue, 03 Mar 2020 09:51:07 -0800
In-Reply-To: <20200303161223.1870298-2-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Tue, 3 Mar 2020 17:12:22 +0100")
Message-ID: <xmqqzhcx8gz8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 909F3278-5D77-11EA-9E0F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Commit 9700fae5ee (for-each-ref: let upstream/push report the remote ref
> name, 2017-11-07) added a remote_ref_for_branch() helper, which is
> modeled after remote_for_branch(). This includes providing an "explicit"
> out-parameter that tells the caller whether the remote was configured by
> the user, or whether we picked a default name like "origin".
>
> But unlike remote names, there's no default case for the remote branch
> name.

Up to this point, it is well written and easy to read.  I think
"there is no case where a default name for the remoate branch is
used" would be even more easy to read.

In any case, if there is no case that default name, I understand
that explicit is always set to 1?

> In any case where we don't set "explicit", we'd just an empty
> string anyway.

Sorry, but I cannot parse this.  But earlier, you established that
there is no case that a default is used, so is there any case where
we don't set "explicit"?  I don't get it.

> Let's instead return NULL in this case, letting us
> simplify the function interface.

>  	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
> -		int explicit;
>  		const char *merge;
>  
> -		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
> -					      &explicit);
> -		*s = xstrdup(explicit ? merge : "");
> +		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push);
> +		*s = xstrdup(merge ? merge : "");

Mental note: as long as explicit is set to true when the function
returns a non-null value, this change will be a no-op as far as the
result is concerned, which is a good thing.

> diff --git a/remote.c b/remote.c
> index 593ce297ed..c43196ec06 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -516,14 +516,11 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
>  	return remote_for_branch(branch, explicit);
>  }
>  
> -const char *remote_ref_for_branch(struct branch *branch, int for_push,
> -				  int *explicit)
> +const char *remote_ref_for_branch(struct branch *branch, int for_push)
>  {
>  	if (branch) {
>  		if (!for_push) {
>  			if (branch->merge_nr) {
> -				if (explicit)
> -					*explicit = 1;
>  				return branch->merge_name[0];

This case returns a non-NULL pointer, and used to set explicit to
true.

>  			}
>  		} else {
> @@ -534,15 +531,11 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
>  			if (remote && remote->push.nr &&
>  			    (dst = apply_refspecs(&remote->push,
>  						  branch->refname))) {
> -				if (explicit)
> -					*explicit = 1;
>  				return dst;

So did this.

>  			}
>  		}
>  	}
> -	if (explicit)
> -		*explicit = 0;
> -	return "";
> +	return NULL;

And this one used to return 0 in explicit and returned an empty
string.  The only caller ignored that empty string so returning NULL
in the new code does not make a difference, which also is a good
thing.

So the code looks correctly done.  I just don't get the feeling that
the proposed log message explains the change clearly to readers.

After reading the code through, I think "there's no default case"
was what caused my confusion.

    But unlike remote names, there is no default name when the user
    didn't configure one.  The only way the "explicit" parameter is
    used by the caller is to use the value returned from the helper
    when it is set, and use an empty string otherwise, ignoring the
    returned value from the helper.

    Let's drop the "explicit" out-parameter, and return NULL when
    the returned value from the helper should be ignored, to
    simplify the function interface.

perhaps?
