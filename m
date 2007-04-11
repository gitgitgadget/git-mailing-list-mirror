From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 13/10] tests for various pack index features
Date: Tue, 10 Apr 2007 19:57:52 -0700
Message-ID: <7vr6qrr51r.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0704101607390.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbT1x-0001zM-8v
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 04:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbXDKC5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 22:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966128AbXDKC5y
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 22:57:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45639 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966102AbXDKC5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 22:57:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411025753.RGWM1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 22:57:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lexs1W00q1kojtg0000000; Tue, 10 Apr 2007 22:57:53 -0400
In-Reply-To: <alpine.LFD.0.98.0704101607390.28181@xanadu.home> (Nicolas
	Pitre's message of "Tue, 10 Apr 2007 16:26:10 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44210>

Nicolas Pitre <nico@cam.org> writes:

> This is a fairly complete list of tests for various aspects of pack 
> index versions 1 and  2.
>
> Tests on index v2 include 32-bit and 64-bit offsets, as well as a nice 
> demonstration of the flawed repacking integrity checks that index 
> version 2 intend to solve over index version 1 with the per object CRC.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
>
> OK this should really be the last patch for this topic.
>
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> new file mode 100755
> index 0000000..3371964
> --- /dev/null
> +++ b/t/t5302-pack-index.sh
> @@ -0,0 +1,147 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Nicolas Pitre
> +#
> +
> +test_description='pack index with 64-bit offsets and object CRC'
> +. ./test-lib.sh
> +
> +test_expect_success \
> +    'setup' \
> +    'rm -rf .git
> +     git-init &&
> +     for i in `seq -w 100`
> +     do
> +         echo $i >file_$i &&
> +         dd if=/dev/urandom bs=8k count=1 >>file_$i &&
> +         git-update-index --add file_$i || return 1
> +     done &&

Is there a way for our tests to be a bit more stable than
urandom?  I saw on the first run fsck was OOM-killed, but the
second and subsequent run did not.  It's a bit hard to diagnose.
