Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A37C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 19:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLFT0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFT0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 14:26:01 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4309465B2
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 11:26:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so8650373ejb.13
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L+54lROE5kLDF/OhDzah4i63qtnP1evpESJA32P9+tA=;
        b=pDqCN/iqax1UyLYcudIcP0TprdJz2tjHF4zDEcap/+7W/qvObWDjFZVbqzWPJbZzZH
         MmVqje3JyQSquhPtrVPdaeRwMO1graOtlF90+vEgrgnXjxW9B/lGykkoLZ1moAI39rNu
         w/hOZ9H88PMXFxIfGk3p92fo6rqnS9X/OJhd5ApqTDfLV6POoPyf0nWtljpcwxYXJBA5
         2mkuPLVrAoroSs5PvCM1ZWzv2UAgymSHRKmczv9OopyF+lqcXGoVMVFd7nSIE+nLK8KZ
         IXOdSWas8UNwrvQsYLhsrwQLxbOdtFtK/+sFZ2B2z87ww6QihrRDSVgoKXLJ8RlEF0D3
         6aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+54lROE5kLDF/OhDzah4i63qtnP1evpESJA32P9+tA=;
        b=3Yez9I3rkiEtzkPnSKoeWV+MxjhsuthxOrn/67vtaGLU6Q4M65c/nwoFTz1EjppJvR
         7ZxbOQjMet5dblCZkueDyUyOQQhAkVA0YAEsvQ8UW/Hoq6erKlWXRa6/NdWVwxitVrOs
         QyrBpPOH1d2V9EDA3e2MA/KU1q2JLXsB8iSUN5Xlc6ZhzjrGe7GnxG4iRhuL8XW/AgV4
         ekEy8Y9CCOomiYDnRpwivQ9ZJ7Z/+L688MQd5FwRQlDJHx9VNeh1Fmj9ulCnxoEdt/Q5
         SW0TJVM0JYIykHzzRss0oDnEjvNNNFT2KjHx5XcJkraEFbgRnHkIqIcYLii9+OCu2p4N
         fAIA==
X-Gm-Message-State: ANoB5pmEW+AicH52x2yOfpt3Gt4+sX1AfqDyAfBHS193SK7KDZJ7lHDi
        cWn8n4d8mEAOBLzpSP60lqE=
X-Google-Smtp-Source: AA0mqf4FXP+6XaLrR9VLR1Ze70IZSJFZS6ySeGOU+zx52Jpqu868b/J94+LJltdZE/QPoeWx7Jo+zg==
X-Received: by 2002:a17:906:aec1:b0:7c0:a04b:6795 with SMTP id me1-20020a170906aec100b007c0a04b6795mr24597930ejb.16.1670354758773;
        Tue, 06 Dec 2022 11:25:58 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kv21-20020a17090778d500b0078de26f66b9sm7681983ejc.114.2022.12.06.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:25:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2dZl-0043jw-1u;
        Tue, 06 Dec 2022 20:25:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Auto packing the repository - foreground or background in Windows?
Date:   Tue, 06 Dec 2022 20:19:46 +0100
References: <CAPMMpoiN=Rj_z9VEJZ4EFhb8gBeqb6H7JhTUBbn-b-t-jHRVnA@mail.gmail.com>
 <4dcad1f5-9ebd-d15a-b663-a3513ae1bcb8@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <4dcad1f5-9ebd-d15a-b663-a3513ae1bcb8@github.com>
Message-ID: <221206.86o7sgbagq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Derrick Stolee wrote:

> On 12/1/2022 7:25 AM, Tao Klerks wrote:=20
>> But my *question* is: Does anyone know where I could/should look to
>> understand why the GC was happening in the foreground, even though the
>> message says it will run in the background?
>
> On Windows, Git's foreground process cannot complete without also
> killing the background process. I'm not sure on the concrete details,
> but the lack of a background "git gc --auto" here is deliberate for
> that platform.
>=20=20
>> I don't know how to create the conditions for the auto-GC on demand
>> (how to create lots of loose objects??), so I don't know how to verify
>> whether it ever runs in the background on Windows, or what that might
>> depend on. I saw some discussions in 2016, but I can't tell what the
>> conclusion was; is it simply the case that git has been "lying" about
>> running GC in the background, on windows, for all these years? Or is
>> there something specific going on in this user's environment?
>
> Instead, the modern recommendation for repositories where "git gc --auto"
> would be slow is to run "git maintenance start" which will schedule
> background maintenance jobs with the Windows scheduler. Those processes
> are built to do updates that are non-invasive to concurrent foreground
> processes. It also sets config to avoid "git gc --auto" commands at the
> end of foreground Git processes.
>
> See [1] for more details.
>
> [1] https://git-scm.com/docs/git-maintenance

That's good advice, but Tao is pointing out that the message we emit is
buggy here, which is a correct.

The problem is just that on Windows we always fail to daemonize(), but
didn't correct the bits that know that to the bits that emit the
message.

I think this should fix it:
=09
	diff --git a/builtin/gc.c b/builtin/gc.c
	index 02455fdcd73..a5f599ebff0 100644
	--- a/builtin/gc.c
	+++ b/builtin/gc.c
	@@ -623,9 +623,11 @@ int cmd_gc(int argc, const char **argv, const char *p=
refix)
	 		if (!need_to_gc())
	 			return 0;
	 		if (!quiet) {
	+#ifndef NO_POSIX_GOODIES
	 			if (detach_auto)
	 				fprintf(stderr, _("Auto packing the repository in background for opti=
mum performance.\n"));
	 			else
	+#endif
	 				fprintf(stderr, _("Auto packing the repository for optimum performanc=
e.\n"));
	 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
	 		}
Tao: If you're interested do you mind carrying that (or some other
similar) patch forward?

The above is: Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com>
