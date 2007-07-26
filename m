From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add is_absolute_path(), make_absolute_path() and normalize_path()
Date: Wed, 25 Jul 2007 23:53:24 -0700
Message-ID: <7v1wevac63.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260724010.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:53:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxE2-00072V-Pd
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbXGZGx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbXGZGx0
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:53:26 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37703 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588AbXGZGxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:53:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726065325.WURD1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 02:53:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U6tQ1X00N1kojtg0000000; Thu, 26 Jul 2007 02:53:25 -0400
In-Reply-To: <Pine.LNX.4.64.0707260724010.14781@racer.site> (Johannes
	Schindelin's message of "Thu, 26 Jul 2007 07:24:28 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53789>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +/* strip out .. and . */
> +char *normalize_path(char *path)
> +{

This always makes one worry what should happen when foo/../bar
is _not_ bar in reality (i.e. foo is symlink to a directory
elsewhere).

It depends on what kind of "path" you feed to the function (and
its caller, make_absolute_path()).  If you always feed a path
from the index (or a path obtained by recursively reading a
tree), it is Ok.  If it is arbitrary path obtained from the user
or the filesystem, it is not.
