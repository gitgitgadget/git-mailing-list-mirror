Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14461FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 22:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966327AbcLVWhs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 17:37:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966322AbcLVWhr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 17:37:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 920BB5A719;
        Thu, 22 Dec 2016 17:37:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L2/XuuDe13nslYJt8ID6hdN3Nmw=; b=n8/jip
        SHhTBcmlAuyCR/re0eEU+RXk/rujbJfV5xdmk1OCvvmnRRrQCg8WkXt8QI/iK+YO
        a6JmzE8LSNFssGQtgKHGyNsaxotZGiyp6Y3RH+rDBdhm4zcGgZRS8PT7rftqyYEb
        3Uc5CjLEvC/wRV5LXTAIyg0Ok/VzujGs490TM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=no2uXEiFBja2IzlDo3C+OKusVIMVXFSe
        rFUIRcHf6ixvknuvNgqq+7orknsteFEM80YPfY2f8G2UWg5/isQ7DP+4h9FRjrFC
        Hbrl+gjY+IiWt3HKeVaCOoV4cRxrf8we0bVbQdpnYlGAWTqU/3Khzu05JLvazpPp
        8jZo+J5jeCY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7332B5A718;
        Thu, 22 Dec 2016 17:37:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA4ED5A717;
        Thu, 22 Dec 2016 17:37:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diffstat information to rebase
References: <20161222185609.21139-1-sbeller@google.com>
Date:   Thu, 22 Dec 2016 14:37:44 -0800
In-Reply-To: <20161222185609.21139-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 22 Dec 2016 10:56:09 -0800")
Message-ID: <xmqqtw9vegjr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 425363A0-C897-11E6-8C47-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>     $ git rebase -i HEAD^^
>
>     pick 2eaa3f532c Third batch for 2.12
>     # Documentation/RelNotes/2.12.0.txt | 40 +++++++++++++++++++++++++++++++++++++++
>     # 1 file changed, 40 insertions(+)
>     pick 3170a3a57b add information to rebase
>     # git-rebase--interactive.sh | 2 ++
>     # 1 file changed, 2 insertions(+)
>     
>     # Rebase 2eaa3f532c..3170a3a57b onto 2eaa3f532c (1 command)
>     #
>     # Commands:
>     # p, pick = use commit
>     # r, reword = use commit, but edit the commit message
>     # e, edit = use commit, but stop for amending
>
> I am not completely satisfied with the result, as I initially wished these
> information would just appear in line after the commit subject, but this
> comes close. Maybe the last line also needs to be dropped.

This is an interesting and thought-provoking idea ;-).

In practice, you would probably be touching the same file over and
over again in the series you are rebasing, when you are doing "many
miniscule commits recording experiments and dead ends, with an
intention to clean it up later", and by definition, your subject
lines are useless series of "oops", "fix", etc.  The subject and
list of filenames would probably not make a good "summary" of the
changes for each commit.

Stepping back a bit, right now, when the user asks "git commit" to
supply material to help writing a good commit message, we punt on
mechanically generating a good summary and instead just show output
of "diff --cached".  If we can come up with a way to mechanically
generate a concise summary for the purpose of annotating "rebase -i"
instruction, we probably can reuse that and append it at the end of
the log editor "git commit" spawns when it is run without "-v".

Also, this makes me wonder if the ideal endgame might be to depend
on the current "rebase -i" UI as little as possible.  

"rebase -i" is "interactive" only to the extent that you can
interact in your text editor the order and the fashion in which the
changes are applied.  If we instead teach either gitk or tig to
easily allow you to "tick" each commit you see in their UI and
generate the instruction used by the sequencer, and feed that and
actually drive the sequencer to execute it (perhaps inside a
temporary/throwaway working tree) while you are still in gitk or tig
and reload the UI dynamically to let you view the result, the
overall user experience would become a lot more "interactive".

