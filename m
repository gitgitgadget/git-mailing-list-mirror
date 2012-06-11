From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lessen the impression of unexpectedness on remote hangup
Date: Mon, 11 Jun 2012 09:41:42 -0700
Message-ID: <7vmx497qd5.fsf@alter.siamese.dyndns.org>
References: <20120610182310.GB2427@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:41:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7ge-0000Wy-Dn
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab2FKQlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:41:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab2FKQlq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:41:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 931B88741;
	Mon, 11 Jun 2012 12:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6LCD5zBu4F4QwVY8FoeA2xrmWXQ=; b=m7NQio
	vsQEaQSGY5wZyd5Qz8ja7CEWKVOd6cLXe/H7jQxW/MR951ajHkPaxnS6Pls9DQfr
	Y3detTxgjdjXtiLHdkGIROFNNpeeDKaBtCM9p4p5ugG+WxN9Kt0pUiH7t36GtdoN
	T45x1SOUZFI9mVcg/3/ktA7ca/AobuCkGNdtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sCL/vDVDC+FZKkKaSa9Fufu12uxLJC8n
	y2QRj6sO1qwJkNGA/icsBwSJy+kUsGQPeYf0WU79fShL7mUnO3BtbtayCYWGbgEC
	iys7M62HuMEH28UjCuyXi0Stvc9FIb2u0nV2c0/QnW4XxzKIpXR8P9tFk7o5fz+T
	UUpA/R044aE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A02B8740;
	Mon, 11 Jun 2012 12:41:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E84E3873D; Mon, 11 Jun 2012
 12:41:44 -0400 (EDT)
In-Reply-To: <20120610182310.GB2427@book.hvoigt.net> (Heiko Voigt's message
 of "Sun, 10 Jun 2012 20:23:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54830BA6-B3E4-11E1-93AF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199673>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> If a server accessed through ssh is denying access git will currently
> issue the message
>
> 	"fatal: The remote end hung up unexpectedly"
>
> as the last line. This sounds as if something really ugly just happened.
> Since this is a quite typical situation in which users regularly get
> lets just say:
>
> 	"fatal: The remote end hung up"
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---

This change makes sense, but you would need to adjust tests for the
change, perhaps at least these:

 t/t5512-ls-remote.sh    | 2 +-
 t/t5522-pull-symlink.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5c546c9..a24eb42 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -104,7 +104,7 @@ test_expect_success 'use branch.<name>.remote if possible' '
 
 cat >exp <<EOF
 fatal: 'refs*master' does not appear to be a git repository
-fatal: The remote end hung up unexpectedly
+fatal: The remote end hung up
 EOF
 test_expect_success 'confuses pattern as remote when no remote specified' '
 	#
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index 8e9b204..f06ffb4 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -46,7 +46,7 @@ test_expect_success SYMLINKS 'pulling from real subdir' '
 # Instead, the error pull gave was:
 #
 #   fatal: 'origin': unable to chdir or not a git archive
-#   fatal: The remote end hung up unexpectedly
+#   fatal: The remote end hung up
 #
 # because git would find the .git/config for the "trash directory"
 # repo, not for the clone-repo repo.  The "trash directory" repo
