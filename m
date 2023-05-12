Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0D5C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 12:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbjELMyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbjELMyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 08:54:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13B13C1E
        for <git@vger.kernel.org>; Fri, 12 May 2023 05:53:54 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7577435f507so60449485a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683896034; x=1686488034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meywcvsmcPAfWggUorNeG61AzKKdvK3G5xGtglmRm2M=;
        b=inRYmG8c6/WqVtZzJcQOWMjWH1H7lpjb0ycxUHjYg3YdiHXSBa2ojylRI1Kl+VLkWn
         VBz0AR6dkXBjib28hYzmQvx+4BkvWHEg8p7wfGi5nSefOn5DYgZLI3elJQKCnMVvM9DS
         m9ohUbg+yyG7jYRsAM+2E5nzNXNEOsUVOvv6r+Vtu0Eaow6WrIpuljfqG2eUrEt6dXni
         unLTOypTLPHgcVYfyVjvPUamON0pApLrYY1F9iG5i2RS+KAY5BMR/KzzF04LWDTnlx7G
         xn+DYl3CPaVzrmV6jdVJF+0aZp+KpkVLFbUcjLK4EWw94UZkBgQjVByGZ8jO6gf5kkW5
         WFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683896034; x=1686488034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meywcvsmcPAfWggUorNeG61AzKKdvK3G5xGtglmRm2M=;
        b=dUknr2Eet9VwHGRThBkZi7r9RnkEu99iTjuX6KW1v4iXH/1sN29LCSiBKCK02DvKt2
         mNT96U/ZqiOlNXCRCvZ9xUsaASMTWpEobB1kvXlyD4LZfFzJbkNh5TInALqLT1Szzrrv
         7d7fUI7SG/H63QYJlmeGNr1ZpXUEiNWcJsMoyuftB4IjJ8a2EJPXBhAkmZKV+1mZV5g4
         o5eiOHbjnDAsBhOOK5SQKYAdT+VsojV2NFx9ieWj22JegZ2iuGBwN6dgPW+7P67S4O7X
         nxup+e1A8fkzKhvOy9DNe/3RDD0aXrBf2RhZq+LJUfN/VnggKe3CP6Fs7aaRlY/3XSQF
         2Zew==
X-Gm-Message-State: AC+VfDxqu/mTolnsoaMwzC4/nsn4Cu+2AjxdbcE3OhDx3lkMSP070HD4
        l6taZtf0+E93L8qnF38XlwLCWNakmyA=
X-Google-Smtp-Source: ACHHUZ4ew9T1gyvxKxnU1rPtucxeCJGEiI7Kb7Ue57JQhQ3X/0ho9G2nIh3VwlV5RMmy6g9iX8lojQ==
X-Received: by 2002:a05:6214:5297:b0:616:870c:96b8 with SMTP id kj23-20020a056214529700b00616870c96b8mr36683252qvb.3.1683896033851;
        Fri, 12 May 2023 05:53:53 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:4533:8b00:18f3:8a21:eac1:94c8])
        by smtp.gmail.com with ESMTPSA id nd22-20020a056214421600b0061b63237be3sm2967061qvb.131.2023.05.12.05.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2023 05:53:53 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 2/4] pack-refs: teach --exclude option to exclude refs from being packed
Date:   Fri, 12 May 2023 08:53:52 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <7664500D-8C64-46DD-8567-F3AAB532B7EF@gmail.com>
In-Reply-To: <ZF2BmI/SnhfEDB2K@nand.local>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
 <8c5c66a3050ee1c0ce8a48a088f5ecc2df7d1e3a.1683828635.git.gitgitgadget@gmail.com>
 <ZF2BmI/SnhfEDB2K@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Taylor,

On 11 May 2023, at 20:00, Taylor Blau wrote:

> On Thu, May 11, 2023 at 06:10:32PM +0000, John Cai via GitGitGadget wro=
te:
>> From: John Cai <johncai86@gmail.com>
>>
>> At GitLab, we have a system that creates ephemeral internal refs that
>> don't live long before getting deleted. Having an option to exclude
>> certain refs from a packed-refs file allows these internal references =
to
>> be deleted much more efficiently.
>>
>> Add an --exclude option to the pack-refs builtin, and use the ref
>> exclusions API to exclude certain refs from being packed into the fina=
l
>> packed-refs file
>>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  Documentation/git-pack-refs.txt | 12 +++++++++++-
>>  builtin/pack-refs.c             | 20 ++++++++++++++++----
>>  refs.c                          |  4 ++--
>>  refs.h                          |  7 ++++++-
>>  refs/debug.c                    |  4 ++--
>>  refs/files-backend.c            | 16 ++++++++++------
>>  refs/packed-backend.c           |  2 +-
>>  refs/refs-internal.h            |  3 ++-
>>  revision.h                      |  2 +-
>>  t/helper/test-ref-store.c       |  3 ++-
>>  t/t3210-pack-refs.sh            | 16 ++++++++++++++++
>>  11 files changed, 69 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-=
refs.txt
>> index e011e5fead3..c0f7426e519 100644
>> --- a/Documentation/git-pack-refs.txt
>> +++ b/Documentation/git-pack-refs.txt
>> @@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repo=
sitory access
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git pack-refs' [--all] [--no-prune]
>> +'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
>>
>>  DESCRIPTION
>>  -----------
>> @@ -60,6 +60,16 @@ interests.
>>  The command usually removes loose refs under `$GIT_DIR/refs`
>>  hierarchy after packing them.  This option tells it not to.
>>
>> +--exclude <pattern>::
>> +
>> +Do not pack refs matching the given `glob(7)` pattern. Repetitions of=
 this option
