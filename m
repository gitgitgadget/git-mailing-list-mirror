Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1B32055E
	for <e@80x24.org>; Thu, 26 Oct 2017 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdJZGPL (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 02:15:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63935 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750957AbdJZGPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 02:15:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E2D19C73E;
        Thu, 26 Oct 2017 02:15:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eVXnKMb/r1EMODDdIYqQA+OndI0=; b=U64kR9
        rpDsKcj/rSAdtBZT8n+oCIG/+sqesHfEeTuhzhbXKZuhdFzSh73tzOzMh6aJkhAr
        nI306h2YDu4Q9FtdXAtDB01/nIbxW4YZDqOsvfisXt041cZklMHutcyhDDEUBacm
        tv3A2mIpNmfequsx+BJU+c81K8UIoNdIqJjw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h9IEkr/sKVhFv0E0M/HF3RLorr7G/1Ho
        og8chWdl+N081fU25TqYT7uKIw/PBqUtWT3ZLdmVk5kIE5vY3WjBH3ZT+zJpIJfz
        m7XVSjO1hcRUrixsAmz0nlVTim/NwmUtD/W1R9GLsszIC7kseoOY+SgDiv2RZu1G
        cG1j5ZI8bmA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6666D9C73D;
        Thu, 26 Oct 2017 02:15:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D467C9C73B;
        Thu, 26 Oct 2017 02:15:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
        bturner@atlassian.com
Subject: Re: [PATCH] blame: add --fuzzy-lines command line option
References: <20171026021929.1346-1-istephens@atlassian.com>
Date:   Thu, 26 Oct 2017 15:15:07 +0900
In-Reply-To: <20171026021929.1346-1-istephens@atlassian.com> (Isabella
        Stephens's message of "Thu, 26 Oct 2017 13:19:29 +1100")
Message-ID: <xmqqtvyme8pg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 046E0B88-BA15-11E7-B45C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isabella Stephens <istephens@atlassian.com> writes:

> If the -L option is used to specify a line range in git blame, and the
> end of the range is past the end of the file, git will fail with a fatal
> error. It may instead be desirable to perform a git blame for the line
> numbers in the intersection of the file and the specified line range.

Even though erroring out upon such input was done as a deliberate
design decision, in retrospect, I do not think the design decision
made much sense.

The code already takes a nonsense input and tries to make best sense
of it, e.g. "-L10,6" is interpreted as "-L6,10" instead of erroring
out.  So if we were to do this kind of change, I suspect that it may
be better to do so unconditionally without introducing a new option.

Thanks.
