Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9B3C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5635122BEB
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oammRlrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgH0TIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:08:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55754 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0TIp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:08:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE759F6195;
        Thu, 27 Aug 2020 15:08:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=whsHjX0yh1BqjuyEOFpXZe+vfyo=; b=oammRl
        rfx/tZJMIJ8ulREg4jcty4ibNh8nSqwqlH78aOOjH8aZlkHB/e5yUwSX1Z5DLZzi
        zNMXH+K8RuGGwQkOJkwEa57aREBSa/ay33u8SC9obJ3Yy3OEsKi8XUKMPl8ixO5I
        oMX9U0eMg3jsDNVr7O34NSvJ9nQNCi/QTwLWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uLf5T2ER5Fhlhc3Qf5DOcw6DIscsFhkE
        d8yKbGMM13p/HaqKRo0Dtbt20j9sMsE3sK3jVml6SSNUIwlUvx9Njs3/5GKlrGQV
        cARGQekKJSfxsHM4If+wPVbMFjkM1wxg6vqDLGP2eWuA8XGAmkBTlQBnQdtOQmlm
        /+g/Bu9vLpQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5551F6194;
        Thu, 27 Aug 2020 15:08:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D190BF6193;
        Thu, 27 Aug 2020 15:08:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <20200827175552.132193-1-sir@cmpwn.com>
        <xmqq7dtjrjut.fsf@gitster.c.googlers.com>
Date:   Thu, 27 Aug 2020 12:08:38 -0700
In-Reply-To: <xmqq7dtjrjut.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 27 Aug 2020 12:04:26 -0700")
Message-ID: <xmqq3647rjnt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7740700-E898-11EA-A02D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Drew DeVault <sir@cmpwn.com> writes:
>
>> Most mailing lists prefer that new patchsets and their revisions are
>> placed into a new thread. Additionally, knowledge of what In-Reply-To
>> means and where to find the Message-Id to fill in are domain-specific
>> and confusing to new users. In the niche situations where this is called
>> for, the --in-reply-to flag is sufficient.
>>
>> A config option, sendemail.promptInReplyTo, has been added to re-enable
>> the old behavior.
>
> We do not break existing users' habits without a good reason, and a
> subjective "this is the way I prefer" is *not* a good reason.

Having said that (and I am not retracting anything I said in the
message I am responding to), I haven't seen this prompt triggering
for me when I use send-email, with or without --in-reply-to option
on the command line.

Admittedly I use a wrapper around "git send-email" to add minimum
set of command line options that are always used (they are --from,
--envelope-sender, and --smtp-server) but I do not think they have
effect on the use of in-reply-to prompt.  

What are we doing differently, I wonder?


