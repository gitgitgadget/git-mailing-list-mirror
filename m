Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B66720248
	for <e@80x24.org>; Sat,  2 Mar 2019 02:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfCBCkX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 21:40:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53783 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCBCkX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 21:40:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4699B599E5;
        Fri,  1 Mar 2019 21:40:18 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=2k6Bm6k0WYg8nE0NbcwJCne9XCc=; b=na11mQf
        N5p6d4Z4cm2tePapS6AquQR1L6boyN4DjioMDfWuO2ds2xQHRjXPx1C5+/AxEiN4
        RIR9oGqCNQJ7SSx/ndEixIXwwVWmR7NLf2Sp8D1pp/oODLUtvhkNAbLeXzODyL8O
        EDJkVhkScOvLU3DakRc0oQugpQpFvVNjBfsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=VfHu/rC/HUK4KrOfLwNAEDwNrkOIGkJT/
        eqLu0dtn0Cd5wgVVzw8liokGtnAI6K+gxMAGR4/8f0GlmNm55SeAKLBGw2xfsTtG
        AJamWUDPPH+xiyugAsHvxCxEg1TpKLxmN9+RC/54GWlPhKByT5wWnZy2qbg7pLZc
        hCo6kCgCdY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EA18599E4;
        Fri,  1 Mar 2019 21:40:18 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4FD2599E3;
        Fri,  1 Mar 2019 21:40:14 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Fri, 1 Mar 2019 21:40:12 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190302024011.GF31362@zaya.teonanacatl.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-1-tmz@pobox.com>
 <20190301183017.GB30847@sigill.intra.peff.net>
 <20190301221551.GD31362@zaya.teonanacatl.net>
 <xmqqef7q6pm1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef7q6pm1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 82784770-3C94-11E9-934A-D01F9763A999-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Hmm.  The comments in list_cmds_by_config() made me wonder
>> if not using a local repo config was intentional:
>>
>>         /*
>>          * There's no actual repository setup at this point (and even
>>          * if there is, we don't really care; only global config
>>          * matters). If we accidentally set up a repository, it's ok
>>          * too since the caller (git --list-cmds=) should exit shortly
>>          * anyway.
>>          */
> 
> Doesn't the output from list-cmds-by-config get cached at the
> completion script layer in $__git_blah variables, and the cached
> values are not cleared when you chdir around?

In testing, I didn't find any evidence of caching.  Setting
commands to be added and removed in the global and local
configs worked reasonably.

Duy's reply suggests that was considered but not
implemented.  I there were caching (and if it were tedious
for the completion code to keep fresh between repos), then
it would a bad plan to allow per-repo config.

If there was a goal of adding such caching it might also
make sense to avoid "fixing" the code here to allow per-repo
config before it's known how that might affect such caching.

It sounds like that's not something Duy is planning on for
the near term though, so perhaps we're fine to allow local
repo config here?  As Duy mentioned, maybe some users with
local aliases want to add them to the completion locally as
well.

If we choose to avoid local repo config then we can add a
comment to the documetation like I had in 2/3.  Maybe also
update the comment in list_cmds_by_config() to note that we
intentionally don't setup a repo -- or a similar comment in
list_cmds(), where Jeff's 1/3 was adding
setup_git_directory_gently().

I don't have a strong opinion either way.  I more or less
have the minor patches for either direction at this point.

Thanks,

-- 
Todd
