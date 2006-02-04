From: Junio C Hamano <junkio@cox.net>
Subject: [RFD] diff-tree -c (not --cc) in diff-raw format?
Date: Fri, 03 Feb 2006 16:18:38 -0800
Message-ID: <7vfyn0asdd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 01:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5B8V-00062T-Gt
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 01:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946130AbWBDASl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 19:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946127AbWBDASl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 19:18:41 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64960 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1946124AbWBDASk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 19:18:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204001845.IGIQ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 19:18:45 -0500
To: Marco Costalba <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15560>

The second paragraph from this log caught my attention:

    commit cb80775b530a8a340a7f9e4fecc8feaaac13777c
    Author: Marco Costalba <mcostalba@gmail.com>
    Date:   Sun Jan 29 12:27:34 2006 +0100

        Use git-diff-tree -c (combined) option to retrieve merge's
        file list

        Change un-interesting files pruning algorithm to use native
        git-diff-tree -c option when showing merge files in files
        list box.

The current diff-tree -c is rather expensive way to do this.  I
made both -c and --cc to always produce patches, but this
suggests at least qgit would benefit if I allow -c in diff-raw
format.  Essentially, you are interested in paths that the
results do not match _any_ of the parents.

So instead of 70 lines output from

	$ git-diff-tree -m -r --abbrev v1.0.0

I could give you:

        $ git-diff-tree -c -m -r --abbrev v1.0.0
        c2f3bf071ee90b01f2d629921bb04c4f798f02fa
        :100644 100644 92cfee4... e9bf860... M	Makefile
        :100644 100644 d36904c... 4fa6c16... M	debian/changelog
        c2f3bf071ee90b01f2d629921bb04c4f798f02fa
        :100644 100644 50392ff... e9bf860... M	Makefile
        :100644 100644 376f0fa... 4fa6c16... M	debian/changelog

or even:

        $ git-diff-tree -c -m -r --name-only v1.0.0
        c2f3bf071ee90b01f2d629921bb04c4f798f02fa
        Makefile
        debian/changelog

I am not so sure which one is more useful, though.  What do you
think?

On the other hand, git-diff-tree --cc needs to look at the diff
between result and parents of the merge in order to do its job
hunk-per-hunk, so producing diff-raw output fundamentally does
not make sense for that option.

I should keep track of qgit repository more often but I haven't
been doing so because the site used to be almost unpullable over
http (it seems to work just fine these days so it is not an
excuse for me anymore) and I do not read C++ too well (bad
excuse perhaps but still an excuse for me).
