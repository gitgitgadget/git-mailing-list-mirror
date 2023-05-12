Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ADDC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjELVOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbjELVOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:14:04 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03527ED2
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:12:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75907a763d7so31346485a.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683925895; x=1686517895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi3uNJo8RBHrgzWO2tdHBRr7BUgcPEZRbeVrKXzWzmA=;
        b=okFfjSmY0OMWE0Dqk1si5sppvijku71217aSPDqdfNHEnH7IVhvCPfHuRk4jiOPCyv
         Mjyh/z7KFmsukCR9p9E2UYlLQ2X+qka2UZiQjNS8PaLkfKJrt+zE76XwEO8+laPhfIcf
         utBfrZilutKNGgA9atHLP3J2RmXOfjUX7Idf1wkxx14inwGSzySYLrvEz08ceC+BA0dz
         NJphIrcxx6TYtYbjJgxqPs9axV/MVpg8Eb6QOv2Gr+kT4KTOesv1/PkofClsdvr+2MHm
         RXv0lkyXL88W+URkxCMKWDFhYqQR4rn12ahfdJ5EUMG4rEAQ1C/DlWgM2gk5Xr+O3Y62
         OJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683925895; x=1686517895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi3uNJo8RBHrgzWO2tdHBRr7BUgcPEZRbeVrKXzWzmA=;
        b=JQvFosFh/yzktZICslbidbLZF6zIeT55fzg+Xo0ZArQDInW2F6mruLrd5hgVLy1bNw
         EVW42jFE3LNffLKMpQ0Rl62DwHTpqwiHla3+NdU4xWlhKdFm+sNXXFgT9C0ffZR8A9ef
         sjHVBZexoWIHTuBlLGsLFIRa35HBpmzq3RXfTtow9LrCFNXdKDr+PzXlcuGimvkfle44
         xM+/GURFeSS5nhFsPAC56u8p/fWVgX2QcB1lSAJIaKuyG5Lu9OQkD0CRRvoGrxXWzCOf
         euqk3o0m4kk8iwV1uWrQ9guUZxaF9uOuZzpaCpGRL9qsQFNVRjWEiRKc0kN3sGHFYrkg
         jnRw==
X-Gm-Message-State: AC+VfDwcYX9IyUx13hlo/s4jP2UlD0ueJ/HogUjtPvPcUsF8l3Oz9dVa
        KuHgNssx85UNUrxCjj9+pVH1+w85SgQ=
X-Google-Smtp-Source: ACHHUZ6CfIE4ZMCnu36h6gJUeMTnw55jSCcpCjQN9AH6+HxWqAfdJMm3wn65ehPAnxeZ1Qk89wG5Pw==
X-Received: by 2002:a05:6214:622:b0:621:bf0:7609 with SMTP id a2-20020a056214062200b006210bf07609mr32583028qvx.0.1683925895088;
        Fri, 12 May 2023 14:11:35 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:4533:8b00:18f3:8a21:eac1:94c8])
        by smtp.gmail.com with ESMTPSA id p18-20020a0ccb92000000b0061acac1e61bsm3263531qvk.39.2023.05.12.14.11.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2023 14:11:34 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 2/4] pack-refs: teach --exclude option to exclude refs from being packed
Date:   Fri, 12 May 2023 17:11:34 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <5D8B0ED5-F122-4E96-9ED4-5D21C0A392A1@gmail.com>
In-Reply-To: <7664500D-8C64-46DD-8567-F3AAB532B7EF@gmail.com>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
 <8c5c66a3050ee1c0ce8a48a088f5ecc2df7d1e3a.1683828635.git.gitgitgadget@gmail.com>
 <ZF2BmI/SnhfEDB2K@nand.local>
 <7664500D-8C64-46DD-8567-F3AAB532B7EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12 May 2023, at 8:53, John Cai wrote:

> Hey Taylor,
>
> On 11 May 2023, at 20:00, Taylor Blau wrote:
>
>> On Thu, May 11, 2023 at 06:10:32PM +0000, John Cai via GitGitGadget wr=
ote:
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> At GitLab, we have a system that creates ephemeral internal refs that=

>>> don't live long before getting deleted. Having an option to exclude
>>> certain refs from a packed-refs file allows these internal references=
 to
>>> be deleted much more efficiently.
>>>
>>> Add an --exclude option to the pack-refs builtin, and use the ref
>>> exclusions API to exclude certain refs from being packed into the fin=
al
>>> packed-refs file
>>>
>>> Signed-off-by: John Cai <johncai86@gmail.com>
>>> ---
>>>  Documentation/git-pack-refs.txt | 12 +++++++++++-
>>>  builtin/pack-refs.c             | 20 ++++++++++++++++----
>>>  refs.c                          |  4 ++--
>>>  refs.h                          |  7 ++++++-
>>>  refs/debug.c                    |  4 ++--
>>>  refs/files-backend.c            | 16 ++++++++++------
>>>  refs/packed-backend.c           |  2 +-
>>>  refs/refs-internal.h            |  3 ++-
>>>  revision.h                      |  2 +-
>>>  t/helper/test-ref-store.c       |  3 ++-
>>>  t/t3210-pack-refs.sh            | 16 ++++++++++++++++
>>>  11 files changed, 69 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack=
-refs.txt
>>> index e011e5fead3..c0f7426e519 100644
>>> --- a/Documentation/git-pack-refs.txt
>>> +++ b/Documentation/git-pack-refs.txt
>>> @@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient rep=
ository access
>>>  SYNOPSIS
>>>  --------
>>>  [verse]
>>> -'git pack-refs' [--all] [--no-prune]
>>> +'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
>>>
>>>  DESCRIPTION
>>>  -----------
>>> @@ -60,6 +60,16 @@ interests.
>>>  The command usually removes loose refs under `$GIT_DIR/refs`
>>>  hierarchy after packing them.  This option tells it not to.
>>>
>>> +--exclude <pattern>::
>>> +
>>> +Do not pack refs matching the given `glob(7)` pattern. Repetitions o=
f this option
>>> +accumulate exclusion patterns. Use `--no-exclude` to clear and reset=
 the list of
