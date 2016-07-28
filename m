Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F941F955
	for <e@80x24.org>; Thu, 28 Jul 2016 19:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbcG1TcE (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 15:32:04 -0400
Received: from plane.gmane.org ([80.91.229.3]:34671 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbcG1TcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 15:32:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bSr2G-0005yj-5t
	for git@vger.kernel.org; Thu, 28 Jul 2016 21:32:00 +0200
Received: from ewj64.neoplus.adsl.tpnet.pl ([83.20.233.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 21:32:00 +0200
Received: from jnareb by ewj64.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 21:32:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: git-testadd: Execute a command with only the staged changes in
 Git applied
Date:	Thu, 28 Jul 2016 21:31:35 +0200
Message-ID: <579A5D97.7080708@gmail.com>
References: <CAA787r=FH7Sa4qy2A-dy+wug81ZkqOW2KmSuWBE8_3whmNj1pw@mail.gmail.com>
 <xmqqlh0lsoq6.fsf@gitster.mtv.corp.google.com>
 <CAA787rmDb+1=4RCscvo1rZWSt=tUQSm5wrFet-=PhRKZcf9x5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@ger.gmane.org
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
X-Gmane-NNTP-Posting-Host: ewj64.neoplus.adsl.tpnet.pl
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAA787rmDb+1=4RCscvo1rZWSt=tUQSm5wrFet-=PhRKZcf9x5A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-28 o 18:56, Øyvind A. Holm pisze:
> On 28 July 2016 at 18:37, Junio C Hamano <gitster@pobox.com> wrote:
>> Øyvind A. Holm <sunny@sunbase.org> writes:

>>> This is a script I created some weeks ago, and I've found it to be
>>> immensely useful. Here is a snippet from git-testadd --help:
>>>
>>>   If you have lots of unrelated uncommitted changes in the current
>>>   repository and want to split up the commit, how can you easily
>>>   check if the changes passes the test suite? With all the other
>>>   unrelated changes it can be hard to make sure that only relevant
>>>   changes becomes part of the commit, and that they don't result in
>>>   regressions. This script clones the repository to the directory
>>>   ".testadd.tmp" in the current directory and applies the staged
>>>   chenges there (unless -u/--unmodified or -p/--pristine is
>>>   specified), chdirs to the same relative directory in the clone and
>>>   executes the command specified on the command line there.
>>
>> So in short, this solves the same problem as "git stash --keep" but in
>> a more scalable way, in the sense that "git stash --keep" allows you
>> to instantiate what you have in the index so that your working tree
>> can be used for such a test, but you cannot do anything else while you
>> are waiting for the test to finish, and "testadd" allows you to keep
>> hacking in the working tree while a test runs in its own temporary
>> checkout (and presumably you can have more than one running, which
>> would allow you to scale more)?
> 
> That's correct, the test clone is entirely separated from the working
> copy, and you can keep working while the tests are running in the clone.
> Combined with git-gui and/or "git add -p/git reset -p", it's easy to
> tweak the staged changes until things are ok.

I wonder if using `git worktree` instead of `git clone` (well, local
clone uses hardlinks, so it is not that costly as it looks like) would
be a better solution.
 
> Also, there is a -l/--label option that creates a clone directory with
> the name ".testadd-[LABEL].tmp", so you can have several test clones at
> the same time, all with different staged changes. There is also a
> -r/--ref option that tries to apply the staged changes onto another
> commit, and the command will only run if the apply succeeds. Also, this
> won't create dangling heads like "git stash --keep" does.

Nice.


