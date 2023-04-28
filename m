Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F7C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 19:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbjD1TMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbjD1TMC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 15:12:02 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A98E9
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 12:12:00 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E684523FBC;
        Fri, 28 Apr 2023 15:11:57 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1psTVd-T8Y-00; Fri, 28 Apr 2023 21:11:57 +0200
Date:   Fri, 28 Apr 2023 21:11:57 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZEwafQmat347la3/@ugly>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <xmqqcz3netxr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqcz3netxr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2023 at 11:35:28AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> +The command generates the subject 'Revert "<title>"' for the resulting
>> +commit, assuming the original commit's subject is '<title>'.  Reverting
>> +such a reversion commit in turn yields the subject 'Reapply "<title>"'.
>
>Clearly written.
>
>> +These can of course be modified in the editor when the reason for
>> +reverting is described.
>
>Not just the title but the entire message can be edited and that is
>by design.  Having to modify what this new mechanism does when
>existing users do not like the new behaviour will annoy them, and
>this sentence will not be a good enough excuse to ask them
>forgiveness for breaking their established practice, either.
>
>So, I am not sure if there is a point to have this sentence here.
>
well, it's the one sentence i copied verbatim from your proposal. :-D

but i don't get the argument anyway. i think the docu is pretty 
pointless except to emphasize that the generated subject is a default 
that should be edited when circumstances recommend it. in fact, i 
wouldn't mind writing just that, with a notice that the default attempts 
to be somewhat natural for repeated reverts.

>>  			strbuf_addstr(&msgbuf,
>>  				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>> +		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject)) {
>> +			if (skip_prefix(orig_subject, "Revert \"", &orig_subject)) {
>> +				/*
>> +				 * This prevents the generation of somewhat unintuitive (even if
>> +				 * not incorrect) 'Reapply "Revert "' titles from legacy double
>> +				 * reverts. Fixing up deeper recursions is left to the user.
>> +				 */
>
>Good comment but in an overwide paragraph.
>
there are several lines in the lower 90-ies in that file, one of them 
seen in the patch context. would 88 be fine?
(too narrow flowed text looks silly, imo.)

>Doesn't t3501 seem a better home for them?
>
looking closer at it, i guess it kind of does. the file's contents have 
clearly grown to fulfill the filename's broad promise, but nobody 
bothered to adjust the test description and make the setup title more 
specific. any takers?

-- ossi
