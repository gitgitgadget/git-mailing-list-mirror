Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52F32036D
	for <e@80x24.org>; Wed, 22 Nov 2017 03:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdKVD4C (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:56:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54313 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751434AbdKVD4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:56:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCBC1BB8BA;
        Tue, 21 Nov 2017 22:56:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4qB4FdJScIK27ZYo2QmVCHRje9A=; b=vThSGN
        LM3DI8dZiL6tHyCcEe+gTEFhAKKBPTiSy7KkytJJZ1N4Agev9PPgcr3i8KXpkE9f
        3TV0NKGUoPiAXE6qf7Ryuu4SeQRwsxNP1fe50FnFbdKt3Oqqz50Bsf8M4eotsoQO
        abMA8KC5PinXpAVcWj9njPKFx3qSvSjlNAm0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tt2tE6UGoZfpUbmUkNUTavA5P6Tp0vW3
        LyQ+5uN6J4OYfrxVR+r6vb8t1Bb7Pj2rsOh//Gp0jlDR6JjyojQZSgOFA2BEFDX/
        47VDUAonMPJaccBoJAbtF8MKnMmpqcAwTcnzG/wck6CUJP7wxrBiGDRg2OuAtIy1
        awicacjd7e8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97217BB8B9;
        Tue, 21 Nov 2017 22:56:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1F43BB8B8;
        Tue, 21 Nov 2017 22:55:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
        <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
        <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com>
        <CAPig+cTux4dfBsX3DD=5TbM-p4-t66WX3+sufi39-W5Dw+ZvOw@mail.gmail.com>
        <CAPig+cStgFaeWoNVcwaJVtNnYeLQ2LfS9xXF7uM3Py17HUaFFw@mail.gmail.com>
Date:   Wed, 22 Nov 2017 12:55:58 +0900
In-Reply-To: <CAPig+cStgFaeWoNVcwaJVtNnYeLQ2LfS9xXF7uM3Py17HUaFFw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 21 Nov 2017 22:23:08 -0500")
Message-ID: <xmqqvai3ufu9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D3A62DC-CF39-11E7-9543-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Nov 21, 2017 at 10:14 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The erroring out in this case looks like simple oversight. Most
>> likely, this particular case did not occur to Duy. The code does
>> intentionally check the directory to see if it is dirty so that it can
>> warn the user (in which case the user can re-run with --force or take
>> other corrective action), but erroring out if the directory is merely
>
> "...erroring out if the directory _is missing_ is merely..."
>
>> an indirect (and unintended) result of trying to check for dirtiness.
>>
>> So, Kaatic's patch is intended to address that oversight (though I
>> haven't examined the implementation closely; I was just trying to
>> understand the reason for the patch).

OK, so the proposed log message was a bit confusing for those who
are *not* the person who wrote it (who knew why existing behaviour
was inadequate and did not describe how "worktree remove" would fail
under such a scenario to illustrate it, incorrectly assuming that
everybody who reads the proposed log message already *knows* how it
would fail).

	"git worktree remove" removes both the named worktree
	directory and the administrative information for it after
	checking that there is no local modifications that would be
	lost (which is a handy safety measure).  It however refuses
	to work if the worktree directory is _already_ removed.

	The user could use "git worktree prune" after seeing the
	error and realizing the situation, but at that point, there
	is nothing gained by leaving only the administrative data
	behind.  Teach "git worktree remove" to go ahead and remove
	the trace of the worktree in such a case.

or soemthing like that?
