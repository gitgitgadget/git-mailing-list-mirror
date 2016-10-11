Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FAB1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbcJKTgr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:36:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63973 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752144AbcJKTgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:36:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A24A44FCA;
        Tue, 11 Oct 2016 15:36:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cIfQyEWYphv6
        km3FUqV5LVEjyZo=; b=Fkfwg+h//wqOs1MylkDS6iEfF0RMquCEoD8vqqxKI+3k
        mLNDWwjKHlMg8JDN84qZF9wMETkCc2NY6Qu2T4x/WkqE+HYPFmoHqHk3pqisLalZ
        7M5XOcMleMk6Tp4SrNTBqJLaiaTBxk7yNgUWwCJQlaDfa6jRB7cvDjG7w50JrDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GgcCHl
        96V+hMiRRsbiOqGPbZVIvf7QZzaR0RStFSOloLtFrUCthkQjiO+wUaXXsTUHHmJ6
        DcmxNq0HvPqBAILndTNS3vaRBGEpb39L3uz/+IozElUmu3HnuNJ+QJEHxu7eS+LJ
        Si6I9U0Rr7WyBsX8zfvp4I9O1EyQuNLCxY4pM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02EA344FC9;
        Tue, 11 Oct 2016 15:36:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7884644FC7;
        Tue, 11 Oct 2016 15:36:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] contrib: add credential helper for libsecret
References: <20161009123417.147239-1-grawity@gmail.com>
        <1476198080.3876.8.camel@kaarsemaker.net>
Date:   Tue, 11 Oct 2016 12:36:38 -0700
In-Reply-To: <1476198080.3876.8.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Tue, 11 Oct 2016 17:01:20 +0200")
Message-ID: <xmqqoa2q8ypl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0842FF08-8FEA-11E6-8D35-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On Sun, 2016-10-09 at 15:34 +0300, Mantas Mikul=C4=97nas wrote:
>
>> +		s =3D g_hash_table_lookup(attributes, "user");
>> +		if (s) {
>> +			g_free(c->username);
>> +			c->username =3D g_strdup(s);
>> +		}
>
> This always overwrites c->username, the original gnome-keyring version
> only does that when the username isn't set. Other than that it looks
> good to me.
>
> Reviewed-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> Tested-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>

Thanks for a review.  I'll wait until one of (1) a squashable patch
to address the "we do not want unconditional overwrite" issue, (2) a
reroll from Mantas to do the same, or (3) a counter-argument from
somebody to explain why unconditional overwrite is a good idea here
(but not in the original) appears.


