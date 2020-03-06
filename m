Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB3C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A47F206E2
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LHQnxyEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFWo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:44:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51975 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFWo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 17:44:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F27F93F87E;
        Fri,  6 Mar 2020 17:44:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qlYr76lcbkRNJBUyjkBFFs0agM8=; b=LHQnxy
        Ebi50sQAsbLGHg1xgBXoFRrj/BIjDNA9z/uaewxrFsnKOEe7EEJ2uMwuhw9E50rD
        ZuJek9ArFIUFa8x/LRp/bCGqVU0/YRByxHpKob3OF227fg5IJbeZRkmLWmhgZ3cp
        9xt/1RdO3Qr1ZL0UzL7vAMvtDDvi7TaY4WW0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sCn/0VKKt5R13xJDIrjC1kqIEsMly4e/
        qpPkOOPv41OATkPMUB502+LizfA/mCVNYomee02Pgv36uXbPM2rFKEZqepmd4MTa
        jywPcwnv6zkHrMHinEYkv2y+XyJPFRae+dsN+V52FPj0reZSS8rSjVOZMd+DlQph
        eA+H1wmGEZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E20273F87D;
        Fri,  6 Mar 2020 17:44:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51A583F87C;
        Fri,  6 Mar 2020 17:44:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 4/4] get_superproject_working_tree(): return strbuf
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <2eeefda3d41e6af1bc61249daf14b42050f0d0c3.1583521397.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 14:44:23 -0800
In-Reply-To: <2eeefda3d41e6af1bc61249daf14b42050f0d0c3.1583521397.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Fri, 06 Mar 2020
        19:03:16 +0000")
Message-ID: <xmqqv9nh14u0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0716741C-5FFC-11EA-A7AF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  			if (!strcmp(arg, "--show-superproject-working-tree")) {
> -				const char *superproject = get_superproject_working_tree();
> -				if (superproject)
> -					puts(superproject);
> +				struct strbuf superproject = STRBUF_INIT;
> +				if (get_superproject_working_tree(&superproject))
> +					puts(superproject.buf);
> +				strbuf_release(&superproject);

The new calling convention makes sense here.

>  				continue;
>  			}
>  			if (!strcmp(arg, "--show-prefix")) {
> diff --git a/submodule.c b/submodule.c
> index 215c62580fc..46f6c2cbfd0 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2168,14 +2168,13 @@ void absorb_git_dir_into_superproject(const char *path,
>  	}
>  }
>  
> -const char *get_superproject_working_tree(void)
> +int get_superproject_working_tree(struct strbuf* buf)

Micronit.  

The asterisk sticks to the identifier, not type, in our codebase.
I.e. "struct strbuf *buf".

> diff --git a/submodule.h b/submodule.h
> index c81ec1a9b6c..17492e478fc 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -152,8 +152,8 @@ void absorb_git_dir_into_superproject(const char *path,
>  /*
>   * Return the absolute path of the working tree of the superproject, which this
>   * project is a submodule of. If this repository is not a submodule of
> - * another repository, return NULL.
> + * another repository, return 0.
>   */
> -const char *get_superproject_working_tree(void);
> +int get_superproject_working_tree(struct strbuf* buf);

Likewise.

The conversion of the function body looked quite sensible.

Thanks.
