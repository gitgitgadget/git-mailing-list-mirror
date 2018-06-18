Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8531F403
	for <e@80x24.org>; Mon, 18 Jun 2018 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935546AbeFRWTq (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 18:19:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50977 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934807AbeFRWTp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 18:19:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE609FAF77;
        Mon, 18 Jun 2018 18:19:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=gLS5qd65lez1vx2yvBMhe+8tdVM=; b=NYcixs7
        CzRGHLxm9uELBS15SJ0sO3AxUR2d+Zl/AYmXs3PLZSwyuM70SovK16uRGT6WCt2I
        e4NUEouKH6sUDzjjYHuJQOOQ6poXwpWZN0bvfenVmycaB2fD59peu6YyOEoS61cg
        NRyu/mrzdl5jj/t5zmU6HisZiKeKR+fnbll4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=Q9BNiyKfgUuvpjtlLQCm2BCBBbaec0mrs
        j/10qW+tMy80PDcmjC0p/vcv7Dw/TMYmfDuNXCoxSgJUATEtceP4xq4WWVXJzmWF
        0oshAOcBr/ex+jWqun+0gPYmMucoFL+Iel7blcFTTbVwxRHn89XiC18ShYB6qlMr
        P6yGSZEKBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7006FAF76;
        Mon, 18 Jun 2018 18:19:44 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4366CFAF75;
        Mon, 18 Jun 2018 18:19:44 -0400 (EDT)
Date:   Mon, 18 Jun 2018 18:19:42 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] t3404: check root commit in 'rebase -i --root reword root
 commit'
Message-ID: <20180618221942.GQ11827@zaya.teonanacatl.net>
References: <pull.3.git.gitgitgadget@gmail.com>
 <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
 <484fe825-0726-a027-1187-de00df6406d5@talktalk.net>
 <20180618164958.GO11827@zaya.teonanacatl.net>
 <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: B3EA58D4-7345-11E8-AF18-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When testing a reworded root commit, ensure that the squash-onto commit
which is created and amended is still the root commit.

Suggested-by: Phillip Wood <phillip.wood@talktalk.net>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Hi Johannes,

Johannes Schindelin wrote:
>On Mon, 18 Jun 2018, Todd Zullinger wrote:
>> Phillip Wood wrote:
>>> On 15/06/18 05:31, Johannes Schindelin via GitGitGadget wrote:
>>>>
>>>> From: Todd Zullinger <tmz@pobox.com>
>>>>
>>>> +test_expect_failure 'rebase -i --root reword root commit' '
>>>> +  test_when_finished "test_might_fail git rebase --abort" &&
>>>> +  git checkout -b reword-root-branch master &&
>>>> +  set_fake_editor &&
>>>> +  FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
>>>> +  git rebase -i --root &&
>>>> +  git show HEAD^ | grep "A changed"
>>>
>>> I wonder if it should also check that HEAD^ is the root commit, to make
>>> sure that the squash-onto commit that's created and then amended has
>>> been squashed onto.
>>
>> Hmm, is that something which other tests don't cover or an
>> issue that could affect 'rebase -i --root' with reword
>> differently than other 'rebase -i' commands?
>>
>> I admit I'm not well-versed in the rebase -i tests and I
>> focused only on creating a test which demonstrated the bug I
>> noticed.
>
> I think we should test this here, to make sure it is tested, and it should
> be as easy as:
>
>        test -z "$(git show -s --format=%p HEAD^)"
>
> Hopefully you beat me to it, otherwise I will try to take care of this
> tomorrow.

With luck, this will save you a few minutes, assuming the
commit message is reasonable (or can be improved with help
from Phillip and others). :)

Or Junio may just squash this onto js/rebase-i-root-fix.

Thanks.

 t/t3404-rebase-interactive.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e500d7c320..352a52e59d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -977,7 +977,8 @@ test_expect_success 'rebase -i --root reword root commit' '
 	set_fake_editor &&
 	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
 	git rebase -i --root &&
-	git show HEAD^ | grep "A changed"
+	git show HEAD^ | grep "A changed" &&
+	test -z "$(git show -s --format=%p HEAD^)"
 '
 
 test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Anyone who is capable of getting themselves made President should on
no account be allowed to do the job.
    -- Douglas Adams, "The Hitchhiker's Guide to the Galaxy"

