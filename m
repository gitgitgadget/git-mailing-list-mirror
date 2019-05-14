Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7B81F461
	for <e@80x24.org>; Tue, 14 May 2019 23:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfENXLL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 19:11:11 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:31149 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfENXLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 19:11:10 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QgZghTJMqp7QXQgZghYBqn; Wed, 15 May 2019 00:11:09 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=kviXuzpPAAAA:8 a=D6MqCBOtqYAtU9Hh2O0A:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=qrIFiuKZe2vaD64auk6j:22
Subject: Re: How to exchange rerere/redo resolutions?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
 <871s17xk79.fsf@evledraar.gmail.com>
 <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
 <d139d79a-f35a-e00c-3790-104146b066c7@iee.org>
 <87mujpwiod.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <acad0bcf-e124-156d-569e-21024b7617a7@iee.org>
Date:   Wed, 15 May 2019 00:11:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87mujpwiod.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFQq7NfIrAbuFaHOheFZW8sv2FJibtlxk8caZD2qk6Ic8dYC6+FY2RA727hkqoEFTfmnF/gzR5bS3ldzr9egYi+pFwYMuZwDGjc/0U1LtSSvKuoeT48+
 EthS1MFbtB4LacNz2vmvwNkEcZ9xPFnTmx7EuANkFYMXTKACqmvoAQa+os9w9E9KMpDqQ2fLdcxjBPEFF7/jicLmGFupfR58A3z9/mSoY/Mk68u/rCdyJcbi
 aECmmQ98gHc5C7kjcR7Rjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On 14/05/2019 09:21, Ævar Arnfjörð Bjarmason wrote:
> On Tue, May 14 2019, Philip Oakley wrote:
>
>> Hi All,
>>
>> On 10/05/2019 15:59, Philip Oakley wrote:
>>>> You can publish your merged branch somewhere, and others can use
>>>> contrib/rerere-train.sh to learn from the resolution.
>>>>
>>>> Supposedly, I've never actually used it...
>> Does the contrib/rerere-train.sh actually work? I'm reading the code
>> to ensure I understand what rerere/redo is doing, and in the training
>> it tries to detect MERGE_RR via L87
>>
>>      if test -s "$GIT_DIR/MERGE_RR"
>>
>> It's not clear if that is an internal implementation detail, or a
>> mistaken use of a historic path name. Can anyone enlighten me?
> Historic? No, this is path.c now on master:
Hmm, I'd now agree it's not a mistake, but the implementation detail is 
historic. I've now found [1,2,3,4] from before I knew of Git! And it's 
not mentioned in any of the documentation.
>
>      path.c:1454:REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
>
> Internal, sure. We don't document it so it could change in theory, but
> then we'd probably change rerere-train.sh along with it...
Hopefully it'll be integrated into rerere/redo before that ;-), along 
with a bit more documentation on the capability for those who arrived 
late to the party. The use of this implementation detail came up 
yesterday in [5].
>>> The tricky part is when the patch series doesn't apply so the
>>> conflict isn't yet on any branch..
>> When copying patches across to Git for Windows, the conflict
>> resolution can be tricky.
--
Philip

[1] git-rerere: reuse recorded resolve, 29 Jan 2006, 
https://public-inbox.org/git/7v4q3no0v7.fsf@assigned-by-dhcp.cox.net/
[2] StGIT and rerere, 26 Oct 2006, 
https://public-inbox.org/git/7vfydbkn64.fsf@assigned-by-dhcp.cox.net/
[3] git-explain, 04 Dec 2006, 
https://public-inbox.org/git/7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net/
[4] Make git-rerere a builtin, 20 Dec 2006, 
https://public-inbox.org/git/Pine.LNX.4.63.0612201738000.19693@wbgn013.biozentrum.uni-wuerzburg.de/ 

[5] merge: add --quit, 14 May 2019 , 
https://public-inbox.org/git/nycvar.QRO.7.76.6.1905141540300.44@tvgsbejvaqbjf.bet/
