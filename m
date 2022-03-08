Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFFC433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 13:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347060AbiCHNGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiCHNGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 08:06:19 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B61648301
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 05:05:22 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qt6so39055550ejb.11
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 05:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vxxPHfoecf8nFBNr9XLSbnrUBrrTtkimHjTHzptUPRU=;
        b=cCSkFpCNNMSG960Dh3kas4Kyz19qklPrL9kt75SBcqvUKDkBXaGD4B/7zTINFNhwq1
         TVIsmRyjdWzmTxtXTa/FDpR6FCZyB/dZbp99/ueCGS1tg9ieFIc7tN8DiV156mERL1eX
         snhhM9JSFznUXYy+Q33CMZNNIuZyTtkBKEmSA34OLB0DvgYCKHGV9B2nelpqrLpjTVnz
         ZAPZlwWg8YuurmizcqJ4zgMiAgcO7h72A752x/1UnUtmgvv+uDFfLBYmEFdAqug58iVA
         ek5MLEUzbfLNIupqYd+C6aFUN4sF0ei0kPECllck6dAEekjY+cBbft3foRygHu0kLl9B
         MqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vxxPHfoecf8nFBNr9XLSbnrUBrrTtkimHjTHzptUPRU=;
        b=x2BD5/H/z04dc3tvNezPmGIVnHsWleXygX7TN0QXuM/V9OPBF1dlVvCtCzJ674LEK2
         2yWskOnRZG+8x3tXVmuzS4s4XbibFbnWMylYlS2rNmCAl3HnApMUyhTsUVDOMWoAmglD
         SxaDb5otjhksDCLaUp2S6E8DLgW1TdNwGJJW022iNEQeYCt77Gzj89nByrnUAGdl+bwM
         I1a2/lJJVxJeisFTjzB4PTTKB2Tpl4bTAyKleQq13J7rLLrItybMD1LShu8Bhk/AB8LQ
         R+g61g74JIhWr8J9dSoad3q+bao7Z+/VtIhB85sCeHsUHQQnKMNFLr1ptiru2Vz9FkrA
         IUQA==
X-Gm-Message-State: AOAM531/K+GO0Oy/do8XsDhRhIJVj2XUulUFWjfAiORd3wcz/WIORhNY
        v7uuNmCc43ljgeMos7sskAs=
X-Google-Smtp-Source: ABdhPJz8PFAsnuakaEdX3+8lBVWUuw/BBp5zB1sbYq2tmMn8jAHVVYMXbsOmjS95c5BJOwam8SMtGw==
X-Received: by 2002:a17:906:c59:b0:6b9:59d8:263e with SMTP id t25-20020a1709060c5900b006b959d8263emr13504645ejf.770.1646744720466;
        Tue, 08 Mar 2022 05:05:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og49-20020a1709071df100b006db0dcf673esm2955237ejc.27.2022.03.08.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:05:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRZWh-001tqG-BR;
        Tue, 08 Mar 2022 14:05:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Keep reflogs for deleted (remote tracking) branches?
Date:   Tue, 08 Mar 2022 13:59:38 +0100
References: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
 <CAFQ2z_Oht=-QrzoH8FW_Jm-B7u9O0wXUaY-ifwZah6gkcgVVSA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_Oht=-QrzoH8FW_Jm-B7u9O0wXUaY-ifwZah6gkcgVVSA@mail.gmail.com>
Message-ID: <220308.868rtky4q8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Han-Wen Nienhuys wrote:

> On Tue, Mar 8, 2022 at 12:28 PM Tao Klerks <tao@klerks.biz> wrote:
>> As far as I can tell, even "core.logAllRefUpdates=always" does *not*
>> keep any reflog entries around, even temporarily (until reflog
>> expiry), once a ref  is deleted - do I understand that correctly? Is
>> this behavior intentional / reasoned, or just a consequence of the
>> fact that it's *hard* to keep "managing" per-branch reflogs for
>> branches that don't exist?
>>
>> I am planning a workaround using server hooks to "back up" refs that
>> are being deleted from specific namespaces, in my specific case, and I
>> imagine that a system like github keeps track of deleted stuff itself
>> for a while, but I find this "per-ref reflog disappearance" behavior
>> puzzling / out-of-character, so wanted to make sure I'm not missing
>> something.
>
> I think this behavior is motivated by directory/file conflicts. If you
> have a reflog file in refs/logs/foo, you can't create a reflog for
> refs/foo/bar, because that would live in refs/logs/foo/bar
>
> At Google, we keep reflogs in a completely different storage system
> altogether, which avoids this problem, and I wouldn't be surprised if
> other large hosting providers do something similar.

I once worked on a system where:

 * References would be "archived", i.e. just a backup system that would
   run "git fetch" without pruning.

 * You were only allowed to push to either existing branches like
   "master", or names with exactly one slash in them, e.g. "avar/topic",
   not "avar/topic/nested", for that you'd need "avar/topic-nested" or
   whatever.

The second item neatly avoids D/F conflicts, at the cost of some
grumbling from people who can't use their preferred branch name.

And you can easily implement backups without that constraint by fetching
refs/* to refs/YYYYMMDD-HHMMSS/* or whatever, and have some manual
pruning process in place for those "secondly refs".

More generally I have not really run into this as a practical
problem.

I.e. if a co-worker created a branch, AND nobody else used it, AND
nothing was based on it, AND someone (presumably they) thought it was OK
to delete it, it was probably something nobody cared all that much about
to begin with :)

Another way to solve a similar problem is to have
pre-receive/post-receive hooks log attempted/successful pushes, which
along with an appropriate "gc" policy will allow you to manually look up
these older branches (or even to fetch them, if you publish the log and
set uploadpack.allowAnySHA1InWant=true).
