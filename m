Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22D71F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 03:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfJ1DUg (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 23:20:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62293 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfJ1DUg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 23:20:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A3A09D6D4;
        Sun, 27 Oct 2019 23:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/DxAl7pJXOAG
        LIaz6tnVxlgrI2M=; b=pWFplYzcueCS3SX3DAnG3nnUGkO/xSxIidGQdPqmNkbk
        woPC90TtAvNkzxzvFPOEGUvWn/vGulKsSF9NStIKvzvITaCQEhve9L7D3KNZ7VNv
        8aScsjkq/CICl0imYmB0YB8661+6z8pJhqOXQ8tgDoPVJ1qlRPuFOhds0Q85cWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aGVWll
        pQ2wBrQ3le0H0RfSa2k57Aa4vgn/ChB2aC1od6yoPiVTLscLNjdxVigRyb5JACUF
        /MzZZiCdl/RdGTjkgqzmUCc5V5s0RlKfqL2WT2ewQShBOefa0JGeQsT0ptRCzYBO
        xIccFDKOvGxu4L4ypf5GVo4jqcnkGwyJpXcqI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 423F39D6D3;
        Sun, 27 Oct 2019 23:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71B049D6D0;
        Sun, 27 Oct 2019 23:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from complete_action()
References: <20190925201315.19722-1-alban.gruin@gmail.com>
        <20190925201315.19722-6-alban.gruin@gmail.com>
        <67c98856-55dc-df95-c4a6-61f1af85c480@web.de>
        <9b81e879-091b-bbf7-2d1b-51236d19ee9a@gmail.com>
        <xmqqeeyxbqc6.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 28 Oct 2019 12:20:26 +0900
In-Reply-To: <xmqqeeyxbqc6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 28 Oct 2019 10:39:53 +0900")
Message-ID: <xmqqftjda745.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3F67A26-F931-11E9-BFF8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So I'd probably just send a "fixup!"to be queued on top of the
> series to fix a leak in 'next' for now, remind the maintainer not to
> merge it to 'master' before the release, and once the upcoming
> release is made, send another reminder to the maintainer to squash
> the "fixup!" in before rebuilding 'next', if I owned this series.

This is based on Ren=C3=A9's suggestion, but seeing the pre-context of
this fix, many of the error code path, after an error return from
edit_todo_list() has been handled, can follow the pattern of this
fix to jump to the cleanup label after losing their own calls to
todo_list_release().  An obvious advantage of doing so is that it
future-proofs the codepath---the todo-list structure may not stay to
be the only thing that holds resources that need cleaned up.

 sequencer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b395dd6e11..ec0b793fc5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5140,14 +5140,18 @@ int complete_action(struct repository *r, struct =
replay_opts *opts, unsigned fla
 		return error_errno(_("could not write '%s'"), todo_file);
 	}
=20
+	res =3D -1;
+
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
-		return -1;
+		goto cleanup;
=20
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
-		return -1;
+		goto cleanup;
=20
 	todo_list_write_total_nr(&new_todo);
 	res =3D pick_commits(r, &new_todo, opts);
+
+cleanup:
 	todo_list_release(&new_todo);
=20
 	return res;
