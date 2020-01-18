Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D0C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B774D20748
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q1FAeoUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgARSPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:15:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57275 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARSPa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 13:15:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88228AF065;
        Sat, 18 Jan 2020 13:15:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TIBFMcii1zMq
        pCm8Cm9UN4ZM7M0=; b=q1FAeoULDzgpIjfG2yT+yCfcnd7LyKB8pwaZ2bjCwxwu
        2dYcrJpK5QfN2rS1ungYzv8Nkulsk+5rvbIRpUjSmV7IjONj6gYsMSJ1taCaUH5J
        LFnVThFjoL/n0ZijmXIMMVkXaWh25+1Zl+HC25U2fTKno+ugKYjI8gcxmSLvlGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K7SVcE
        +hnck8yNSSaFMNRX717snj9jpVaFExV+nmn1P/9FyE7136Mc5XdOh73GWgWlEnnO
        yjIxJp4nkeQhzH9fkqqqU1N7prXHE74gxqNSwHFBWGX4XYpGDNsGPHPb3Uivzhd9
        Ql64AmV+tB0aCfdAoW2+mFtWyr6SgHmoaxLpw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80F86AF064;
        Sat, 18 Jan 2020 13:15:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87D45AF063;
        Sat, 18 Jan 2020 13:15:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Groth <christoph@grothesque.org>
Cc:     git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
References: <87v9p9skjz.fsf@drac>
Date:   Sat, 18 Jan 2020 10:15:22 -0800
In-Reply-To: <87v9p9skjz.fsf@drac> (Christoph Groth's message of "Sat, 18 Jan
        2020 00:57:36 +0100")
Message-ID: <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F32E218-3A1E-11EA-8C49-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Groth <christoph@grothesque.org> writes:

> However, there is one problem with syncing git repositories, that has
> been noticed by multiple people [1]: The file .git/index contains not
> only the =E2=80=9Cgit index=E2=80=9D, but also a cache of stat-data of =
the files in the
> working directory.  Some file synchronizers are able to sync mtimes, bu=
t
> syncing ctimes would be bizarre (if it is even possible).

The stat-data in the index file is meant to be a mere optimization,
and after copying .git/index and the working tree files to a new
box, running "git update-index --refresh" would make them in sync,
no?
