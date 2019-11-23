Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B09C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 02:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C36E2070E
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 02:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iYC5tyEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKWCPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:15:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58383 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWCPk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 21:15:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69DF1995FF;
        Fri, 22 Nov 2019 21:15:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W18fz3FHudJpv8qVKMYfwlxMvb0=; b=iYC5ty
        EXkzo8+uv9pIaa8YdEx5LdHXqoKu5cV4Ni9JKOqdJdcrORsxKGUC4V8ovEl9duHr
        WxFVl+Re5wjsX0ZwxKaJFvgn7Rhn0OLaV2CHviOCMM2Ed57EXgv/UF7IYT30Sgcz
        g+0w/ZaRoIJreWNEjYbFJudBE2Wy6hjTbVTrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QMvnT+qa7xKkJIAyNDUIr8uoLr5yEDnT
        J2HQPepq0QI4jaHy8YFe7JQB0kesBJio9BCPv/PbQt+lMDPEo7wnGt2Vhcqe3RzN
        WGfVYwdqHUUKF98zyw+BLg06xjXeU+7R++pML4hgeF5bjq/DYbc60LKOKnHKWjAW
        6Ppfv5bPjzs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61569995FD;
        Fri, 22 Nov 2019 21:15:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D497995FB;
        Fri, 22 Nov 2019 21:15:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Avis <eda@waniasset.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-log diff formatting options: some turn on diffs, some don't
References: <55ab4d09c51446c6b23abbb1c92441d6@WCL-EX13MBX-DR.wcl.local>
Date:   Sat, 23 Nov 2019 11:15:30 +0900
In-Reply-To: <55ab4d09c51446c6b23abbb1c92441d6@WCL-EX13MBX-DR.wcl.local> (Ed
        Avis's message of "Fri, 22 Nov 2019 11:42:58 +0000")
Message-ID: <xmqq1rtz2v99.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20925A1C-0D97-11EA-BC38-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Avis <eda@waniasset.com> writes:

> If you run git log -c this implies the -p flag.  But git log -r
> does not imply -p, even though both -r and -c are flags which
> exist to 'control the formatting of diff output' according to the
> documentation.

`-r` does not control the formatting, actually.  It has no effect in
the Porcelain "git diff" and "git log"---it is always on and there
may not even be a way to turn it off (so, effectively it is a no-op).

The only case I offhand recall that `-r` makes difference is when
running `git diff-tree`, whose default output format is the `--raw`
format.  `git diff-tree A B` and `git diff-tree -r A B` both give
its output in the raw format, but if there are differences in the
contents of the subdirectory between A and B, the former just shows
the subdirectory without showing which paths in that subdirectory
differ, while the latter shows the individual paths.  For obvious
reasons, the '-r' option must *not* imply '-p' for this command, to
which the `-r` option has any effect.

I've responded to your email even though I wasn't the entity to whom
it was addressed.  I promise I won't do so again ;-)

> To learn how we protect privacy, please use this link (https://www.qma.com/gdpr.html) to read our Privacy Notice.
>
> This email and any files transmitted with it are CONFIDENTIAL and are intended solely for the use of the individual(s) or entity to whom they are addressed. Any unauthorised copying, disclosure or distribution of the material within this email is strictly forbidden. Any views or opinions presented within this email are solely those of the author and do not necessarily represent those of QMA Wadhwani (QMAW) unless otherwise specifically stated. An electronic message is not binding on its sender. Any message referring to a binding agreement must be confirmed in writing and duly signed. If you have received this email in error, please notify the sender immediately and delete the original. Telephone, electronic and other communications and conversations with QMAW and/or its associated persons may be recorded and retained.
>
> Please note that your personal information may be stored and processed in any country where we have facilities or in which we engage service providers. If you provide personal information to us by email or otherwise, you consent to the transfer of that information to countries outside of your country of residence and these countries may have different data protection rules than your country.

