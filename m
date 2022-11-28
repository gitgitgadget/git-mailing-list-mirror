Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DCBC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiK1OTP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Nov 2022 09:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiK1OTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:19:06 -0500
Received: from rincon.dynax.at (rincon.dynax.at [62.171.155.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3BC1837E
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:19:00 -0800 (PST)
Received: from smtpclient.apple (62-178-42-31.cable.dynamic.surfer.at [62.178.42.31])
        (Authenticated sender: hagen)
        by rincon.dynax.at (Postfix) with ESMTPSA id CA6AD4B91C;
        Mon, 28 Nov 2022 15:18:58 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: =?utf-8?Q?Re=3A_making_use_of_=24sm=5Fpath_=40_git_submodule_fore?=
 =?utf-8?Q?ach_=E2=80=94recursive?=
From:   "signal@dynax.at" <signal@dynax.at>
In-Reply-To: <221128.86r0xnkzyw.gmgdl@evledraar.gmail.com>
Date:   Mon, 28 Nov 2022 15:18:57 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DEE63B3B-95B2-469B-AC02-CAC1B5FCAC67@dynax.at>
References: <70ED2ECF-DAF1-4CCB-9E05-2599211F3569@dynax.at>
 <221128.86r0xnkzyw.gmgdl@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, thanks! I didn’t notice that it chdir’ed into the submodule folder! Then clearly this is the relation I was looking for!
Thanks! sorry for the noise!

> On 28.11.2022, at 13:43, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> 
> On Sun, Nov 27 2022, signal@dynax.at wrote:
> 
>> Hi,
>> 
>> when using 
>> git submodule foreach —recursive [..] 
>> $sm_path contains only the relative part of the latest
>> recursion. Since the command has no generic way of knowing from which
>> recursion level it is executed any $sm_path of deeper recursion level
>> is useless unless there is a way for the command to find out from
>> which recursion it is called.
>> 
>> I suggest $sm_path should be extended to be relative to the repo from where the submodule recursion started or another variable should contain the recursive part.
>> 
>> Viele Grüße/Cheers,
>> Hagen.
> 
> I think it might be sensible to have a $super_prefix_sm_path or
> something which does what you suggest here.
> 
> But the current "$sm_path" is far from useless, it's just not useful for
> what you're trying to do.
> 
> When we run a command in sub1/sub2 or whatever the "$sm_path" will be
> "sub1", then as we cd to "sub1" it'll be "sub2".
> 
> You want "sub1/sub2" there, but a "sub2" is still useful, because we've
> chdir()'d to the "sub1" at that point.
> 
> So you can e.g. run 'git -C "$sm_path" log' in your 'foreach', or
> another command that expects to get the *relative* submodule path.
> 
> If we simply changed how "$sm_path" works that would break, and if we
> "fixed" that by not chdir()-ing from the super-project we'd break even
> more things, as e.g.:
> 
> 	git submodule foreach 'git pull'
> 
> Or whatever wouldn't behave as you'd expect.

