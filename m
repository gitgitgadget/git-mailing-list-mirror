Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0C4C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF182072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q0usUvlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbgAXUWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:22:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60807 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbgAXUWx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:22:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B77969E3BD;
        Fri, 24 Jan 2020 15:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OLKuNtqWA/2EpVsiij4N6q7HpP4=; b=Q0usUv
        lCEBb4AnYXWvY8TLC6xZerrwQgzqMhgklCa0AhDOF1u0y5FhD+xxQifosDVU9loD
        B7G94sqXy/pR3cTEPpF6e0KK8J1H34XJrrdiwYjwUdCybu7BCsFfe0EX59qAY3vW
        b2ZBJspjYCbh8XsNeH+a5x3wUBDJ/onYamVuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qGDDh67zCZKl/63jqBLoPADWv5ztEM2Y
        06Td/8pyRzQmHgw2gHLlxN96wNspgFUlbJJfxvsx2eeCVAF8sbMN+if0IwJRI05o
        j9kuG8yL/OOkoQn6fEBTmGS1OrbEfZJhYGEjxyddUaS8k9H3t+xNSesikQm6PS9d
        E+2az9R4NB8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AECEF9E3BC;
        Fri, 24 Jan 2020 15:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D79E59E3B6;
        Fri, 24 Jan 2020 15:22:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew Rogers <mattr94@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 6/6] config: add '--show-scope' to print the scope of a config value
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <5549db7e39bf38aa5cc42292421f4676e3073b7d.1579825267.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 12:22:46 -0800
In-Reply-To: <5549db7e39bf38aa5cc42292421f4676e3073b7d.1579825267.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 24 Jan 2020
        00:21:06 +0000")
Message-ID: <xmqqblqszjs9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A0DE2A4-3EE7-11EA-B307-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +const char *scope_to_string(enum config_scope scope)
> +{
> +	switch (scope) {
> +	case CONFIG_SCOPE_SYSTEM:
> +		return "system";
> +	case CONFIG_SCOPE_GLOBAL:
> +		return "global";
> +	case CONFIG_SCOPE_LOCAL:
> +		return "local";
> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
> +	case CONFIG_SCOPE_COMMAND:
> +		return "command";
> +	case CONFIG_SCOPE_SUBMODULE:
> +		return "submodule";
> +	default:
> +		return "unknown";
> +	}
> +}

In earlier round(s), this was called config_scope_name(), wasn't it?

"scope_to_string()" is a much worse than "config_scope_name()" as a
name of a global function (e.g. we won't know what subsystems other
than "config" may want to use "scope").  As you remember, Bert's
"remote rename" series wants to use a public interface like this
function, and the series expects this function to be called
config_scope_name().  Let's not rename a public API function
suddenly---it disrupts other topics in flight.

Thanks.
