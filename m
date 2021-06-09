Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63128C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E92E613DF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFIUXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhFIUXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:23:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40157C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 13:21:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z3so26378185oib.5
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n7GR3VV294sUaX8KoqBtEuVrcsLhzdYS83ZY62IBRDY=;
        b=kNV1zNTrTIPVa7t2+iWe9GHpC7pZ/3gUPrqyLPZzYWme3Q4OQKKF/70GYCStpibME4
         ZP4fX0gCZNBvrG6aQ1kmk7aTBHXn+DwKnsy2zD8YMQ93kD1MjxDSdt7ETbPdJyozWZ0m
         fLZPwzcDkKhngJjlHMLineH+G61FwuH68+EsJx8831uNKlFTNar7dapRMxXx6IHn1oMl
         DGmIeZbNP5623e6Lt+5EnvsL99moTfs1rNlyoGwWumd9mURm+r8/5xKd8b7Iz/n6yL9b
         YYN/wvSphCkFSlf198VoKuF4sBITjDTHoXBdUOSeelaWTxa5UWUVH3QPh9RBoFji3ap+
         z+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n7GR3VV294sUaX8KoqBtEuVrcsLhzdYS83ZY62IBRDY=;
        b=EfsCUJ4ToNsHLDU4e8I/i52rylf6jTu/GA0IBbkFidx0pkUZr6jiYRN7a9AsXKm6ss
         jn5Tnaetozgp/UuS+ZHLafU7i4dPAaGYOAUA3E5BN1cWO41ktknYuvLPRMJOJB4YR/xz
         RP5+imBWxOKO8jAcCL2jda2B0s0aBIKBRS83KMgMDHyPDgAz3SpC1WJtG6bXR7emRGHw
         dzXDfxJM7qUptd9b+hAO/9q4yCys2dfa6TQg7a965EX/YjLnYL+B/6L49r7JJeJ/fu27
         upYecsRs5u4BpKCUUKNaCMfQOSrH10TS0IWe00MyW0jc4eUy+DnYCDSBCmU4XEikGKix
         SyPA==
X-Gm-Message-State: AOAM533ATKorYvI42l7ERhJF7/FY/aJCqd4t/6XLabGmAjlqm6JYuX0r
        B7PqVDdqN41yVVxPLjbc41E=
X-Google-Smtp-Source: ABdhPJwQ/7nJ85Qz1wWqyo+CUBzwUSpkvkDB+jxTI9B/EObVEDwHuIGJzSiE8xiaq630qbpIy3gJEw==
X-Received: by 2002:aca:aad2:: with SMTP id t201mr911956oie.117.1623270069289;
        Wed, 09 Jun 2021 13:21:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:757b:21f8:d6f2:dd1b? ([2600:1700:e72:80a0:757b:21f8:d6f2:dd1b])
        by smtp.gmail.com with ESMTPSA id s81sm159803oie.23.2021.06.09.13.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:21:08 -0700 (PDT)
Subject: Re: [PATCH v5 08/14] unpack-trees: unpack sparse directory entries
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <724194eef9f6d5514bcd7761daf0eb2bb87c0619.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BGj0y1bKuyaZf14v==j2-mHoiEuV0Am3MBCK4hkbb085Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d7839e43-f427-e52f-7cb6-99a932b58132@gmail.com>
Date:   Wed, 9 Jun 2021 16:21:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGj0y1bKuyaZf14v==j2-mHoiEuV0Am3MBCK4hkbb085Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2021 11:48 PM, Elijah Newren wrote:
> On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> During unpack_callback(), index entries are compared against tree
>> entries. These are matched according to names and types. One goal is to
>> decide if we should recurse into subtrees or simply operate on one index
>> entry.
>>
>> In the case of a sparse-directory entry, we do not want to recurse into
>> that subtree and instead simply compare the trees. In some cases, we
>> might want to perform a merge operation on the entry, such as during
>> 'git checkout <commit>' which wants to replace a sparse tree entry with
>> the tree for that path at the target commit. We extend the logic within
>> unpack_nondirectories() to create a sparse-directory entry in this case,
>> and then that is sent to call_unpack_fn().
> 
> Does this presume that all callbacks are prepared to accept a sparse
> directory entry?  Or do we have an external flag that ensures we do
> not reach this code path when using callbacks that aren't prepared to
> handle it properly?
> 
> I hope that the answer is the latter, and that the ensure_full_index()
> calls are what prevents the code from reaching this point if a
> callback would be used that couldn't handle a sparse directory entry.

To the best of my knowledge, callbacks that are not protected have
ensure_full_index() protecting them. At minimum, the repository setting
command_requires_full_index is enabled by default, causing a sparse
index to be expanded to a full one immediately upon parsing (and also
after writing) to protect cases that might be missing. That is, until
we can create tests for each command before disabling it for that
command.

> I'd be particularly concerned that merge-recursive would call this
> code with unpack_opts.fn = threeway_merge.  threeway_merge is kind of
> interesting in that it might just happen to not die when passed a
> sparse directory entry, but would pass along data that'd just break
> stuff downstream in various subtle ways.  For example, if there were
> conflicts in the sparse directory entries because both had been
> modified, the merge should recurse and resolve individual paths
> underneath, which the merge-recursive code would not be prepared to do
> since unpack_trees() has already returned.  Also, even if there wasn't
> a "conflict" because only one side modified, blindly doing a trivial
> directory resolution will break rename detection.  I mention
> merge-recursive not because it's worth fixing (well, it was and the
> fix is called merge-ort) but because I'm most familiar with it.  The
> other callbacks _might_ have similar problems, though its possible
> that it's safe for one- and two- way merging and just fails once you
> get to three-way.

