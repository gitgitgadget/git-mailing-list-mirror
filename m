Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C54D2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdKXNsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 08:48:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63753 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753617AbdKXNsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 08:48:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8A4EBB7FD;
        Fri, 24 Nov 2017 08:48:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fmWBsfLq3TSh9oMAcfFNBOjTPMU=; b=onHfHw
        ymVlrWMxfM72eTTcIyPs4BZpVQa1Ktj/kxLa1/tGMv22CK4PBLBb45tK+7ziLaeP
        fLes1JmqeJjFauVGzHzbEEkipvP6d4lZpJH7Pt6VCYPbzMFZ4joUdA9Rqj/KA3uL
        Jck39oTDvvhx83f1orJI8DIsp4n+w5dwRwVZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V6Bd5oxmy3nIov0zW7miLd5Xk3TT3d50
        MnK+lmL2lcgducjm9CSo3SJcQXzOSz3Pzz5c+/bgcK8fhE3MiELJSHT5gI0DIxXv
        NbDz6qIOZOcb/Pu8wm9Nr9evPN3seunv7tm3/FMQ1jGuTqtt0Mr1acYrAEN77Wat
        3+JLVuxRXuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE086BB7FC;
        Fri, 24 Nov 2017 08:48:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 566A1BB7FB;
        Fri, 24 Nov 2017 08:48:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 7/9] sequencer: load commit related config
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171124110758.9406-1-phillip.wood@talktalk.net>
        <20171124110758.9406-8-phillip.wood@talktalk.net>
Date:   Fri, 24 Nov 2017 22:48:12 +0900
In-Reply-To: <20171124110758.9406-8-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Fri, 24 Nov 2017 11:07:56 +0000")
Message-ID: <xmqqbmjrn5yb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D96281E-D11E-11E7-A6A9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Load default values for message cleanup and gpg signing of commits in
> preparation for committing without forking 'git commit'. Note that we
> interpret commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE to
> be consistent with 'git commit'

Hmph, is that because we never invoke the editor to edit the commit
log message?  Over there, scissors is demoted to space when the
editor is not in use, but otherwise this demotion does not occur.

Just being curious.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     changes since v3:
>      - interpret commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE
>        to match 'git commit'
