Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1AE2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758206AbcISNqk (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:46:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42765 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756055AbcISNqi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Sep 2016 09:46:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A83720707;
        Mon, 19 Sep 2016 09:46:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 19 Sep 2016 09:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=4lLOmWwJg5OkRrt8XqY4iDqPAbc=; b=kNsSwN
        SjtFpyNjOQPe9SZ4e0BlX487ZPsNdIFYJKjBm8EQrBt8lDTXvzNN2EOUgDJFi6zl
        TzGfc0/AzTBfVCvE1qXcTrLAjBbZ4Y2PdiSkGqPyiqWOwTCFb55WbyRt7xFeLS4C
        53tb6kfeLPlKWpqXayon933Yu3qezkF4pRr2k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4lLOmWwJg5OkRrt
        8XqY4iDqPAbc=; b=YYpjSz+h8bHgkH+aHKET8NT2alvZXETjNb8z00T9S+dmfWz
        +Nynv7Y68sN/yXxD+DqT0Ob38BSBEI6wXf6rYAojWEmVSbJvfYdGg7V4bT5uCfLL
        gj+vrpb3Y4PloQDiGfS+HVs0vo2TGStl7AKGTlpZWdtm47XidgndECAMagXQ=
X-Sasl-enc: GCpkzA+tg/ERplD6VJi4D44eFXQKrqDhlU7qmkxzE/lZ 1474292796
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 98BA8CCE96;
        Mon, 19 Sep 2016 09:46:36 -0400 (EDT)
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
To:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
Date:   Mon, 19 Sep 2016 15:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley venit, vidit, dixit 19.09.2016 12:56:
> A question came up on the Git user list regarding cherry-pick that got me
> reading the manual (again), in this case regarding --no-walk ranges.
> 
> Essentially my question is: If --no-walk is given to rev-list (e.g. via
> charry-pick), and the user includes a caret prefixed rev, when does that
> range definition take effect on the command line, especially in light of
> the --do-walk option?
> 
> In rev-list(1) there are only 8 references to  'range', with only
> the --no-walk option saying "This has no effect if a range is specified."
> but leaving open the decision as to what does (and does not) comprises the
> specification of a range on the cli.
> 
> The two and three dot notations are fairly obvious ranges from
> gitrevisions(7) as they are complete strings, while the caret prefix is an 
> implied range (it needs additional parameters to complete the range, and 
> there-in lies the issue).
> 
> It can be read that
> 
> $ git cherry-pick maint next
> 
> would pick two single commits, while
> 
> $ git cherry-pick maint next ^master
> 
> could implicitly be read as
> 
> $ git cherry-pick maint next --do-walk ^master
> 
> because the ^ caret starts the range that cancels the --no-walk.
> 
> Clearly that's not what is intended, which is
> 
> $ git cherry-pick --do-walk maint next ^master
> 
> but it is open to interpretation as to where in the command line the caret
> range prefix's --do-walk (to countermand the --no-walk) should applied.
> 
> If the user did want just the single commit at the tip of maint, and then
> the range master..next, what would be their command line, and also, how
> would the man page warn against false expectations?

Maybe:

Every negative rev (rev prefixed with ^, or a range) implies a
`--do-walk` (right at its position on the command line).

And then curb the misleading range sentence in the `--no-walk` description.

Michael

