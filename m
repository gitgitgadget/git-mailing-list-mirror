Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A5C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiCCVK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiCCVKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 16:10:25 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5281111BA
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 13:09:39 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2329A18BAFD;
        Thu,  3 Mar 2022 16:09:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gJ6L/++qki/hAQHTZ8yFcQs5dkGk9Xaft/nS4K
        aQ79U=; b=QtO4ZaRyGEtcXvhL9sPi96IlEtZ0uLrxgxPX3KWcWsW22siNaDFplm
        0RABICjtNj8vC0P2rVg/K7u6mT2sjHofT2nUvLIW7FMi4su6567QDLJjcJxZIoRj
        J964TO4KL3sXswd3mNuOwT32C3Ic5stz/H7oRzc88Bram3dUPUe/k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B71B18BAFC;
        Thu,  3 Mar 2022 16:09:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97EF118BAFB;
        Thu,  3 Mar 2022 16:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r?= =?utf-8?Q?=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 04/13] submodule--helper run-update-procedure: remove
 --suboid
References: <20220301044132.39474-1-chooglen@google.com>
        <20220303005727.69270-1-chooglen@google.com>
        <20220303005727.69270-5-chooglen@google.com>
Date:   Thu, 03 Mar 2022 13:09:35 -0800
In-Reply-To: <20220303005727.69270-5-chooglen@google.com> (Glen Choo's message
        of "Wed, 2 Mar 2022 16:57:18 -0800")
Message-ID: <xmqqilsuagkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B41F884-9B36-11EC-9C03-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Teach run-update-procedure to determine the oid of the submodule's HEAD
> instead of doing it in git-subomdule.sh.

subomdule -> submodule.

> @@ -3032,6 +3029,12 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
>  /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
>  static int update_submodule2(struct update_data *update_data)
>  {
> +	if (update_data->just_cloned)
> +		oidcpy(&update_data->suboid, null_oid());
> +	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
> +		die(_("Unable to find current revision in submodule path '%s'"),
> +			update_data->displaypath);
> +
>  	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
>  		return do_run_update_procedure(update_data);

Makes sense.
