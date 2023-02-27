Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B8C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 21:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjB0V4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB0V4F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 16:56:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E903166CD
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 13:56:02 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so173963pjn.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 13:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afR68ODglnr92QgqJuPZf+6F75GS26eyJmFFULXmipI=;
        b=eHQO4G06X3KQYZBuGqvRW7v4UnDYh0C/9hjT/yj4WF0qwfXdAgyM34TN98E0MoRLkz
         mzutAza7aSYkUt3JkGSMg/GBaA4mB5l1bSBouABpHqubMMCLyQgWv0BZVvpCxXFvrUBR
         2oCZHGi+dv5V71YJg23VoF9mC7+2xO/pCJRGr9hoRawKjHsAX934hWp6dzyh6Gkxj/5J
         6PGXLLt/7LAeH3gpfgtiovrdLtPk7Ia25nd3SIkjzOZ4TBditqLIaAjDSNyU5PBYTnOR
         oPo3I+0GCfYKsQIAXkmhtXq8MHPjxA1pU0WQ7c8CfA7EvbW6fnFdCYY1LZ24ONIkuxoF
         mKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afR68ODglnr92QgqJuPZf+6F75GS26eyJmFFULXmipI=;
        b=3M3aLF8lRibGbANRUtyYa+DYkDjmyH8fUuPcGpJs6chWoueTfGdJlqub/mGM8nJDKw
         z8v9HXlBT+7jHMccCF9OvfV2a3S4Fymr2wTnDtayAflOq4nu5A1TMSabqK3M97vL3HCw
         bgXxDCA5IKGO89yf3O49ZmF1FSl5M1Dbqpu2p7m9FlXLr9mT5JLwbN3Ph/IrZ8TyXYMl
         PM0C2ePiShDKmLoDL24P+E/bTOjfMqXtR6uKEItTyXadmRCBjV5sg/Zq3gbIIfPDSrhc
         gH73xDfny8581mrMrt9Dw0PSOMxTn8cyHg5M8ThD9UV0gyQ7eghxBjeCZhZr5X+J3GQN
         ioIA==
X-Gm-Message-State: AO0yUKWX+NqhJfWBYzZde7GlzcKqN44etTscqeg2zGhl11Cr+hgJ5R3/
        1/GHfSb3KlRVeE57Zyg5OQ4FdSKsZdE=
X-Google-Smtp-Source: AK7set9dVVDhnd3w0v9j/nvukeHsXigPZZwAiguBxzeqpSu8MvRX6Nw6yz27RYMkyXFa3QJxvVmlDw==
X-Received: by 2002:a17:902:da90:b0:19c:e405:4446 with SMTP id j16-20020a170902da9000b0019ce4054446mr454312plx.30.1677534961931;
        Mon, 27 Feb 2023 13:56:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id jb5-20020a170903258500b0019ad6451a67sm5102911plb.24.2023.02.27.13.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:56:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 2/3] branch: description for orphan branch errors
References: <20230227193839.2416545-1-jonathantanmy@google.com>
Date:   Mon, 27 Feb 2023 13:56:01 -0800
In-Reply-To: <20230227193839.2416545-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 27 Feb 2023 11:38:39 -0800")
Message-ID: <xmqq5ybmsrgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Firstly, the subject could be more precise. Maybe "branch: check all
> worktrees for orphan branches" (47 characters) or something like that.
>
> Rubén Justo <rjusto@gmail.com> writes:
>> In bcfc82bd48 (branch: description for non-existent branch errors,
>> 2022-10-08) we checked the current HEAD
>
> Probably clearer to say "HEAD in the current worktree" instead of
> "current HEAD".
>
>> to detect if the branch to
>> operate with is an orphan branch, so as to avoid the confusing error:
>> "No branch named...".
>> 
>> If we are asked to operate with an orphan branch in a different working
>> tree than the current one, we need to check the HEAD in that different
>> working tree.
>
> Probably clearer to just say "But there might be orphan branches in
> other worktrees".
>
>> Let's extend the check we did in bcfc82bd48, to all HEADs in the
>> repository, using the helper introduced in 31ad6b61bd (branch: add
>> branch_checked_out() helper, 2022-06-15)
>
> s/HEADs/worktrees/
>
>> @@ -493,8 +496,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>>  	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
>>  	const char *interpreted_oldname = NULL;
>>  	const char *interpreted_newname = NULL;
>> -	int recovery = 0;
>> +	int recovery = 0, oldref_usage = 0;
>>  	struct worktree **worktrees = get_worktrees();
>> +	struct worktree *oldref_wt = NULL;
>
> Better to have 2 variables (one for rebased, and one for bisected) to
> avoid the situation in which the last problematic worktree seen was a
> bisected one, but a prior one was a rebased one.

All good suggestions.

>> @@ -818,7 +835,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  
>>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>>  		if (!ref_exists(branch_ref.buf))
>> -			error((!argc || !strcmp(head, branch_name))
>> +			error((!argc || branch_checked_out(branch_ref.buf))
>>  			      ? _("No commit on branch '%s' yet.")
>>  			      : _("No branch named '%s'."),
>>  			      branch_name);
>> @@ -863,7 +880,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  		}
>>  
>>  		if (!ref_exists(branch->refname)) {
>> -			if (!argc || !strcmp(head, branch->name))
>> +			if (!argc || branch_checked_out(branch->refname))
>>  				die(_("No commit on branch '%s' yet."), branch->name);
>>  			die(_("branch '%s' does not exist"), branch->name);
>>  		}
>
> What is the relevance of these changes?

Thanks for reading very carefully and asking clarification for
relevant parts of the changes.



