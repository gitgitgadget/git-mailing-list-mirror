Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85EA020209
	for <e@80x24.org>; Thu, 25 May 2017 05:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031299AbdEYFyB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:54:01 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34006 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934849AbdEYFx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:53:59 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so156981868pfj.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bJDUr248uzin+oIC7xp3hw0eMVyYzKtybNv+v7l4l50=;
        b=JqaqW/7XzX+l+ojwovTVUDRv2l0cwTI5xLjMgbN1Ld0SOVads0SPT7lQvrMA9mR6mf
         8HUXgopSDc50OoBLDcbxBQGGCKAV5WQEiln6YEEnZg0sX14SS5X/+xaGuME/gyKFN2qd
         AkOtfSIY4o7lrh9MjAhxzG8RU9/UCUWEyqoIANIbaLZ6R3LgETXcEY4mHkY3Coyw9y26
         uPRLA1l2UfhGJGX+li7drSwXxgemmjzAVbCu6IGtKTWgCNCxUWo8y3r3Ex6UUOuZXL3W
         gIfL0uMuTy6JVvPf2n97esvkgtXwMYAlaLRHzLB3DUq0t+PZjbYGhYO/oDmfA9Lndm8O
         QZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bJDUr248uzin+oIC7xp3hw0eMVyYzKtybNv+v7l4l50=;
        b=GojD5g0hrNtaijpeUT8U3+oQcRQaDpxpN7/ftpRMKkUsDkxCIoohEz4l23SKO+a7FL
         FYV0mcQZFEfTGQAfyXwYoyXLcNUOIQj8mqLOBXYVkfLN9l+BdwmUB/urFPDu9HawOZK2
         XkV3BfHqSIQQchwzMcFImtIpO5XHvZ6yDGGCoUXF+iRRPJqYR7M6ZNPJtg6OUfhrcoYG
         xSjnqaW3YiXP9yhBgbC4+kFkosNuoA3HHy7J47GJC2uPpuSEzJN+xUNaVX4Hj//HRmmD
         S6fJr2idKI3K97k2RPCPB6qQcsCTzSmeKWmizYsE8vmroI9IHNbux5W11Wom7KKHdhI4
         geig==
X-Gm-Message-State: AODbwcCSTtMOs2E+j/rMDyB1zaVBDKJ5IsientJkk88ljXihhSiPDGqE
        SuWwDJjw/Wz3wP4LSok=
X-Received: by 10.84.217.91 with SMTP id e27mr49343587plj.87.1495691639257;
        Wed, 24 May 2017 22:53:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id 3sm11143396pfp.11.2017.05.24.22.53.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 22:53:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 28/29] blame: move scoreboard setup to libgit
References: <20170524051537.29978-1-whydoubt@gmail.com>
        <20170524051537.29978-29-whydoubt@gmail.com>
Date:   Thu, 25 May 2017 14:53:57 +0900
In-Reply-To: <20170524051537.29978-29-whydoubt@gmail.com> (Jeff Smith's
        message of "Wed, 24 May 2017 00:15:36 -0500")
Message-ID: <xmqqfufteb2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  blame.c         | 279 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  blame.h         |  10 +-
>  builtin/blame.c | 276 -------------------------------------------------------
>  3 files changed, 281 insertions(+), 284 deletions(-)
>
> ...
> +static struct commit *find_single_initial(struct rev_info *revs,
> +					  const char **name_p)
> +{
> +	int i;
> +	struct commit *found = NULL;
> +	const char *name = NULL;
> +
> +	/*
> +	 * There must be one and only one negative commit, and it must be
> +	 * the boundary.
> +	 */
> +	for (i = 0; i < revs->pending.nr; i++) {
> +		struct object *obj = revs->pending.objects[i].item;
> +		if (!(obj->flags & UNINTERESTING))
> +			continue;
> +		obj = deref_tag(obj, NULL, 0);
> +		if (obj->type != OBJ_COMMIT)
> +			die("Non commit %s?", revs->pending.objects[i].name);
> +		if (found)
> +			die("More than one commit to dig up from, %s and %s?",
> +			    revs->pending.objects[i].name, name);
> +		found = (struct commit *) obj;
> +		name = revs->pending.objects[i].name;
> +	}
> +
> +	if (!name)
> +		found = dwim_reverse_initial(revs, &name);
> +	if (!name)
> +		die("No commit to dig up from?");
> +
> +	if (name_p)
> +		*name_p = name;
> +	return found;
> +}
> +...
> -static struct commit *find_single_initial(struct rev_info *revs,
> -					  const char **name_p)
> -{
> -	int i;
> -	const char *final_commit_name = NULL;
> -	struct commit *found = NULL;
> -
> -...
> -
> -	if (!final_commit_name)
> -		found = dwim_reverse_initial(revs, &final_commit_name);
> -	if (!final_commit_name)
> -		die("No commit to dig up from?");
> -
> -	if (name_p)
> -		*name_p = final_commit_name;
> -	return found;
> -}


In a patch whose primary purpose is to move code between files,
making what used to be public to static and vice versa is an
integral part of moving code.  That is why we want to see a patch
organized in such a way that comparing the lines that are lost from
builtin/blame.c and the lines that are added to blame.[ch] is made
easy.

And from that point of view, it was somewhat irritating to find this
kind of meaningless change.  If you didn't like the name of the
variable "final-commit-name", that shold have been renamed while the
code was still in builtin/blame.c

The end result looks OK anyway (I've checked 29/29 as well).

Thanks.


