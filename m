Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09AE20899
	for <e@80x24.org>; Thu, 27 Jul 2017 15:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdG0PYO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 11:24:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63668 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751122AbdG0PYN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 11:24:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12582A09F2;
        Thu, 27 Jul 2017 11:24:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2W7AMCpJzPSa87erTCLEO/H5Gtk=; b=bJVqrk
        WNuwpAeseL8zQnR+hgbmi/1SUfZA3GUbKEdOubSotOBIQC0Rg8WuEKuHCHcQcU4b
        iPjB9SHzM7UodWFHLXRSrDQhBEzObNHhs7YL37q+p/gh7TQzsdyl47P/pfqJf603
        TjkQ02thUKo+/xZKyNYYSkQQcRC9j0IhNoPBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mYYiK4AY2/Vx3zTK2iIRH6qlAHn7YkUD
        rWhzyxGUYp6HFpEltYI+9LgpnGqJI8aEghPPB2gdQEi9ZqXQ0n0CQdzwc0LGPQ7O
        kRHBwB6Pt8thMkUAPEMouwIbBTCPGP3r3ncLt9IJ3HkgtJaT3wjVSEJrZQ0xNBXe
        Wz/PCPPFBVc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08F8EA09F1;
        Thu, 27 Jul 2017 11:24:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 611E9A09ED;
        Thu, 27 Jul 2017 11:24:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
        <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
        <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
        <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
        <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
        <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
Date:   Thu, 27 Jul 2017 08:24:06 -0700
In-Reply-To: <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net> (Phillip
        Wood's message of "Thu, 27 Jul 2017 14:25:40 +0100")
Message-ID: <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1B1D276-72DF-11E7-AC5A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> On 26/07/17 23:12, Junio C Hamano wrote:
>>> I think
>>> you are already 80% there without adding a yet another option,...
>> ...
>> I'm interested in the 20% as it's about 100% of my rebase conflicts.

OK, then at least a fixed --rerere-autoupdate would hopefully limit
the scope of the additional 20%; I'd suspect that a new option would
also internally turn on --rerere-autoupdate, so that the remaining
changes you would see upon --continue would be limited to what the
user had to manually resolve (and edit without having textual conflict,
aka evil merge to resolve semantic conflicts).

I am *not* opposed to an option to tell the command to blindly take
such remaining changes, as long as it stays optional---the use of
the option can then be taken as a strong signal that the user is OK
with the local changes in the working tree, even if the user may not
have marked them as resolved with "git add".

>>> And from the
>>> workflow point of view, encouraging them to "git add" their manual
>>> resolution after they are satisified with their changes by not doing
>>> "git add" blindly for all changes, like your --autostage" does, is
>>> probably a good thing.
>
> Git allows 'git commit -a' to complete a conflicted merge which I
> think is much the same thing as I'm proposing....

"-a" is a strong enough sign that the user is OK with all the paths;
"git commit" without an option does not.  So it is OK for a new
option (perhaps "--all-autoupdate", which does more than the
existing "--rerere-autoupdate") to become the signal that the user
is OK with all the local changes.

This is a tangent, but concluding a merge with "commit -a" (or "add
-u && commit -a") has always been discouraged among Git expert
users, and it will stay to be so.  If you search the list archive,
you would find a good explanation by Linus on this, but a short
version is that this is because it is normal to start a merge in a
dirty working tree where the user has local changes that the user
knows will not interfere with the merge.  

Because "rebase" refuses to work in a dirty working tree, the
analogy with "merge" does not quite hold.  Doing "add -u" before
telling it to "--continue" would be much safer.

Thanks.



