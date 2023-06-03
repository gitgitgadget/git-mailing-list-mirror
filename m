Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C289FC77B7A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 06:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjFCGDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jun 2023 02:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCGDH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2023 02:03:07 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8EE55
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1685772171; x=1686376971; i=l.s.r@web.de;
 bh=kPDvWdCEPEP5cqU/wZsUSe68yChTL8HVuosF+gCC1RI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NjCl5G4yPydUaZVbeboqDao4IlbEna9JxyUug106VNsdWveSbVKmSRHXZMFjOapJqnKU5pg
 zVRfBvkllZtf4KXJskJcNrOzM5ivBKTMClRNW4cQYD25FXL36V52llsZomyqT7C7r57Rkph5P
 Ozyiy2YVFHZZcrEjwUp1rHoq1jYInxeXNc8EZi9OqM2Sy2RhVRzI8pkjLw9VjI18c1Xxtun2h
 hvDKveyzu5Z4pMdyPQEGmoLtpxXouaAGuQlzFMSJyyEQgT8Q7+Uggl32zzZ8P2w89NH/wOG3S
 qoCrYUE+BMUKxIpqMX1TzBbHsO/4Z1Jj0HFl6gUAUcLlR88gJs6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.134]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaRt-1qKFZA38yx-00tu0d; Sat, 03
 Jun 2023 08:02:51 +0200
Message-ID: <21d3f105-ed32-e397-a1fe-53344894bd44@web.de>
Date:   Sat, 3 Jun 2023 08:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] Fix memory leak in get_reachable_subset
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>
References: <20230603002819.1122129-1-mh@glandium.org>
 <xmqqedmt7167.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqedmt7167.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sdBtfQxiphvDeGAM2ahodK2ImxuL8DKg9M1L5rEx8+CR0asxbR4
 OIozjPqGY9QB3lXcMubdklkBRikaOHJLRtZa5MKhmGvbQAOqEyRs4UHZjYWa/mVnAQpF7lD
 2GvnLvAHc+E7WHs8olScDivIZppKJj+rdbHJULuuVFx+stUAwyOxWJ5a3vuvvkn2AjaKZE8
 8dZkdPdXnlVeUpJHOgr6w==
UI-OutboundReport: notjunk:1;M01:P0:wo7HlZ3hD/g=;Te75WKzBBiBrAjMwTgArnEh28Sh
 aSEd9CNdEEkn1LlCXKpLBmNK2y8ZgvfsERA8L7MTEVhlyLDAmBa5Mqt+OPwVT36OvmJuhfM0X
 Dm+57WxTJq+aG10I2H6tJ3JNTAwiBDvpjq3ZcTrOJI0FnIFSHeA3TsckcgWIeG1UYuRuyWWf1
 NFJkqPb3oLGNNE291uDyx3Ls768T7EEjdgal6pDplsUQlUuPIBLQUoU7N9cBKuR7TazenpXlM
 0KISTdK9YesDGp70tyCHLZPAeYrpyOgZVXmXdONtdM1ysJq5k59ISClkAHX++3Dibu3Sez32U
 IKVVU6MskQaTqzWC7ZVnVLOpMMVXpm4sWgheGuAS9a30V2aDyVp9UkuyHBPjQymaInDbwM1Yg
 xC6wcsgrgbqdREqIfNmfWtTCoDwV7xd4e0h7u6A4tL3LesK2JhUAXS7t/bIbZ1sWRLfHMSVnK
 mWFshxMn8abCvTuhfLpry1fziT+4wSj2PfJvxzErpj4HEylBJdW5PFoC0aZoJz1oRDJj7TWL0
 cKWuilHrtxz9alfFxm4XR+Hoi/dUXj4XCbYyyTceplSznTOUspIY+udtFNL718lPiLaNSjFfj
 tty10ZQUEn5aAGmfiy/aNyLjrKnHvEFz4zb69Y+uPcs6gbgV+7V82vvd1ElK8qb1uaS0F7m9M
 YjKHoS2KrE5iu5PjpGMbBCxmRv9h537qzkAsNMVkWDZY6Wjx4WA0hrdUivYXNGpffgcT/I7M4
 sm+Xr+ZtL8wVMZslK6pZ3p7hxX1StsUc2H6BXi7/cRVT1QCOi60HG5azg6jr23pYrYuHUwQdG
 NfG4rq6XXzusS2DTKkh2oZVjJ5atWDVXBsb4LdlTCJ3B4ZGyF8v3Mhh8tiGfz8huf3jw9SAMR
 Ad/WpY4j2W6VKLmYtKGc+1Zg5sanmL9loYbxnErFNcno2kjTRkMqNhlQLgY0DWIM5CbW1JtlM
 25A62zJc3H8uxYHxnFHA0viOUJA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.23 um 04:02 schrieb Junio C Hamano:
> Mike Hommey <mh@glandium.org> writes:
>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>
> As most lines in the affected function seems to come from your
> fcb2c076 (commit-reach: implement get_reachable_subset, 2018-11-02),
> I'll redirect the review of this patch to you.

Stolee reviewed it already when the patch was sent the first time, here:
https://lore.kernel.org/git/20230421234409.1925489-1-mh@glandium.org/T/#u

>
> Thanks.
>
>>  commit-reach.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/commit-reach.c b/commit-reach.c
>> index 70bde8af05..f15d84566b 100644
>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -944,6 +944,8 @@ struct commit_list *get_reachable_subset(struct com=
mit **from, int nr_from,
>>  		}
>>  	}
>>
>> +	clear_prio_queue(&queue);

Makes sense: The loop that dequeues would end before consuming all items
when all "to" commits are found to be reachable.

>> +
>>  	clear_commit_marks_many(nr_to, to, PARENT1);
>>  	clear_commit_marks_many(nr_from, from, PARENT2);

