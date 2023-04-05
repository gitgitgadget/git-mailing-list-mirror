Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C6C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 10:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjDEKfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDEKfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 06:35:50 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 03:35:48 PDT
Received: from mail.zombino.com (c2.zombino.com [65.108.93.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618C40F7
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 03:35:48 -0700 (PDT)
Received: from [10.168.4.122] (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id B54193E9D7
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:28:11 +0000 (UTC)
Message-ID: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
Date:   Wed, 5 Apr 2023 12:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Adam Majer <adamm@zombino.com>
Subject: git clone of empty repositories doesn't preserve hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I've noticed while adding support for sha256 repositories for Gitea that,

git init --bare --object-format=sha256 a
git clone a b

Then the repository b is initialized as default hash, so sha1. It seems 
that receive-pack will list the null OID in the header if there are no 
refs available, but the upload-pack doesn't list anything and hence the 
header with capabilities and the hash function is missing

git receive-pack a
git upload-pack a

What is the right approach here? Could upload-pack send a NULL OID 
followed by header info that is then used by clone?

There is a workaround to specify the hash via GIT_DEFAULT_HASH. Not 
ideal though.

Thanks,
Adam

