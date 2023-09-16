Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF3CCD37B3
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 02:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbjIPCKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 22:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjIPCJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 22:09:48 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69B1BF2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:09:42 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694830180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQkPj4ma1Vj4er2SoTr4eJOjnKZVInmVEUeMynEIW88=;
        b=BQinGRG2wtB5gKArFNmdMCmThTSL+x095sYJZYO0qVe3ttdaJASNWAtXJ8vMWRyCo75lHd
        SshRhn5oyBeSI+0LtOxlXGzh9aYfQRQm7q9z7n9ULP8L/sP1CaIBPlOC4Gd/LpsZA7nkeq
        JQazj8LMTG0n3RPg0uFRVkTQkGKv9bUaZhbrLsQsSNdOb9znksZxU8b2t/Iv9/copwvuWk
        hwzjEPQVBdlk05Glb5ZwmeLMO9Yzh124Z4BL6AM5lS5EnGoDlYlDDRZyu2QKSBUzS3dadd
        /V07mc4Yr3HhuDhiodpP67CPvjAPhm6ImN/jwqw8zdD3xk4I9HPQiReklSHZ8A==
Date:   Sat, 16 Sep 2023 04:09:39 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: add config option to limit filename width
In-Reply-To: <487bd30e5a4cdcea8697393eb36ce3f3@manjaro.org>
References: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
 <xmqqil8gs3s0.fsf@gitster.g> <487bd30e5a4cdcea8697393eb36ce3f3@manjaro.org>
Message-ID: <7aceb7db8d3f4b569564ffd9d1e2e368@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-12 04:11, Dragan Simic wrote:
> On 2023-09-12 01:12, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> Add new configuration option diff.statNameWidth=<width> that is 
>>> equivalent
>>> to the command-line option --stat-name-width=<width>, but it is 
>>> ignored
>>> by format-patch.  This follows the logic established by the already
>>> existing configuration option diff.statGraphWidth=<width>.
>>> 
>>> Limiting the widths of names and graphs in the --stat output makes 
>>> sense
>>> for interactive work on wide terminals with many columns, hence the 
>>> support
>>> for these configuration options.  They don't affect format-patch 
>>> because
>>> it already adheres to the traditional 80-column standard.
>>> 
>>> Update the documentation and add more tests to cover new 
>>> configuration
>>> option diff.statNameWidth=<width>.  While there, perform a few minor 
>>> code
>>> and whitespace cleanups here and there, as spotted.
>>> 
>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>> ---
>> 
>> The stat lines have <width> (the entire display width),
>> <graph-width> (what appears after '|') and <name-width> (what
>> appears before '|'), so I would worry about letting users specify
>> all three to contradictory values, if there weren't an existing
>> command line option already.  But of course there already is a
>> command line option, so somebody more clever than me must have
>> thought about how to deal with such an impossible settings, and
>> adding a configuration variable to specify the same impossible
>> settings to the system would not make things worse.
> 
> Good point, but we're actually fine with adding diff.statNameWidth as
> a new configuration option, because the real troubles with
> contradictory configuration values might arise if we ever add
> diff.statWidth later.  However, we should still be fine at that point,
> because the code in diff.c, starting around the line #2730, performs a
> reasonable amount of sanity checks and value adjustments.
> 
> If we ever add diff.statWidth later, a good thing to do would be to
> emit warnings from the above-mentioned code in diff.c if it actually
> performs the adjustments, to make the users aware of the contradictory
> values.  I might even have a look at that separately, if you're fine
> with adding such warnings.

Just checking, do you want me to perform any improvements to this patch, 
so you can have it pulled into one of your trees?

I'll start working on a patch that adds the above-mentioned warnings, 
but having those implemented properly and hashed out will surely take a 
fair amount of time.  However, those warnings should be quite usable, if 
you agree, although they're not critical at the moment.

>>>  Documentation/config/diff.txt  |  4 ++++
>>>  Documentation/diff-options.txt | 17 +++++++-------
>>>  builtin/diff.c                 |  1 +
>>>  builtin/log.c                  |  1 +
>>>  builtin/merge.c                |  1 +
>>>  builtin/rebase.c               |  1 +
>> 
>> Someday, as a follow-up after the dust from this topic settles, we
>> would probably want to look at how these rev.diffopt.* members are
>> initialized and refactor the common code out to a helper.  It would
>> allow us to instead of doing this ...
> 
> Another good point.  If you agree, I'd prefer to have my patch
> accepted and merged as-is, after which I'll have a look into unifying
> the initialization of the rev.diffopt.* members.  Such an approach
> should, in general, also be better in case any regressions are
> detected at some point in the future.
> 
> I'll also have a look into the NEEDSWORK note in diff.c that asks for
> using utf8_strnwidth() to calculate the display width of line_prefix.
> I already had a brief look at that, and it seems that it leaves enough
> space for some rather nice related code cleanups.

I'll also start working on these patches in the next few days, which 
should result in some rather nice code cleanups, AFAICT so far.

>>>  	/* Set up defaults that will apply to both no-index and regular 
>>> diffs. */
>>>  	rev.diffopt.stat_width = -1;
>>> +	rev.diffopt.stat_name_width = -1;
>>>  	rev.diffopt.stat_graph_width = -1;
>>>  	rev.diffopt.flags.allow_external = 1;
>>>  	rev.diffopt.flags.allow_textconv = 1;
>> 
>> ... in many places, do so in a single place in the helper function,
>> and these places will just call the helper:
>> 
>> 	std_graph_options(&rev.diffopt);
>> 
>> I do not know offhand if "stat graph options related members" is a
>> good line to draw, or there are other things that are common outside
>> these .stat_foo members.  If the latter and the helper function will
>> initialize the members other than the stat-graph settings, its name
>> obviously needs a bit more thought, but you get the idae.
> 
> Sure, I'm willing to have a detailed look into all that, as I already
> described above.
