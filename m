Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72CC20954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbdLGPnU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:43:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52449 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754206AbdLGPnT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:43:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51FAEC05E7;
        Thu,  7 Dec 2017 10:43:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GbnlGLc5Tmz/koALM8zWx2M9Oa0=; b=IHPjka
        WAP77DWUfIgFmuGhR4AGCEVB/GAmpRotwW6oDRPYfVT41IwbY86gXGisMD1hHcOR
        rQbgynXR69zZrbtjmMjky52mrDDgWwKfUs6HfxEA59dgrKg+SVx0Zsl2Pqtg/9Qp
        MB1ROCUKHZqryBfLJ2IPMFPBqWFzU8U7Z1ivU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sMHHVhtyC1KlaweqIuVlzttPg+lq8eZ3
        Q41Mk8yWWyxnUR7B6XagPUr8N3+RnM29qpcg7AK7Y0ir1nNlBDPdgxMlwvWiqs8L
        w/54hsQaObzEdlGYkbJA6D078Cxwb4lyZXjGDWq4D63iKMBqg4JUPZLSukeMa7zf
        BlOR5g3DL6Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48B92C05E6;
        Thu,  7 Dec 2017 10:43:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A437CC05E4;
        Thu,  7 Dec 2017 10:43:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user input
References: <20171207151641.75065-1-lars.schneider@autodesk.com>
        <20171207151641.75065-3-lars.schneider@autodesk.com>
Date:   Thu, 07 Dec 2017 07:43:17 -0800
In-Reply-To: <20171207151641.75065-3-lars.schneider@autodesk.com> (lars
        schneider's message of "Thu, 7 Dec 2017 16:16:41 +0100")
Message-ID: <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58E31D86-DB65-11E7-AE7C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +		if (print_waiting_for_editor) {
> +			fprintf(stderr,
> +				_("hint: Waiting for your editor to close the file... "));
> +			if (is_terminal_dumb())
> +				/*
> +				 * A dumb terminal cannot erase the line later on. Add a
> +				 * newline to separate the hint from subsequent output.
> +				 */
> +				fprintf(stderr, "\n");
> +			fflush(stderr);
> +		}

Was the trailing whitespace at the end of the hint message intended?

If we expect the editor to spit out additional garbage on the line,
it would probably help to have that SP, but if that is why we have it
there, it probably should be done only when !is_terminal_dumb().

If the trailing SP is merely there by accident, then removal without
changing anything else is also OK.

I cannot tell which is the case, hence this comment.

Thanks.
