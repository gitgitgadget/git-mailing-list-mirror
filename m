Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C1820373
	for <e@80x24.org>; Mon, 13 Mar 2017 23:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbdCMXSM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 19:18:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753375AbdCMXSL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 19:18:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EC9A86BD4;
        Mon, 13 Mar 2017 19:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DAbMzFM00z+oLKcagtFCYDjnX8U=; b=RGZxq8
        fN3/aR2b6/aM5lWeQXwWndgi3Q+/EB9NXuWfsuXS6sR1WKIefvpBaXtr0c0NJ1N5
        YYnjBVlIGUEoG6Sftyom0bTmkK3UCW3gOL+1AR5NvLYyhFY5rCTj0Bc6d1pio1uR
        6S34UO4JCSMyYr22A2xzFYUdBXutZ3EXGs0Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W7C+yw/VDPQlaD2ctuX2rgLeUpvIPqAJ
        rt3biNypHbOrYrpWS4QW9m3xJmhmnB6Z+PssmDaloe8w9anmHg9C7Ssb8TC42yx2
        WeehObSZSXAArAgoiqTx+BoRbuIwuonDAODlPUksNrX8FITgICaRbSyfdlG61MXY
        8ALvHqolQyw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15D7786BD3;
        Mon, 13 Mar 2017 19:18:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D5CC86BD1;
        Mon, 13 Mar 2017 19:18:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Nikhil Benesch <nikhil.benesch@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 1/1] archive: learn to include submodules in output archive
References: <20170312075404.23951-1-nikhil.benesch@gmail.com>
        <20170312075404.23951-2-nikhil.benesch@gmail.com>
        <CAGZ79kZrbvJz+S434BmEA_qeMOUXHk60yDSwdcKef62-Bz8nyw@mail.gmail.com>
        <CAGZ79kZbcLFJPUt3wGsYX-XgAO+xW1ZDGJqN-q=r8i5Zbv_tTw@mail.gmail.com>
Date:   Mon, 13 Mar 2017 16:18:07 -0700
In-Reply-To: <CAGZ79kZbcLFJPUt3wGsYX-XgAO+xW1ZDGJqN-q=r8i5Zbv_tTw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 13 Mar 2017 15:57:44 -0700")
Message-ID: <xmqqpohklqa8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51B31ACA-0843-11E7-8DCC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Mar 13, 2017 at 3:12 PM, Stefan Beller <sbeller@google.com> wrote:
>
>>> will recursively traverse submodules in the repository and
>>> consider their contents for inclusion in the output archive, subject to
>>> any pathspec filters.
>
> git-archive pays attention to export-ignore and export-subst attribute
> as read from .gitattributes or $GIT_DIR/info/attributes
>
> When recursing into submodules, we'd need to clarify if the attributes
> from the superproject or from the submodules are applied; or both.

I think the most natural expectation is for the output from the
"archive --recurse-submodules" command is to be logical
concatenation of "archive" run at the top-level and submodules,
adjusting the output from the latter with leading paths to the
submodules.  For that to happen, the attributes that apply to paths
inside a submodule must come from that submodule's setting.

