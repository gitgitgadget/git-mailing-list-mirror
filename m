From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-suite: adding a test for fast-export with tag
 variants
Date: Sun, 22 Mar 2009 17:39:54 -0700
Message-ID: <7vfxh59in9.fsf@gitster.siamese.dyndns.org>
References: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:41:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYEY-0000B8-09
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbZCWAkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 20:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756753AbZCWAkD
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:40:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbZCWAkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 20:40:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EEF7A4F0D;
	Sun, 22 Mar 2009 20:39:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9E609A4F0B; Sun,
 22 Mar 2009 20:39:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23A9E626-1743-11DE-83EF-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114216>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  t/t9302-fast-export-tags.sh |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>  create mode 100644 t/t9302-fast-export-tags.sh
>
> diff --git a/t/t9302-fast-export-tags.sh b/t/t9302-fast-export-tags.sh
> new file mode 100644

Make it executable if you need to add a new script, but shouldn't these
small tests be done as an addition to existing t9301, not as a brand new
script?

> index 0000000..2ecac32
> --- /dev/null
> +++ b/t/t9302-fast-export-tags.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Erik Faye-Lund
> +#
> +
> +test_description='git fast-export tag variants'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	touch dummy &&
> +	git add dummy &&
> +	git commit -m "initial commit" &&
> +	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
> +	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
> +	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
> +	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
> +	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
> +'
> +
> +test_expect_success 'tree_tag'        'git fast-export tree_tag'
> +test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
> +test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
> +test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
> +
> +test_done

The purpose of the first patch that adds tests is to expose existing
problems, and it is better to say test_expect_failure in them.  Later
patch to fix these issues will contain code change and also change to flip
some of the expect_failure to expect_success, and that way we can see what
issue is fixed with which patch more easily.

These tests seem to only care about fast-export not dying, but don't we
also want to check if they produce correct results?
