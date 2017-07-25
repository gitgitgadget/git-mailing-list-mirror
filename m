Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574171F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbdGYVWG (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:22:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61945 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752211AbdGYVWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:22:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E925074FDB;
        Tue, 25 Jul 2017 17:22:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iqc8rgjjuCtk5H9rPFJ87yiBIXg=; b=IuZPzW
        wzujt9blmjAkSQV6o01tY5r5gjobCU6oso0HXzcuu3tt95l4ViTrgYPW4kPbn1CF
        F1pAh8yTGMQw0rDjD+8Lj/1AKIM91+6AtQcKoqxJLU/VxpDVX2/fc3/KPVxg8Dyk
        LmLB3cIdz2Sg9G+xx73zvjSQ2ZXfbBWH0AXm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=duE2Da0puC7iqGlBLZ8gWFl6qaIM8U+b
        nArHgQK9qJiKkGyfAwHv7e5BHbAbaWiC+8yM/Tuae0dGxUSiROYE94lm9ECupMPZ
        enI8pkPRtHSikHKEmRngiOnYRcFusVu5p9zCh7xzs4fQJ2z1u1JMdPGt+K7iqiMF
        rmNWO9m59F8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBDAC74FDA;
        Tue, 25 Jul 2017 17:22:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E1AE74FD8;
        Tue, 25 Jul 2017 17:22:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/3] interpret-trailers: add --where, --if-exists, --if-missing
References: <20170724082044.26199-1-bonzini@gnu.org>
Date:   Tue, 25 Jul 2017 14:22:00 -0700
In-Reply-To: <20170724082044.26199-1-bonzini@gnu.org> (Paolo Bonzini's message
        of "Mon, 24 Jul 2017 10:20:41 +0200")
Message-ID: <xmqqshhktdon.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CD75426-717F-11E7-8618-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paolo Bonzini <bonzini@gnu.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> These options are useful to experiment with "git interpret-trailers"
> without having to tinker with .gitconfig (Junio said git should ahve
> done this first and only added configuration afterwards).  It can
> be useful in the case where you want a different placement for the trailer,
> or for scripts/aliases that don't want to rely on specific .gitconfig
> settings.
>
> Compared to v2, the main change is that option order on the command-line
> is respected.  That is,
>
> 	--trailer 'acked-by: foo' --where end --trailer 'signed-off-by: me'
>
> will only apply where=end to the second trailer.  Likewise,
>
> 	--where end --trailer 'signed-off-by: me' --no-where \
> 	--trailer 'acked-by: foo'
>
> will only apply it to the first, reverting to trailer.*.where for the
> "acked-by" trailer.

I am getting the following in my build after merging these to 'pu'.

trailer.c: In function 'apply_arg_if_exists':
trailer.c:270:2: error: enumeration value 'EXISTS_DEFAULT' not handled in switch [-Werror=switch]
  switch (arg_tok->conf.if_exists) {
  ^
trailer.c: In function 'apply_arg_if_missing':
trailer.c:307:2: error: enumeration value 'MISSING_DEFAULT' not handled in switch [-Werror=switch]
  switch (arg_tok->conf.if_missing) {
  ^
trailer.c: In function 'process_command_line_args':
trailer.c:717:3: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
   int separator_pos = find_separator(string, cl_separators);
   ^
cc1: all warnings being treated as errors
m
