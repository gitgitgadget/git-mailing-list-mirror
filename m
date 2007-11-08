From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout: Add a test case for relative paths use.
Date: Wed, 07 Nov 2007 21:03:04 -0800
Message-ID: <7v8x5972if.fsf@gitster.siamese.dyndns.org>
References: <11944932524072-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 06:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpzY6-0004w6-SF
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 06:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXKHFDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 00:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbXKHFDM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 00:03:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50930 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXKHFDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 00:03:11 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 57F4E2F2;
	Thu,  8 Nov 2007 00:03:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BD01690380;
	Thu,  8 Nov 2007 00:03:27 -0500 (EST)
In-Reply-To: <11944932524072-git-send-email-dsymonds@gmail.com> (David
	Symonds's message of "Thu, 8 Nov 2007 14:40:52 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63932>

David Symonds <dsymonds@gmail.com> writes:

> Signed-off-by: David Symonds <dsymonds@gmail.com>
> ---
>  t/t2008-checkout-subdir.sh |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>  create mode 100755 t/t2008-checkout-subdir.sh
>
> diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
> new file mode 100755
> index 0000000..cb9c9eb
> --- /dev/null
> +++ b/t/t2008-checkout-subdir.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 David Symonds
> +
> +test_description='git checkout from subdirectories'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +
> +	echo base > file0 &&
> +	git add file0 &&
> +	mkdir dir1 &&
> +	echo hello > dir1/file1 &&
> +	git add dir1/file1 &&
> +	test_tick &&
> +	mkdir dir2 &&
> +	echo bonjour > dir2/file2 &&
> +	git add dir2/file2 &&
> +	git commit -m "populate tree"
> +
> +'
> +
> +test_expect_success 'remove and restore with relative path' '
> +
> +	cd dir1 &&
> +	rm ../file0 &&
> +	git checkout HEAD -- ../file0 && test -f ../file0 &&
> +	rm ../dir2/file2 &&
> +	git checkout HEAD -- ../dir2/file2 && test -f ../dir2/file2 &&
> +	rm ../file0 ./file1 &&
> +	git checkout HEAD -- .. && test -f ../file0 && test -f ./file1
> +
> +'

This is better than not having any test, but we would also want
a negative test.  Things like trying to check out "../file"
without going down into a subdirectory, check out "../../file"
in a subdirectory that is only one level deep.
