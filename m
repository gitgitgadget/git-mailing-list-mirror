From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Move the pick_author code to git-sh-setup
Date: Sun, 24 Jun 2007 00:09:21 -0700
Message-ID: <7vejk125i6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706240000340.4059@racer.site>
	<7v7ipt3lh6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 09:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2MDs-0007CN-8n
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 09:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbXFXHJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 03:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbXFXHJX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 03:09:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50217 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbXFXHJW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 03:09:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624070922.JMVI17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 03:09:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FK9M1X0071kojtg0000000; Sun, 24 Jun 2007 03:09:21 -0400
In-Reply-To: <7v7ipt3lh6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 23 Jun 2007 23:39:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50774>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> -	set_author_env=`git show -s --pretty=raw --encoding="$encoding" "$use_commit" |
>> -	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
>> -	eval "$set_author_env"
>> ...
>> +	eval $(get_author_ident_from_commit "$use_commit")
>
> Are you sure about this part of the change?  I suspect that you
> are losing IFS by not dq'ing the argument you give to the eval.
>
> ...

If you care about your data in your variable and do not want
word-splitting at $IFS to happen, you should always dq your
variable.  A quick rule of thumb is that the only place that you
can get away by not quoting is straight assignment to another
variable, like so:

	var='a  b c '
        another=$var	;# another="$var" is fine but unnecessary.
