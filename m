Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C74DC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiD0UpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiD0Uo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:44:58 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF77675
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:41:43 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E7FDA3F4833;
        Wed, 27 Apr 2022 16:41:42 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C9BE93F4814;
        Wed, 27 Apr 2022 16:41:42 -0400 (EDT)
Subject: Re: use core.fsmonitor instead
To:     David Calkins <david.s.calkins@gmail.com>, git@vger.kernel.org
References: <CAMTWFOGU1ojFLE0v6cyyOh3tRRNmT8Nc9aWW=RLS4aHwJ5QDmw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c4397971-5ff5-d339-cfb5-f19993852207@jeffhostetler.com>
Date:   Wed, 27 Apr 2022 16:41:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMTWFOGU1ojFLE0v6cyyOh3tRRNmT8Nc9aWW=RLS4aHwJ5QDmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/22 6:43 PM, David Calkins wrote:
> I installed Git v2.36.0 for Windows (64-bit) and when running commands
> I get the following output.
> 
> hint: core.useBuiltinFSMonitor will be deprecated soon; use
> core.fsmonitor instead
> hint: Disable this message with "git config advice.useCoreFSMonitorConfig false"
> 
> I opened the system Git config file and updated it to have the below.
> 
>   useBuiltinFSMonitor = false
> 
> After this change I no longer get that output.  However, the hint
> indicated that I should "use core.fsmonitor instead".  Is there
> something else I should be doing besides just telling it not to
> useBuildtinFSMonitor?  How do I tell it to "use core.fsmonitor
> instead"?
> 

Yes, the wording of that message could use some work.

Git for Windows 2.34 and 2.35 included an experimental version
of the builtin FSMonitor feature that was centered around
`core.useBuiltinFSMonitor`.  We are in the process of upstreaming
the FSMonitor feature into core Git.  The first half of it is
included in core Git 2.36 and centered around the `core.fsmonitor`
config variable instead of the former config variable.  Git for Windows
2.36 recognizes both config variables, but warns that the former
is deprecated.

Setting
	git config core.fsmonitor true

will quiet the warning.

We are phasing out the old config variable as soon as we can retire
the "experimental" label from the feature in GFW, but felt that we
could not just delete it and switch because Windows users sometimes
have more than one version of Git installed.  For example, VS
ships with a hidden version that may be ahead or behind the version
you have installed explicitly in Program Files.

If you know that you only have one version of Git installed, you
can unset the old config value.  But if you have more than one,
leave both set to true.

Sorry for the confusion.
Jeff
