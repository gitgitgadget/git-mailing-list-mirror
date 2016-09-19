Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C6B2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbcISRAL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 13:00:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60949 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750922AbcISRAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 13:00:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48B5F3F7C1;
        Mon, 19 Sep 2016 13:00:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XRrsFPRpr+qwluvq9scgqSAwnNI=; b=Jyx7ll
        phAA1EYZiFlvVOBKs5AZLrwCJz+rEE9Tx3qzmoogwpIM3Qp6/Ajj597DJbZSOpzU
        JvT3hHdaql74izoIz4JWP6wi0hroMZ6XnIFXt1Mwu43oUUgvHcQUUVkONuDEgRYD
        6TPT/gzne0fFeArvcyyZKS0EFzrEKrw1eIEdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RXpj7LV9fGtLdvsBALn/X1i4RpByITmo
        vvRkc3IzG6gECQ9IUpPCqFl706q0hCUs/dnu3QWjPjfAlbHJKcxUNiH0PPODlmBB
        76zsdHhLdlf/j04l4yAl5bS1vXVf/37DN1pQFDnrUGazEBw5Ag3wuOYyzVQ25E5Y
        K36o5rth+eQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4226C3F7C0;
        Mon, 19 Sep 2016 13:00:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE8473F7BB;
        Mon, 19 Sep 2016 13:00:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
        <1474073981-96620-1-git-send-email-bmwill@google.com>
        <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
        <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
Date:   Mon, 19 Sep 2016 10:00:06 -0700
In-Reply-To: <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
        (Brandon Williams's message of "Sun, 18 Sep 2016 11:40:22 -0700")
Message-ID: <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8546B876-7E8A-11E6-9FC3-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> OK, so as discussed previously with Heiko and Stefan, the idea is to
>>
>>  - pass the original pathspec as-is,
>>
>>  - when --submodule-prefix is given, a path discovered in a
>>    submodule repository is first prefixed with that string before
>>    getting checked to see if it matches the original pathspec.
>>
>> And this loop is about relaying the original pathspec.
>
> Exactly.  Perhaps I should have made this more clear either with a
> detailed comment or
> more information in the commit msg.

I think you were clear enough.

Don't read everything other people say in their reviews as pointing
out issues.  Often trying to rephrase what they read in the code in
their own words is a good way to make sure the reviewers and the
original author are on the same page.  The above was one of these
cases.

>>> +     if (prefix > 0) {
>>> +             if (ps_strncmp(item, pattern, string, prefix))
>>> +                     return WM_NOMATCH;
>>
>> This says: when we have a set prefix that must literally match, and
>> that part does not match what we have, it cannot possibly match.
>>
>> Is that correct?  What do we have in "name" and "item" at this
>> point?  We disable the common-prefix optimization, so we do not have
>> to worry about a pathspec with two elements "sub/dir1/*" and "sub/dir2/*"
>> giving you "sub/dir" as the common prefix, when you are wondering if
>> it is worth descending into "sub/" without knowing what it contains.
>> Is that what guarantees why this part is correct?
>
> I adopted this structure from another part of the code.  The caller
> uses a field in
> the pathspec item which indicates the location of the first wildcard character.
> So the prefix (everything prior to the wildcard char) must match
> literally before
> we drop into a more expensive wildmatch function.

"Another part of the code" is about tree walking, right?  Weren't
you saying that part of the code may be buggy or something earlier
(e.g. pathspec "su?/" vs entry "sub")?

Again, what do we have in "name" and "item" at this point?  If we
have a submodule at "sub/" and we are checking a pathspec element
"sub/dir1/*", what is the non-wildcard part of the pathspec and what
is the "string"?  Aren't then "sub/dir1/" and "sub/" respectively,
which would not pass ps_strncmp() and produce a (false) negative?

I am starting to have a feeling that the best we can do in this
function safely is to see if prefix (i.e. the constant part of the
pathspec before the first wildcard) is long enough to cover the
"name" and if "name" part does not match to the directory boundary,
e.g. for this combination

	pathspec = "a/b/sib/c/*"
        name = "a/b/sub/"

we can say with confidence that it is not worth descending into.

When prefix is long enough and "name" and leading part of the prefix
matches to the directory boundary, e.g.

	pathspec = "a/b/sub/c/*"
        name = "a/b/sub/"

we can say it is worth descending into.

If these two checks cannot decide, we may have to be pessimistic and
say "it may match; we don't know until we descend into it".  When
prefix is shorter than name, I am not sure if we can devise a set of
simple rules, e.g.

	pathspec = "a/**/c/*"
        name = "a/b/sub/"

may match with its ** "b/sub" part and worth descending into, so is

	pathspec = "a/b/*/c/*"
        name = "a/b/sub/"

but not this one:

	pathspec = "a/b/su[c-z]/c/*"
        name = "a/b/sub/"

but this is OK:

	pathspec = "a/b/su[a-z]/c/*"
        name = "a/b/sub/"

So I would think we'd be in the business of counting slashes in the
name (called "string" in this function) and the pathspec, while
noticing '*' and '**' in the latter, and we may be able to be more
precise, but I am not sure how complex the end result would become.

