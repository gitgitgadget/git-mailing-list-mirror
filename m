Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754811FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 01:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932310AbdJVBqG (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 21:46:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60514 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932295AbdJVBqF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 21:46:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1775A9C2DA;
        Sat, 21 Oct 2017 21:46:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rlHVSH85fdIWW66J1mjE3WX6JDM=; b=MG/wD1
        jo0+X7IorpkcPkbCjT23i4KWojZ2kWsUeje1n22G1Jh4fj1cgNjgXK2loSfjIu+h
        v34w+JKLvhMch6gX/cxu8VsJUooVgauVK2nnNvLfaGmBOdiW/IyhV3qz5L8gxr8t
        zKQmecf5X8rV9ZwWyvrrw/bVPz2Vf73z8h+aM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JBDOH1YwrtEPdaqCcicADwxWdG/rFiJX
        Gy8xdLf53tFEM7ucArDOjJYXHiVyhK7PyelhR2Gf6RBBwWfQ3zX4Nb2b+Na0tLI/
        +QYV3Pyh9I+DN951uIv+6/zj51rbSHcl2dV/3RIf9RLdmYqI/dGIXprM/GAndXPz
        2l60fjEJvzo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E8299C2D9;
        Sat, 21 Oct 2017 21:46:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F67D9C2D6;
        Sat, 21 Oct 2017 21:46:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/6] t0021/rot13-filter: add capability functions
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
        <20171019123030.17338-6-chriscool@tuxfamily.org>
Date:   Sun, 22 Oct 2017 10:46:02 +0900
In-Reply-To: <20171019123030.17338-6-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 19 Oct 2017 14:30:29 +0200")
Message-ID: <xmqqefpwdkf9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C35C552A-B6CA-11E7-B65A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Add functions to help read and write capabilities.
> These functions will be reused in following patches.

One more thing that is more noteworthy (read: do not forget to
describe it in the proposed log message) is that the original used
to require capabilities to come in a fixed order.

The new code allows these capabilities to be declared in any order,
it even allows duplicates (intended? shouldn't we be flagging it as
an error?), the helper can require a set of capabilities we do want
to see and fail if the remote doesn't declare any one of them
(good).

It does not check if the remote declares any capability we do not
know about (intended? the original noticed this situation and error
out---shouldn't the more generalized helper that is meant to be
reusable allow us to do so, too?).

	Side note: my answer to the last question is "it is OK and
	even desirable to ignore the fact that they claim to support
	a capability we do not know about", but I may be mistaken.
	The reasoning and the conclusion that is consistent with
	what the code does should be described in any case.

> +sub packet_read_capabilities {
> +	my @cap;
> +	while (1) {
> +		my ( $res, $buf ) = packet_bin_read();
> +		return ( $res, @cap ) if ( $res != 0 );

The original had the same "'list eq list' does not do what you may
think it does" issue.  This one corrects it, which is good.

I am not sure if ($res != 0) is correct though.  What should happen
when you get an unexpected EOF at this point?  The original would
have died; this ignores and continues.

> +		unless ( $buf =~ s/\n$// ) {
> +			die "A non-binary line MUST be terminated by an LF.\n"
> +			    . "Received: '$buf'";
> +		}

It may make sense to extract this in a small helper and call it from
here and from packet_txt_read().

> +		die "bad capability buf: '$buf'" unless ( $buf =~ s/capability=// );

This may merely be a style thing, but I somehow find statement
modifiers hard to follow, unless its condition is almost always
true.  If you follow the logic in a loop and see "die" at the
beginning, a normal thing to expect is that there were conditionals
that said "continue" (eh, 'next' or 'redo') to catch the normal case
and the control would reach "die" only under exceptional error
cases, but hiding a rare error condition after 'unless' statement
modifier breaks that expectation.

> +		push @cap, $buf;
> +	}
> +}
> +
> +sub packet_read_and_check_capabilities {
> +	my @local_caps = @_;
> +	my @remote_res_caps = packet_read_capabilities();
> +	my $res = shift @remote_res_caps;
> +	my %remote_caps = map { $_ => 1 } @remote_res_caps;

FYI:

	my ($res, @remote_caps) = packet_read_capabilities();
	my %remote_caps = map { $_ => 1 } @remote_caps;

may be more conventional way.

> +	foreach (@local_caps) {
> +        	die "'$_' capability not available" unless (exists($remote_caps{$_}));
> +	}

It is good that we can now accept capabilities in any order and
still enforce all the required capabilities are supported by the
other side.  It deserves a mention in the proposed log message.

> +	return $res;
> +}
> +
> +sub packet_write_capabilities {
> +	packet_txt_write( "capability=" . $_ ) foreach (@_);
> +	packet_flush();
> +}
> +
>  print $debug "START\n";
>  $debug->flush();
>  
>  packet_initialize("git-filter", 2);
>  
> -( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
> -( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
> -( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
> -( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
> +packet_read_and_check_capabilities("clean", "smudge", "delay");
> +packet_write_capabilities(@capabilities);

Neither the original nor the rewrite ensures that @capabilities we
ask to the other side to activate is a subset of what the other side
actually declared.

Fixing this is a bit more involved than "refactor what we have", but
probably is part of "refactor so that we can reuse in other
situations".  You'd want to return the list of caps received from
packet_read_and_check_capabilities() and make sure @capabilities is
a subset of that before writing them out to the other side to
request.

Thanks.
