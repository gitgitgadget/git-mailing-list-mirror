Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224BFC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 20:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29E920715
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 20:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HoykT+l4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgAFUbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:31:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50268 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgAFUbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 15:31:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9943029E68;
        Mon,  6 Jan 2020 15:31:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L0h2c1fiPUPsJ6bMLBlh56D0CGM=; b=HoykT+
        l4KWDJYbTSCNiKd/TDi2E+hv7ZzruyckR/Tf3WodCASFVHyJ5N2FXgDUMwN7S7Mu
        mStxaLf8DeYxHz2dXl88ooywWchErolAtFTCUI4fZ/bo8haYIptQI0Ylr/eOC0QD
        6L2RJSq5aurKDebpolbbW1xGYwbBfOFnKZxbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kQoOORzWHBiB/JsXSyvgIO7IVkyqpiwM
        vZWvkHUiCb7Ic0OCmASSOoaoBSZ3Aqqlte9emCEHY6MP+HgcAaXSN2+8GydNGdrI
        OqdfRKXR+gay0NB+PyINjgld5oAQoDvxhNZF3k7o6v/BGrxhIwSUg7vxFDgD5Joj
        8iOEAkHkqMY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 910DA29E67;
        Mon,  6 Jan 2020 15:31:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBC2429E64;
        Mon,  6 Jan 2020 15:31:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] commit: make the sign-off trailer configurable
References: <20200105174127.9278-1-hji@dyntopia.com>
        <20200105174127.9278-2-hji@dyntopia.com>
        <71a718a7-2be7-391c-dc8f-0626a0a21aac@gmail.com>
        <xmqqtv58a5m2.fsf@gitster-ct.c.googlers.com>
        <cfa40ca5-98a1-fc9c-9ccc-f14b81119e60@gmail.com>
Date:   Mon, 06 Jan 2020 12:31:28 -0800
In-Reply-To: <cfa40ca5-98a1-fc9c-9ccc-f14b81119e60@gmail.com> (Derrick
        Stolee's message of "Mon, 6 Jan 2020 14:53:58 -0500")
Message-ID: <xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 853559B6-30C3-11EA-BB85-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Since I started the line of "this isn't a bad idea" I'll follow up with
> the historical search. Here are previous attempts from 2018 [1], 2015 [2],
> 2010 [3].
>
> Thanks,
> -Stolee
>
> [1] https://lore.kernel.org/git/20180204020318.4363-1-chenjingpiao@gmail.com/
> [2] https://lore.kernel.org/git/1435217454-5718-1-git-send-email-cmarcelo@gmail.com/
> [3] https://lore.kernel.org/git/alpine.LNX.2.00.1001131635510.16395@vqena.qenxr.bet.am/

Thanks.  In an earlier thread, we did

https://lore.kernel.org/git/20090401175153.GA90421@macbook.lan/

to which I said "... the wording we can update if somebody can come
up with a better one" in its follow-up.  Perhaps it's time for us to
be that somebody to help everybody to be on the same page.

Here is my attempt, starting from what I wrote in

https://lore.kernel.org/git/xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com/

-- >8 --
Subject: commit -s: document why commit.signoff option will not be added


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 As I said in https://lore.kernel.org/git/7veiw69p26.fsf@gitster.siamese.dyndns.org/
 I have a mixed feeling about this.  To projects that use the same
 definition of what SoB means, not adding the configuration ever is
 the right thing to do, but Git is to be used by other projects, and
 some of them may use SoB with a completely different meaning that
 has no legal weight---and to them, lack of such an automation may
 be a bug.  So ...

 Documentation/git-commit.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index ced5a9beab..1909551087 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -171,6 +171,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	the rights to submit this work under the same license and
 	agrees to a Developer Certificate of Origin
 	(see http://developercertificate.org/ for more information).
++
+As it makes it harder to argue against one who tells the court "that
+log message ends with a SoB by person X but it is very plausible
+that it was done by inertia without person X really intending to
+certify what DCO says, and the SoB is meaningless." to more
+publicized ways to add SoB automatically, Git does not (and will not)
+have a configuration variable to enable it by default.
 
 -n::
 --no-verify::

