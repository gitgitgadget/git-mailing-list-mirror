Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3532120899
	for <e@80x24.org>; Wed, 23 Aug 2017 18:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbdHWSTS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 14:19:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37247 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdHWSTR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 14:19:17 -0400
Received: by mail-pg0-f67.google.com with SMTP id w27so219373pge.4
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZpmUXEDffhMJaLzJyOBnPg1X2LuhDEzz6WHVJvPnj9I=;
        b=QaHPjfFmhz1tZCOdS0adBHKz0p4ix4gUz6CbcS3pX58SkTQV+3vbXWLfN/7iir4KpE
         f7oiA6UiKTkP23j2Lub8mU2QHXU8WzOaCcwg2bZgV5th29FGDcTEfuwR8FoLOBchgckD
         vOSj/rFkyYsYMaS3lE+0CKVwDXI23EKU24QRF+2Hqw39GwKeAySvxai8hGRNRL1kkRge
         4upPQj38a+5JUh6uP5/t9IKdmiFnqvUvB6ZsDsFmYl9UUP7evws1+4/4pqaGpz53Lhhb
         WnXZ895+StbEZCBHTmK6GJKCtAu3tR+ol0aHZHPeobYIc43li60B6uxVZBXRQ3THWZCG
         LT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZpmUXEDffhMJaLzJyOBnPg1X2LuhDEzz6WHVJvPnj9I=;
        b=HypDRDmMyjsYljjEeIecUshrqTcUS4rvWvrX0TX/mqSWL2BwgtNSPYqhB38yUPTr/w
         0aft9m01DSQZoXnS31lGXQaRvq36Bt10l4lM5y/H/cwwxLGPe196KqFRrj3JHP/CC38y
         HZE6RotEdG5CO5ugbuAthSzb50S4iErD+s/5ljw2YrwnLaw+NFfycWVqWnL+f3hLzDhy
         IhguYIZ6MuNi0ADd8w30PKJQW3t1Qy5JCb8zLa05sPOLPPufg3k3Zlh1pwNe8BT7XFWg
         ZUaWDooBnxIXpv2l1oZXnZoEc5rD4/Zi6o/GLVOEjt4iBXfNDSy/ks4aRjrvzOFJ8c1A
         kj1A==
X-Gm-Message-State: AHYfb5hiHjjSOF3lD7QuGni0MDjL5gM1Zqc0Q1dTzkZHYqYI30eDiY6J
        eE6fEOinNQAt5g==
X-Received: by 10.99.47.1 with SMTP id v1mr3570913pgv.306.1503512357238;
        Wed, 23 Aug 2017 11:19:17 -0700 (PDT)
Received: from localhost.localdomain ([27.63.165.170])
        by smtp.gmail.com with ESMTPSA id 74sm5007812pfk.58.2017.08.23.11.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 11:19:16 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v2 0/4] submodule: Incremental rewrite of git-submodules
Date:   Wed, 23 Aug 2017 23:45:02 +0530
Message-Id: <20170823181506.8557-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
References: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:

* In the function get_submodule_displaypath(), I tried avoiding the extra
  memory allocation, but it rather invoked test 5 from
  t7406-submodule-update. The details of the test failiure can be seen
  in the build report as well. (Build #162)
  This failure occured as even though the function relative_path(),
  returned the value correctly, NULL was stored in sb.buf
  Hence currently the function is still using the old way of
  allocating extra memory and releasing the strbuf first, and return
  the extra allocated memory.
* It was observed that strbuf_reset was being done just before the strbuf
  was being reused. It made more sense to reset them just after their use 
  instead. Hence, these function calls of strbuf_reset() were moved
  accordingly.
  (The above change was limited to the function init_submodule() only,
   since already there was a deletion of one such funciton call,
   and IMO, it won't be suitable to carryout the operation for the complete
   file in the same commit.)
* The function name for_each_submodule_list() was changed to
  for_each_submodule().
* Instead of passing the complete list to the function for_each_submodule(),
  only its pointer is passed to avoid the compiler from making copy of the
  list, and to make the code more efficient.
* The function names of print_name_rev() and get_name_rev() were changed
  to get_rev_name() and compute_rev_name(). Now the function get_rev_name()
  acts as the front end of the subcommand and calls the function
  compute_rev_name() for generating and receiving the value of revision name.
* The above change was also accompanied by the change in names of some
  variables used internally in the functions.

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/week-14-1

And the build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: week-14-1
Build #163

Prathamesh Chavan (4):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_submodule()
  submodule: port set_name_rev() from shell to C
  submodule: port submodule subcommand 'status' from shell to C

 builtin/submodule--helper.c | 294 ++++++++++++++++++++++++++++++++++++++++----
 git-submodule.sh            |  61 +--------
 2 files changed, 273 insertions(+), 82 deletions(-)

-- 
2.13.0

