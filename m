Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694DD1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 02:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfKHCyf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 21:54:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62261 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfKHCyf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 21:54:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA4B219B34;
        Thu,  7 Nov 2019 21:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7mausqggiUusCIZs4sCmg7pOBr4=; b=LvBSVR
        BvtcB9VXg14snmnCwn9x2WmwdBGPP/75W5ehtv8XTeBXR4yF+2YXGgEnn0CU4yEg
        Ab6SvJmT2ScymO1pXM0xagjU152XrORALN+Whfl4JtuLaMx7PPtSwhDclntZHUB2
        St/jKUsXbZvu5LW6cZrYCmAZ/g3rWysBigyhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZcQOTzgAc2EZzv8qJUdRLGMp+r1MZsO8
        DVyHsmAYIYhjrtLbjXsudbCG9yCBbWFs+QBorM46foaAcoNfFOyKanLfYejDKEY9
        XED6erueUD4hFJAxYlUEs+/CoxkGyDvM2m/wBSGdE3cbztWbmac1ZeEBk/M+g/1F
        aIG5RyYf1dQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B296019B30;
        Thu,  7 Nov 2019 21:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFEB319B2F;
        Thu,  7 Nov 2019 21:54:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: Forbid to create local branches with confusing names
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
        <xmqqftj0qkzm.fsf@gitster-ct.c.googlers.com>
        <20191107135409.13fa0336@ingpc3.intern.lauterbach.com>
Date:   Fri, 08 Nov 2019 11:54:29 +0900
In-Reply-To: <20191107135409.13fa0336@ingpc3.intern.lauterbach.com> (Ingo
        Rohloff's message of "Thu, 7 Nov 2019 13:54:09 +0100")
Message-ID: <xmqq36ezoz6i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1622B29A-01D3-11EA-8219-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ingo Rohloff <ingo.rohloff@lauterbach.com> writes:

> On Thu, 07 Nov 2019 15:05:49 +0900
> Junio C Hamano <gitster@pobox.com> wrote:
>> Ingo Rohloff <ingo.rohloff@lauterbach.com> writes:
>> 
>> > ...
>> > This patch forbids to create local branches, with names which start
>> > with any of
>> >
>> >   refs/
>> >   heads/
>> >   remotes/
>> >   tags/  
>> 
>> Is there a reason why notes/ hierarchy is excluded?  What about
>> pull/?  Are we dealing with an unbounded set?  Should this list be
>> somehow end-user configurable so that say Gerrit users can add for/
>> and changes/ to the "forbidden" set?
>
> I think I did not explain the intention that well.
> What I basically want to avoid is a situation in which there is
> no way at all to refer unambiguously to a particular reference.

Hmph, I thought this was a solved problem, but maybe I am still
misunderstanding you.

When you have a possibly ambigous branch whose name is $X, whether
$X begins with one of the strings you listed above or not, you can
always

 - refer to the commit at the tip of that branch by saying
   refs/heads/$X (e.g. "git show refs/heads/$X") and that always
   refers to the commit, even if there are other branches and tags
   that may begin with refs/ or refs/heads/.  You would of course
   get a warning about possible ambiguity because saying just $X
   (e.g. "git show $X") may not refer to refs/heads/$X when you have
   other refs that make $X ambiguous.

 - refer to the branch by saying $X (and not refs/heads/$X).

The thing to know is when you are naming a branch and when you are
naming a commit.

 - "git branch -d $X" is referring to the branch itself and removes
   refs/heads/$X.  

 - "git branch new <start-point>" uses <start-point> to specify the
   commit to begin the 'new' branch at, and does not necessarily
   take a branch name, so you should say refs/heads/$X.  You may not
   be able to rely on lazy-man's short-hands, like "git checkout -t
   origin/master" that DWIMs what you did not say, as you have to
   say refs/heads/$X that is *not* in the <remote-nick>/<branch>
   form (you can still do so with "git checkout -b master
   refs/heads/$X" followed by necessary configuration updates), but
   that is a price to pay for using ambiguous names.

And for those who do not want to pay for using ambiguous names, we
issue warnings when resolving refnames.

