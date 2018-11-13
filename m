Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6CF1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 01:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeKMLd7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:33:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62509 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeKMLd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:33:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11D181126F1;
        Mon, 12 Nov 2018 20:38:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LQ1duqvLTPzvoWQgSRvlYVS4Z00=; b=M8XdOk
        SdzbO8ig17I+2gRRi4OYJRU+JYFBFiCsPQpFHQ4eZhaaSnwXv09pARyeF90t1w7j
        O/FGePhk9jGxVsRPNL/W9AJlGBOmH7osQIBmEiC2dTdwSoxHVtTDGIpLUH7QBF6b
        GN2mrPe6o7L5DErjvabwJSrtvZYZNKtOtiwBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HPrrRUp300XFH5/hUyqosuEPYYorJqiv
        XvtPH3oxWfnDtS8RK8GPaug9oS5VL5HrkffdG2/D/pqWyQnVErWPLZxOPRLXwJBP
        GIhbx9cF3LtjmopeS3snbKPz0fBCvCLBEWFVtBnP/tD+K+ls7Y/SUHf02eO+pAYp
        ZFtibO3H4U0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09DFE1126F0;
        Mon, 12 Nov 2018 20:38:11 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C0511126EF;
        Mon, 12 Nov 2018 20:38:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     nbelakovski@gmail.com, rafa.almas@gmail.com, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ref-filter: add worktree atom
References: <20180927204049.GA2628@rigel>
        <20181111235831.44824-1-nbelakovski@gmail.com>
        <20181111235831.44824-2-nbelakovski@gmail.com>
        <xmqqsh061u7o.fsf@gitster-ct.c.googlers.com>
        <20181112122245.GB3956@sigill.intra.peff.net>
Date:   Tue, 13 Nov 2018 10:38:09 +0900
In-Reply-To: <20181112122245.GB3956@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 12 Nov 2018 07:22:45 -0500")
Message-ID: <xmqqd0r9zri6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7496E84-E6E4-11E8-993E-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I wonder if "The worktree at /local/src/wt1 has this branch checked
>> out" is something the user of %(worktree) atom, or a variant thereof
>> e.g. "%(worktree:detailed)", may want to learn, but because that
>> information is lost when this function returns, such an enhancement
>> cannot be done without fixing this funciton.
>
> Hmm. I think for the purposes of this series we could jump straight to
> converting %(worktree) to mean "the path of the worktree for which this
> branch is HEAD, or the empty string otherwise".
>
> Then the caller from git-branch (or anybody wanting to emulate it) could
> still do:
>
>   %(if)%(worktree)%(then)+ %(refname)%(end)
>
> As a bonus, the decision to use "+" becomes a lot easier. It is no
> longer a part of the format language that we must promise forever, but
> simply a porcelain decision by git-branch.

Yeah, thanks for following through the thought process to the
logical conclusion.  If a branch is multply checked out, which is a
condition "git worktree" and "git checkout" ought to prevent from
happening, we could leave the result unspecified but a non-empty
string, or something like that.

> file-global data-structure storing the worktree info once (in an ideal
> world, it would be part of a "struct ref_format" that uses no global
> variables, but that is not how the code is structured today).

Yes, I agree that would be the ideal longer-term direction to move
this code in.

>> > +		} else if (!strcmp(name, "worktree")) {
>> > +			if (string_list_has_string(&atom->u.worktree_heads, ref->refname))
>> 
>> I thought we were moving towards killing the use of string_list as a
>> look-up table, as we do not want to see thoughtless copy&paste such
>> a code from parts of the code that are not performance critical to a
>> part.  Not very satisfying.
>> 
>> 	I think we can let this pass, and later add a wrapper around
>> 	hashmap that is meant to only be used to replace string-list
>> 	used for this exact purpose, i.e. key is a string, and there
>> 	is no need to iterate over the existing elements in any
>> 	sorted order.  Optionally, we can limit the look up to only
>> 	checking for existence, if it makes the code for the wrapper
>> 	simpler.
>
> This came up over in another thread yesterday, too. So yeah, perhaps we
> should move on that (I am OK punting on it for this series and
> converting it later, though).

FWIW, I am OK punting and leaving, too.
