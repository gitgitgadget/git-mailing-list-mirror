Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59EB9202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 14:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbdKGO0r (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 09:26:47 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:19232 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbdKGO0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 09:26:46 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id C4pwe5f68pb8rC4pxepwrZ; Tue, 07 Nov 2017 14:26:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510064805;
        bh=BoV2zGawIrpIzDx+GuE20b5Wz9QGElWsFYYng4eL86g=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WoKfxQhlBFmh1fKlk4u393LnGViSaLTnq73eCx+QHeGzxYVqkMO5kUFfnUoT3/VIZ
         7dglavny+TnfO/gQqV/ylL7WOG/yhMsLbBTYByeZUeAGKrAJBKwIVm5EGxobg7OPKN
         3pql2Oew/qO6208o8a2KLjm2H/RsW460w9t+JZ7g=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=k74jPCraqWSQ9TMNbXIA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 2/8] Add a function to update HEAD after creating a
 commit
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
 <20171106112709.2121-3-phillip.wood@talktalk.net>
 <xmqqtvy6g5k8.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711070400160.6482@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5a65cf3c-911b-83e5-ac97-2d7386465de1@talktalk.net>
Date:   Tue, 7 Nov 2017 14:26:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711070400160.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPVxDrzIeL023jQ1bx2PzLhujbEK3vNyz88pQsKzDOj+FYwaTqf8ncNkyh+MQgOvar2PybZLJrnEoowur1lUK6hLTzdpDUziv/OHh568HjrfhdqsiJEu
 pZmZJTTwQz1o+oFYuIm+EYBfoLen79g3HX96hgOJRY6S5Cn2WqqC4UiANV9j7HBXPSEORGi7zmCuMuOJ+0WFtfbanPFOTXZrWbsHd3Vzpc8waOrbzCkURaac
 kve/aJ/06hDO8Y4JSoDcxhgzhAg2YrQDR41NVZ6A7O/0yHVqf1z3X+DSWRn7hA/1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/17 03:02, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Tue, 7 Nov 2017, Junio C Hamano wrote:
> 
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> @@ -751,6 +751,42 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
>>>  	return rest_is_empty(sb, start - sb->buf);
>>>  }
>>>  
>>> +int update_head(const struct commit *old_head, const struct object_id *new_head,
>>> +		const char *action, const struct strbuf *msg,
>>> +		struct strbuf *err)
>>> +{
>>
>> [...]
>>
>> I however do not think update_head() is such a good name for a
>> helper function in the global scope.  builtin/clone.c has a static
>> one that has quite different semantics with the same name (I am not
>> saying that builtin/clone.c will in the future start including the
>> sequencer.h header file; I am pointing out that update_head() is not
>> a good global name that will be understood by everybody).

Good point, I'll go with the name Dscho suggests if that's OK with you.

> Please try to always accompany a "Don't Do That" by a "How About This
> Instead".
> 
> In this case, I could imagine that `update_head_with_reflog()` would be a
> better name. If you disagree, I invite you to propose an alternative that
> strikes your liking.
> 
> Ciao,
> Dscho
> 

