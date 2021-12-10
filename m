Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A70C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 01:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhLJBKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 20:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLJBKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 20:10:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319DEC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 17:06:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so24431418edb.8
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 17:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7N2n1QUhnA2Vp7EWdZ/35G68Hg0fNw9gzlciWAksNwM=;
        b=D6Zgd3Wbph8Dd8QrIhIdnKyOUpAxYC/VVnWHhVEI711CYKJW66QWs1TnxYTe7Bc1q1
         pZARYpqUXcAsMhF7YmVODePWYM0ViXwXoaQs6bRHy15lMl7Kpd080XhnLcBaAErfobti
         R20fYf87Ez63yo129lYSY0BvK9fPV6Yq93TjaENPD/bdUy0KtR2A6td+3TARvSsiM2og
         h+xmKsPS3cntS2q+rGnu1aAR6jTAyXBNaI49ia3QnWl6IeRgqQx/7MD587eDEfmP9f+T
         Bih0VXUHfBalA908bD5BnsMMjPvEVHfEn+/B7AvPlVbqR+k2BZCrQYTsJ48vnVupL6+Y
         igiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7N2n1QUhnA2Vp7EWdZ/35G68Hg0fNw9gzlciWAksNwM=;
        b=L83ZgUznU4PcGIoDRIqPAeXO1KZ5kS9d7gmYDWwQ5QpbAnni6yNVmw4SRw7YWl8tO2
         p+WeKYJAhfVwPm4/COwJhE6tj23zgWuf9BOWIjh7VeFUYePKg1fSHcevwt+u10oGahwv
         i4mGANGeZG0Y/won7YP238LcbO2z0dxiB7hSag1LIKeIOC95zCSh2yQtuGKJlGKTeNN/
         mEwwdjt4kfsM3zgVNevNXEwdeMONo/nrVsua0shHKkTHRCt8d3g5q286eYY2iCN9suQy
         dl5Q5ld8AYIu+82bzQK26hkkYR4iDrqiyOd3APvGk2u3uzHAkp5S1bStaxamuMdmfhnW
         sdgg==
X-Gm-Message-State: AOAM531NHGfnRs0VYCCy1qw/FwSljhstepghy0YxBG4gZxduO0J3knp3
        rM0z2E2YQ3r3k7FGFUUFW8A7+z66ETwEFQ==
X-Google-Smtp-Source: ABdhPJzGrVN0apiOjm+dsF7d0VruOOdJwwF/FTUcdOe7dBPkeCMrWyBQkGck8OSTJOvhyUFqL5w6Lg==
X-Received: by 2002:a05:6402:4396:: with SMTP id o22mr34111597edc.263.1639098398532;
        Thu, 09 Dec 2021 17:06:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn26sm667736ejc.14.2021.12.09.17.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 17:06:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvUMt-0007Sf-Jz;
        Fri, 10 Dec 2021 02:06:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, emilyshaffer@google.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Date:   Fri, 10 Dec 2021 02:03:35 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6llf0war1x.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YbKHBsl7w1uNhLb6@google.com>
 <kl6l35n19w97.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6l35n19w97.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <211210.86ilvxe09w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 09 2021, Glen Choo wrote:

> Josh Steadmon <steadmon@google.com> writes:
>
>>> > @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>>> >  	advise(_(tracking_advice),
>>> >  	       origin ? origin : "",
>>> >  	       origin ? "/" : "",
>>> > -	       shortname ? shortname : remote);
>>> > +	       remotes->items[0].string);
>>> >  
>>> >  	return -1;
>>> >  }
>>> 
>>> When there is more than one item in remotes->items, this advice is
>>> _technically_ incorrect because --set-upstream-to only takes a single
>>> upstream branch. I think that supporting multiple upstreams in
>>> --set-upstream-to is a fairly niche use case and is out of scope of this
>>> series, so let's not pursue that option.
>>> 
>>> Another option would be to replace the mention of --set-upstream-to with
>>> "git config add", but that's unfriendly to the >90% of the user
>>> population that doesn't want multiple merge entries.
>>> 
>>> If we leave the advice as-is, even though it is misleading, a user who
>>> is sophisticated enough to set up multiple merge entries should also
>>> know that --set-upstream-to won't solve their problems, and would
>>> probably be able to fix their problems by mucking around with
>>> .git/config or git config.
>>> 
>>> So I think it is ok to not change the advice and to only mention the
>>> first merge item. However, it might be worth marking this as NEEDSWORK
>>> so that subsequent readers of this file understand that this advice is
>>> overly-simplistic and might be worth fixing.
>>
>> Sounds like we should just have separate advice strings for single vs.
>> multiple merge configs?
>
> That sounds like a good idea if it's not too much work. Otherwise, a
> NEEDSWORK is still acceptable to me (but that said, I'm not an authority
> on this matter).

We haven't used Q_() with advise() yet, but there's no reason not to:

	advise(Q_("fix your branch by doing xyz",
		  "fix your branches by doing xyz",
                  branches_nr));
