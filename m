Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD833C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjHHTgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjHHTgF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:36:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC0EBA5
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 12:00:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF69E1AF990;
        Tue,  8 Aug 2023 15:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aTno0QAPQ9GT8jEHwMENm5rcejffTdeCiExvx+
        aHFss=; b=aKj+JU5NivVilSDIWkiTF8jBABIsq+d+4TL3sS0VVrdOPA/zJC4puh
        kGZdCK20R0hIQtFEbTyA5BR1tKqk7By/ozP8j/3Z+Mo/+U2TtN7y7HdWfJ2TM+k9
        RgWmhNIKJdnyLJPjWLw8IlHK2ogthWPbcXCRTZ6DDt6DqmmpLiyzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6F6E1AF98F;
        Tue,  8 Aug 2023 15:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 523B61AF98D;
        Tue,  8 Aug 2023 15:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sebastian Thiel via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sebastian Thiel <sebastian.thiel@icloud.com>
Subject: Re: [PATCH] fix `git mv existing-dir non-existing-dir`*
References: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
        <xmqqy1il77wp.fsf@gitster.g>
Date:   Tue, 08 Aug 2023 12:00:53 -0700
In-Reply-To: <xmqqy1il77wp.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        08 Aug 2023 10:36:54 -0700")
Message-ID: <xmqqttt9740q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E675A6F0-361D-11EE-8B98-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> What is curious is that dest_st.st_mode, after lstat on dst
> succeeds, is never checked, even though the error message claims
> that it detected an attempt to move directory over file.  What
> should happen when the user did this then?
>
>     $ git mv existing-dir another-existing-dir
>
> Shouldn't it do something similar to
>
>     $ mv D1 D2
>
> which is to move the entire hierarchy of D1 and make it appear at
> D2/D1?

Ah, that case is handled in a different codepath, so this lstat of
dst needs to check only the existence.  So there is no (unrelated)
bug there.  Sorry for the noise.
