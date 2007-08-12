From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a test for git-commit being confused by relative GIT_DIR
Date: Sat, 11 Aug 2007 18:55:46 -0700
Message-ID: <7vvebljz31.fsf@assigned-by-dhcp.cox.net>
References: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
	<85tzr5spaj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 03:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK2gK-0004dZ-DI
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 03:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918AbXHLBzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 21:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756249AbXHLBzs
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 21:55:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57134 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232AbXHLBzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 21:55:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812015548.TFXV3478.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 21:55:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id apvn1X0051kojtg0000000; Sat, 11 Aug 2007 21:55:47 -0400
In-Reply-To: <85tzr5spaj.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	12 Aug 2007 00:02:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55659>

David Kastrup <dak@gnu.org> writes:

> +test_expect_success 'Setting up post-commit hook' '
> +mkdir -p .git/hooks &&
> +cat <<EOF >.git/hooks/post-commit &&
> +#!/bin/sh
> +touch $(pwd)/output
> +echo "Post commit hook was called."
> +EOF
> +chmod +x .git/hooks/post-commit'

We have avoided to use here text inside test_expect_success, as
there have been reports that some otherwise reasonably usable
shells do not grok it.  Although I prefer to do everything,
including the set-up part, inside test_expect_success, please
move this code outside.

Also I do not think you would want to say touch $(pwd)/output
there inside the here text that begins with <<EOF not <<\EOF.
