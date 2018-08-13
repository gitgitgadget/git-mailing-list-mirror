Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544261F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeHMNsS (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 09:48:18 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:39066 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeHMNsS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 09:48:18 -0400
Received: by mail-ua1-f43.google.com with SMTP id g18-v6so8654317uam.6
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AZVHEnvzCaRu9ssUW87rEIdRSvXNePmPQQlS26B/h04=;
        b=cKPExZ7G2TCEyPSj5t7H3ryW4VTTb7FQFHpk1i4rzajTf9VJEvLC2yVCE6FTIDpFRX
         7Jk/7aqnK/ssRXglKdgMycG58gRMDYuBtCThfIXHRb83RceE2PL3h27G7npoCsXdFcik
         XGXJ0IWOxEXojOkKgrXepJFHMiY4TvZgXlSjCgAilx8Q0C8GkpUjb/M2olZZEjusBI+O
         2W8zvXox5bQYjBJpfHHrXT3Xwa824jnv2klN17IrAvfHm7izneEWNlccoAkws+I23yQQ
         F+aIlnqTP3YZVTXwFq7+aNI74raxLkVEF8EDMrN+qGcDlwcPF9dZQbDCCrJH6t8gsLPl
         SFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AZVHEnvzCaRu9ssUW87rEIdRSvXNePmPQQlS26B/h04=;
        b=ge3OyNkvMZdSpVYMlnudvEYXhYA1mOOLRbzkOrfVjl0V/zCHbYumNjnyAURM6+2p3I
         EMYu9UtPc1cb/bt3hz3iPIZUodTILdekY2lgg9UxDAbZLtclydxfljvMPFFbNwjYR1bI
         UHN/dBaZ8hS/s2AoyPMDWIUeRpHf1leZZpNK0OeRmf895tmgUgoEICvqKj23jxpQHGav
         7XBC53MeZTDzeiNQPz10cO0H5dfpfNaQesdzrdeGpe/FRxV12m1MuOXBcmMeGLvH2M10
         pEdxRGQiit4nXaf7uoypruejy2ky4W9X+IhMHV6DqzkCEWEfkoQg5FHOH6OFW/GMVAhl
         uSzA==
X-Gm-Message-State: AOUpUlHf90qeMx2awJh9knSG0gPy7QWYGWI8jSAebUWezKUuJOO2fm0T
        Ma4WxfEUNV7kvxd+/ZvsOs8JeKKDxTdFKoyTXg3WU2JP
X-Google-Smtp-Source: AA+uWPzKjmrJeRjGiRtLeWniKKWeTnRdQWDVPf+uMAOtAexbGQons9GUR2Kr/uB2O2wXDWAm9sphYPX35q5hR+2BxL4=
X-Received: by 2002:ab0:644f:: with SMTP id j15-v6mr11137246uap.70.1534158391628;
 Mon, 13 Aug 2018 04:06:31 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?RMOhbmllbCBWw7Zyw7Zz?= <daniel.voros@gmail.com>
Date:   Mon, 13 Aug 2018 13:06:20 +0200
Message-ID: <CA+wscc=TKnWc+Dtq6U=EFZKWEd-0afwFD+mmfR53rA9Ts9toDA@mail.gmail.com>
Subject: Bug? Interactive rebase with reword after conflict
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey All,

I'm seeing some weird behavior when doing interactive rebase of a
single commit with reword if there's a conflict. The rebased commit
gets "squashed" into the target commit and is not a child of that.

I've asked this question in the git-users group first a few weeks ago,
but got no explanation:
https://groups.google.com/forum/?fromgroups#!topic/git-users/1X15nAts3mg

Please refer to the link above for detailed repro steps (reproducible
with 2.18.0).

Kind Regards,
Daniel