I also believe that threeway_merge might be difficult to integrate
and that its use should be protected with ensure_full_index() even if
'git merge' in general does not do it by default. We can cross that
bridge when we get to it. Merge, rebase, and cherry-pick are next on
my list of "commands to integrate with sparse-index" but I haven't
done the work yet to make them work.
>> +       if (is_sparse_directory) {
>> +               ce->name[len] = '/';
>> +               ce->name[len + 1] = 0;
> 
> Should this be '\0', for clarity?

Sure.

>> @@ -1064,16 +1073,24 @@ static int unpack_nondirectories(int n, unsigned long mask,
>>                                  unsigned long dirmask,
>>                                  struct cache_entry **src,
>>                                  const struct name_entry *names,
>> -                                const struct traverse_info *info)
>> +                                const struct traverse_info *info,
>> +                                int sparse_directory)
>>  {
>>         int i;
>>         struct unpack_trees_options *o = info->data;
>>         unsigned long conflicts = info->df_conflicts | dirmask;
>>
>> -       /* Do we have *only* directories? Nothing to do */
> 
> You've removed the comment, but not the code.  So it still returns
> immediately if there are only directories...right?  Am I missing
> something?  Is this code still correct?  Or is the comment just
> misleading now that src[0] can be a directory?
Yes, the comment is misleading now that we can call this method
with sparse-directory entries. The method name is also a bit
misleading: this should perhaps be renamed to unpack_single_entry()
or something like that. That will signal that we are not recursing
with traverse_trees_recursive() as we do in the other case.
 
>>         if (mask == dirmask && !src[0])
>>                 return 0;
>>
>> +       /* no-op if our cache entry doesn't match the expectations. */
>> +       if (sparse_directory) {
>> +               if (src[0] && !S_ISSPARSEDIR(src[0]->ce_mode))
>> +                       BUG("expected sparse directory entry");
>> +       } else if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode)) {
>> +               return 0;
>> +       }
> 
> This code reads like "If sparse_directory is false, but the cache
> entry is a sparse directory, we'll just keep it as-is and ignore
> changed or conflicting directories or files from the names name_entry.
> However, I think this has to be coupled with knowledge about changes
> to unpack_callback() you made, where you introduce an extra call to
> unpack_nondirectories() for the sparse directory case, and in the
> second one you would do useful work.  So "no-op" is kind of
> misleading, it's more deferral until the later unpack_nondirectories()
> call.
> 
> Or, at least so I think after trying to read over this patch.  Am I
> understanding this right?

I think they are both correct: we defer until later by doing a no-op
right now. But using "defer" is more informative of the context of
this call.

>> +
>> +       /*
>> +        * Compare ce->name to info->name + '/' + p->path + '/'
>> +        * if info->name is non-empty. Compare ce->name to
>> +        * p-.path + '/' otherwise.
> 
> p->path, not p-.path

Thanks!
 
> Also, you state in both cases that you are comparing against a
> trailing '/', but...
> 
>> +        */
>> +       if (info->namelen) {
>> +               if (ce->ce_namelen == info->namelen + p->pathlen + 2 &&
>> +                   ce->name[info->namelen] == '/' &&
>> +                   !strncmp(ce->name, info->name, info->namelen) &&
>> +                   !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen))
> 
> You only checked for one of the two '/' characters here.

The first '/' check is to verify that we match "{info->name}/{p->name}/"
and not "{info->name}.{p->name}/" ('.' means "any character").

>  Are you
> omitting the check for the final '/' do to the S_ISSPARSEDIR() check
> above?

Since we know at this point that ce is a sparse directory entry, the
final character _must_ be a trailing slash. There is not a trailing
slash in the input p->path.

>> +                       return ce;
>> +       } else if (ce->ce_namelen == p->pathlen + 1 &&
>> +                  !strncmp(ce->name, p->path, p->pathlen))
> 
> Here you didn't check for the final '/'.  Is that intentional because
> of the S_ISSPARSEDIR() check above?  If so, should the comment above
> this block be corrected?

Yes, will do.

>> +               return ce;
>> +       return NULL;
>>  }
>>
>>  static void debug_path(struct traverse_info *info)
>> @@ -1251,6 +1301,32 @@ static void debug_unpack_callback(int n,
>>                 debug_name_entry(i, names + i);
>>  }
>>
>> +/*
>> + * Returns true if and only if the given cache_entry is a
>> + * sparse-directory entry that matches the given name_entry
>> + * from the tree walk at the given traverse_info.
>> + */
>> +static int is_sparse_directory_entry(struct cache_entry *ce, struct name_entry *name, struct traverse_info *info)
>> +{
>> +       size_t expected_len, name_start;
>> +
>> +       if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
>> +               return 0;
>> +
>> +       if (info->namelen)
>> +               name_start = info->namelen + 1;
>> +       else
>> +               name_start = 0;
>> +       expected_len = name->pathlen + 1 + name_start;
>> +
>> +       if (ce->ce_namelen != expected_len ||
>> +           strncmp(ce->name, info->name, info->namelen) ||
>> +           strncmp(ce->name + name_start, name->path, name->pathlen))
>> +               return 0;
> 
> What about the intervening '/' character?  Could we get a false hit
> between "foo/bar/" and "foo.bar/"?

Here, you are right that I missed this check. I will add it.

> Also, do we have to worry about the trailing '/'?

No, the index would be malformed without it. Since this code
is so similar to the other check (just the negation of it)
I will add a clearly-commented helper method.

Thanks,
-Stolee
