Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2354AC433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D099222B4E
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbhAXCmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhAXCmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:42:13 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C54C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:41:32 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 22so9332533qkf.9
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O3RK2q8Q86pCkrvSeIKkpWu6I46EmufWAS1JAQaOKNo=;
        b=fHy1Gm4o0X8XduJJpkSrGgFt71A509B2LHp+jZAK+Q7ZY45qahwXBoo8k8xojZGcKi
         Zfflq08N399lwJNcnSlKjpaMCPH+32dL1NR6T4gKmbm9gUTJFp+ZXAKnhPr2Qiy6VzO1
         s1qAalhhnfizAysKpA5o9xzwCFV/ClbObA97GW0JOcUi+JQdby3TJmhYCO5Gm+9yiifi
         Y/6CBE5ytBMOzeFoPUA5E0gY8cuPZaowaX/ISKoQ0t7QkCKoXkT0Ju50lHdT4Lg1GFjN
         plB63691BnsNGpdTrXvcHU2mIc3SibWMltOONr6yjCHwCxbx4yI7r3fgF0n6LK5u/4PM
         TpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O3RK2q8Q86pCkrvSeIKkpWu6I46EmufWAS1JAQaOKNo=;
        b=Q/XnhW9P/8z7QPfz+abat9fp744ZE64kptISOVshKyHonslJKN0qn2jMYzunKZtDHO
         kf2hyKlH3sUoVJqB8h5EHXbZoDkS+OlBSBYVAXfj+czmNMNielF/NKL4+RWwuqh0e8dG
         Vpcuclzal2om0wcS/Rd/Gssg5hXKSYQ4wlxn8DcLS3m2hw6KhjTqMHIWPGdzY3xZxmQD
         nuCXnCRnGi7TcgIyhqhU35zJCY6NM0PXtB49PuEQPO8XLkhLQS1M+H42pU82XaP26Xzy
         KsZffa6cbuZI4Mlsq8y7u/E+eTmnQXFURnEx+uMdlNu7XbdBXWwHYas9HdJsKMajvt6n
         BAEA==
X-Gm-Message-State: AOAM533haopehE7OVmIGjpxphLfpab136SwNNqshBgHsCb5O1/wLSr0Y
        kcTFjcRN06UTvLYCEMHuXKk=
X-Google-Smtp-Source: ABdhPJwD5KiHZd/yNMCzq7nuQ3LNwlpPXczcFfLbnZQfzAfY/teEw5zlvMwxJc6KkqJfUrvhWyCAWg==
X-Received: by 2002:a37:6206:: with SMTP id w6mr249754qkb.102.1611456091983;
        Sat, 23 Jan 2021 18:41:31 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 22sm2184950qke.123.2021.01.23.18.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 18:41:31 -0800 (PST)
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
 <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com>
Date:   Sat, 23 Jan 2021 21:41:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Le 2021-01-15 à 14:59, Jeff King a écrit :
> On Thu, Jan 14, 2021 at 07:14:34PM -0800, Junio C Hamano wrote:
> 
>> It seems that homebrew suddenly started giving us trouble, like this:
>>
>> https://github.com/git/git/runs/1705953982?check_suite_focus=true#step:3:70
>>
>> Here is my attempt to work it around by blindly following the
>> suggested course of action in the error message, without knowing
>> what I am doing X-<.  I am not a Mac person.
>>
>> What is frustrating is that every time we hit a minor snag like this
>> to break one of the jobs, all other unrelated jobs are also taken
>> down.
> 
> I think that has to do with the grouping in the workflow file (the
> Windows builds, for example, will cancel the _other_ Windows tests if
> they fail, but not the Linux ones).
> 
> So we could split the macos test out. It would probably involve
> duplicating a little bit of the content, but we do something similar for
> the dockerized builds. It might be that there is an option we can set to
> say "keep building the others even if one of these fails", which would
> give us the best of both.

Yes, a quick Google search pointed me to a blog post [1]
that mentions using 'fail-fast: false' in the test matrix so that
one failing job does not automatically cancel the rest of the jobs
in the matrix (the default is 'true') [2].

If we apply that to all four matrices in the workflow file,
(windows-test, vs-test, regular and dockerized), it would be
something like this:

~~~
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index aef6643648..6c31f978bc 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -125,6 +125,7 @@ jobs:
      strategy:
        matrix:
          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+      fail-fast: false
      steps:
      - uses: actions/checkout@v1
      - name: download build artifacts
@@ -229,6 +230,7 @@ jobs:
      strategy:
        matrix:
          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+      fail-fast: false
      steps:
      - uses: actions/checkout@v1
      - name: download git-sdk-64-minimal
@@ -289,6 +291,7 @@ jobs:
            - jobname: GETTEXT_POISON
              cc: gcc
              pool: ubuntu-latest
+        fail-fast: false
      env:
        CC: ${{matrix.vector.cc}}
        jobname: ${{matrix.vector.jobname}}
@@ -315,6 +318,7 @@ jobs:
            image: alpine
          - jobname: Linux32
            image: daald/ubuntu32:xenial
+      fail-fast: false
      env:
        jobname: ${{matrix.vector.jobname}}
      runs-on: ubuntu-latest
~~~

I've CC-ed Dscho regarding if we also want this for the Windows tests,
(I don't see why not) and if we feel it's a good idea I can
send a proper patch.


Cheers,

Philippe.


[1] https://www.edwardthomson.com/blog/github_actions_6_fail_fast_matrix_workflows.html
[2] https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategyfail-fast
