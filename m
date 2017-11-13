Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3BF1F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 11:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdKMLZM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 06:25:12 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:11105 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbdKMLZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 06:25:12 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id ECrWezOWImITaECrXeEzuW; Mon, 13 Nov 2017 11:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510572311;
        bh=EXxPciWvDtr4jcbY7n7kx8Klo1eFTpcL+SlW6LaXWIE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U0m9t8sytNrHOlLbaR+h5wNFttfuSZ+xBydhy5+HG8QQnsPSPG3XoimNhJ5+8I8Ro
         cxSkhkncMwhWdWXd8pSdEH+gOu6GJd/6QWsCVfGzqIADgRSpP7afgaAsVvTTFXaIZ3
         n2h595qNRulefMVXpdo4Ji6jn7SJ36eSNKZcJ9vw=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=N0pRPbasu0K5IVrryW8A:9 a=Dc0VfDqT_EpIvGl2:21
 a=zTbpL1ce4hDdh3u7:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/9] Add a function to update HEAD after creating a
 commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
 <20171110110949.328-4-phillip.wood@talktalk.net>
 <xmqq7euyf0ap.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <43448e40-1b89-eeb2-086d-c23c804d3fcb@talktalk.net>
Date:   Mon, 13 Nov 2017 11:25:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq7euyf0ap.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFTI+B/UuChXJrNeJNgG3+ndGOWK776YqdwwGwCrdPG5+h9g6siPmc+Bysi7eovEpVQsBVu6CnswzikcjUhJ97tNB+L4YNDD41h4wlLB71JdlWPx7/p8
 Nr3KUveBHh2Tk7ZfkBLFKJ0HebTsrdHa03B5PqySIMmEedYZBjjyORAtP6O3PllUJL1nT+GzcVzIFk/qVCABvoNO4U998kzBlfSeWVPvem0Aj4JpHZSid0t0
 vA98mIw7/DOUt0IvN/FMo2DVAOdefv8MHnCotOwrXbRU5ycqhWjJXujvp97IgRFj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/17 18:36, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Add update_head() based on the code that updates HEAD after committing
>> in builtin/commit.c that can be called by 'git commit' and other
>> commands.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>
>> Notes:
>>     changes since v1:
>>      - rename update_head() to update_head_with_reflog()
> 
> The above proposed log message still calls it with the old name
> though.
> 
Oops, sorry I'll fix that
