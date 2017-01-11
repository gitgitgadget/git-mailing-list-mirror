Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23558205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939412AbdAKSVq (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 13:21:46 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:37691 "EHLO
        homiemail-a101.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S938665AbdAKSVp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Jan 2017 13:21:45 -0500
Received: from homiemail-a101.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a101.g.dreamhost.com (Postfix) with ESMTP id 4CE35117E07C;
        Wed, 11 Jan 2017 10:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=N52Bq
        CZ0qOHDNHaygJJ0rjOBedg=; b=caWzAv0hw9k7o/GONO03QTuKQ0V6AqF9ycBaO
        SFCUkG/m9iUxmMQY5idW1O/FkdsSK/oQxYwP2UUMIymMeGq3pT3XXktJbhUlaPhW
        Foy9CTWDaIUQQgugyxQF2Ky72u1M846709RyaU9arq94BSZoKgCQQNv79+60tlg4
        9qZlOY=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a101.g.dreamhost.com (Postfix) with ESMTPSA id DE1BB117E078;
        Wed, 11 Jan 2017 10:21:43 -0800 (PST)
Message-ID: <1484158902.11251.3.camel@frank>
Subject: Re: git cat-file on a submodule
From:   David Turner <novalis@novalis.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 11 Jan 2017 13:21:42 -0500
In-Reply-To: <20170111125330.3skwxdleoooacts6@sigill.intra.peff.net>
References: <1484093500.17967.6.camel@frank>
         <20170111125330.3skwxdleoooacts6@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-01-11 at 07:53 -0500, Jeff King wrote:
> On Tue, Jan 10, 2017 at 07:11:40PM -0500, David Turner wrote:
> 
> > Why does git cat-file -t $sha:foo, where foo is a submodule, not work?
> 
> Because "cat-file" is about inspecting items in the object database, and
> typically the submodule commit is not present in the superproject's
> database. So we cannot know its type. You can infer what it _should_ be
> from the surrounding tree, but you cannot actually do the object lookup.
> 
> Likewise, "git cat-file -t $sha1:Makefile" is not just telling you that
> we found a 100644 entry in the tree, so we expect a blob. It's resolving
> to a sha1, and then checking the type of that sha1 in the database. It
> _should_ be a blob, but if it isn't, then cat-file is the tool that
> should tell you that it is not.
> 
> > git rev-parse $sha:foo works.
> 
> Right. Because that command is about resolving a name to a sha1, which
> we can do even without the object.
> 
> > By "why", I mean "would anyone complain if I fixed it?"  FWIW, I think
> > -p should just return the submodule's sha.
> 
> I'm not sure if I'm complaining or not. I can't immediately think of
> something that would be horribly broken. But it really feels like you
> are using the wrong tool, and patching the tool to handle this case will
> probably lead to weird cognitive dissonance down the road.

OK, this makes sense to me.  I tried cat-file because that is the tool I
was familiar with, but that doesn't mean that it was the right thing to
do.

> Maybe it would help to describe your use case more fully. If what you
> care about is the presumed type based on the surrounding tree, then
> maybe:
> 
>   git --literal-pathspecs ls-tree $sha -- foo

That (minus --literal-pathspecs, which does not exist in the version of
git I happen to be using) is fine for my purposes.  Thanks.

