Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75AD41F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdAYVLR (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:11:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750998AbdAYVLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:11:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B5EE62F90;
        Wed, 25 Jan 2017 16:11:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VMYmyy/VCP30
        uNuNJkPXFxrZ4Lg=; b=HFsipkDhpXhXaaXC5iqlBu/9lXls4NB9IaEGnDSVJBcS
        q/EkDPUTxlLKdxWFzLTNxDKTET2SSI/ZV/W/p/psBwfR18mqozdFMmorbejngkhk
        6rikz0YQTQoTe74nZxncXa5cd8DlE5qAvoh4A/EddXNqTZmpQtSeitIpHg5uCck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Xoaw+W
        xPtwPaLoQrq66iSXuEXT76eaAY3gC4n1kRkiFtbBXPKyVqKTBdOSXhEf1dDJQqzo
        H/IkWQqG+F4uHQuyzNq6AF6Tnff8zUGhKCBF9tBHgkr5m/7UByo2VkYJLByvRvmA
        VzVNZy0xkVhfV9X4Tu8lbGdye1XXwX0YkjVTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C0B62F8F;
        Wed, 25 Jan 2017 16:11:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6596262F8E;
        Wed, 25 Jan 2017 16:11:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        jacob.keller@gmail.com
Subject: Re: [PATCH 2/5] revision.c: group ref selection options together
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
        <20170125125054.7422-1-pclouds@gmail.com>
        <20170125125054.7422-3-pclouds@gmail.com>
Date:   Wed, 25 Jan 2017 13:11:12 -0800
In-Reply-To: <20170125125054.7422-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 25 Jan 2017 19:50:51 +0700")
Message-ID: <xmqqo9yualqn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDF7E53C-E342-11E6-B2CA-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> These options have on thing in common: when specified right after

one thing.

> --exclude, they will de-select refs instead of selecting them by
> default.
>
> This change makes it possible to introduce new options that use these
> options in the same way as --exclude. Such an option would just
> implement something like handle_refs_pseudo_opt().
>
> parse_ref_selector_option() is taken out of handle_refs_pseudo_opt() so
> that similar functions like handle_refs_pseudo_opt() are forced to
> handle all ref selector options, not skipping some by mistake, which ma=
y
> revert the option back to default behavior (rev selection).

I am not sure about these two refactorings, for at least two reasons.

 * Naming.  The function is all about handling "refs options" and I
   do not see anything "pseudo" about the options handled by the
   handle_refs_pseudo_opt() function.  This is minor.

 * I am expecting that the new one yet to be introduced will not
   share the huge "switch (selector)" part, but does its own things
   in a separate function with a similar structure.  The only thing
   common between these two functions would be the structure
   (i.e. it has a big "switch(selector)" that does different things
   depending on REF_SELECT_*) and a call to clear_* function.

   If we were to add a new kind of REF_SELECT_* (say
   REF_SELECT_NOTES just for the sake of being concrete), what
   changes will be needed to the code if the addition of "use reflog
   from this class of refs for decoration" feature was done with or
   without this step?  I have a suspicion that the change will be
   simpler without this step.

   The above comments will be invalid if the new "use reflog for
   decoration" feature will be done by extending this pseudo_opt()
   function by extending each of the switch/case arms.  If that is
   the case, please disregard the above.  I just didn't get that
   impression from the above paragraph.

