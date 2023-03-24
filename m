Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34EC6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjCXPaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXPae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 11:30:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1411DB8A
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:30:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s19so1326998pgi.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679671831;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzfNt6i2eFw0oAa4uuQx8I3OBdt7zEt8+Dcun+RmPcQ=;
        b=Q3SLbK3JlbVAMm9UP4pwdnpm0FB3sDQpZpoimhop2AvF3UTYu1K3wb6F9/DP7zAFy/
         vTmV++wnjREAuGzaCC1csTIBYLS5mEMRw/77x+JZfmtzR8WlckjeEPppSJYxo/C9XOVO
         41TLYGQMy7eFWhkkErsX7yshvHKuTq3aRFHSY0JLliG+ou6PxnnC9TfO7c2O5wcJDnPV
         Us8b7Ut8X9KL/flgn/UPfTda0c5lMnUI0L76jJoNePpum1E60FPmivekk5jl+Lgky7Wo
         QdHdVgupXEoWJcstpixzCQKLIWMpkPMwf4Wi3nqACQxlUMBJG8Caw+slYMlnocNLNB6Q
         8dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679671831;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZzfNt6i2eFw0oAa4uuQx8I3OBdt7zEt8+Dcun+RmPcQ=;
        b=ZkQ/Q6As8MxHG/CVPhY+c9Q2DOeIncVfbeWZkyJVPWIViAgsvG0ltX0B+ftmBz/y3m
         cPH6X1kVL3eKZcxqxeXWbOJasTwblvhU5Gii8MzTpbq2pwHi7oAW+gA9IyFKBvbzlxIq
         3BDNZruXvHKJdmajPRCWbDQvqvxXqiq6Wv05iZp341/JTO9uV3jMu/fh8KZhi6jdnkNX
         wC2FKP7YeKkkCwv5B1CBfMHOjUPX7WPVN8CZD826SfDtqDWW80kZxxlgCHhvG0Jamnck
         mWEgfnctSTN207a6lg/P0JqQivSelJn9dbutfcDrKPe83gN+YbdjZ6V3nrBvAw4mKCs9
         GxLw==
X-Gm-Message-State: AAQBX9cflmNkryiJSlusKKd3ovWCjr/wgAJynW9TPXMCuUPUvOMcJ8CA
        VQxqY0O7cwmCQeoHR5Dg8lk=
X-Google-Smtp-Source: AKy350ZtsMB4R/xtt2bLpzI8aqgpsnsH2M6LQWx6EHzEkPPg+MalvgIBrT2+fVS4+LFeXe2ZdWcFVg==
X-Received: by 2002:a62:1c83:0:b0:622:dd9b:e2d8 with SMTP id c125-20020a621c83000000b00622dd9be2d8mr3326795pfc.3.1679671831421;
        Fri, 24 Mar 2023 08:30:31 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78394000000b00608dae58695sm13903632pfm.209.2023.03.24.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:30:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] blame: allow --contents to work with non-HEAD commit
References: <20230324055437.297401-1-jacob.e.keller@intel.com>
Date:   Fri, 24 Mar 2023 08:30:30 -0700
In-Reply-To: <20230324055437.297401-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Thu, 23 Mar 2023 22:54:37 -0700")
Message-ID: <xmqqpm8y4161.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> This is because the blame process generates a fake working tree commit
> which always uses the HEAD object as its sole parent.
>
> Enhance fake_working_tree_commit to take the object ID to use for the
> parent instead of always using the HEAD object. Then, always generate a
> fake commit when we have contents provided, even if we have a final
> object. Remove the check to disallow --contents and a final revision.

Around here, probably in between the two paragraphs, it makes sense
to explain why we do this enhancement only for --contents but not
for the case where we take contents from the working tree file (that
would ensure what I wrote will not go waste in my review ;-).

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 9a663535f443..6476dd327377 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -64,11 +64,10 @@ include::line-range-format.txt[]
>  	manual page.
>  
>  --contents <file>::
> +	Pretend the file being annotated has the contents from the named
> +	file instead of using the contents of <rev> or the working tree
> +	copy. You may specify '-' to make the command read from standard
> +	input for the file contents.

Hmph, I can sort of see that "or the working tree copy" refers to
the behaviour when <rev> is not given, but I wonder if it makes it
easier to understand to explicitly say that missing <rev> (or having
no positive end) defaults to "HEAD" when choosing the parent of the
fake commit with the given contents in it.

> @@ -198,10 +198,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
>  	commit->date = now;
>  	parent_tail = &commit->parents;
>  
> -	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
> -		die("no such ref: HEAD");
> -
> -	parent_tail = append_parent(r, parent_tail, &head_oid);
> +	parent_tail = append_parent(r, parent_tail, oid);

Good.  As fake_working_tree_commit() is no longer about creating a
fake commit based on "HEAD", we do not interpret "HEAD" here, and
instead the caller is now responsible for feeding the fake parent
object name to us.

> @@ -2772,22 +2769,30 @@ void setup_scoreboard(struct blame_scoreboard *sb,
>  		sb->commits.compare = compare_commits_by_reverse_commit_date;
>  	}
>  
> -	if (sb->final && sb->contents_from)
> -		die(_("cannot use --contents with final commit object name"));
> -

OK.

> +	if (sb->contents_from || !sb->final) {
> +		struct object_id head_oid, *parent_oid;
> +
>  		/*
>  		 * "--not A B -- path" without anything positive;
>  		 * do not default to HEAD, but use the working tree
>  		 * or "--contents".
>  		 */

This comment is no longer valid, as this block handles more cases now:

	/*
         * Build a fake commit at the tip of the history, when
         * (1) "git blame ^A ^B -- path", i.e. without any positive
	 *     end of the history range, in which case we build such
	 *     a fake commit on top of the HEAD to blame in-tree
	 *     modifications.
	 * (2) "git blame --contents=file [A] -- path", with or without
	 *     positive end of the history range but with --contents,
	 *     in which case we pretend that there is a fake commit
         *     on top of the positive end (defaults to HEAD) that
         *     has the given contents in the path.
	 */

> +		if (sb->final) {
> +			parent_oid = &sb->final->object.oid;
> +		} else {
> +			if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
> +				die("no such ref: HEAD");
> +			parent_oid = &head_oid;
> +		}
> +
>  		setup_work_tree();
>  		sb->final = fake_working_tree_commit(sb->repo,
>  						     &sb->revs->diffopt,
> -						     sb->path, sb->contents_from);
> +						     sb->path, sb->contents_from,
> +						     parent_oid);
>  		add_pending_object(sb->revs, &(sb->final->object), ":");
>  	}

Other than that, looking good.

Thanks.
