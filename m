Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C18BC433DF
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6809C20786
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fPk98Ujz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgG0XVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:21:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59381 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0XVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 19:21:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2F067A6E8;
        Mon, 27 Jul 2020 19:21:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t0KDQtuinKBcFVwOxwWZIrr7pRY=; b=fPk98U
        jzQDX1vxU0ew28S3+j5PyTZE/3tzPqCOq1Wq+QSooGF+N8ntIx2RYFbPot6EFyaD
        3YBVhbgHsRM7L2Vbk5gmv2MLxFR9dFIPBBwhgj5ley24/VhZ6qZCTtQvpX1kcW7K
        0oX9/uwPA5BfkN+/5redKloMnhDLEZ6Z2wWhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h2aGre9jfVkSKX9+8LKjvAnkfwwaXX1Z
        WnWwKg6ITTIv4VY6vKqlXP+hq8pOLnBrc7y2dPxL3x6x66NvD0HGZj+uW9n+c3X8
        kPlVKhnuFo/OB4PdMRUYI490y9lScVRk5dSyz3xQcdoKVwE3XaLtVEZXGuAFLmn0
        IvQ6h/pWTfQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB5D67A6E7;
        Mon, 27 Jul 2020 19:21:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74BEA7A6E6;
        Mon, 27 Jul 2020 19:21:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/5] ref-filter: add `short` option for 'tree' and 'parent'
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <49344f1b5559e7b4c63bad323a4dab5956331dde.1595882588.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 16:21:49 -0700
In-Reply-To: <49344f1b5559e7b4c63bad323a4dab5956331dde.1595882588.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Mon, 27 Jul 2020 20:43:05
        +0000")
Message-ID: <xmqq1rkwfss2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2F6E870-D05F-11EA-BE1B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -		if (!strcmp(name, "tree")) {
> +		if (!strcmp(name, "tree"))
>  			v->s = xstrdup(oid_to_hex(get_commit_tree_oid(commit)));
> -		}
> +		else if (!strcmp(name, "tree:short"))
> +			v->s = xstrdup(find_unique_abbrev(get_commit_tree_oid(commit), DEFAULT_ABBREV));

Again, isn't this going in totally unacceptable direction?  

By the time grab_foo() helper functions are reached, the requested
format should have been parsed to atom->u.foo.option and the only
thing grab_foo() helper functions should look at are the option.

Perhaps studying how "objectname" and its ":"-modified forms are
handled before writing this series would be beneficial.

 - objectname_atom_parser() is called when the parser for --format
   notices "objectname:modifier"; it is responsible for setting up
   atom->u.objectname.option.  Note that this is done only once at
   the very begining of processing

 - grab_objectname() is called for each and every object ref-filter
   iterates over and "objectname" and/or its modified form
   (e.g. "objectname:short") is requested.  Since the modifier is
   already parsed, it can do a simple switch on the value in
   .option.

I do not know if patches [3-5/5] follow the pattern used in [1-2/5],
but if they do, then they all need to be fixed, I think.

Thanks.


