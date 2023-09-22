Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B57CD484C
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 18:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjIVSMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIVSMt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 14:12:49 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976C8A7
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:12:42 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 38MI9tZD1898060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 18:09:56 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Ben Boeckel'" <ben.boeckel@kitware.com>, <git@vger.kernel.org>
References: <ZNffWAgldUZdpQcr@farprobe> <ZQ21NsLmp+xQU5g+@farprobe>        <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>        <ZQ3GAJ/AHsM9e9a6@farprobe>        <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com> <xmqqediq2j0g.fsf@gitster.g>
In-Reply-To: <xmqqediq2j0g.fsf@gitster.g>
Subject: RE: [BUG] `git describe` doesn't traverse the graph in topological order
Date:   Fri, 22 Sep 2023 14:12:31 -0400
Organization: Nexbridge Inc.
Message-ID: <032d01d9ed80$5e569670$1b03c350$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMniK2C5ueFGaecrAkj2WziqqcqsgIDXfPaAV8c8ysBL0/7iQKiZtYXAnm84MCtPn6GMA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, September 22, 2023 1:52 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> There appears to be a merge at 446120fd88 which brings v9.3.0.rc0 closer
to HEAD
>than v9.3.0.rc1.
>
>I didn't look at the actual graph but let me say I trust you ;-)
>
>I wonder if there should be an obvious "explain why you gave this name"
mode added
>to the command, though.  The command should be able to say "The closest
path from
>HEAD to any tag is via this, that, and that commit, which is N hops to tag
T0", and
>from there, the user should be able to say "Oh, I thought T1 was closer,
let me try
>again to describe HEAD, limiting the candidate only to T1" and run the
command in
>that mode, which should be able to say "The closest path from HEAD to any
tag that
>is allowed as a candidate is via these commits, which is M hops to tag T1".
And if M
>is smaller than N, then that may deserve to trigger a bug report (but as
you said,
>there are rules like preferring annotated over unannotated tags involved,
so it may
>not as straight-forward as comparing the two integer hop counts).
>
>Thanks for digging.

I'm wondering whether we need something more general that --first-parent.
Perhaps something like

git describe commitish [ commitish ... ]

Where the traversal must cross the set of specified commitish points in
history in order to find the expected tag. In Ben's case, I do not think
that would help much, given the complexity of his history. Perhaps a
--verbose argument might display the analysis path done by git describe as
above. Sadly, I am not familiar with this code area.

What confuses me is how, in the other subthread, that adding sleep 1 to the
construction of history should make any difference. My understanding is that
the path to the tag is invariant of the commit-date.

