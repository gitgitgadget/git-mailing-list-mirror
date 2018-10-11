Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046681F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeJKJPF (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:15:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43981 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJKJPF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:15:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id p24-v6so3531248pff.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hseb1RYNR/LCA0Pttk121DPYqMmMLxJL6j4WnXNq6u8=;
        b=au447G2Fszx7PV7TQxDr7eaO24ldzKxDwd3DPRc9QRRcKKPc4Tv7r7IOsv6nMggLSB
         jBq+aZoK7tQjU90sl06jRmqsOVq9qlVs8SaN81C2E8Hn5239Cn2B8N6Vxgf3fpCZQudt
         MI5fjiw4PIy7dUEYGRCv03ZycPw5eAqQK3Ct61Oez/MZ3IJ5++ZByb9NU6OrE9sZwp8f
         DzQV7z0wJ23FkMP5nBdZqVQn2/bmkFtaO4MJrVXCRIBgsb2WxVeEJLmPibA4nTQLGaOo
         26RwO8hKEi4LfwsArOJrheFEAbfpv8CIny+Bsg31hGCAHjNZzmsXljMALv3pb9h3osYe
         2YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hseb1RYNR/LCA0Pttk121DPYqMmMLxJL6j4WnXNq6u8=;
        b=E4sX/48Kv02Yx7cCHQZmOfH3MuKD7uEYVyJI1OQRUaUHJHXL2cWqTZJHPdchExkc5i
         gDGIIHXk+DR+CLMMZ6CQf+jJrDK+NAAo1r+csIhnpIZQ0lD0vzXLFRHoV7CS810Rp8YJ
         mNE1H2oP29Qgd2rbzetM/7OpD1dRv9SiTHv4jajYo7j4AJzYF/gYYZUhSmjTUyzOXuxq
         daSWjTzWgujb8dFE9G96ISYviH4iPVlC+ePMAkU4/3k9McP5BcW6HHLcITeDTz6T4l4N
         qg9V1Sx9FM+ipqVqvPZSnXgzxnSO9Mtyo5mgl2ichHeJXa+FZQSKuKbnFvv+fBbiU+a7
         hz7g==
X-Gm-Message-State: ABuFfohUeyr36mcntjAbZUUwtm+LNHgmQjVwRkqanrIAI/pG/CynMZY0
        SLPhRK6JDZzVxz8xM1cZbBM=
X-Google-Smtp-Source: ACcGV6005ZLs3cpT4bWaU3W0EuWVMNJnY5h+MNuKSv2kxPH7RDUfUG1o2y78SU+RoqY2jWrD6TMjCA==
X-Received: by 2002:a62:ff09:: with SMTP id b9-v6mr36947368pfn.46.1539222609733;
        Wed, 10 Oct 2018 18:50:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id s2-v6sm25429070pgo.90.2018.10.10.18.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:50:09 -0700 (PDT)
Date:   Wed, 10 Oct 2018 18:50:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 6/6] commit-reach: fix first-parent heuristic
Message-ID: <20181011015007.GA40329@aiede.svl.corp.google.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
 <20180906151309.66712-7-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906151309.66712-7-dstolee@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

>  commit-reach.c        | 4 +++-
>  t/t6600-test-reach.sh | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)

I like this testing technique, and the test passes for me.

Except: if I put

	CC = cc -m32
	NO_OPENSSL = YesPlease
	NO_CURL = YesPlease

in config.mak (the first line to force 32-bit pointers, the others
to avoid some dependencies on libs that I don't have 32-bit versions
of), then the test fails for me:

 $ ./t6600-test-reach.sh -v -x -i
 [...]
 expecting success:
         cp commit-graph-full .git/objects/info/commit-graph &&
         run_and_check_trace2 can_all_from_reach_with_flag num_walked 19 input \
                 "test-tool reach can_all_from_reach"

 ++ cp commit-graph-full .git/objects/info/commit-graph
 ++ run_and_check_trace2 can_all_from_reach_with_flag num_walked 19 input 'test-tool reach can_all_from_r
 each'
 ++ CATEGORY=can_all_from_reach_with_flag
 ++ KEY=num_walked
 ++ VALUE=19
 ++ INPUT=input
 ++ COMMAND='test-tool reach can_all_from_reach'
 +++ pwd
 ++ GIT_TR2_PERFORMANCE='/usr/local/google/home/jrn/src/git/t/trash directory.t6600-test-reach/perf-log.t
 xt'
 ++ test-tool reach can_all_from_reach
 can_all_from_reach(X,Y):1
 ++ cat perf-log.txt
 ++ grep 'category:can_all_from_reach_with_flag key:num_walked value:19'
 error: last command exited with $?=1
 not ok 11 - can_all_from_reach:perf
 #
 #               cp commit-graph-full .git/objects/info/commit-graph &&
 #               run_and_check_trace2 can_all_from_reach_with_flag num_walked 19 input \
 #                       "test-tool reach can_all_from_reach"
 #

When I cat perf-log.txt, I see

  ..category:can_all_from_reach_with_flag key:num_walked value:20

instead of the expected 19.

Known issue?

Thanks,
Jonathan
