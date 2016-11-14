Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A141F858
	for <e@80x24.org>; Mon, 14 Nov 2016 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754379AbcKNSKL (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 13:10:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62882 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753758AbcKNSKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 13:10:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D2664E430;
        Mon, 14 Nov 2016 13:10:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AQFUO/qhtIoTZPT2wTLf70OWgfc=; b=J2TkMU
        eQQ/MNexMsLVvkpMUF6IM+31YzhJQiBcsJdje3Y1OBrXdCDs0AGzrsm2r4ccG0QW
        T3idoLcpn9UAu3DM5GG1gpqWfR3uBajbnHQwrh1zYp+/N4zhxFaepRH1BWDNnkQR
        IlErQ8HJoGebr6OceMbIAGeCxjmZ2g5HHX2B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B0AQKpS81cdQtruy/CYdBKY6ZSaZ5i6s
        ki1FA/IiPwwVr8YuN30eDZd8uasMUuprK+n2PVOPIgwMB8n1k23KL8oTbGugvUIC
        KuyIV6AkmX45bCYTG9/oz3zZ17EFXUggUxOfgK6IcMD4Vr3FoGQV+1hZ9ZSzezPT
        erAFiX5n0ng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 047674E42E;
        Mon, 14 Nov 2016 13:10:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 623F64E42D;
        Mon, 14 Nov 2016 13:10:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 5/6] grep: enable recurse-submodules to work on <tree> objects
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
        <1478908273-190166-1-git-send-email-bmwill@google.com>
        <1478908273-190166-6-git-send-email-bmwill@google.com>
Date:   Mon, 14 Nov 2016 10:10:07 -0800
In-Reply-To: <1478908273-190166-6-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 11 Nov 2016 15:51:12 -0800")
Message-ID: <xmqqk2c6x79c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93947FB2-AA95-11E6-B044-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Teach grep to recursively search in submodules when provided with a
> <tree> object. This allows grep to search a submodule based on the state
> of the submodule that is present in a commit of the super project.
>
> When grep is provided with a <tree> object, the name of the object is
> prefixed to all output.  In order to provide uniformity of output
> between the parent and child processes the option `--parent-basename`
> has been added so that the child can preface all of it's output with the
> name of the parent's object instead of the name of the commit SHA1 of
> the submodule. This changes output from the command
> `git grep -e. -l --recurse-submodules HEAD` from:
> HEAD:file
> <commit sha1 of submodule>:sub/file
>
> to:
> HEAD:file
> HEAD:sub/file
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Unrelated tangent, but this makes readers wonder what the updated
trailer code would do to the last paragraph ;-).  Does it behave
sensibly (with some sane definition of sensibleness)?

I am guessing that it would, because neither To: or HEAD: is what we
normally recognize as a known trailer block element.


