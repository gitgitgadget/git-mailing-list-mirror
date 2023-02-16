Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C6C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 19:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBPTAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBPTAc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 14:00:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACD528AE
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 11:00:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 16so2078031pfo.8
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ntvpl3i2dPglR1L4HtRxBA9ccx7Fcp8OZItBWbzOMe0=;
        b=Okix8tAbEe2VLHbu40In1qIun4JLFmWNGaAWod3+UtrUyU5s5o1wHEP5h9mo1LZuKn
         Rkn73bhdKivL5jD60OjSlXiwwPR4lXhrSu3r/Nm5JMAaf60a+pUtsNNfohp5NmRVSqod
         p7XQx59os/O/bvpUQzJdY3Bych9DhOPwOec1tjaEpcE9H4uDV+MBZMyCbRErPY6Lac2S
         iGfSVy2p918wxmdAmcP1oLowRrTzsGjVwNv54CWA+FCoz4gOhYcH5nlNTtjv82B614uK
         q3WHiUcyszjfulkSzMQguY7szrkI0gswmOFMesyFShT7ZNpFCDzSCLCQasZx9hvtGOkf
         j/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntvpl3i2dPglR1L4HtRxBA9ccx7Fcp8OZItBWbzOMe0=;
        b=7p4j2UDBM5iuImhWJkJH1lPL+uAXhXWLfTryQyBf7tu5DpZEXtoE0MeboA84Rrs1qo
         TF58gv8YQZGjPmzV67aWNxOXZ01uoCzTuas6wnIo3NK2TY0mUo4LwtfBeBt3DW4ULLDk
         4L3jXequnjDgxLszJD4rX885KHMRQHoJmaxPh/LNdB8YRl5YnF+JQXN2CtidoLnu/AOQ
         ojwUreVo5Yw2dvlCW8VnsnKMFQ1USYvlRfUBgkjpPkBLUbC6vyn9RfFMUgt+VzZcFJsa
         Ca8BWiWyNHfj9nB/yUnZ9VQgtI4lhvZExqtPyU+GFF3hzrj/MJ+EbdbQ4fjbBAy90rfv
         slDQ==
X-Gm-Message-State: AO0yUKUmhfrgANmU2cjulpZ8EhhX7oxF7Qf/rxXMWIuvkcy2qOKRlazc
        5CWetYkvAJzRTiT56EiXzzchoEh65a0=
X-Google-Smtp-Source: AK7set+f+BFjXJ3rB3Nf+rMp1ZiaKZxKSfXoQGit3nRgfC+9Sj4z2z6nQy7YbQvhvUGW02nO7PiKyA==
X-Received: by 2002:aa7:9e5a:0:b0:58d:9791:44bc with SMTP id z26-20020aa79e5a000000b0058d979144bcmr5930872pfq.9.1676574015205;
        Thu, 16 Feb 2023 11:00:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j26-20020a62b61a000000b0058d8db0e4adsm1667981pff.171.2023.02.16.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 11:00:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone
 options
References: <20230216041432.1668365-1-alexhenrie24@gmail.com>
Date:   Thu, 16 Feb 2023 11:00:14 -0800
Message-ID: <xmqqa61dpha9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> GitHub and GitLab have features to create a branch using the web
> interface, then delete the branch after it is merged. That results in a
> lot of "gone" branches in my local clone, and I frequently find myself
> typing `git branch -v | grep gone`. I don't want `git branch --merged`
> because that would include branches that have been created for future
> work but do not yet have any commits.

I can see why it is a useful feature to filter or group branches by
its remote tracking status, but I do not know if the design
presented here is what we want.  "--has-upstream" (yes/no) is
understandable, but "--no-has-upstream" is quite a mouthful and an
awkward way to say "no configured upstream" ("--has-no-upstream"
might be more palatable).  "--gone" does not even hint it is about
the precense or absense of upstream ("Are we looking for a branch
that is gone?  Perhaps in a future we may have logs of branches that
have been deleted?") and will not "click" in readers' mind that it
is about branches configured to track some branch at the remote that
has been removed.

Perhaps something like

	--upstream=(configured|unconfigured|gone)

may be easier to explain, understand, and possibly more extensible
but I dunno.

If most people use a single remote and track branches from the
single remote, then --upstream=origin to select branches with
upstream configured somewhere in origin would allow users who
interact with multiple remotes to further limit by remote.  Or we
could even go --upstream=refs/remotes/origin/* using ref matching
rules to specify that chosen branches must have upstream configured
to refs that match the pattern (your "--has-upstream" becomes a mere
special case of doing "--upstream=*"), with a special token, e.g.
"--upstream=no", that never matches a real ref, to select ones
without any upstream configured.

I do not know offhand how that line of UI design that allows future
enhancement would mesh with the concept of "configured upstream no
longer exists", but whatever UI we pick that is understandable,
explainable and extensible, it should be made to work well with
"gone", too.
