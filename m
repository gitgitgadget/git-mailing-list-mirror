Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6110220A17
	for <e@80x24.org>; Mon, 23 Jan 2017 19:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdAWTxr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 14:53:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62346 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750908AbdAWTxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 14:53:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57F1162C35;
        Mon, 23 Jan 2017 14:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hsnhqvkEeAebj2GYtUly48GhNVI=; b=k/6iAO
        fHTGGN/+HpF5lgdtkRvg4uUoT9vmRF+nTgaibRlt2zdNn/cN4bdPjA57gs1TTohl
        +pzRO45GhgDezjFU0MXhz82jTW9GoHRAQ5rRTthOr5LNEY+fhVVDd5EqGEpCzogZ
        GG0KJQx3bD34b4dGShnH6BjY/L65tR/KRxw0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QAsxBCMjePbHb0CTKR+CK7FujHtbPB6b
        65xqhAnJcejxLdaKwf6RVyiWe6zLnS6XVD3aBR5jFSR+dyc+fnO8M4Fvw+6cQI2D
        Kj3HwiZXh0uvH76UzjxTDYdNXSTY89uU7HOMTgoEZowXY95OpHHNA2ng2YY8hFv4
        JOxkhxG0b9o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EAAC62C2E;
        Mon, 23 Jan 2017 14:53:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACB5062C2D;
        Mon, 23 Jan 2017 14:53:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v1 0/2] urlmatch: allow regexp-based matches
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
Date:   Mon, 23 Jan 2017 11:53:43 -0800
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de> (Patrick
        Steinhardt's message of "Mon, 23 Jan 2017 14:06:33 +0100")
Message-ID: <xmqqsho9r1rs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B348DA-E1A5-11E6-A040-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <patrick.steinhardt@elego.de> writes:

> This patch is mostly a request for comments. The use case is to
> be able to configure an HTTP proxy for all subdomains of a
> certain domain where there are hundreds of subdomains. The most
> flexible way I could imagine was by using regular expressions for
> the matching, which is how I implemented it for now. So users can
> now create a configuration key like
> `http.?http://.*\\.example\\.com.*` to apply settings for all
> subdomains of `example.com`.

While reading 2/2, I got an impression that this is "too" flexible
and possibly operates at a wrong level.  I would have expected that
the wildcarding to be limited to the host part only and hook into
match_urls(), allowing the users of the new feature to still take
advantage of the existing support of "http://me@example.com" that
limits the match to the case that the connection is authenticated
for a user, for example, by newly allowing "http://me@*.example.com"
or something like that.

Because you cannot have a literal '*' in your hostname, I would
imagine that supporting a match pattern "http://me@*.example.com"
would be already backward compatible without requiring a leading
question-mark.

I also personally would prefer these textual matching to be done
with glob not with regexp, by the way, as the above description of
mine shows.

Thanks.


