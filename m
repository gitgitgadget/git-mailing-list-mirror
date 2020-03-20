Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02F1C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE1B20714
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RSl5twO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCTXgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:36:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60033 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbgCTXgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 19:36:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F860CA153;
        Fri, 20 Mar 2020 19:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1tUNKKiqsGCUTmAzrzHbivWv+ds=; b=RSl5tw
        O3iNpR0nNj/+TFW2L9OPh0KLyUy16rK8IB98oyV5i4TBhffaCZOjvEaaIaw1RHZU
        6bCyXtkXXVQmD50D9jWBk6bruF55eV2ZPZ1d14WgtE59yHb/Cv3eHtSD9s9cuyLM
        +EqhLl7HezbcLq7yy3SxSCeqgT6no8fEfTk/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nXOZLGnd9G+RnKEvO8isDu8qe60vxnGQ
        Epf78l3zJ/mHouIHipLufVUSsga3S1P+Z7X4FwbeGz31P3rKHyAaxU+ZEkxHBc3m
        BK6YeB7Wq3r2MtDDvihomd7fhBvr8bOb/qVSHM3+h+tzK0jbFTpOVBr4ctZcpSMj
        A5TP6hA+cKY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46EEBCA152;
        Fri, 20 Mar 2020 19:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89F5FCA14E;
        Fri, 20 Mar 2020 19:36:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Parth Gala <parthpgala@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, chriscool@tuxfamily.org
Subject: Re: [GSoC Project RFC] "git log --oneline" improvements
References: <28aee28c-8e8d-763a-66c7-d365025e56a2@gmail.com>
Date:   Fri, 20 Mar 2020 16:36:40 -0700
In-Reply-To: <28aee28c-8e8d-763a-66c7-d365025e56a2@gmail.com> (Parth Gala's
        message of "Sat, 21 Mar 2020 04:41:34 +0530")
Message-ID: <xmqqwo7ea99z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7665588-6B03-11EA-BFC3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Parth Gala <parthpgala@gmail.com> writes:

> I went through the discussions here[1] and here[2] and what I could
> conclude from [1] is, the 'git log --oneline' command currently shows the
> decorations of a commit before the commit message but after the shortened
> hash due to which the alignment of the messages is disturbed like this,
>
>     3f07dac29 (HEAD -> master) pathspec: don't error out on all-excl...
>     ca4a562f2 pathspec magic: add '^' as alias for '!'
>     02555c1b2 ls-remote: add "--diff" option to show only refs that differ
>     6e3a7b339 (tag: v2.12.0-rc0, origin/master, origin/HEAD) Git 2.12-rc0
>     fafca0f72 Merge branch 'cw/log-updates-for-all-refs-really'
>     74dee5cfa Merge branch 'pl/complete-diff-submodule-diff'
>     36acf4123 Merge branch 'rs/object-id'
>
> And if the decorations were to be shown after the message and you were
> checking the logs just to see the status of a branch rather than the
> contents then you would again be at a disadvantage, since you would want
> to have them visible right next to the hashes. Besides decorations at the
> end would have the inconvenience of being truncated at the end of the line
> on smaller screens.
>
> This format for --oneline with decorations was decided upon,
>
>   b9df16a4c (HEAD -> master)
>             pathspec: don't error out on all-exclusionary pathspec patterns
>   91a491f05 pathspec magic: add '^' as alias for '!'
>   c8e05fd6d ls-remote: add "--diff" option to show only refs that differ
>   20769079d (tag: v2.12.0-rc2, origin/master, origin/HEAD)
>             Git 2.12-rc2
>   076c05393 Hopefully the final batch of mini-topics before the final

Hmph.  Who decided that such a format is a good idea?  I do not see
anything decided positively in the thread [1] you referred to.

> In [2] such formats with date and timestamp are discussed along with
> compatibility for --graph option as well,
>
>   === 2015-09-17 ===
>   * ee6ad5f4 12:16 jch (tag: v2.5.3) Git 2.5.3
>     === 2015-09-09 ===
>   * b9d66899 14:22 js  am --skip/--abort: merge HEAD/ORIG_HEAD tree
> into index
>   |   === 2015-09-04 ===
>   | * 27ea6f85 10:46 jch (tag: v2.5.2) Git 2.5.2
>   * 74b67638 10:36 jch (tag: v2.4.9) Git 2.4.9
>                        ..........
>   * ecad27cf 10:32 jch (tag: v2.3.9) Git 2.3.9
>
> So these are the two main formats to be enhanced along with as many options
> of log as possible. What are your views on this ?
>

Making the "--oneline" format to consume more than one line for a
commit is probably not what we want anyway.

Coming up with a new format (say, "--pretty=concise"), or a new
option that tweaks the behaviour of "--oneline", are possible ways
to add a new feature without disrupting existing users' use cases,
though.

Thanks.

