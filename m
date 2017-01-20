Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62DA020756
	for <e@80x24.org>; Fri, 20 Jan 2017 23:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbdATXPq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 18:15:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62200 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752631AbdATXPn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 18:15:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8752763AB2;
        Fri, 20 Jan 2017 18:15:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BD86elHfOglcJN0nYS+B9XPsKaw=; b=T0jgvj
        GlcFK9q3Hxnq+pa+YdGOCmNON8dB0Jv/bxMulO3NCyTT4gXREXgjWn5DD4TCqfR3
        FTuTHOhT9sk4hapBG+UvV6x8+Fna05LcAh9DneSnb8hfGmqjxLhpdMovwBV99lhz
        Gts9fVSsZo+TBIkCR2nNQdbA9em6Fc3XJlWKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NT7DNHIZ27+/y1jv2C94UAtMPTOeJw9G
        kchCWtpor4Z3lWsMDPRGW159pmUQO1hnVnJAIbq9ZtazWjrap0HoKZUDDEGiw7Tm
        OT+6oC7aVZ0OoVTLDzxSbXl5DTjWc0tPAt2j1a1tUJbj/s4LgPLwsScBR7Xa1bW0
        6mLxVR7V6rI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BB9963AB1;
        Fri, 20 Jan 2017 18:15:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBF3663AAD;
        Fri, 20 Jan 2017 18:15:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
References: <20170120155015.4360-1-git@thecybershadow.net>
        <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
        <1bf9a446-0b00-f27a-4625-0bc8c25356fe@gmail.com>
        <xmqqefzxwew9.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 20 Jan 2017 15:15:35 -0800
In-Reply-To: <xmqqefzxwew9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 20 Jan 2017 14:22:14 -0800")
Message-ID: <xmqqwpdpuxuw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59DA5EBC-DF66-11E6-B040-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Your log message for the patch needs to be updated by summarizing
> the above better.

Here is my attempt.

     "git show-ref HEAD" used with "--verify" (because the user is
     not interested in seeing refs/remotes/origin/HEAD), and used
     with "--head" (because the user does not want HEAD to be
     filtered out), i.e. "git show-ref --head --verify HEAD", did
     not work as expected.

     Instead of insisting that the input begins with "refs/", allow
     "HEAD" when "--head" is given in the codepath that handles
     "--verify", so that all valid full refnames including HEAD are
     passed to the same output machinery.
