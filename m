Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF3ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 02:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiIAC2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 22:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiIAC2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 22:28:40 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 19:28:38 PDT
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7BB10B945
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 19:28:37 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id TZtSoUPGLLmeETZtToMfy5; Thu, 01 Sep 2022 03:25:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1661999133; bh=fLPau/eX+87rz79nZK20guOtyYvBNosmuIU66VDplJk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kkoYHWSLy/Wr9VKNuEEjh1s6JPtR750AS1qf+cyiNen5g8EMP//pDj1/dRINyfJLu
         Y4yuFE9Q8EpFmG/nKaVwuHAStCCn0XYOWKwt5+ukUk1cPy16BQ5XErFxp7FMYHPqGO
         r2yIwoKscCjz6vJCqKhl4PtRwpDWvmJrcigrRUNMMpejSaeqdh5UlpWJ+m1csUqRNZ
         p+HhEpGp7f6kqIvgdhqd8OexBk0N3glbKIDfgRAGnFPcKKoAHPAPKgi/qdAVKq+5sm
         qbXpitryMGSkp+gqdVSOmIljfktTDH0zYORkH9T9zAylB273pp8B3fuRVNBwLv4ZKv
         ue6BbxERUlxkA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=M/5elg8s c=1 sm=1 tr=0 ts=6310181d
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=s8AV3YTns38XMBn0O3EA:9 a=QEXdDO2ut3YA:10
 a=iMKwS5WCztSl3EfDOHEb:22
X-AUTH: ramsayjones@:2500
Message-ID: <db2442fb-5b38-9556-39db-ba621bdf2476@ramsayjones.plus.com>
Date:   Thu, 1 Sep 2022 03:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options, allowRemote
 and socketDir
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
 <xmqq7d2ofact.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq7d2ofact.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOqL8Hn7HbHBoZvGXUwtQ25He+w5jd+qJwN4N6Kd1A3kP5YHWlPf3Npn4Jm6bYX3uYuXieD7a4KniiA+DsMuoHY1wAAsaq5seRSMoC51F9s8sFubgHmM
 RKhNghX9AszAqmP0YlaFR8qgDUR+5ENhXL43gWYdKQinQ1czhmpl2q053meBQVmHTb4VgsF1aavNYFj70RLTVSGGVqrvkcfU3cc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/08/2022 21:04, Junio C Hamano wrote:
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
[snip]
>> diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
>> index d9c2605197f..2de54c85e94 100644
>> --- a/fsmonitor-settings.h
>> +++ b/fsmonitor-settings.h
>> @@ -23,12 +23,16 @@ enum fsmonitor_reason {
>>  	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
>>  };
>>  
>> +void fsm_settings__set_allow_remote(struct repository *r);
>> +void fsm_settings__set_socket_dir(struct repository *r);
> 
> Do these two need to be extern?
> 

On 'seen' after building:
  ...
  $ ./static-check.pl >ssc
  $ diff nsc ssc
  3a4
  > bundle-uri.o	- for_all_bundles_in_list
  15d15
  < config.o	- git_config_from_file_with_options
  40a41,43
  > fsmonitor-settings.o	- fsm_settings__get_allow_remote
  > fsmonitor-settings.o	- fsm_settings__get_socket_dir
  > fsmonitor-settings.o	- fsm_settings__set_allow_remote
  44a48
  > fsmonitor-settings.o	- fsm_settings__set_socket_dir
  $ 

.. so probably not. ;-)

ATB,
Ramsay Jones


