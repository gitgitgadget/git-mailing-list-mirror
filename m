Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF1C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 14:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiCMOWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCMOWD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 10:22:03 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487B27B14
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 07:20:52 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22DEKlTG021726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 13 Mar 2022 10:20:48 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Sean Allred'" <allred.sean@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        <sallred@epic.com>, <grmason@epic.com>, <sconrad@epic.com>
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g> <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
In-Reply-To: <87zglu9c82.fsf@gmail.com>
Subject: RE: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 10:20:42 -0400
Organization: Nexbridge Inc.
Message-ID: <01f201d836e5$89247c30$9b6d7490$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDHpNtgb5IcYOGFILwDPZIseKDDCgE3FbtSAfu2vTkCYUxZpa6x3s8A
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 13, 2022 10:01 AM, Sean Allred wrote:
><rsbecker@nexbridge.com> writes:
>> Is there anything we could do around the new signature infrastructure
>> relating to this? I am NOT a fan of SSH keys without passphrases, but
>> what if we could use the coaxing above and map to SSH expiring keys
>> then stitch in signatures (a.k.a. sign the commits) to correspond to
>> the users in the given timeframe - then destroy the private keys to
prevent
>further signing.
>> After that the Name/email becomes somewhat irrelevant from an
>> integrity standpoint.
>
>Is this really possible?  Is it really as straightforward as splicing in
some text into the
>commit message to the effect of 'this commit is signed' along with some
signature
>artifact calculated pre-signing?
>
>Though I'll note I *think* this would only solve the problem for the
committer field
>-- it's my current understanding that a commit can only be signed by one
>signature.  (I have heard of systems that generate a new key that is then
signed by
>multiple signatures, then signing with that new key -- but even if this is
possible, it
>seems pretty involved for such a common workflow.  This level of
coordination
>might not be possible for us -- especially given the merge workflows we've
>needed to create to accommodate our current release process.)

(I am a little nervous about this advice, hoping others will chime in and
correct anything wrong here)

While this will change the commit hashes, AFAIK, the other metadata is
preserved, including date, author, and committer. Set up the specific
keys/settings in ssh-agent and the user.signingKey value, then:

git filter-branch --commit-filter 'git commit-tree -S "$@";'
<FROM-COMMIT>..<TO-COMMIT>

Others might have a better way of doing this or may tell me this will not
work. Test this before you do it. I have not done this operation before. You
do need to start from the oldest commit going forward otherwise I think that
filter-branch will (should!) invalidate child commits. I suspect this is
going to be a rather lengthy script to build and run.

