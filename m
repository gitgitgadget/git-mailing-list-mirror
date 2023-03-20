Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1901C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 23:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCTXV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCTXV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 19:21:57 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CC32E66
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 16:21:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id E39CB16007D;
        Mon, 20 Mar 2023 16:21:41 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2h2lcmrS0cV8; Mon, 20 Mar 2023 16:21:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 2EBCC160082;
        Mon, 20 Mar 2023 16:21:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra.cs.ucla.edu 2EBCC160082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=78364E5A-2AF3-11ED-87FA-8298ECA2D365; t=1679354501;
        bh=GGS1ttSP6NzfksEVlIefAnLBd5JhVYAIiBagux4vzY0=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
         Content-Transfer-Encoding;
        b=eRl1eQaNwkcbhw9bfgwKA9LhV3HT3PA5L9tMLeOws7rrP9qaUYappHNqodm3ZkQzD
         a+quJAnc38hx1WNk75aJT0OBT71+20jHnvb7XlB7OrshLml1vfbHk3Ni86EdhiOnlO
         ZsNXOe1tV7Dv8nGPK8TEzhP+KOXu2IsTqNaXoUPk=
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kHGVRcX9tYXe; Mon, 20 Mar 2023 16:21:41 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 121E516007D;
        Mon, 20 Mar 2023 16:21:41 -0700 (PDT)
Message-ID: <f78fd970-cce5-0a38-5ada-94ccb5bce592@cs.ucla.edu>
Date:   Mon, 20 Mar 2023 16:21:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230320230507.3932018-1-gitster@pobox.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <20230320230507.3932018-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, this looks good. As a matter of fact it almost precisely matches 
what I was about to email you. The only significant difference is that 
yours has "#define time(x) git_time(x)" whereas mine had "#define time 
git_time". Since Git never takes the address of 'time' the two macro 
definitions should have equivalent effects when used in Git.
