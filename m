From: Junio C Hamano <junkio@cox.net>
Subject: Re: move directories in work dir
Date: Sat, 22 Oct 2005 23:24:34 -0700
Message-ID: <7vzmp04uot.fsf@assigned-by-dhcp.cox.net>
References: <6f22540448f7234336a00bce5b6547b6@Splinter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, ryan@michonline.com
X-From: git-owner@vger.kernel.org Sun Oct 23 08:25:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETZHe-0005Yp-Q1
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 08:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVJWGYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 02:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVJWGYj
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 02:24:39 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59041 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751413AbVJWGYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 02:24:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023062423.WIXP16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 02:24:23 -0400
To: "Rogelio M. Serrano Jr." <rogelio@smsglobal.net>
In-Reply-To: <6f22540448f7234336a00bce5b6547b6@Splinter> (Rogelio M. Serrano,
	Jr.'s message of "Sun, 23 Oct 2005 13:44:54 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10487>

"Rogelio M. Serrano Jr." <rogelio@smsglobal.net> writes:

> ... is there a way to tell git that i moved a directory into
> another? For example i have.

Before you moved them, you could have done [*1*]:

	$ mkdir analyze/import_tools
	$ git rename analyze/import_a analyze/import_tools/import_a
	$ git rename analyze/import_b analyze/import_tools/import_b

But that may be too late now.  Instead you already did:

	$ mkdir analyze/import_tools
        $ mv analyze/import_a analyze/import_b analyze/import_tools/.

At this point, you can:

	$ git-add analyze/import_tools
	$ git-ls-files analyze/import_a analyze/import_b |
          git-update-index --remove --stdin

> right now i have to do git-update-index --add for everything all over 
> again.

"git rename" is just a short-hand of your manual
"git-update-index --add --remove" (and at the same time moving
files in the working tree).  There isn't any extra information
you are giving git by using it (IOW "git" does not record
renames).

BTW, do you really have a file whose name ends with an ESC
character?

> analyse/import_a/import_a.c

[Footnote]

*1* It strikes me that git rename *could* be friendlier by
emulating how "mv" treats the paths parameters (current
implementation insists two parameters $src and $dst).  What do
you think, Ryan?
