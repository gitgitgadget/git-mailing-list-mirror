Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B9E1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeCWWlc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:41:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34269 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752564AbeCWWlP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Mar 2018 18:41:15 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BC9B420C8D;
        Fri, 23 Mar 2018 18:41:14 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 23 Mar 2018 18:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        aaronjgreenberg.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6GdZWcB5Jhg5XJUGaxgvIbYGuGfdR1AkDV2V8Q8QYzw=; b=M9KBP0BC
        veENuDEXFrvofdqP0U10dkTtyaZvUSEIj5rQaM092XaSsR/SW82rqeK15hnX4hRl
        ZM0s6IopuRCVF0Lljdc3m7J6oir9k8TB8TAveH+FfpTt+BIHTLwJxW5jvhZy/kMY
        O5ndxz42wiPH3mTwc8xdHEyqsNoZ85rWJQNqqWfmpEHK/+YmgDBSpOfbPXE8xjPL
        RCYue21tQOIDrcM0q5iWUK1td5u5mt7QjvBOcz64GzFMuWq4L63iHi/h1hFj8yrU
        a0MtNZLLkaDjKStdCtSdoxmOm1tQOQP/I7/BKvFN/wX8kQQ8SSou/Dm9MtGp+ah5
        1pBvTBTGPzHjRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6GdZWcB5Jhg5XJUGaxgvIbYGuGfdR1AkDV2V8Q8QYzw=; b=dZHO7s0O
        5S/hEXowx4op0jTF1ZyphRSdAq1mkCGGl83kDhx9H2rj+3fdsR9EIApcafVbt3iT
        jroqTZ9044n/Rb3zdG5Hm0ebhDXAlv3mPC3+L1IcOpFJduzc+X7kDEJwQMl8OUxX
        9xTezYIPWRgaffX6iDPhHfY+XQd5Ky6Wi2sob7zmcoC9ZOd8HjOZVASYo2aNMwW8
        OoUlA8H5lokS6VPjjzR/7uDl0wo9swtJCSrVuqkZFrnXgvKWE6lqCVZe+kWo2wYo
        0D0ShTnSxq6UwanBFXqACAzJ172Y0ztspQpK4Xtne6GqhHqBNxkOrclAFsqnklyv
        WvV4tOrRp5lWBA==
X-ME-Sender: <xms:ioK1WoFVt3roTaCZYvxz3eCq8SpmSmWqgkRcj6kU6-32D4pev5mLTQ>
Received: from localhost.localdomain (unknown [159.203.64.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72DC924131;
        Fri, 23 Mar 2018 18:41:14 -0400 (EDT)
From:   Aaron Greenberg <p@aaronjgreenberg.com>
To:     peff@peff.net
Cc:     git@matthieu-moy.fr, git@vger.kernel.org, p@aaronjgreenberg.com,
        gitster@pobox.com
Subject: [PATCH v2] branch: implement shortcut to delete last branch
Date:   Fri, 23 Mar 2018 22:40:34 +0000
Message-Id: <1521844835-23956-1-git-send-email-p@aaronjgreenberg.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180323085636.GA24416@sigill.intra.peff.net>
References: <20180323085636.GA24416@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I updated the commit message to include my first email's cover letter
and cleaned up the test.

Copying Junio, since he also had good comments in the conversation you
linked.

I can appreciate Matthieu's points on the use of "-" in destructive
commands. As of this writing, git-merge supports the "-" shorthand,
which while not destructive, is at least _mutative_. Also,
"git branch -d" is not destructive in the same way that "rm -rf" is
destructive since you can recover the branch using the reflog.

One thing to consider is that approval of this patch extends the
implementation of the "-" shorthand in a piecemeal, rather than
consistent, way (implementing it in a consistent way was the goal of
the patch set you mentioned in your previous email.) Is that okay? Or
is it better to pick up the consistent approach where it was left?
