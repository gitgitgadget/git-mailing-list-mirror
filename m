Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E9B1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeGTUmy (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:42:54 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41609 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeGTUmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:42:54 -0400
Received: by mail-qt0-f169.google.com with SMTP id e19-v6so11328873qtp.8
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3E3iimU/1qMsKSS+o/jc0b3Rc1f2V8ZGRew8WiCy2rc=;
        b=X7vcfo8gZnoww+onhT+PkflBVFi/XM8Zzw0gVankx6mQNvCpjv5OJQmgnrzMZ7uuNe
         dNDQrqvr5bTmNbcXv4cNeTlmRWO7jRhJSXN3n5e8AR2xixyIgxVQdifFc84bsBxogklT
         NqnBpEImwCBgQEm+lHOgTTHUl09nnzE+gnS74sAey8QuCI5okbKUFWpqPjJ/WKr3sIjC
         TQlairs1c7fXcSAhbirodk9B9Dkl6TAAEXskJ86WB7CFneFI6MUfKvzokWgaZ2BknunB
         1Wmtcf/06NV3Sx50ceaaGPz69S0qZkhyXT5HVFCt5s86rR+FTc9t6ZBQAQxCls7QCJLL
         JDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3E3iimU/1qMsKSS+o/jc0b3Rc1f2V8ZGRew8WiCy2rc=;
        b=AVfTfnSvvps7YWE496ByGJ6gWKvw1adEQp21FIMKLLr1wZmOulcUigi9PATkZbht+Q
         P9ZL/aq3y7SzgMwVQAJfF0rmy0QXbNeAYqN6KCnsWP4jtmHJD67H6uwZpdEEt8y+fWWe
         i9BMzOIaaumPV/fmm+yMhzUfnraRUjHYYCtrbfHvPptmo3Z4/BOh9pAw3qwqEIfivL47
         l21pgsyBgrfDkkO9OI0m8K1K3n1SVmKho6Tl37f5xhCVrGoxb/4OXe8kxL/b/XOlHcTi
         VSgRDXZn77hR+biDOGVsfEsRcEwvHibR4aWRD61ng5kUVZi8L6+ggQjsmk90bUqC4cZF
         mKRw==
X-Gm-Message-State: AOUpUlEGi/PateNSH2CqYy2zLhvzrc6+H4MYpjEpLC/ppoF3SjDsM7rt
        izu6mdX7UneIve6Qknmgaj8=
X-Google-Smtp-Source: AAOMgpdXbXilYEmNg1i5D6QHmAnvco7JLk3CmiXGQjKJnCpm38JI090Wo6tQKOYlHa1PEzbkkRcOGg==
X-Received: by 2002:ac8:18c4:: with SMTP id o4-v6mr3155355qtk.95.1532116388732;
        Fri, 20 Jul 2018 12:53:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id c9-v6sm2260881qtc.34.2018.07.20.12.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 12:53:07 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Subject: [BUG] merge-recursive overly aggressive when skipping updating the
 working tree
Message-ID: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
Date:   Fri, 20 Jul 2018 15:53:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we were attempting to migrate to 2.18 some of our internal functional 
tests failed.  The tests that failed were testing merge and cherry-pick 
when there was a merge conflict. Our tests run with sparse-checkout 
enabled which is what exposed the bug.

What is happening is that in merge_recursive, the skip-worktree bit is 
cleared on the cache entry but then the working directory isn't updated. 
  The end result is that git reports that the merged file has actually 
been deleted.

We've identified the patch that introduced the regression as:

commit 1de70dbd1ada0069d1b6cd6345323906cc9a9ed3
Author: Elijah Newren <newren@gmail.com>
Date:   Thu Apr 19 10:58:23 2018 -0700

     merge-recursive: fix check for skipability of working tree updates

     The can-working-tree-updates-be-skipped check has had a long and 
blemished
     history.  The update can be skipped iff:
       a) The merge is clean
       b) The merge matches what was in HEAD (content, mode, pathname)
       c) The target path is usable (i.e. not involved in D/F conflict)


I've written a test that can be used to reproduce the issue:


diff --git a/t/t3507-cherry-pick-conflict.sh 
b/t/t3507-cherry-pick-conflict.sh
index 7c5ad08626..de0bdc8634 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -392,4 +392,17 @@ test_expect_success 'commit --amend -s places the 
sign-off at the right place' '

         test_cmp expect actual
  '

+test_expect_success 'failed cherry-pick with sparse-checkout' '
+       pristine_detach initial &&
+       git config core.sparseCheckout true &&
+       echo /unrelated >.git/info/sparse-checkout &&
+       git read-tree --reset -u HEAD &&
+       test_must_fail git cherry-pick -Xours picked>actual &&
+       test_i18ngrep ! "Changes not staged for commit:" actual &&
+       echo "/*" >.git/info/sparse-checkout &&
+       git read-tree --reset -u HEAD &&
+       git config core.sparseCheckout false &&
+       rm .git/info/sparse-checkout
+'
+
  test_done

Thanks,

Ben
