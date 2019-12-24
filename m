Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D953CC2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983B620643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r3orq5j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfLXTeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:34:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58339 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXTeu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:34:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE57698D27;
        Tue, 24 Dec 2019 14:34:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1yZyIWbg+yhzW3EPQ0pd27DZTHg=; b=r3orq5
        j4baH2AP/llRS3s85arZdeGObmXpjNcng5tzjEyxv4m+XohetOrGMYZWtIhJTpp8
        9M8oGLH1LcKKTEg43Jg+LslQgD2i2Z8PHRAL9VdzzYTC18lOljxtt9ADI7kADEua
        702v+gxExp3mESPlF6LHhPIvdfMpScGZAXYEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NIy3QwPqtPWE+8H7TiNe+LdYw5VUlX9A
        SkkAryVoBwKrVGkD7vE87yNCEFFsi8ZFHVoS/1wECw9y9zkP0GHZXzX6WNkpr/z4
        0NkctLfZuNgIqOKjicUMomIZOFEi5HdNRfpxJ8/ZoqTUI+WENFZoMggL/bqzRzsg
        DPSh5g07k5Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A79E998D26;
        Tue, 24 Dec 2019 14:34:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D06D198D25;
        Tue, 24 Dec 2019 14:34:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git diff` treats an unchanged line as modified
References: <CA+PpKPm0_zXr978Mw8h7owHBChx-uqVCdjrtuh45uOS-A_0qrA@mail.gmail.com>
Date:   Tue, 24 Dec 2019 11:34:43 -0800
In-Reply-To: <CA+PpKPm0_zXr978Mw8h7owHBChx-uqVCdjrtuh45uOS-A_0qrA@mail.gmail.com>
        (Hao Lee's message of "Wed, 25 Dec 2019 01:50:29 +0800")
Message-ID: <xmqqy2v14iwc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70D3E652-2684-11EA-9393-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hao Lee <haolee.swjtu@gmail.com> writes:

> I think the latter is correct because the fifth line is not changed
> and it's still a line which only contains a whitespace.

As long as lines that begin with "-" and " " match what the 'old'
file has, and replacing them with lines that begin with " " and
"+" in the 'old' file yields the 'new' file, any patch is "correct".

IOW, there is no *single* diff output that is correct.

Among many "correct" diff output, there are ones that readers find
them easier to understand and those that look suboptimal.  The
differences are often personal tastes.

"git diff" has options to tweak heuristics it uses to choose among
many "correct" diff outputs, like --patience, --histogram, etc.
Perhaps using one of them would produce one that match your taste
better?

