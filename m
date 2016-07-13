Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1812018F
	for <e@80x24.org>; Wed, 13 Jul 2016 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbcGMRqn (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:46:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750987AbcGMRqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:46:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1675E2B8DF;
	Wed, 13 Jul 2016 13:46:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TnZIJSF4HsmRuQtaPNd9/5MJcqo=; b=s9YTQs
	t5dePLIEllZrZw0Wibxw8HsdyHapnpjRgaGzqKKaeIFAMzlU9v3boCMvXeKUwxo2
	IHVxfL+sO+edDA4DZw0cF9HPOe/sEnJGEH5xaYSt4cLHkypgfXsruGc7tnd/CBsF
	5324pna+xDdMMYWWDwsb7GMObAkqnhO44LJAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DoqBXl6IznJED99D3x/X3ly1iWFgBYSc
	7nuPX9QX0oCTGaq/ez7+ji4bYT0EizEGX+CV8VMn7PIfVWN1QQMGAHkZwDc27WpD
	6oAe/JBADGlmvmNsmAMfXSjq32rfAM9GLzWtHfB9YyT5VxOqSno62wia+HGu5lo5
	lJOhnBVIJuk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FDB22B8DD;
	Wed, 13 Jul 2016 13:46:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CE0E2B8D8;
	Wed, 13 Jul 2016 13:46:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CVJr6-9CnyrOU4UoPPGu6Ovn_=-2YKeqC8Lp_rVnh5fg@mail.gmail.com>
Date:	Wed, 13 Jul 2016 10:46:33 -0700
In-Reply-To: <CACsJy8CVJr6-9CnyrOU4UoPPGu6Ovn_=-2YKeqC8Lp_rVnh5fg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 13 Jul 2016 19:40:40 +0200")
Message-ID: <xmqqh9bt1ldy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE3E0F7E-4921-11E6-96CB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On the subject of truncation, there is something else I should note.
> The field sd_size in struct stat_data is 32 bits, so large files will
> overflow it too, regardless of platforms. I did not do anything
> because I checked and double checked and was pretty sure we did not
> use it for anything meaningful (as a file size). To us, it's just
> another random number, like st_ino, that we check to detect if a file
> has changed.

Yes, the comparison to flip DATA_CHANGED bit near the end of
match_stat_data() has a cast for that exact reason.  It might
deserve a comment there.
