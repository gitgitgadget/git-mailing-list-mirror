From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 10:44:12 -0700
Message-ID: <xmqqegojftsj.fsf@gitster.dls.corp.google.com>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:44:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0y8-0008Vg-Vv
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbbCTRoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:44:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751506AbbCTRoU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:44:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 898024099D;
	Fri, 20 Mar 2015 13:44:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y212+1i+xq0e/DipEnfUWR6WjQQ=; b=gZsPvu
	whzYgVsFdxr5LuhygyG2/Sxz0AmYFWFyXi+PAGcv6tW1F0ZUO7tNTAIkBTdF3D3q
	Ze8BEPaHHec6/87fsxu1eAbkmRxwBz+jK0uCQ2/dgiLUo7jQHt6VsGIok3xq3rDg
	MbMz7zNt2Bzl1q0x0E/hQ3a4OhTkHFlzkQr5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MO69G/Ku+OKz0KC2ndOQQF4+aXEeBlBu
	Je5FCjg9oSr81vfsaho8ccx03wa3ni5KDyXFA1N4ULjxOJFZlXjqvPhl22kRozFu
	aSdRmZ1C4FnWvhSlioxyq2uq8HXlE3GR8HQRAmb6nenhs+b8wfvNdj1QknllzDQb
	eoz8l5H49Fs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 801214099C;
	Fri, 20 Mar 2015 13:44:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C197E40999;
	Fri, 20 Mar 2015 13:44:13 -0400 (EDT)
In-Reply-To: <20150320100429.GA17354@peff.net> (Jeff King's message of "Fri,
	20 Mar 2015 06:04:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B90AE262-CF28-11E4-8455-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265918>

Thanks.  They applied cleanly on 'master' and all looked sensible.

I found 2026 and 5312 to be broken (there may be others that are
excluded in my usual test set) in 'pu'.  As to these topics in "git
log --first-parent master..pu", my preference is to queue fixups on
the broken-out topics (available at http://github.com/gitster/git)
independently.

For example, this will go on top of nd/multiple-work-trees.

diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index 2936d52..e885baf 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -65,7 +65,7 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 '
 
 test_expect_success 'not prune locked checkout' '
-	test_when_finished rm -r .git/worktrees
+	test_when_finished rm -r .git/worktrees &&
 	mkdir -p .git/worktrees/ghi &&
 	: >.git/worktrees/ghi/locked &&
 	git prune --worktrees &&
@@ -73,7 +73,7 @@ test_expect_success 'not prune locked checkout' '
 '
 
 test_expect_success 'not prune recent checkouts' '
-	test_when_finished rm -r .git/worktrees
+	test_when_finished rm -r .git/worktrees &&
 	mkdir zz &&
 	mkdir -p .git/worktrees/jlm &&
 	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
