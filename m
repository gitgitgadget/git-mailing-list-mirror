Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E55E1F991
	for <e@80x24.org>; Tue,  8 Aug 2017 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdHHKWZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 06:22:25 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:11763 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdHHKWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 06:22:25 -0400
Received: from [192.168.2.201] ([92.22.15.146])
        by smtp.talktalk.net with SMTP
        id f1eWdMuafiSHaf1eXd0LY3; Tue, 08 Aug 2017 11:22:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1502187744; bh=VFa58WDFdWXHJDOxwVeA9xHcM6kWZBSSzr3T84Uz3QU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kScOy/qgRdESSCsmSF1weRvEO055JJiMCc1zXYnItIeMEPx4FucysnnjOy7Mryvv7
         7/tjWTghbqP/h55wls8UO2690EXUS8k2cVL6ZgZZnHArObON9TerAneD/N6OUGidCS
         ACIHCciA/Bh5dz+k0YUU/YUHjGDayeXyvu0E0J/A=
X-Originating-IP: [92.22.15.146]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=PRKyDR6jJsLBrgZYJ8A23w==:117
 a=PRKyDR6jJsLBrgZYJ8A23w==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=ybZZDoGAAAAA:8 a=zWSdXvz2DD2Q03NDeowA:9
 a=wPa3-hHKdjY40i44:21 a=if-MyVygf5cHKfhx:21 a=QEXdDO2ut3YA:10
 a=SHUmGpGg8TAA:10 a=RfR_gqz1fSpA9VikTjo0:22 a=0RhZnL1DYvcuLYC8JZ5M:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1] am: fix signoff when other trailers are present
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170807102929.25151-1-phillip.wood@talktalk.net>
 <xmqqfud3qndj.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <866e9789-73f7-697d-a68c-c536b0e9b90d@talktalk.net>
Date:   Tue, 8 Aug 2017 11:22:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqfud3qndj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFGu75hyL6klzODAuj/u2JJxc8joWmxQC3ovUhjo/K6PBgYORBWx/Hj4F76jh5NKUAgWygvEGsDQ5E0SGWqbaJbkEmlE4/K+oDiV117ZbKQcURL0qSJJ
 x3dTrgxJ+UOUXVl3bbDysEFg81JxO2JSoVI2pf6KpccZOdHhZTKR3GJz+P1xLFvQs+hewcpTqsMPREf7B0xH/6ZNqvjlF8w/cpZ+9E1iRXKp0oh64/szuVl4
 4QGiBabD3EzWR91wiK3E58AbuUk0ptdMx/CsBzptdPDL0OiUFtXEX4Qhic2GaNTgkQCE+vLoEtjvT0qfGZmNmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/17 18:49, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If there was no 'Signed-off-by:' trailer but another trailer such as
>> 'Reported-by:' then 'git am --signoff' would add a blank line between
>> the existing trailers and the added 'Signed-off-by:' line. e.g.
>>
>>     Rebase accepts '--rerere-autoupdate' as an option but only honors
>>     it if '-m' is also given. Fix it for a non-interactive rebase by
>>     passing on the option to 'git am' and 'git cherry-pick'.
>>
>>     Reported-by: Junio C Hamano <gitster@pobox.com>
>>
>>     Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Fix by using the code provided for this purpose in sequencer.c.
>> Change the tests so that they check the formatting of the
>> 'Signed-off-by:' lines rather than just grepping for them.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> I'm not sure if this should be calling ignore_non_trailer() or not -
>> git commit does but git cherry-pick does not. This follows commit and
>> cherry-pick in ignoring the value of trailer.ifExists for the signoff.
>> I'm a bit surprised they do that - is it correct?
> 
> These built-in "sign-off" machinery long predates the "trailer"
> thing, so I am not surprised if they do not behave the same.  I
> vaguely recall having discussions on this earlier this year, but
> details escape me.  

Ah, that explains it. I did a quick search on public-inbox but didn't
turn up any obvious discussion about --signoff and trailer config. If
that's the behavior people are used to then lets leave it as it is
unless there is a call for it to be changed.

> Asking Jonathan, who did a series that ends at 44dc738a ("sequencer:
> add newline before adding footers", 2017-04-26), and Christian, who
> is the original contirbutor to the "trailer" machinery, for input.
> 

