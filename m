Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE15C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 14:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0012077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 14:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH/z9D/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbgDCO0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:26:12 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36368 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCO0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 10:26:11 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so3009918pjb.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=40EIC9iQ+DQm2n4Fm7sP6oxybsl9xQrbvVgJTNqM4s4=;
        b=YH/z9D/8l5q+zPJczyZxGqHSMbshWmQ33rHxfm7DzYdzestEmmP5Q2ug2a2imUABc0
         CPXdkSGtdaFQpDgLcjzt+U+Ws8Wp9oSUdc3XVYpOfJP1zPCosFZ7Fr5rqc+P0dQuifF9
         AdXkbzJs6ybMbiq+nkMOI64enLM3oTTyP0Ckl63U90fVhYY7Jv7JCTk9OWgL/D61M93i
         67RbTcCv+jJoXSEpiRgec+NWA1h9fBlY4GtVmqifKMInyN8qWPY9/fGdMMTi/+IT2SqU
         oJOEXQwd8KunpdmL7oEa5F7nCAtJsSPdJkaqbCxzQDyBQfYxqyd6c+8Dx919FcK3A+Nn
         Mg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=40EIC9iQ+DQm2n4Fm7sP6oxybsl9xQrbvVgJTNqM4s4=;
        b=ATIz5Z9UWZRgDMhpHOpR+OQF697Wu8/+L5UbKQ6yNKDlzGjHqzliSh8Exbje9ZDAf0
         R6hFwHgajMkNZM/QZ4lR7ew87HfUo1y7ZSYq31ebT4gLqzQkIYZ+5Co5zMZ1Ema0DJ5h
         y4WQn/53GjJeXMQC6cP2zIVDGwMTUmRJTz2q4Q/FtvKelQkna+nBqrZiubTc0lggtInV
         Ak4kgyDhwBNluemUTsdYtSWBdUK7DhaRkJU60C3aYlQvRrmCd/g6krm0BZw4PVEjjGwV
         qnyJeHMIqdAl2KmgDgxy97gcqYZOmn9jRbeUHp98MrSSA3wt/X9aGJf+fDH6inwGemvU
         cjrg==
X-Gm-Message-State: AGi0Pubn7r38sKJxyw9ZAz8gA2bLmonTeo73z4u4Bgw81c6bcTbeInB4
        beTb+A1LGNoyN/f2VhEOxNegUDLk
X-Google-Smtp-Source: APiQypJI2+DDtMSPlWxjci0HmSy8KAEwZHLjCRK1xMBNNNnDL19wj4g3a8h0pn+GnUfYt1uC9rseSg==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr8326516plo.147.1585923970447;
        Fri, 03 Apr 2020 07:26:10 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id w127sm5922570pfw.218.2020.04.03.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:26:09 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:26:08 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/6] cherry-pick/revert: honour --no-gpg-sign in all
 case
Message-ID: <20200403142608.GE32101@danh.dev>
References: <20200331064456.GA15850@danh.dev>
 <cover.1585909453.git.congdanhqx@gmail.com>
 <28ebbfe72a04b787fb92702199efea663a6b7ee5.1585909453.git.congdanhqx@gmail.com>
 <180436a8-5b50-88b8-f3f1-1ec6aff41c9e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <180436a8-5b50-88b8-f3f1-1ec6aff41c9e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-03 14:43:05+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Đoàn
> 
> On 03/04/2020 11:28, Đoàn Trần Công Danh wrote:
> > {cherry-pick,revert} --edit hasn't honoured --no-gpg-sign yet.
> > 
> > Pass this option down to git-commit to honour it.
> 
> I did wonder if try_to_commit() needed any changes as we do not fork 'git
> commit' unless the message is being edited but the tests seem to cover that
> case. It might be worth checking the code just to be sure if you haven't
> done so already.

try_to_commit pass opts->gpg_sign to commit_tree_extended (sequencer.c:1413)

if "--edit" was passed into cherry-pick and/or revert (--edit is
default if revert run in tty), sequencer.c will run git-commit just
6 lines above it.

-- 
Danh
