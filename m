Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23434C46467
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 00:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjAEANd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbjAEAM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 19:12:58 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184148CE7
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 16:11:48 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a16so28750422qtw.10
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 16:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLWT1z7eUUnV6qEeV4r7hvBBoXfRHkYwz6XvVE7Lr2o=;
        b=KoPKZhg9H1No31YqDg91LSIFu8CprySkAsAZ2HxAELRlNHlbW4w4KTbQAjtcSsxlY3
         1u0GFtPZhDJOh+ffq4gLhrQLLFc4Wl4G1gDmmgKtyaFAY1VzaE/xsV61Isg9Q8tzebP1
         EDqkvhzI1l6lGEY1MXAoijvHpv7V5yPSn5FG9OWRJmK+Gtm9QDKM+8w1eswPAsuxgkGY
         qeUo6a2D5c7fhHg7H6qA5ahP+dnGrbSBxpu6Tei4vM6jchkPQSv0pxc46PHKMgPCLVxw
         WkK4WnsNLGZlClxtuorhe0BatesX1vLXsKQsC9toU4AMco+Xt2mlA5LulwZWK4a5RDZb
         7xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLWT1z7eUUnV6qEeV4r7hvBBoXfRHkYwz6XvVE7Lr2o=;
        b=5ysvPCCBsgxaY1+G0IZVEAdsalIJjlv7D7E6e8FNDRl6cDKpWnlVPiOr9f4lN5rg5A
         4AdH5GAd/mi+X9qXrBwrhbDMSnP0Z9JjynGD41nQPFtaEwdKmxXnXF5A2U6sOBjwGTeH
         lVjZhlLT3P6bgaaJ8zUEJM2xi4avLTHqwXrXQIJbWouVtb5hVSc1wpGOkrsrOCi0uHQC
         jF6f6OXTJNgN3C+fFpzKfH438PB1nqQQteXiOnLe9wLLhiiPBeeW4lTlJTilNbrF/Vtk
         8xx/JJkT4ymJGz/unT4TM+VJgyoWp7uz7Y7lJQ2f9DzI1IoEHFlKFZkKNY1M+W7TgXmg
         iqiQ==
X-Gm-Message-State: AFqh2kphe7FGaB5HDmv+EexDfPln9zIbI8UOz2dDhGBZ8EbEiElzxdcK
        nUnfIYQA4Nnp7lTqzAaUD6N9J4+94BI=
X-Google-Smtp-Source: AMrXdXua/PxEu3vyAemrjTNMLFopfv1bEesSlaYRY8e6w6KWhyOMro9bd2rI09K2m3CeT8w0tEV3Qg==
X-Received: by 2002:ac8:7770:0:b0:3a5:4f6f:da0b with SMTP id h16-20020ac87770000000b003a54f6fda0bmr72630513qtu.29.1672877504005;
        Wed, 04 Jan 2023 16:11:44 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003a6947863e1sm20553839qtt.11.2023.01.04.16.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 16:11:43 -0800 (PST)
Subject: Re: bug?: ORIG_HEAD incorrect after reset during git-rebase -i
To:     Erik Cervin Edin <erik@cervined.in>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
 <e6adaad6-f6ee-57d3-dc8f-d14a760c57c2@talktalk.net>
 <CA+JQ7M9G8HqqieRAK3C6csMM93PHOmaMd8GMPrDEfogWG0bteA@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ef389a14-8513-4650-21e4-89421a24df2d@gmail.com>
Date:   Wed, 4 Jan 2023 19:11:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CA+JQ7M9G8HqqieRAK3C6csMM93PHOmaMd8GMPrDEfogWG0bteA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip and Erik,

Le 2021-12-16 à 11:44, Erik Cervin Edin a écrit :
> Hi Phillip,
> 
> Yes, I know.
> It's just that I was under the impression ORIG_HEAD was to be reverted
> to .git/rebase-merge/orig-head at the finish of the rebase.
> Personally, it's the behavior I would expect.
> 
> Thanks for the tips.

I just hit the same bug (I think it qualifies as one). In fact git-rebase(1) explicitely mentions
that ORIG_HEAD is set to the branch tip before the rebase starts:

$ git grep -C2 ORIG_HEAD Documentation/git-rebase.txt
Documentation/git-rebase.txt-36-The current branch is reset to `<upstream>` or `<newbase>` if the
Documentation/git-rebase.txt-37-`--onto` option was supplied.  This has the exact same effect as
Documentation/git-rebase.txt:38:50:`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
Documentation/git-rebase.txt-39-to point at the tip of the branch before the reset.
Documentation/git-rebase.txt-40-

Here is my runnable reproducer. It is slightly more complicated than Erik's, since
I split the second commit in two, but this is not necessary to trigger the bug; just
running 'git reset HEAD^' as Erik wrote is enough.

```bash
#!/bin/bash
rm -rf repro
git init repro
(
cd repro
# Create 3 commits
cat << EOF >test
hello
every
one
EOF
git add test
git commit -m initial
cat << EOF >test
hello

add new lines

every

and also here

one
EOF
git commit -am second
cat << EOF >test
hello

add new lines

every

and also here

one

still more changes
EOF
git commit -am third
# Rebase to split the second commit
GIT_SEQUENCE_EDITOR="sed -ie '1 s/^p /e /'" git rebase -i HEAD~2
git reset HEAD^
cat << EOF >test
hello

add new lines

every
one
EOF
git ci -am "second 1/2"
cat <<EOF >test
hello

add new lines

every

and also here

one
EOF
git ci -am "second 2/2"
# Finish rebase and demonstrate bug
git rebase --continue
echo ---
echo "@{1} is :"
git log -1 @{1}
echo "ORIG_HEAD is :"
git log -1 ORIG_HEAD

)
```

Cheers,

Philippe.
