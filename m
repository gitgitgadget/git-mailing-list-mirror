Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2AC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 15:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiCKPC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiCKPCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 10:02:25 -0500
X-Greylist: delayed 185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 07:01:21 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E31A41C4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 07:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1647010693;
    s=strato-dkim-0002; d=uhdejc.com;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=XY3u4Bo38lTax5NcKiWOZXtyJ0SetTqOKfoqI8zyuRg=;
    b=XoDMTkSX/9TGO/uVkyQYrBPJF5XxY6Hr2vJTnoPXExi46Ce0hkG0inELD2P560GKvk
    tsVO8YMiF6dpAnu0bBuxyNGo/2kFwqwGMuHwQVQwy1QsFdjANfW9UdIig9HmhCm2mU99
    Chv87jnd9k6THKS9+pgVY0kKUCgrWquR72bie+9M+wuozaDlio3CC7DXcfKO8vACtISM
    Aw5/Jfe5w2mfIe9wmvdZVrSPJ/raduAM4Tojwb/K2fXWSPeaK1fM9X8J+4ckjdX6i/uA
    VTFRAeXwhg5R0w6C0mz00igq5K+GBqxHHysxrV5ZwcCtd7UuNqGeJewEGobflWZPGF2F
    MzdA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":Jm0KVVWgf/qsp6yYkPuIAWpZc5/7d/LUhoNVUVqyWOFyRWTQm1L2tCey"
X-RZG-CLASS-ID: mo00
Received: from [10.13.37.13]
    by smtp.strato.com (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id e5f035y2BEwDAN9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <git@vger.kernel.org>;
    Fri, 11 Mar 2022 15:58:13 +0100 (CET)
Message-ID: <9c494301-3c52-c953-95ab-48675634ada7@UhdeJc.com>
Date:   Fri, 11 Mar 2022 15:58:13 +0100
MIME-Version: 1.0
User-Agent: Why are you interested in my client, Sir?
From:   Jan Christoph Uhde <Jan@UhdeJc.com>
Subject: `git rebase -i --rebase-merges` formatting
To:     git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

for the following commits:

``` git log
*   4fd94fd  (HEAD -> master) 6 hours ago Jan Christoph Uhde Merge branch 'b_two'
|\
| * cc75466  6 hours ago Jan Christoph Uhde b_two
|/
*   9ad8a2b  6 hours ago Jan Christoph Uhde Merge branch 'b_one'
|\
| * b23658f  (b_one) 6 hours ago Jan Christoph Uhde one
|/
* a9d65bc  6 hours ago Jan Christoph Uhde initial commit
```

I get a this merge script when rebasing onto the initial commit.

``` actual merge script
   1 label onto
   2
   3 # Branch b-one
   4 reset onto
   5 pick b23658f one
   6 label b-one
   7
   8 # Branch b-two
   9 reset onto
  10 merge -C 9ad8a2b b-one # Merge branch 'b_one'
  11 label branch-point
  12 pick cc75466 b_two
  13 label b-two
  14
  15 reset branch-point # Merge branch 'b_one'
  16 merge -C 4fd94fd b-two # Merge branch 'b_two'
  17
  18 # Rebase a9d65bc..4fd94fd onto a9d65bc (11 commands)
  19 #
```

I think it should be more similar to this:


``` suggested merge script
   1 label onto
   2 reset onto #Could imo go but probably avoids special cases
   3
   4 # Branch b-one
   5 pick b23658f one
   6 label b-one
   7 reset onto
   8 merge -C 9ad8a2b b-one # Merge branch 'b_one'
   9 label branch-point
  10
  11 # Branch b-two
  12 pick cc75466 b_two
  13 label b-two
  14 reset branch-point # Merge branch 'b_one'
  15 merge -C 4fd94fd b-two # Merge branch 'b_two'
  16 # add `label branch-point-1` here to avoid special cases?!
  17
  18 # Rebase a9d65bc..4fd94fd onto a9d65bc (11 commands)
  19 #
```


Looking at the sequencer.c it might not be worth the invested time
to change the format. If it can not be resolved easily I think
removing the empty lines and the branch-comments would suffice
to reduce the confusion. I think they have been introduced to
help people but here they are a hindrance.

Another unrelated suggestion is to start with `branch-point-0`
instead of `onto` and keep counting up. This would make the
edit-distances smaller when you fiddle with the first commits.

Regards

Jan