>> +accumulate exclusion patterns. Use `--no-exclude` to clear and reset =
the list of
>> +patterns. If a ref is already packed, including it with `--exclude` w=
ill not
>> +unpack it.
>> +
>> +When used with `--all`, it will use the difference between the set of=
 all refs,
>> +and what is provided to `--exclude`.
>> +
>
> I think this last paragraph could be simplified, though feel free to
> discard my suggestion if you think it makes things less clear.
>
>   When used with `--all`, pack only loose refs which do not match any o=
f
>   the provided `--exclude` patterns.

I like the wording here, thanks

>
>>  int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>>  {
>>  	unsigned int flags =3D PACK_REFS_PRUNE;
>> +	static struct ref_exclusions excludes =3D REF_EXCLUSIONS_INIT;
>> +	struct pack_refs_opts pack_refs_opts =3D {.exclusions =3D &excludes,=
 .flags =3D flags};
>> +	static struct string_list option_excluded_refs =3D STRING_LIST_INIT_=
NODUP;
>> +	struct string_list_item *item;
>
> Since this list does not appear to be sensitive to its order, have you
> considered using the strvec API instead of the string_list one?

Thanks for this suggestion--you're right in that the order doesn't matter=
 here.
The only thing is, the only option parsing macro I could find that operat=
es on
strvec is OPT_PASSTHRU_ARGV. I tried it out, and it seem to work just fin=
e.

>
>> diff --git a/refs.c b/refs.c
>> index d2a98e1c21f..881a0da65cf 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2132,9 +2132,9 @@ void base_ref_store_init(struct ref_store *refs,=
 struct repository *repo,
>>  }
>>
>>  /* backend functions */
>> -int refs_pack_refs(struct ref_store *refs, unsigned int flags)
>> +int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opt=
s)
>>  {
>> -	return refs->be->pack_refs(refs, flags);
>> +	return refs->be->pack_refs(refs, opts);
>>  }
>>
>>  int peel_iterated_oid(const struct object_id *base, struct object_id =
*peeled)
>> diff --git a/refs.h b/refs.h
>> index 123cfa44244..46020bd335c 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -63,6 +63,11 @@ struct worktree;
>>  #define RESOLVE_REF_NO_RECURSE 0x02
>>  #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
>>
>> +struct pack_refs_opts {
>> +	unsigned int flags;
>> +	struct ref_exclusions *exclusions;
>
> I think this would be OK to include directly in the struct instead of
> via a pointer, but either is fine.
>
>> @@ -1175,15 +1176,18 @@ static void prune_refs(struct files_ref_store =
*refs, struct ref_to_prune **refs_
>>   */
>>  static int should_pack_ref(const char *refname,
>>  			   const struct object_id *oid, unsigned int ref_flags,
>> -			   unsigned int pack_flags)
>> +			   struct pack_refs_opts *opts)
>>  {
>>  	/* Do not pack per-worktree refs: */
>>  	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=3D
>>  	    REF_WORKTREE_SHARED)
>>  		return 0;
>>
>> +	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
>> +		return 0;
>
> Looks good, here is where we throw out refs that we don't want. I wonde=
r
> if ref_excluded() does the right thing with a zero-initialized argument=

> (i.e. that it behaves as if nothing matches).

Yes, I think we can skip checking if opt->exclusions is not null. Junio h=
ad
feedback around this as well.

>
> I wonder if it's possible to skip over certain loose references by
> avoiding traversal into the sub-directories for simple prefixes. That
> may be a premature optimization, though, so I don't think you
> necessarily need to worry about it in this round.
>
>> +test_expect_success 'test excluded refs are not packed' '
>> +	git branch dont_pack1 &&
>> +	git branch dont_pack2 &&
>> +	git branch pack_this &&
>> +	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
>> +	test -f .git/refs/heads/dont_pack1 &&
>> +	test -f .git/refs/heads/dont_pack2 &&
>> +	! test -f ./git/refs/heads/pack_this'
>> +
>> +test_expect_success 'test --no-exclude refs clears excluded refs' '
>> +	git branch dont_pack3 &&
>> +	git branch dont_pack4 &&
>> +	git pack-refs --all --exclude "refs/heads/dont_pack*" --no-exclude &=
&
>> +	! test -f .git/refs/heads/dont_pack3 &&
>> +	! test -f .git/refs/heads/dont_pack4'
>
> Tests look good. The trailing quote is a little odd to be placed on the=

> last line of the test instead of off on its own, but I suppose that is
> imitating existing style, which is OK.

thanks for the feedback!
John
>
> Thanks,
> Taylor
