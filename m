Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336ACA0FF6
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 01:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbjIBBfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 21:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIBBfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 21:35:53 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3036E54
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 18:35:44 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 9785C241BA;
        Sat,  2 Sep 2023 03:35:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id EA97C23FF9;
        Sat,  2 Sep 2023 03:35:41 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sLOPiFHJboap; Sat,  2 Sep 2023 03:35:41 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id CF4F824242;
        Sat,  2 Sep 2023 03:35:39 +0200 (CEST)
Message-ID: <fa702b47-ae29-4299-9226-4920620b9fff@opperschaap.net>
Date:   Fri, 1 Sep 2023 21:35:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing without
 a forkpoint
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20230819203528.562156-1-wesleys@opperschaap.net>
 <20230819203528.562156-2-wesleys@opperschaap.net>
 <6127b570-5e9b-404f-9802-9135a1c9f31f@gmail.com>
 <a168fe69-f305-4280-b0e6-9406fbac796f@opperschaap.net>
 <xmqqledppxw3.fsf@gitster.g>
From:   Wesley <wesleys@opperschaap.net>
In-Reply-To: <xmqqledppxw3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=GP927dFK c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=N3miCFJ7AAAA:8
        a=v-pe1zJSd-iy4nW2YFMA:9 a=QEXdDO2ut3YA:10 a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/23 14:10, Junio C Hamano wrote:
> Wesley <wesleys@opperschaap.net> writes:
> 
>> The quirk is this: --fork-point looks at the reflog and reflog is
>> local. Meaning, having an remote upstream branch will make
>> --fork-point a noop. Only where you have an upstream which is local
>> and your reflog has seen dropped commits it does something.
> 
> Why do you lack reflog on your remote-tracking branches in the first
> place?

I do not know? I tested with a bare repo and two clones. And I also 
tested it with just a remote upstream in another branch.

When in repo-1 I do the reset --hard HEAD^, and push the results, and 
pull them in in repo-2 the behavior doesn't replicate. The git reflog 
command doesn't show the reset.
However, if I delete the reflog entry for removal of the reset HEAD^, 
git rebase exposes the fork-point behavior.

> The fork-point heuristics, as far as I understand it, was invented
> exactly to protect you from your upstream repository rewinding and
> rebuilding the branch you have been building on top of.  The default
> fetch refspec +refs/heads/*:refs/remotes/origin/* has the "force"
> option "+" in front exactly because the fetching repository is
> expected to keep the reflog for remote-tracking branches to help
> recovering from such a rewind & rebuild.

I haven't force pushed anything btw, maybe that could explain things?

Cheers,
Wesley

-- 
Wesley

Why not both?

