Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E079C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 21:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiCLVOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 16:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiCLVOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 16:14:40 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20734BA7
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 13:13:33 -0800 (PST)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22CLDV4N074938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Mar 2022 16:13:31 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Sean MacLennan'" <seanm@seanm.ca>, <git@vger.kernel.org>
References: <20220312130712.6d9d2d00@zonker.seanm.ca>
In-Reply-To: <20220312130712.6d9d2d00@zonker.seanm.ca>
Subject: RE: Request: a way to ignore .gitattributes
Date:   Sat, 12 Mar 2022 16:13:26 -0500
Organization: Nexbridge Inc.
Message-ID: <01ab01d83656$071d7cd0$15587670$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJvh+7/pX89uEmw8XPU2NNWw47BgauNmvHg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 12, 2022 1:07 PM, Sean MacLennan wrote:
>We have a git repo that is a mirror of an svn repo. The tools create a huge
>.gitattribute file that is about 83,000 entries. Almost all are of the
form: <path> -
>text
>
>This file kills git grep. A grep that takes <1s without the file takes
almost 2 minutes
>with the file. So git grep it unusable.
>
>My current solution is to rename the file:
>
>-#define GITATTRIBUTES_FILE ".gitattributes"
>+#define GITATTRIBUTES_FILE ".gitattributes-no"
>
>But I would like a cleaner solution so I don't have to maintain my own git.
>
>My request is more for what would be the best gitish way to solve this; I
am willing
>to do the actual patch.
>
>This needs to be something in the local config and not global. My current
thoughts
>are:
>
>1) A way to override the default name (much like I do now):
>   gitattributesfile = .gitattributes-no
>
>2) A flag variable:
>   gitattributes = ignore
>        or
>   ignoreattributes = true
>
>I personally like 1) because it would also work for the case where you want
to
>override a bad .gitattributes file (that you have no control
>over) with a good .gitattributes file. I just think it would be more
generally useful.
>
>But I would like to pick a solution that is most likely to get accepted.

These may seem a little off the wall, but:
1. Could you use a clean/smudge approach to mess with your bad
.gitattributes file before it gets put down on disk? I realize that
registering the filter might not be possible given that you need to muck
with .gitattributes to do it, but if you have any control at all and can get
the filter in, perhaps that might be a way to clean up the bad
.gitattributes file.
2. What about a post-checkout hook that fixes .gitattributes and then does
an update-index --assume-unchanged on it. This is under the assumption that
you will never change .gitattributes in your clone.

My $0.02,
--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



