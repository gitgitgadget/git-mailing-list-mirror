Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76366C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 02:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268AB2075A
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H7ft7a/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKUCAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:00:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58233 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKUCAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 21:00:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04DAE2D337;
        Wed, 20 Nov 2019 21:00:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qp15PjkMPuVDjaGifW3XdMFZqnQ=; b=H7ft7a
        /AGlKWpiPpXAQJTC1YfXi0XIvm8qX2kNJdn5NNR083YGJPIBsufT5v/ZWYZlF0I0
        FFgFlaJQ1aztlA6cAB4GKVCHh4aY0KBxmDERenK7kqTBW8b9KDR/84kZX3WY7dFI
        cUDTOB2bHcBRLbdvRLmqbgpOaDa051vl3mRec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HPWmoSj99EDjLb+EXNluOgYT8A62jmot
        PO4nMvLr7SSD2Cv7IOsB0xq1WIR/zumQNm6jYQs8oHdvE7fo3G3RoALTZH7GHdKg
        YFcpgpq2BW/2mYjAihG4hSb5wb+WiBEUPXTu0xMDohF0ou/CMFapxxy24FKhOwF/
        Hd7FwuYCjS4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF87C2D336;
        Wed, 20 Nov 2019 21:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B2A82D330;
        Wed, 20 Nov 2019 21:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, predatoramigo@gmail.com
Subject: Re: [RFC PATCH v2 2/4] rebase: prepare cmd before choosing action
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
        <20191120095238.4349-3-rybak.a.v@gmail.com>
Date:   Thu, 21 Nov 2019 11:00:13 +0900
In-Reply-To: <20191120095238.4349-3-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Wed, 20 Nov 2019 10:52:36 +0100")
Message-ID: <xmqqimne9efm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A874AF8E-0C02-11EA-8813-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> When git rebase is started with option --exec, its arguments are parsed
> into string_list exec and then converted into options.cmd.
>
> In following commits, action --edit-todo will be taught to use arguments
> passed with --exec option.  Prepare options.cmd before switch (action)
> to make it available for the ACTION_EDIT_TODO branch of the switch.

Hmph.  With or without this change, when we hit the run_rebase label
in this function and call into run_rebase_interactive(), opts->cmd
does contain what came from the --exec option.  In that function, I
see ACTION_EDIT_TODO calls edit_todo_file() that edits the on-disk
file without paying attention to opts->cmd (the only thing in the
function that pays attention to this field is ACTION_ADD_EXEC).

So I am not sure what makes this step necessary.  I guess it is not
wrong per-se, but if the objetive of this series is to add what
came from the --exec option when the user interacts with the editor
in rebase-interactive.c::edit_todo_list(), wouldn't it be sufficient
to skip this step, pass opts to edit_todo_file() and let the helper
use opts->cmd while preparing the todo_list it passes to underlying
edit_todo_list() function?

I am not claiming that it would be a better way---I wouldn't be
surprised if it is an incorrect approach---but it is unclear why
this step is needed and why the tweak of the todo list must be done
in the "switch (action)" we see in the post context of the first
hunk in this patch.

Thanks for working on this.


> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  builtin/rebase.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 793cac1386..fa27f7b439 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1595,6 +1595,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			trace2_cmd_mode(action_names[action]);
>  	}
>  
> +	for (i = 0; i < exec.nr; i++)
> +		if (check_exec_cmd(exec.items[i].string))
> +			exit(1);
> +
> +	if (exec.nr) {
> +		imply_interactive(&options, "--exec");
> +
> +		strbuf_reset(&buf);
> +		for (i = 0; i < exec.nr; i++)
> +			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
> +		options.cmd = xstrdup(buf.buf);
> +	}
> +
>  	switch (action) {
>  	case ACTION_CONTINUE: {
>  		struct object_id head;
> @@ -1731,10 +1744,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	for (i = 0; i < exec.nr; i++)
> -		if (check_exec_cmd(exec.items[i].string))
> -			exit(1);
> -
>  	if (!(options.flags & REBASE_NO_QUIET))
>  		argv_array_push(&options.git_am_opts, "-q");
>  
> @@ -1746,15 +1755,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
>  	}
>  
> -	if (exec.nr) {
> -		imply_interactive(&options, "--exec");
> -
> -		strbuf_reset(&buf);
> -		for (i = 0; i < exec.nr; i++)
> -			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
> -		options.cmd = xstrdup(buf.buf);
> -	}
> -
>  	if (rebase_merges) {
>  		if (!*rebase_merges)
>  			; /* default mode; do nothing */
