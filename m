Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D65C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhLQQOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:14:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39601 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235959AbhLQQOL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Dec 2021 11:14:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 916FA5C0174;
        Fri, 17 Dec 2021 11:14:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 17 Dec 2021 11:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=5udqMt16DRZ4s
        kB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=wsj7HdPcpTA804ctDnR7jBMr9mPr8
        eh+JdwmWykE6zbzlCvAvdg/5pZiIrQ9qmp+typeyFH//vQUS/A9rvB+XpnacVJ9k
        P0cHV9BA3Gw4av9DIqnHyA4tPBNLI+3UrsaqLJ78fxORNvZBwPbIG+Mgs43+E1XG
        lKrezSZhlJHJrPhMnNg4KnPP3whxjEtEJ3QTDpr8xGQaqZP8h5Rqkmj/ERZm5HjK
        /UpAITqfNc+krZ0Ioy4Yv76KEzHxkvnnp4uZ1r7n3JpdijArVBfaLDUTHJ/oFazL
        RwcQcb7LX0L9+gdeuNRjKDMGY4obJdI+Asbg6PBMmNeIItdnPTQYZE8BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5udqMt16DRZ4skB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=bdpbU940
        a+Ad7Mwxk92npLQBpJrtrQ6HgjscMegCF3+OAQaH7yuSEqmMoive35nLO3MGyESi
        rrS5du4QleNnnQ5FnmTGWO9zdp4wqhIscOFiRLthcAHI2ayF2p8nMuza3qz9Izg7
        vjLghyOfY7BJD5E9z8plCQnUoVUKA6nVdKITlDxr4aHatQTAHnje/e6V1XXz2jlO
        2kVL030pTlRO6atSIaVS8TsqI59ArPggNNOgDAO9sR+KhYanGERGJ31poU0Fwe9g
        7r44885BQvUSWX+S0wnDM3S83QXkcyV2IxUj7WfbeR3hwQgAm8HNuyN/2wbkrrkB
        g2Fdpfahxpj6XA==
X-ME-Sender: <xms:Ure8YUoT7ofACy32No-XvzRw71ooYR0PxEZ-drLqTnw3KERZPikNeg>
    <xme:Ure8YarO4AHdhPKqgpsEwdGveg8vm8sA-b1Q_v419tsslfzDT_iXQoVL-d4M28g2V
    TvuT_XDs94grAOP4wI>
X-ME-Received: <xmr:Ure8YZMSfa7RhWhw706b7lmrYbRggvVt7WbFxx2hpLfHB4MAoRML4O6M1PufvH2nzIRL9p5C1RU6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepifhrvghgucfj
    uhhrrhgvlhhluceoghhrvghgsehhuhhrrhgvlhhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeutedvieffudeggeehudehtddufeeljeehtddttedvteefhfevkeeuudelhedtfeen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgh
    eshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:Ure8Yb5mWIhftdvlGeOHvYDrZmAH5-WMGBTHnXU-eK0Fe_lwoNXaog>
    <xmx:Ure8YT43XjE_h9ywGAO3L0Y1kl_XrHe-O_flB8HLl6r4hBCGPukuog>
    <xmx:Ure8YbjVzdxEAQOGc_JN8SPfOnRQFi-F7DfQSIj7lDTa8goMQ8InXA>
    <xmx:Ure8YQjPNFHzuW1Sol61oDo5_sZSuNz8PLpYe8X-zgFIJAQdmMJojQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 11:14:09 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] docs: add missing colon to Documentation/config/gpg.txt
Date:   Fri, 17 Dec 2021 17:13:58 +0100
Message-Id: <20211217161359.15360-1-greg@hurrell.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
References: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just added a Signed-off-by and reworded the commit message
as suggested by Eric Sunshine. There are other fixes that could
be applied to other places in this documentation (eg. backticks,
capitalization fixes etc) but my intent here was just to fix the
most jarring problem.

