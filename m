From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-remote: support remotes with a dot in the name
Date: Tue, 20 Feb 2007 21:21:46 -0800
Message-ID: <7vwt2ct79x.fsf@assigned-by-dhcp.cox.net>
References: <20070221050336.26431.46485.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 06:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJjvL-0007Ul-Ee
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 06:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbXBUFVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 00:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbXBUFVs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 00:21:48 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45899 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030224AbXBUFVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 00:21:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221052146.XGMK1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 00:21:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S5Ml1W00Q1kojtg0000000; Wed, 21 Feb 2007 00:21:46 -0500
In-Reply-To: <20070221050336.26431.46485.stgit@dv.roinet.com> (Pavel Roskin's
	message of "Wed, 21 Feb 2007 00:03:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40278>

Pavel Roskin <proski@gnu.org> writes:

> Ignore configuration data other that "url" and "fetch" for the remote. 
> We cannot process it to extract the remote name from it reliably. 
> Besides, a remote without "url" is currently invalid, so we are not
> missing anything.
>
> Signed-off-by: Pavel Roskin <proski@gnu.org>

I do not think we ever officially "supported" remotes with a dot
in their names since $GIT_DIR/remotes/ or $GIT_DIR/branches
days.  

>  	for (@remotes) {
> -		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
> +		if (/^remote\.(\S*)\.(fetch|url)\s+(.*)$/) {
>  			add_remote_config(\%seen, $1, $2, $3);
>  		}

I do not strongly oppose to allowing it now, but I suspect this
is probably less impact:

	if (/^remote\.(\S+?)\.([^.\s]+)\s+(.*)$/) {
        	...
	}

With this, we disallow whitespaces in remote names, but we leave
the door open for supporting variables other than fetch and url
by accepting the third token that matches any sequence of
non-dot, non-whitespace letters.
