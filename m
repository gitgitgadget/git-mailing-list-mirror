Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2376520A40
	for <e@80x24.org>; Thu, 23 Nov 2017 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdKWPIO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 23 Nov 2017 10:08:14 -0500
Received: from elephants.elehost.com ([216.66.27.132]:62900 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdKWPIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 10:08:13 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea ([70.25.22.42])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vANF886I048509
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Nov 2017 10:08:09 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <techtonik@gmail.com>
Cc:     <gitster@pobox.com>, <git@vger.kernel.org>,
        <igor.d.djordjevic@gmail.com>
References: <201711231458.vANEwUMK048049@elephants.elehost.com>
In-Reply-To: <201711231458.vANEwUMK048049@elephants.elehost.com>
Subject: RE: Re: Unify annotated and non-annotated tags
Date:   Thu, 23 Nov 2017 10:08:07 -0500
Message-ID: <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF02p9WCNfRWF/Jv0n0N7hIQTYBZKPfIfsQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-23 02:31 (GMT-05:00) anatoly techtonik wrote
>Subject: Re: Unify annotated and non-annotated tags 
>On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>>
>>> If you would like to mimic output of "git show-ref", repeating
>>> commits for each tag pointing to it and showing full tag name as
>>> well, you could do something like this, for example:
>>>
>>>       for tag in $(git for-each-ref --format="%(refname)" refs/tags)
>>>       do
>>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>>       done
>>>
>>>
>>> Hope that helps a bit.
>>
>> If you use for-each-ref's --format option, you could do something
>> like (pardon a long line):
>>
>> git for-each-ref --format='%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectname)%(end) %(refname)' refs/tags
>>
>> without any loop, I would think.
>Thanks. That helps.
>So my proposal is to get rid of non-annotated tags, so to get all
>tags with commits that they point to, one would use:
>git for-each-ref --format='%(*objectname) %(refname)' refs/tags>
>For so-called non-annotated tags just leave the message empty.
>I don't see why anyone would need non-annotated tags though.

I have seen non-annotated tags used in automations (not necessarily well written ones) that create tags as a record of automation activity. I am not sure we should be writing off the concept of unannotated tags entirely. This may cause breakage based on existing expectations of how tags work at present. My take is that tags should include whodunnit, even if it's just the version of the automation being used, but I don't always get to have my wishes fulfilled. In essence, whatever behaviour a non-annotated tag has now may need to be emulated in future even if reconciliation happens. An option to preserve empty tag compatibility with pre-2.16 behaviour, perhaps? Sadly, I cannot supply examples of this usage based on a human memory page-fault and NDAs.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



