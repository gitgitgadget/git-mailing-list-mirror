Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F5C3DA7A
	for <git@archiver.kernel.org>; Mon,  2 Jan 2023 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjABQye convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 2 Jan 2023 11:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjABQyb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 11:54:31 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9111081
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 08:54:30 -0800 (PST)
Received: from Mazikeen (ec2-99-79-192-80.ca-central-1.compute.amazonaws.com [99.79.192.80])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 302GsTFU006961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jan 2023 11:54:29 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Zitzmann, Christian'" <Christian.Zitzmann@vitesco.com>,
        <git@vger.kernel.org>
References: <DB5PR02MB100691E6422F5E94228F0E0EC8AF79@DB5PR02MB10069.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB100691E6422F5E94228F0E0EC8AF79@DB5PR02MB10069.eurprd02.prod.outlook.com>
Subject: RE: Parallelism for submodule update 
Date:   Mon, 2 Jan 2023 11:54:24 -0500
Organization: Nexbridge Inc.
Message-ID: <009801d91eca$e1646360$a42d2a20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQI6EBmcUnIBnHgK/rdRgdVApR4RqK3JdHEQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>-----Original Message-----
>From: <Christian.Zitzmann@vitesco.com>
On January 2, 2023 11:45 AM Christian Zitzmann wrote:
>we are using git since many years with also heavily using submodules.
>
>When updating the submodules, only the fetching part is done in parallel (with
>config submodule.fetchjobs or --jobs) but the checkout is done sequentially
>
>What I’ve recognized when cloning with
>- scalar clone --full-clone --recurse-submodules <URL> or
>- git clone --filter=blob:none --also-filter-submodules --recurse-submodules
><URL>
>
>We loose performance, as the fetch of the blobs is done in the sequential
>checkout part, instead of in the parallel part.
>
>Furthermore, the utilization - without partial clone - of network and harddisk is not
>always good, as first the network is utilized (fetch) and then the harddisk
>(checkout)
>
>As the checkout part is local to the submodule (no shared resources to block), it
>would be great if we could move the checkout into the parallelized part.
>E.g. by doing fetch and checkout (with blob fetching) in one step with e.g.
>run_processes_parallel_tr2
>
>I expect that this significantly improves the performance, especially when using
>partial clones.
>
>Do you think this is possible? Do I miss anything in my thoughts?

Since this is a platform-specific request, if it happens, this should be a configuration switch that defaults off. On my platform, the file system itself is fairly fast, but the name service traversals and resolutions (what happens in the name service) is a performance problem. Doing the checkout/switch in parallel would actually be counter-productive in my case. So I would keep it off, but I get that other platforms could benefit.

Regards,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



