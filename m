Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679EC54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 15:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjAMPsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAMPrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 10:47:42 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A036167
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 07:39:35 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id g10so9514613qvo.6
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejwlW4OfAUarWy9Y3GoygZXM3WOZKBtJRAPZTU0hFvg=;
        b=ZPraLKFLPnysjQWZU5KMxp2Bln5BThFL9dtpc77cWL908W45vu+0rVdYnm/e3Y0m2U
         POQTHSJVVfZMdmLHRzmSO6n4NvcWZ8COIJhfCwIU3ZIkDs736VHEDyZkj5aUDppxUgV1
         8DClonvtzZRmVzQSwIAVgtyN3oxAr3AdrFbz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejwlW4OfAUarWy9Y3GoygZXM3WOZKBtJRAPZTU0hFvg=;
        b=JEYBsEG/AP9aRa4LxIGTFySPDaZAdK/Wqsz2kMGgO6fUoRk9yDW18EKStTFYj4BkIF
         g8cY24HBZgfNd3Ol9ENb1gbpCLT1QqbSh5/hAEAZmFO7+P5fihMYkEQlgBvTzi7sMSCt
         0Uct4Vn3UrL51I8snoRs8OPcKsf27WL4yAKEHYPnKyDrlFmQrNbi1E/Kmg3bPlIAT1dw
         Y1GQkRzS+0ThjTuMbWess3QO/fPoqtCm8gto4Axgu6TyGN356G8Mjx5Oq6PoM8iP05Pw
         Od6aJADj54BHaPgaCUtEbZCoNkrut6SiEhOdH31C7I1ucAC2I44G/lzOPkH1CTtb5MXt
         cznA==
X-Gm-Message-State: AFqh2kq18EDyr+AQKE4UiLcV+JSnEpyJhNmX4hSCuTAozwxGrHGJpUk+
        ct+i0tJwTqv2LkmjzSgv5/S08Noe51Y3GQlX
X-Google-Smtp-Source: AMrXdXuFb7AbMybH6TOzTZvMjTKLMFf7dGIiyPSLidDWCHyGWrBAfQw0fGvIeBh1zzPTt4ST9aaxYQ==
X-Received: by 2002:a05:6214:3586:b0:531:c474:bf6c with SMTP id nn6-20020a056214358600b00531c474bf6cmr72288192qvb.14.1673624374352;
        Fri, 13 Jan 2023 07:39:34 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b007055dce4cecsm13055957qkn.97.2023.01.13.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:39:33 -0800 (PST)
Date:   Fri, 13 Jan 2023 10:39:32 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113153932.gsnt4t26tlzotw65@meerkat.local>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 02:39:37PM +0100, Hans Petter Selasky wrote:
> Just imagine the consequences of finding child porn inside a 10-year old
> firmware binary blob in the Linux kernel. Will you just ignore it, or will
> you fix it?

How do you expect something like this would happen? A much more likely
scenario would be someone contributing a binary blob that doesn't actually
allow redistribution, and therefore would need to be purged from the
repository.

When something like this happens, everyone is given a heads-up, the history is
rewritten, and everyone moves on. It's a fairly routine procedure -- ask
anyone who's ever committed an API key into their repo.

Git supports history edits and everyone lives with it just fine -- I think you
are under the impression that git is some kind of globally distributed
blockchain where any history edit requires a consensus fork. It's not at all
the case.

-K
