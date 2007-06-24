From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Move the pick_author code to git-sh-setup
Date: Sat, 23 Jun 2007 23:39:01 -0700
Message-ID: <7v7ipt3lh6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706240000340.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 08:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Lkl-0004J6-Uy
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 08:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbXFXGjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 02:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbXFXGjG
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 02:39:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60821 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbXFXGjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 02:39:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624063903.UDEM6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 02:39:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FJf21X0041kojtg0000000; Sun, 24 Jun 2007 02:39:02 -0400
In-Reply-To: <Pine.LNX.4.64.0706240000340.4059@racer.site> (Johannes
	Schindelin's message of "Sun, 24 Jun 2007 00:01:01 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50769>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -	set_author_env=`git show -s --pretty=raw --encoding="$encoding" "$use_commit" |
> -	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
> -	eval "$set_author_env"
> ...
> +	eval $(get_author_ident_from_commit "$use_commit")

Are you sure about this part of the change?  I suspect that you
are losing IFS by not dq'ing the argument you give to the eval.

    #!/bin/sh

    test1 () {
        echo "$1=' d  e'"
    }

    eval $(test1 A)
    eval "$(test1 B)"
    echo "A=$A"
    echo "B=$B"
