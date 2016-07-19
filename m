Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C636B2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbcGSVGl (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 17:06:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751803AbcGSVGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 17:06:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 53BF82C337;
	Tue, 19 Jul 2016 17:06:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GiIa9PDUfDdxpyRrrHckNJ2PmFY=; b=GDGbVn
	qMqD0xa2X1pPqenckgpasBHs6ofsMN+4opNh4Wwr0zU5Qn8RWhIyrAToYvwfTn9g
	qHDDrIilzAJIxk3zjtfbOhCImrc7QyIU2sxbcUWfqjenAZ1eFHeUV8CPxA5oTnqH
	DmCKD0xKcnORcKBUKJRVF5c5jv5K0dbSMRtI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+lo8XJ92tF/cU1ovbWduZdcTQa80oHg
	KDQVvTUUfla3aH80I9CTjSz/rU4TMJ1cQf1EQLX3/UFfNiEbM3pzsZBNxw/LCDzc
	aMbB5DqTKqxkO5fXkuReT1/oNRPS8t1N643jPA1eUIkzzRzH7Ez2nDB6rktEYNVd
	AA2SSHQxd0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AC552C336;
	Tue, 19 Jul 2016 17:06:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7CF92C334;
	Tue, 19 Jul 2016 17:06:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Aguilar <davvid@gmail.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] difftool: avoid $GIT_DIR and $GIT_WORK_TREE
References: <20160719035756.24961-1-davvid@gmail.com>
	<20160719035756.24961-2-davvid@gmail.com>
	<xmqqy44xfq3n.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 19 Jul 2016 14:06:35 -0700
In-Reply-To: <xmqqy44xfq3n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Jul 2016 11:19:08 -0700")
Message-ID: <xmqqvb01e3s4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE9D1A06-4DF4-11E6-9750-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is not wrong per-se, but as you are in a subshell, you do not
> have to unset these, I would think.  Not worth a reroll, but unless
> I am overlooking something (in which case please holler) I'm
> inclined to remove these two lines myself while queuing the series.

I propose to squashing the following to 2/3 (and adjusting 3/3 as
needed).  No need to resend if you agree it is a good idea, as it is
part of what I've queued on 'pu'.

Thanks.

 git-difftool.perl   | 2 +-
 t/t7800-difftool.sh | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index bc2267f..c81cbe4 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -88,11 +88,11 @@ sub changed_files
 	my @refreshargs = (
 		@gitargs, 'update-index',
 		'--really-refresh', '-q', '--unmerged');
-	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
 	try {
 		Git::command_oneline(@refreshargs);
 	} catch Git::Error::Command with {};
 
+	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
 	my $line = Git::command_oneline(@diffargs);
 	my @files;
 	if (defined $line) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index afdf370..cb25480 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -421,8 +421,6 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory with GIT_DIR set' '
 		cd sub &&
 		git difftool --dir-diff $symlinks --extcmd ls \
 			branch -- sub >output &&
-		sane_unset GIT_WORK_TREE &&
-		sane_unset GIT_DIR &&
 		grep sub output &&
 		! grep file output
 	)
-- 
2.9.2-581-g77f0ffb

