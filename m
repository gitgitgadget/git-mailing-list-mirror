Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D4C207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 16:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966341AbcIWQnt (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 12:43:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61267 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966306AbcIWQnt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 12:43:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9CA93E296;
        Fri, 23 Sep 2016 12:43:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AsagiWVXk8XNGsMHQqJFXT2bDxA=; b=dAKzMI
        U1uW7uibn7/NlUoruF4har+OKP1C9dU+5NKmUyBnxD0QEp/z5vMs/2IZ3xu8sqQV
        EhRHM8ssfqDuRqETWoEWqXozUL07al0sQ6mA2qbm/weeb5yZBUqZIMUe+MNPuiLr
        wr4RZg8BjOTzIF+0wAG3RIpjGADlnTLNGrb/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qI5r1lVXi94BthD5l3Wdp1hl2hExoljB
        8eP7pUQUv6JTWirUNV3Wtfn287uVTXHASNJrSj0aA4WgZj9N0TQf7l6Ja7dXtXz9
        wXs53UY+5lOoQsG6Cc7Ns7JZPePp9Od5kFa6GUb2nzOe4iJzce7bsgRl54WjJaMv
        RotxmAWnf4c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A159A3E295;
        Fri, 23 Sep 2016 12:43:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18F413E294;
        Fri, 23 Sep 2016 12:43:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [RFC PATCH] revision: new rev%n shorthand for rev^n..rev
References: <20160923105254.10235-1-vegard.nossum@oracle.com>
Date:   Fri, 23 Sep 2016 09:43:45 -0700
In-Reply-To: <20160923105254.10235-1-vegard.nossum@oracle.com> (Vegard
        Nossum's message of "Fri, 23 Sep 2016 12:52:54 +0200")
Message-ID: <xmqqr38a1s8u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5CD7A70-81AC-11E6-8717-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> I use rev^..rev daily, and I'm surely not the only one. To save typing
> (or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
> we can make rev% a shorthand for that.

No, we cannot.

'%' is not reserved as a special character that is forbidden in
reference names, and for somebody who has a branch whose name is
'master%', such a change will suddenly make 'master%' mean something
completely different, breaking existing users' repositories.

This is why existing rev^@ and rev^! both use the "^" as the first
character that introduces the "magic" semantics; "^" cannot be a
part of a refname.  Also sequences that begin with "^{" and "@{" are
reserved as escape hatches to allow us extend the revision syntax in
the future ("^{" works on history, while "@{" bases its working on
the reflog data).

As "rev^$n" is "nth parent", it may be a possibility to use "rev^-$n"
as a short-hand for "^rev^$n rev".
