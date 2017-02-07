Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC79D1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbdBIOLi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 9 Feb 2017 09:11:38 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:25774 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbdBIOLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 09:11:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 9A4AB1E2F2D;
        Thu,  9 Feb 2017 13:43:46 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id leT3etdRbZ0z; Thu,  9 Feb 2017 13:43:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 0CDA01E3017;
        Thu,  9 Feb 2017 13:43:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oYH6r-3Fc0Vl; Thu,  9 Feb 2017 13:43:45 +0100 (CET)
Received: from [192.168.178.64] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id B950E1E3027;
        Thu,  9 Feb 2017 13:43:45 +0100 (CET)
Subject: Re: Request re git status
To:     Phil Hord <phil.hord@gmail.com>, Ron Pero <rpero@magnadev.com>,
        Git <git@vger.kernel.org>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
 <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <5e9357f3-ca64-bdc9-34d1-67e700de7995@tngtech.com>
Date:   Tue, 7 Feb 2017 02:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2017 01:45 AM, Phil Hord wrote:
> On Mon, Feb 6, 2017 at 3:36 PM Ron Pero <rpero@magnadev.com> wrote:
> Do you mean you almost pushed some changed history with "--force"
> which would have lost others' changes?  Use of this option is
> discouraged on shared branches for this very reason.  But if you do
> use it, the remote will tell you the hash of the old branch so you can
> undo the damage.
> 
> But if you did not use --force, then you were not in danger of being
> bit.  Git would have prevented the push in that case.

I totally agree with Phil. Besides, git-status should be fast. And
talking to a remote can be painfully slow. As Phil pointed out, even the
slow answer when talking to the remote can give you better guarantees
than the quick (local) answer. Therefore, I prefer the quick answer.

Since you pointed out the use of --force, I want to add the
--force-with-lease option of git-push. The idea is basically, that we
may force-push, if the remote end does indeed have the state we think it
has. This avoids those situations where somebody pushed to the remote
while you were typing 'git push --force' (which would then loose the
other contributor's work). For details have a look at 'git help push'.

>> Or change the message to tell what it really
>> did, e.g. "Your branch was up-to-date with 'origin/master' when last
>> checked at {timestamp}"? Or even just say, "Do a fetch to find out
>> whether your branch is up to date"?
> 
> These are reasonable suggestions, but i don't think the extra wording
> adds anything for most users.  Adding a timestamp seems generally
> useful, but it could get us into other trouble since we have to depend
> on outside sources for timestamps.  

The date of the last update is actually stored in the reflogs for the
remote branches. That timestamp is "internal" and could be trusted.
However, I don't quite believe that it would avoid accidents. For that
you would have to remember the time when some other (!) contributor has
pushed to the remote AND recognize that its timestamp is after the date
printed.
I prefer being warned by git when I try to do something stupid.
