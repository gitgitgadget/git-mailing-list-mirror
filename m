Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901B21F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfIQQ7S (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:59:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64994 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfIQQ7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:59:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E74798C12;
        Tue, 17 Sep 2019 12:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MNRsA/Td9dScUoVUK1/UyIFghzw=; b=NcOFvp
        yKV4ahciDIKQajetz3DfelN4EJ8foftRVb5LCYHD/sYOzFoWE1MNAo3dLZlXU8w3
        zt064u68uVRhxycEBejikq+KCYMg7invMF24hNA3T5gJm8JFgq1VK4BG+GJNRpGB
        PaX54kr2YgGcNE6Q9iGyBZhXqWaSrVhJrswgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EE12uWBme/HKz6NyJwnvs16sl41kaPLf
        mUetCCjqQ0R0AcSk03svf3CuhxD1quMfKXifETywPTo0NszgpMdZ1aP2bDiwpfk9
        uTG/PBHCKaoSXfMPP01Cv5m9tsTm5p94foU/1X4f1yqHzqKY05ulvsaKSqWLbtZP
        jINFf5PqwEg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 468D898C11;
        Tue, 17 Sep 2019 12:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CC6E98C10;
        Tue, 17 Sep 2019 12:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Git config allows value setting from stdin
References: <20190917133135.190145-1-git@zjvandeweg.nl>
        <20190917133135.190145-2-git@zjvandeweg.nl>
Date:   Tue, 17 Sep 2019 09:59:11 -0700
In-Reply-To: <20190917133135.190145-2-git@zjvandeweg.nl> (Zeger-Jan van de
        Weg's message of "Tue, 17 Sep 2019 15:31:35 +0200")
Message-ID: <xmqqy2ym97vk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79CB8F36-D96C-11E9-AAA5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zeger-Jan van de Weg <git@zjvandeweg.nl> writes:

> Subject: Re: [PATCH 1/1] Git config allows value setting from stdin

Probably something like this, with the "<area>:" prefix.

	config: learn the --stdin option to take args from the standard input

> When setting values in the git config, the value is part of the
> arguments for execution. This potentially leaks the value through
> logging, or other programs like `ps`.

OK.

> Prior to this change, there was no option to do this. This change adds
> the `--stdin` to be combined with `--add`. When passed, the value cannot
> be passed and is read through stdin.

That's overly verbose.

	Add the `--stdin` option that can be used with `--add` to
	instead take the variables and values from the standard
	input to hide them from prying eyes.

or something?  When you say "Add", we know there isn't any right now
(that is why you are adding, after all).

Also, shouldn't the variable also be considered sensitive?  IOW

	$ git config --stdin --add <<\EOF
	remote.hidden.url=https://user:pass@over.there/repo
	EOF

instead of

	$ git config --stdin --add remote.hidden.url <<\EOF
	https://user:pass@over.there/repo
	EOF

?  

Incidentally, allowing it to take variable=value pair would also
allow you to set many of them in batch, which is another benefit.

> -'git config' [<file-option>] [--type=<type>] --add name value
> +'git config' [<file-option>] [--type=<type>] --add [--stdin] name [value]

This does not convey "you pass name and value without --stdin, or
you pass only name with --stdin" and instead allow a nonsense like
"git config --add name".  Splitting it into two would be a way to
tell this unambiguously to the readers, e.g. 

	git config [--type=<type>] --add name value
	git config [--type=<type>] --add --stdin name

although I suspect we would also want to allow treating the varilabe
names as sensitive.

Thanks.
