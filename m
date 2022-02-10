Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0CFC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 17:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbiBJRXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:23:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiBJRXU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 12:23:20 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63B192
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 09:23:21 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BECC180356;
        Thu, 10 Feb 2022 12:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pVNjLAOcx0znugqQmf4qFZ9uRcEb6NkR1rI2rI
        0X80s=; b=OpvESvqjwr824jPg4dfrmrlOOdIlQFbHnQX1Wt8/MCWMzbeTb4thHN
        Utyx1kPfAxmmQeFEFNK5ZR2KVcypNuGhunTMH3FNBJmTQqt/M7TJUAKkE5EMs1zM
        uxpIW9dweE1cx2e6ba45KxfHUSZwlnecCqmwXVp+xJZfBMZI1q/Sc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31072180355;
        Thu, 10 Feb 2022 12:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79033180351;
        Thu, 10 Feb 2022 12:23:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
        <20220121102109.433457-2-shaoxuan.yuan02@gmail.com>
        <Yer/oEZK6TBFSsde@nand.local> <xmqqr190g6gd.fsf@gitster.g>
        <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
        <xmqqo83fw5yc.fsf@gitster.g>
        <CAJyCBOTBcvgAcSaQ4xs-V=M-im_Umf3ymsWzCAGEmrj6b38pEA@mail.gmail.com>
Date:   Thu, 10 Feb 2022 09:23:17 -0800
In-Reply-To: <CAJyCBOTBcvgAcSaQ4xs-V=M-im_Umf3ymsWzCAGEmrj6b38pEA@mail.gmail.com>
        (Shaoxuan Yuan's message of "Thu, 10 Feb 2022 15:21:00 +0800")
Message-ID: <xmqqv8xmvdoa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2363CB3A-8A96-11EC-9FF7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> On Thu, Feb 10, 2022 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
>>
>> > Since I didn't see this change in seen or next, do you plan to apply it?
>>
>> I actually wasn't, as my understanding of it was primarily your
>> practice.
>
> Understood, thanks for the reply.

FWIW, I have the posted patch plus the following SQUASH??? fix-up
parked in the 'seen' branch.  As the script is quiescent right now,
I do not mind merging it down, now we spent more time on it ;-)

 t/t0001-init.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c72a28d3a5..d479303efa 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -6,7 +6,8 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
-	if test_path_is_dir "$1" && test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
+	if test_path_is_dir "$1" &&
+	   test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
 	then
 		: happy
 	else
-- 
2.35.1-102-g2b9c120970

