Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77270C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 15:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiCMPDn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 13 Mar 2022 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiCMPDl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 11:03:41 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C058812
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 08:02:33 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22DF2ToC023036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 13 Mar 2022 11:02:30 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Sean Allred'" <allred.sean@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        <sallred@epic.com>, <grmason@epic.com>, <sconrad@epic.com>
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g> <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com> <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
In-Reply-To: <87v8whap0b.fsf@gmail.com>
Subject: RE: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 11:02:24 -0400
Organization: Nexbridge Inc.
Message-ID: <01f301d836eb$5c7a6810$156f3830$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDHpNtgb5IcYOGFILwDPZIseKDDCgE3FbtSAfu2vTkCYUxZpQI7aYtuAn9FDKaujBSzoA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 13, 2022 10:41 AM, Sean Allred wrote:
><rsbecker@nexbridge.com> writes:
>> (I am a little nervous about this advice, hoping others will chime in
>> and correct anything wrong here)
>>
>> While this will change the commit hashes, AFAIK, the other metadata is
>> preserved, including date, author, and committer. Set up the specific
>> keys/settings in ssh-agent and the user.signingKey value, then:
>>
>> git filter-branch --commit-filter 'git commit-tree -S "$@";'
>> <FROM-COMMIT>..<TO-COMMIT>
>>
>> Others might have a better way of doing this or may tell me this will
>> not work. Test this before you do it. I have not done this operation
>> before. You do need to start from the oldest commit going forward
>> otherwise I think that filter-branch will (should!) invalidate child
>> commits. I suspect this is going to be a rather lengthy script to build and run.
>
>Given the size of our history (several orders of magnitude larger than linux.git),
>using git-filter-branch after the fact is certainly not ideal.  The replay already takes
>a week to run (we're IO-bound).  We'd rather want to extend git-fast-import to
>allow signing commits instead
>-- which comes back to our shared 'nervousness' about this approach in
>general: I don't know that Git should endorse this as a standard option.
>
>But yes -- hoping others can chime in with more thoughts :-)

I have another reluctant suggestion, but it depends on your industry, regulations, and other factors. In some sectors, there is a requirement to keep only some period of time worth of history. In fact, in some settings, keeping user identifying information beyond, say 7 years, actually is problematic. Pruning your history may be not only an option but required. An alternative is to use filter-branch to essentially tokenize the identities of past authors and keep those in a electronic vault somewhere. I have customers who are interpreting GDPR-like rules just such as situation, where employees gone 7 years ago and cannot be retained, by name, in the repos. I am not personally happy about that, because my own repo-OCD demands that I know exactly who did what until the end of time, but according to them, it actually violates the local regulations. I'm sure you have had conversations with lawyers, yes? ☹