>>> +patterns. If a ref is already packed, including it with `--exclude` =
will not
>>> +unpack it.
>>> +
>>> +When used with `--all`, it will use the difference between the set o=
f all refs,
>>> +and what is provided to `--exclude`.
>>> +
>>
>> I think this last paragraph could be simplified, though feel free to
>> discard my suggestion if you think it makes things less clear.
>>
>>   When used with `--all`, pack only loose refs which do not match any =
of
>>   the provided `--exclude` patterns.
>
> I like the wording here, thanks
>
>>
>>>  int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>>>  {
>>>  	unsigned int flags =3D PACK_REFS_PRUNE;
>>> +	static struct ref_exclusions excludes =3D REF_EXCLUSIONS_INIT;
>>> +	struct pack_refs_opts pack_refs_opts =3D {.exclusions =3D &excludes=
, .flags =3D flags};
>>> +	static struct string_list option_excluded_refs =3D STRING_LIST_INIT=
_NODUP;
>>> +	struct string_list_item *item;
>>
>> Since this list does not appear to be sensitive to its order, have you=

>> considered using the strvec API instead of the string_list one?
>
> Thanks for this suggestion--you're right in that the order doesn't matt=
er here.
> The only thing is, the only option parsing macro I could find that oper=
ates on
> strvec is OPT_PASSTHRU_ARGV. I tried it out, and it seem to work just f=
ine.

Actually I had a bug in my test that made it seem like it worked. I reali=
ze that
OPT_PASSTHRU_ARGV passes through the entire option flag eg
--include=3Drefs/tags/dont_pack* so we would have to strip the flag name.=
 It's not
as user friendly as OPT_STRING_LIST that is just plug and play.

Unless there is a significant performance improvement in using strvec, I'=
m
thinking maybe I'll just stick to string_list.

thanks
John

>
>>
>>> diff --git a/refs.c b/refs.c
>>> index d2a98e1c21f..881a0da65cf 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -2132,9 +2132,9 @@ void base_ref_store_init(struct ref_store *refs=
, struct repository *repo,
>>>  }
>>>
>>>  /* backend functions */
>>> -int refs_pack_refs(struct ref_store *refs, unsigned int flags)
>>> +int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *op=
ts)
>>>  {
>>> -	return refs->be->pack_refs(refs, flags);
>>> +	return refs->be->pack_refs(refs, opts);
>>>  }
>>>
>>>  int peel_iterated_oid(const struct object_id *base, struct object_id=
 *peeled)
>>> diff --git a/refs.h b/refs.h
>>> index 123cfa44244..46020bd335c 100644
>>> --- a/refs.h
>>> +++ b/refs.h
>>> @@ -63,6 +63,11 @@ struct worktree;
>>>  #define RESOLVE_REF_NO_RECURSE 0x02
>>>  #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
>>>
>>> +struct pack_refs_opts {
>>> +	unsigned int flags;
>>> +	struct ref_exclusions *exclusions;
>>
>> I think this would be OK to include directly in the struct instead of
>> via a pointer, but either is fine.
>>
>>> @@ -1175,15 +1176,18 @@ static void prune_refs(struct files_ref_store=
 *refs, struct ref_to_prune **refs_
>>>   */
>>>  static int should_pack_ref(const char *refname,
>>>  			   const struct object_id *oid, unsigned int ref_flags,
>>> -			   unsigned int pack_flags)
>>> +			   struct pack_refs_opts *opts)
>>>  {
>>>  	/* Do not pack per-worktree refs: */
>>>  	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=3D
>>>  	    REF_WORKTREE_SHARED)
>>>  		return 0;
>>>
>>> +	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
>>> +		return 0;
>>
>> Looks good, here is where we throw out refs that we don't want. I wond=
er
>> if ref_excluded() does the right thing with a zero-initialized argumen=
t
>> (i.e. that it behaves as if nothing matches).
>
> Yes, I think we can skip checking if opt->exclusions is not null. Junio=
 had
> feedback around this as well.
>
>>
>> I wonder if it's possible to skip over certain loose references by
>> avoiding traversal into the sub-directories for simple prefixes. That
>> may be a premature optimization, though, so I don't think you
>> necessarily need to worry about it in this round.
>>
>>> +test_expect_success 'test excluded refs are not packed' '
>>> +	git branch dont_pack1 &&
>>> +	git branch dont_pack2 &&
>>> +	git branch pack_this &&
>>> +	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
>>> +	test -f .git/refs/heads/dont_pack1 &&
>>> +	test -f .git/refs/heads/dont_pack2 &&
>>> +	! test -f ./git/refs/heads/pack_this'
>>> +
>>> +test_expect_success 'test --no-exclude refs clears excluded refs' '
>>> +	git branch dont_pack3 &&
>>> +	git branch dont_pack4 &&
>>> +	git pack-refs --all --exclude "refs/heads/dont_pack*" --no-exclude =
&&
>>> +	! test -f .git/refs/heads/dont_pack3 &&
>>> +	! test -f .git/refs/heads/dont_pack4'
>>
>> Tests look good. The trailing quote is a little odd to be placed on th=
e
>> last line of the test instead of off on its own, but I suppose that is=

>> imitating existing style, which is OK.
>
> thanks for the feedback!
> John
>>
>> Thanks,
>> Taylor
