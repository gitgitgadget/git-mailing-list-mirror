Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B66C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7647920704
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="usmrR3ZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgDWTcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:32:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58066 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgDWTcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 15:32:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 822F7CA197;
        Thu, 23 Apr 2020 15:32:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=spL9JrgzUr42xES6JOejcXO7aII=; b=usmrR3
        ZTytGzT0PkHIsZ+Yq4bRIsQdUaZ9MmGFyhNJCbI1TbLGcbiDgPEpw3Gtfoon2GmL
        9HbQnicljfjlcH6ovNAw4Xp2fHikMTTEVvQ5oqNjb68pmxJs88wXxCmYQaZP/0E7
        Jnsfywxt+XQuos/JPhMQObDEWFQ6N8uyQSbgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tEglCZzvMeON+B72siSYBDq2b6uAwm85
        mACOyOn8SrmofXuS5rVP95vOe1W3WrnzQbwCEzPQilhdaolW4TiOyN1bfE2g2t9N
        052To1fMVE87trq8UPwpy9hq6Or5UBGyQMDjKNCNEP7CEQMd9wdgjJUPlqg3XBcj
        YC8YP/KlelY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7ABAECA196;
        Thu, 23 Apr 2020 15:32:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F9D8CA195;
        Thu, 23 Apr 2020 15:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org
Subject: Re: [PATCH v2] ssh: add 'ssh.keyfile' option
References: <20200423064110.77258-1-ray@ameretat.dev>
        <20200423112110.45405-1-ray@ameretat.dev>
        <d26f8556-ed9b-5145-735b-d348449bb31d@kdbg.org>
Date:   Thu, 23 Apr 2020 12:32:06 -0700
In-Reply-To: <d26f8556-ed9b-5145-735b-d348449bb31d@kdbg.org> (Johannes Sixt's
        message of "Thu, 23 Apr 2020 19:24:09 +0200")
Message-ID: <xmqqimhqgfrd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F1CED58-8599-11EA-A76C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 23.04.20 um 13:21 schrieb Raymond E. Pasco:
>> When a specific private key needs to be used with a repository, manually
>> specifying it via 'core.sshCommand' is not ideal. This option allows a
>> keyfile to be specified in the local configuration. If a keyfile is
>> specified, SSH agents are disabled for the command.
>
> You can do this without modifying Git. Say, your key file is
> ~/.ssh/id_other_ed25519, then do this:
>
> Rename your remote to use an invented host name:
>
>   git remote set-url origin git@other.github.com:other/repo
>
> Then attach the invented name to the real host name and the identity in
> your ~/.ssh/config:
>
>   Host other.github.com
>     Hostname github.com
>     Identity ~/.ssh/id_other_ed25519

Nice.  I wonder if this answer (and answers to other "how would I
use .ssh/config to adjust Git to suite my use?" questions people may
often ask) can be put in some of our documentation.
