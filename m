Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92462018F
	for <e@80x24.org>; Wed, 13 Jul 2016 19:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbcGMTQY (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:16:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbcGMTQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 15:16:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BA34F2951F;
	Wed, 13 Jul 2016 15:16:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ltWVtkDNwXc3K3b6bJ40bHkEs4Q=; b=phO5at
	lkrwa6D4njdm+jOZqcxXQpVvantC/iDg0mIBROvYd3bohVZx0pAuRBGIyU8xA17d
	FIGhvdSsF1y8zi3CWJO0dPbfOUSmeT7g8Og71xJe8GbXs7g+lon5e1YTY6+uoXbt
	ZmNxUll+9jIq+VKrqPX0Eb73S37JZ3yDxEDk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gaoHEWvBeUWsftyk3krRl25lndPe5gin
	gqHtMlG7+lHDCipqjQE/OeCuD4aWylYJisiwET65SKwFEh0fJyxYz7LrVvv1722i
	z79IYQyThfq/PWWE7h4wBLPm+cieHvQxEPBlT3SYJghY6/WYMjFty0oIRi6hbKNY
	NzK/DawqLyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A97112951D;
	Wed, 13 Jul 2016 15:16:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 324F229512;
	Wed, 13 Jul 2016 15:16:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Bergi <a.d.bergi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [feature request] Warn about or prevent --amend commits that don't change anything
References: <d2c3365d-6da9-dd58-ae7d-4a2020c6b513@web.de>
Date:	Wed, 13 Jul 2016 12:16:00 -0700
In-Reply-To: <d2c3365d-6da9-dd58-ae7d-4a2020c6b513@web.de> (Bergi's message of
	"Wed, 13 Jul 2016 20:56:22 +0200")
Message-ID: <xmqq4m7t1h8v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D00FB30-492E-11E6-9696-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Bergi <a.d.bergi@web.de> writes:

> when nothing is staged in the index then `git commit` warns about this
> fact with either "nothing to commit, working directory clean" or "no
> changes added to commit".
> However, `git commit --amend --no-edit` will happily record a new
> commit that differs in nothing than its commit date from the original.
>
> This is unexpected and can lead to mistakes.

What kind of "mistake" are you afraid of?

I can sort of see that "git commit --amend" might want to see two
summary diffstat output at the end, unlike "git commit" that shows
what changes were recorded relative to the parent.  In addition to
that "final result is different in this way from the parent" output,
you might also want "this is the change you made by amending" and
knowing the fact that you can notice you didn't add anything by the
latter being empty _might_ give you an additional peace of mind.

But is that the kind of mistake you are worried about?  IOW, you
thought you made and added changes X, Y and Z to the index before
running your "commit --amend", but you forgot the "add" step and did
not add anything?  If so, even the second diff i.e. "this is what
you changed by amending" would not help very much, and your "you
need --allow-empty if you really do not want any changes to the
tree" would not either, if you added X and Y but forgot to add Z.

So I am sensing a slight XY problem here.
