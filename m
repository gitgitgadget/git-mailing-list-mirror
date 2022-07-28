Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F080C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 12:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiG1M1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiG1M13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 08:27:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC461DB2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 05:27:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e15so1982265edj.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=2e479Oz78L7ehUvF6TA36mE6DzdGF/vC1qAdi6RO8jg=;
        b=c4keM7LlChKRLhWkPSdszI7yr17ay6WRz7XEveN37p6zIs6Hmvbzmr+en/I7hnoB9h
         sYopct1uBahn+rD7eYdQdXzOG2JlSkY+8I1F15w4Oy8jzJE3NXycXV3nrXPH6H1vuV97
         y9uA3hiLTJisi1levtLypCZe0iJJcyZHAqCm3bq7LHL6/jNA8Z9dwLLuQ9YDVZzbjBYc
         eVuaafRqLCOTApYFin4E+aee5mGFIyj9i8rwg/wlvYMx99o9Eye85NIZ8tkI/CNhrnHW
         EH9tRzXAGbYVAPM6AUYRmFOXEpYw6JPw+MuhrjWktyO7obJbDF1PH6FVVEbwA/8IkcWE
         5P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=2e479Oz78L7ehUvF6TA36mE6DzdGF/vC1qAdi6RO8jg=;
        b=B6N0CrOzjZmNRacqH4ju+3YlAOzKBzCQN4yGj24THXz3FKlADJOzwufS3Evte8QPsu
         FeksrBnSzEDNrOgzFee8vh3TfDsBJzOKBtYnHljHxKxnW9J9gwl1/gsNwLaMkOu/CCtG
         Ptgs/EQGuaWt9hOZdpdyxFGMgFdeaP01pxThXyQl9TMsgVu9ZCPVVzAi0icDXIzc/Jr/
         jFjIlvz4tmUohA7tKU4jcRLgfdaggkZzH0QYOExqRitMTJtjQmaMRD853muss7VtbvWA
         xo2UuLx2IOJZJkCSOmAKmS0OqzlLPDSk7cPz/GKWmBscG7//QRyKJIjXlEQSBmE6iSAQ
         RFmw==
X-Gm-Message-State: AJIora8DklKg8eE+TRnZMDiYvn7QY1D+m0L6ShnTaz9uU/trtX85xtx1
        Js9A1O6OLsInbx2tj+hPr5SzIBJqMv13dQ==
X-Google-Smtp-Source: AGRyM1sieqRD0bHGqqvi4KxHlenTXHgsUbU0Rv+Ov0yPoHVnFLSlHS+sJG0FkIlRk5OEK3lsOroc6w==
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id ed12-20020a056402294c00b0043a91a9a691mr27621935edb.182.1659011245050;
        Thu, 28 Jul 2022 05:27:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z16-20020a17090665d000b0072faba43409sm374195ejn.58.2022.07.28.05.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 05:27:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH2br-0073t0-CN;
        Thu, 28 Jul 2022 14:27:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Lost file after git merge
Date:   Thu, 28 Jul 2022 14:17:51 +0200
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
Message-ID: <220728.865yjhl8wk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, La=C4=8Fa Tesa=C5=99=C3=ADk wrote:

> 1. I added a file called 'new_file' to a master branch.
> 2. Then I created branch feature/2 and deleted the file in master
> 3. Then I deleted the file in branch feature/2 as well.
> 4. I created 'new_file' on branch feature/2 again.
> 5. I merged feature/2 into master, merge introduced no changes, file 'new=
_file' is not present in master.
>
> This could cause problems to our team in the future, fortunately we notic=
ed it this time.
> Please, does anybody have any explanation for this behavior?
>
> Or is anybody aware of any Git or Source option that changes this behavio=
ur?
>
> Thank you very much,
>
> Lada Tesarik
>
> P. S.
> In the picture the steps were done with git revert command, but result is=
 the same if I delete file manually and perform git commit.
> Tested with git versions 2.26 and 2.37

Those who know "merge" better will chime in, but I believe this is known
behavior, and you can see why if your "topic" branch doesn't
(re)introduce the file as it was on master, but adds a small change to
it.

I quickly experimented with this (with the fast-export stream at the
end). If you had a "hello" as the content on "master" and introduced
"hello2" on the topic you'd get:

	$ git merge topic
	CONFLICT (modify/delete): file.txt deleted in HEAD and modified in topic. =
 Version topic of file.txt left in tree.
	Automatic merge failed; fix conflicts and then commit the result.

So others will know better, but I vaguely recall this having to do with
this being the same in your version (not the below hello2 version, but
if you s/hello2/hello/):

	git rev-parse $(git merge-base topic master):
	git rev-parse topic:

I.e. the topic is the TREESAME as its divergence point with "master",
which IIRC is a shortcut the merge takes when deciding what changes to
keep, and whether they conflict.

--
blob
mark :1
data 6
hello

reset refs/heads/master
commit refs/heads/master
mark :2
author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010359=
 +0200
committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010=
359 +0200
data 9
Add file
M 100644 :1 file.txt

commit refs/heads/master
mark :3
author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010437=
 +0200
committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010=
437 +0200
data 81
Revert "Add file"

This reverts commit 75aa73c55b19219d47dfc7ec3883c88466678718.
from :2
D file.txt

commit refs/heads/topic
mark :4
author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010369=
 +0200
committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010=
369 +0200
data 81
Revert "Add file"

This reverts commit 75aa73c55b19219d47dfc7ec3883c88466678718.
from :2
D file.txt

blob
mark :5
data 7
hello2

commit refs/heads/topic
mark :6
author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010359=
 +0200
committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 1659010=
644 +0200
data 9
Add file
from :4
M 100644 :5 file.txt

