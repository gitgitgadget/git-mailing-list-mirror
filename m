Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D42DC83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjHaV7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaV7s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:59:48 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F311B
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:59:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37VLv8oY979010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 21:57:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Oswald Buddenhagen'" <oswald.buddenhagen@gmx.de>,
        <git@vger.kernel.org>
References: <20230831061735.GA2702156@coredump.intra.peff.net>        <20230831062320.GJ3185325@coredump.intra.peff.net>        <ZPBt6VYAWHJhv3N2@ugly>        <20230831174215.GA3208283@coredump.intra.peff.net> <xmqq7cpaudke.fsf@gitster.g>
In-Reply-To: <xmqq7cpaudke.fsf@gitster.g>
Subject: RE: [PATCH 10/10] lower core.maxTreeDepth default to 2048
Date:   Thu, 31 Aug 2023 17:59:28 -0400
Organization: Nexbridge Inc.
Message-ID: <096e01d9dc56$6d9f12a0$48dd37e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN4EOJP/CsudSNF4KF7MKvDGmCZ1wJ9mbmNAc1ETtYCAvYS9QFQVv7BrIuX68A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, August 31, 2023 5:06 PM, Junio C Hamano wrote:
>Jeff King <peff@peff.net> writes:
>
>> On Thu, Aug 31, 2023 at 12:39:37PM +0200, Oswald Buddenhagen wrote:
>>
>>> On Thu, Aug 31, 2023 at 02:23:20AM -0400, Jeff King wrote:
>>> > But I thought that
>>> > following the sequence of logic (from "4096 is probably OK" to
>>> > "whoops, it's not") had some value to share.
>>> >
>>> of course, but you can just integrate that into the squashed commit
message.
>>> having it all in one place makes it easier to follow.
>>
>> Yes, though I think having it as a separate patch makes it easier to
>> revisit later (e.g., by reverting or by replacing the patch during a
>> re-roll).
>
>I am on the fence.  Having it squashed into the same step as it was
introduced may
>reduce the patch count, but then it would not be easy to explain why 2048
is a
>reasonable default at that step when no code actually uses the variable, so
the end
>result is not all that easier to follow and read, as that earlier step
would be
>handwaving
>"2048 is good at the end of the series, trust me", unlike having it at the
end.  When
>4096 is introduced as a "random number that seems larger than large enough"
in the
>earlier step, it might be worth mentioning that it is a tentative default
and may turn
>out to be larger than necessary in which case we may want to shrink it ;-)

I have been trying to figure out the implications of this and went down the
wrong rabbit hole. Are we taking about the tree depth of the underlying
Merkel Tree (no) or the tree-ish thing representing the file system
(apparently yes). In this case, a practical depth of 2048 hits the exact max
path size on the NonStop platform, so I have no issue there. My concern is
one of terminology. My assumption of what maxTreeDepth meant, from other
terminology used in git, seemed (wrongly) to align with the use of --depth=n
where n<maxTreeDepth parameters for commands like fetch. From a user
intuition (arguably, if I have any here) is that the parameter should be
more of a path nomenclature, like maxPathHeight or maxHierarchyHeight rather
than what is currently in flight. Just my opinion and I'm fine no matter
which way.

--Randall
--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



