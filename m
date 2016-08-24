Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456841FD99
	for <e@80x24.org>; Wed, 24 Aug 2016 05:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbcHXFow (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 01:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63889 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750933AbcHXFov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 01:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA0252F333;
        Wed, 24 Aug 2016 01:36:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/UpX62TDPIB7
        sQlHyHP9CYjO8co=; b=qUnzmxhGPT4An7Ro3K0h7/qHc31zzb9mRGdQxWnsx3Ut
        i+lpj/92BYi1Rbev4KFszk7Lz5WxB0PEFFXAY6+1gzAMg1PfVriqTaNDEX5caOd1
        jkdno2yH1w5UZ6kz2+zOY8Rkr0yuMHHnHbMfthpPTXAnRJ4wgyjTJoceS/CKjI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=THaMRG
        iunsx9CmAUMbJmY8YxdD59cWumFbbG6LyoiSQ9QcQzv+yNzb+PZrJO8lBQxIBHf0
        ZIimvIFRQHrlKxEbXY/Yn5pO+P+FdUSGdcdcVxXqxZj1wHl5WKXa8BTQcQbUFoDQ
        9aY/cgOi70qfEfe8V67PDrsCvOWBC0cuDvMXI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1DB72F332;
        Wed, 24 Aug 2016 01:36:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D6CE2F331;
        Wed, 24 Aug 2016 01:36:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
        <20160821142634.dorgzldjvc3qiaby@x>
        <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
        <20160823065359.34cirqig56fugnwy@x>
        <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com>
Date:   Tue, 23 Aug 2016 22:36:46 -0700
In-Reply-To: <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 23 Aug 2016 22:24:53
 +0200")
Message-ID: <xmqq60qqu3rl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0465EAA-69BC-11E6-9E5E-E86612518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> The point is that submodule has it's own object database.  It might
> be the same as superproject's, but you need to handle submodule objects
> being in separate submodule repository anyway.  Common repository is
> just a special case.
>
> By the way, this also means that proposed "extended extended SHA1"
> syntax would be useful to user's of submodules...

Not really.

I think that you gave a prime example why <treeish>:<path1>//<path2>
is not a useful thing for submodules.  When the syntax resolves to a
40-hex object name, that object name by itself is not useful.

You also need to carry an additional piece of information that lets
you identify the location of the repository, in which the object
name is valid, in the current user's context (i.e. somewhere in the
superproject where the submodule lives).  In other words, you'd need
to carry <treeish>:<path1> around anyway for the object name to be
useful, so there is no good reason why anybody should insist that
the plumbing level resolve <treeish>:<path1>//<path2> directly to an
object name in the first place.
