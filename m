Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F56207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 18:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbcJCSH0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 14:07:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60346 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751260AbcJCSHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 14:07:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09BE741984;
        Mon,  3 Oct 2016 14:07:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JNF4rDogEHuns+58s4P2IsR0bQI=; b=Sjiuhi
        48UGbRlw1E1JHYf0mIWrEHugPnuS1YvoY+1allmKRxYJTUTbdsX7OPT3EJyJZDUO
        Wzzb5alIhYzC/dhvabaXtdjbHu3GK+AVX50Cm/uVaqrm6tKRQgO80yoGXhAF29kN
        fP+vtQICbCz+FAlrNm6t9nGaRXPdgwroUyvP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JGJAC1/zmPW4qET14Ts93iXIZ2zfwMkc
        ptFJYTY/61nxnkL73qf3cj09TWFd2uLaqgQk/LGo60ormgeGt07VzFr4ZvmxpbBq
        fvDd0SJYzJ2TGXr1IbCsk1OFR4Fisr2hnemmixZFLACRrfTBPiyvUSS0sjaTiAIQ
        YoCJOfQYs2M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01BF041983;
        Mon,  3 Oct 2016 14:07:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C29141982;
        Mon,  3 Oct 2016 14:07:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
Date:   Mon, 03 Oct 2016 11:07:21 -0700
In-Reply-To: <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 30 Sep 2016 18:33:44 -0700")
Message-ID: <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BF16F30-8994-11E6-8B97-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * jc/attr (2016-05-25) 18 commits
>> ...
>>  The attributes API has been updated so that it can later be
>>  optimized using the knowledge of which attributes are queried.
>>
>>  I wanted to polish this topic further to make the attribute
>>  subsystem thread-ready, but because other topics depend on this
>>  topic and they do not (yet) need it to be thread-ready.
>>
>>  As the authors of topics that depend on this seem not in a hurry,
>>  let's discard this and dependent topics and restart them some other
>>  day.
>>
>>  Will discard.
>
> So I just realized this is a big hint for me to pick up that topic; I assumed
> you'd want to tackle the attr subsystem eventually, so all I was doing, was
> waiting for your motivation to look at attr stuff to come back.
>
> So what is the actual lacking stuff here?

Quite a bit.  Do you want a grand vision, or just the minimum that
will hopefully futureproof us?

The current attribute API is optimized for a very narrow use case
where a single thread looks up a single set of attributes for
adjacent paths, without mixing lookups for other attributes of
distant paths.

Take "conversion" codepath for an example.  "git checkout" will
iterate over the paths in the index and is interested in the eol,
text and filter attributes (perhaps more, but the details do not
change the overall picture that much).  When it checks dir/fileA, it
is expected that it would next want to check dir/fileB, before it
would want to check dir2/fileC and it would move much later to
otherdir/fileD.  It also is expected that it would want to learn the
same set of attributes, simply because the codepath is doing the
same operation over these paths (i.e. learn how the Git "clean"
representation needs to be converted to the external "smudged"
representation).

Based on the "adjacent paths" assumption, the attribute subsystem
has a single cache that holds the contents of the .gitattributes
files that matter to the current query.  This has to be split up if
we ever want to do a parallel checkout with multiple threads.  One
thread may be walking the first half of the index, while another one
may be walking the second half of the index.  They would benefit
from the same optimization that keeps track of the contents of
.gitattributes files that matters to each of their traversal.  If
the first thread is responsible for working on dir/fileA, it will
work on dir/fileB next, before going to dir2/fileC, but it does not
want to share the cache with the other thread that would be scanning
entries far-away from what it's scanning, like otherdir/fileD, if it
evicts the cached information for dir/* that is still useful for the
first thread.

Another thing we would want to see is to take advantage of the
"lookup is for single set of attributes from a single codepath" for
further optimization.  The way each of the callers is structured is
to first declare a set of attributes it is interested in by
preparing git_attr_check_elem[] array and then make repeated calls
to git_attr_check() passing it and a path.

The current implementation however does not tie the cache to this
git_attr_check_elem[] array but has only one single global cache.
The cache _could_ be used to query any attribute because of it, and
that leads to inefficiency.  It has everything it read from relevant
.gitattributes files, even the entries that do not affect any
attributes that a single codepath showed its interest in.  I am
hoping that we can do better by having a per <thread, callsite>
cache of .gitattributes files, so that a caller in one thread (say,
"git checkout" that scans the first half of the index) that asks for
"eol" and "filter" would use a cache that does not have entries
irrelevant for the attributes the caller is intereseted in, and that
is tied to the directory hierarchy the caller is asking about
(i.e. what prepare_attr_stack() does).

Up to 079186123a ("attr: retire git_check_attrs() API", 2016-05-16)
of the series gives us "struct git_attr_check" to replace the
git_attr_check_elem[] array.  I originally hoped that this struct
can hold the per-callsite cache itself, before we hit the threading
issue too early (IIRC, that was preload-index code) and realize that
the cache needs to be not just per callsite but needs to be per
<thread, callsite>.  This new structure cannot be used to store the
cache itself, but this change is probably a necessary first step for
allowing the API in multi-threaded context.  git_attr_check_elem[]
array was static and had slots to receive returned values, which
would not have worked in threaded environment.  We'd further need to
change it so that the inquiry keys (which are "interned" git_attr
objects) of "git_attr_check" are initialized just once before
starting to make repeated calls to git_attr_check(), but the
mechanism to return values would be thread-safe.  git_check_attr()
call may have to gain an extra/separate variable for the caller to
specify an array to return values, or something.

The way "interned" git_attr objects are managed needs to become
thread-safe by protecting their creation and registering with mutex,
but that is relatively isolated and straightforward conversion so I
didn't pay any attention to that in my series.  In the final state,
it of course needs to be taken care of.

So that's the overall "grand vision" picture the series leading up
to the tip of jc/attr-more was trying to lead us to.

The minimum that would future-proof us, that is still missing from
the series, would probably be to separate the query parameter
"struct git_attr_check" and the return values from git_check_attr().
Once it is done, I think we do not need to update the caller when we
update the attr.c infrastructure to be thread-safe.
