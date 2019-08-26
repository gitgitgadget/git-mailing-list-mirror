Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7761F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbfHZOXB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:23:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55592 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfHZOXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:23:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDD1D15FF68;
        Mon, 26 Aug 2019 10:22:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tnyR+ooAu60y
        h+fRqRhwdrDerUg=; b=JsxqECBKvv+VxSnPlXR1R1I44li1IC2Fxz/HO3w7u778
        RsumMd6r87r0ItVsKAENn7Mv5+O/dZIHdVmbASqW2k3r+62Al9phFqU2MiOM29Gk
        NWuCoZ+AIaWypxDlUsWZEtJjuBINr5R860ds5lTQSp1Z6WuMmF8GIGRE8LZIHsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xYNPG1
        TRuA/usY/+qTBlHmp0wqjceS95sRbQoq05oFlIb1acPLEjA2f/7lSjley1m1phXr
        94klcsj7ve576AqmgIp8voCrPJ7IUC2LKsvgsOrkk1R59izKesEzexbMWAf2ZSzZ
        ZWBtbmA2hQBFNHglySlnkn776LSrA6Zwieq3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5D5815FF66;
        Mon, 26 Aug 2019 10:22:55 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FDD215FF65;
        Mon, 26 Aug 2019 10:22:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: Update in-memory config when changing config options
References: <20190822223316.11153-1-me@yadavpratyush.com>
Date:   Mon, 26 Aug 2019 07:22:54 -0700
In-Reply-To: <20190822223316.11153-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Fri, 23 Aug 2019 04:03:16 +0530")
Message-ID: <xmqqimqkknup.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FED5B380-C80C-11E9-A27A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:


> Subject: Re: [PATCH] git-gui: Update in-memory config when changing con=
fig options

s/git-gui: Update/git-gui: update/

>  lib/option.tcl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/option.tcl b/lib/option.tcl
> index e43971b..139cf44 100644
> --- a/lib/option.tcl
> +++ b/lib/option.tcl
> @@ -344,6 +344,7 @@ proc do_save_config {w} {
>  	if {[catch {save_config} err]} {
>  		error_popup [strcat [mc "Failed to completely save options:"] "\n\n$=
err"]
>  	}
> +	load_config 1

This may make the symptom go away, and in that sense it would be a
good change in the short term.

But I have to suspect that it may indicate a misdesign in the "edit
configuration" part of the program that the newly set configuration
value must load back to the program from the filesystem.  That feels
backwards.

NaaNa=C3=AFvely, one would imagine a program wia capability to save and
load run-time options to disk to behave this way, no?

 * a set of in-core variables exist to control various aspects of
   the program (e.g. font size, background colour, etc.)

 * there is a "load config" helper function that can be called to
   populate these in-core variables from an external file.

 * there is a "edit config" UI that can be used to toggle these
   in-core variables (the checkboxes and radio buttons may not
   directly be connected to the underlying variables, but to their
   temporary counterparts and there may be a "OK" button in the UI
   to commit the changes to the temporaries to the real in-core
   variables).

 * there is a "save config" helper function that can be called to do
   the reverse of "load config"; one of the places that calls this
   helper is upon the success of "edit config".

I didn't look at the lib/option.tcl to check, but I would suspect
that it would require a far larger change than your single liner if
we wanted to restructure the option tweaking part in such a way, and
it would be much more preferrable to use the single liner patch at
least for now, but in the longer term you might want to consider
such a clean-up.

Thanks.
