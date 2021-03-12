Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6039C433E9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9564364DAF
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhCLVzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 16:55:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50072 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhCLVzK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 16:55:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B5B7BE5C3;
        Fri, 12 Mar 2021 16:55:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4oeoduL2hKTKT5Fe4P1qoYiRvb4=; b=dckCTF
        XmdeNZ6gp+NLTOHLp8ka+eilLSkFbJQoBfY1LjRRAx3idCbVtsq0U5ypVeP7UcJm
        1yfvbf2gvJjrFkM8iUFPCggUs8v6nbZK6lrPhybTEtN5e4xu2hzQc5mUuKzMSHSK
        zGjOc2iGM1YPVmP514Hv0cy1/iy8EeI5gUENQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rjXquOsD8Ya3NFxxtdgpxlDsbuhRWuQ3
        k7HPb2eBJPxWp3JZktIg2rvmC/XdXHfxsmTQMAstOV3teaiXfoCV6CQoTApC7B6g
        TjlbEuke8HP2zjUSqGmXnnUZQgKuv/CLAanfHvWllDeGud5weet3smBLGOJppnnV
        5F/h+Ie7OLo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 812B1BE5C1;
        Fri, 12 Mar 2021 16:55:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF6A4BE5BE;
        Fri, 12 Mar 2021 16:55:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC][RFC] format-patch: pass --right-only to range-diff
References: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
        <YEaGbn5rU3pU7/q5@nand.local>
Date:   Fri, 12 Mar 2021 13:55:07 -0800
In-Reply-To: <YEaGbn5rU3pU7/q5@nand.local> (Taylor Blau's message of "Mon, 8
        Mar 2021 15:18:04 -0500")
Message-ID: <xmqq1rck6nr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CB42AFA-837D-11EB-84C5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <ttaylorr@github.com> writes:

> Note that I think (and Johannes--cc'd--could confirm) that what you want
> is '--left-only' to discard rebased changes from the upstream branch:

Does that mean range-diff got --left-only and --right-only
backwards?  IOW, doesn't

$ git log --left-only A...B

show what is shown in "git log B..A", and if so, shouldn't

$ git range-diff --left-only A...B

which is a synonym for

$ git range-diff B..A A..B

also give commits in the B..A range?

Puzzled....

