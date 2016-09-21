Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8294C1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935072AbcIUQPP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:15:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55230 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935053AbcIUQPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:15:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 012D03ECFD;
        Wed, 21 Sep 2016 12:15:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OuJVk8jurh8exAR/W73dA2V00mw=; b=u2TkH0
        xVXvtqyyqSeEbqIWgdqD/hdY6+ORPs75Zm+BYL191lPbz672jbMZmTnWmpXmFVKy
        HJAGHqiN4bg08eoRUThWQ6hEb8005VOUFPQ6SPw6QxuIkb8fvJ/kXmRPEgjCEMjT
        zMSE2bxxCSUhVKNVvV3eBl27i9hfqouXu4dzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dSTO2B0vDE/h2kQHKUR23KiFGdZ9Qyau
        rkAXib6T5AowXWXI2jX6dmqDOR+WbR1538L0WvD1mECWNKamsjYkXQR0hE/zIcyA
        3HXpVdvJTsd4vaRX0sjBGoER358kZqh+SfYJHQDZIPF63vZG3puj9RgCk9wq+JIW
        Du2o/IOLyxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE0D33ECFC;
        Wed, 21 Sep 2016 12:15:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62E3B3ECFA;
        Wed, 21 Sep 2016 12:15:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: pager.<cmd> doesn't work well with editors
References: <nrmbrl$hsk$1@blaine.gmane.org> <nrmd6u$imf$1@blaine.gmane.org>
        <xmqqh99bho7a.fsf@gitster.mtv.corp.google.com>
        <20160920014733.7whjuxfuimx5ztdb@sigill.intra.peff.net>
Date:   Wed, 21 Sep 2016 09:15:09 -0700
In-Reply-To: <20160920014733.7whjuxfuimx5ztdb@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 19 Sep 2016 18:47:34 -0700")
Message-ID: <xmqqponxb56a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9256D0B8-8016-11E6-929E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And this isn't really limited to the editor. It's more _annoying_ with
> the editor, but really "pager.tag" does not make any sense to set right
> now, because it is handled outside of the "tag" command entirely, and
> doesn't know what mode the tag command will be running in.

Stepping back even further, perhaps the whole pager.<cmd> was a bad
interim move.  For those who set "less" without "-F", being able to
set pager.<cmd> to false may still be necessary, but I am wondering
about setting it to true or a command string here.

It did mean well and may have helped when "git <cmd>" that produces
reams of output had not yet learned to auto-paginate as a stop-gap
measure by allowing users to set pager.<cmd>, but I wonder if the
ideal course of action was to identify (or "wait until people show
their desire") individual operating modes of various commands and
teach them to auto-paginate.  For example, "tag -l" may be one of
them that we would want to teach to.
