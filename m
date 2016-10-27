Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43272022A
	for <e@80x24.org>; Thu, 27 Oct 2016 06:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbcJ0GAe (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 02:00:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752575AbcJ0GAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 02:00:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19C89424B5;
        Thu, 27 Oct 2016 02:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/BSTO4urYTJPYh87QAFZ/umSLA=; b=kyn3Wc
        gC6BV+S0j2QOcISvxVfeuwEzTzut930YYxn72TrjIR6KUlzddS27iR+6yyXhbGRt
        /kMJugYUddWvT8H+bVy8gJC5LvULhaJs/gVhckaGwYRJEEJC168sd47viLTRG9XK
        fjYQVZs4aHa2UrPZprcMaBg2J8LcYvJlG87As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gaAKjwNrhqSEOizP30mHOrQPTtq2VgCG
        Ov8IfbsvMlSPmqurh49T8BUl1G1sD9OSS+FxhC7CMyjVFjgVk+K1CPyQbT+13sMn
        mOWoMBoM+qBTpN8CLx1M5C9E/gvPGrnUFKVbmeOba/QYiuwSBZ9CX5Hs5jsIRcsb
        a+tnkKMAh7s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 101B9424B3;
        Thu, 27 Oct 2016 02:00:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E8E1424B2;
        Thu, 27 Oct 2016 02:00:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Williams <pwil3058@bigpond.net.au>
Cc:     Stefan Beller <sbeller@google.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and rebase
References: <1477523244.2764.114.camel@mattmccutchen.net>
        <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
        <xmqqk2cuach3.fsf@gitster.mtv.corp.google.com>
        <f07745f8-d0ff-c41f-fd44-0812757fbd43@bigpond.net.au>
        <xmqqtwby8hu8.fsf@gitster.mtv.corp.google.com>
Importance: high
Date:   Wed, 26 Oct 2016 23:00:24 -0700
In-Reply-To: <xmqqtwby8hu8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 26 Oct 2016 22:46:23 -0700")
Message-ID: <xmqqpomm8h6v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A81C70A0-9C0A-11E6-94D7-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Peter Williams <pwil3058@bigpond.net.au> writes:
>
>> However, for git commands such as diff/status whose job is to display
>> information it would be nice if they had a --recursive option to
>> override the default submodule diff/status and show details of the
>> changes in the submodules.  Sometimes you want to see the big picture
>> in detail.
>
> I won't disagree. My comment was only on this part from the original:
>
>>> - We have to make separate commits and manage corresponding topic
>>> branches for the superproject and subprojects.
>
> and on this point, we seem to be in agreement.

Oh, and as Stefan mentioned, a "git diff" that recurses into the
submodules to give you detailed big picture has been in 'next'
(perhaps aready in 'master' as of tonight, but I am not sure
offhand) to be tested, together with many other fixes and
enhancements that all are waiting to be included in future releases.

The more people try and give feedback to these branches early, the
more solid release with better support for more goodies you'd want
we will be able to give you.  Early adopters are always appreciated
but especially in time like this before the feature freeze for the
upcoming release (see tinyurl.com/gitCal for the schedule), they are
of great help.

Start by cloning from any one of these places

  git://git.kernel.org/pub/scm/git/git.git/
  https://kernel.googlesource.com/pub/scm/git/git
  git://repo.or.cz/alt-git.git/
  https://github.com/git/git/

and then

  $ git checkout -b next origin/next
  : read INSTALL to figure out if any custom options are needed
  : in the following 'make' invocations for your environment
  $ make && make install
  $ PATH=$HOME/bin:$PATH

to join the fun.
