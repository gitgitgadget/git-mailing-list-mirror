Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164DE1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 23:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764349AbdAIXcp (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 18:32:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54911 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753839AbdAIXco (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 18:32:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2914060225;
        Mon,  9 Jan 2017 18:32:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w+bDsaopSEULHxNyfE/tga8bEa0=; b=xKscjr
        hLbr+5V2bnhAEBIiejSi3gy1/0Gti3H50l4if3F59J41W1kN7NfaYXhkbNKEFwF3
        oSu4W/ZBtDo9D1352OMlSFo+OWWxTi9gl0wrS9vxYmh7HMaVCmm1YqFSfdgenWQJ
        PsyyOCsI8euq8ycgu9KirCSi3Rqu0HuZ8tap4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kvndEeY/aiMG9lFYK2G2pmSStr+bR9vT
        v6fW1x0CQylrdEF6nyJ3IssspjVQ4alMF7GSTmMjR6PTyeYRLWFzUvKSqIWT49Am
        +YnpnKRfDfdu5i6DNmb7Id4DgikqLvyQPjER2wfaw5IAp7TGvFKpWhHOGvjQsB5a
        cWGzZxdooAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2038560224;
        Mon,  9 Jan 2017 18:32:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59DC560223;
        Mon,  9 Jan 2017 18:32:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, j6t@kdbg.org,
        sbeller@google.com, simon@ruderich.org
Subject: Re: [PATCH v3 13/13] mergetool: fix running in subdir when rerere enabled
References: <20170106010945.79382-1-hansenr@google.com>
        <20170109054238.42599-1-hansenr@google.com>
        <20170109054238.42599-14-hansenr@google.com>
        <xmqq4m18ump1.fsf@gitster.mtv.corp.google.com>
        <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com>
        <xmqq37gru819.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 09 Jan 2017 15:32:41 -0800
In-Reply-To: <xmqq37gru819.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 09 Jan 2017 15:29:22 -0800")
Message-ID: <xmqqvatnstba.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA9C9786-D6C3-11E6-BE00-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> By the way, I didn't think this through, but how is the orderfile
> that comes from the configuration file handled when it is not an
> absolute path?  I think it is _wrong_ to take it as relative to
> where the user started the program.

Answering my own question: the program does not handle configured
orderfile at all, so there is no gotcha ;-)
