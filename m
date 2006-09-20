From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix @git_base_url_list usage
Date: Tue, 19 Sep 2006 17:43:01 -0700
Message-ID: <7vodtbmkq2.fsf@assigned-by-dhcp.cox.net>
References: <20060920000946.GC13132@pasky.or.cz>
	<7v64fjnzyr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 02:44:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPqBA-0002cN-GJ
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 02:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWITAnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 20:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWITAnF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 20:43:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49611 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750762AbWITAnC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 20:43:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920004301.TTNF22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Tue, 19 Sep 2006 20:43:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QQj31V0171kojtg0000000
	Tue, 19 Sep 2006 20:43:04 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7v64fjnzyr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 19 Sep 2006 17:28:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27320>

Junio C Hamano <junkio@cox.net> writes:

> Why on earth do you want to use wantarray for something like
> this?
>
> It's not like you are implementinging any fancy DWIM magic.

Side note.  I really hate it when people abuse wantarray.

I can think of only two valid reasons (well, perhaps three but
the last one is a logical consequence of the first two) to use
wantarray.  They are:

 (1) The information you are giving back the caller is list of
     things in nature, but there is a natural representation for
     that list as a single scalar, and that representation is
     not the last element of the list.  You would want to help
     the caller by DWIMmery.

     Perl's built-in localtime() is an excellent example for
     wanting to do something like this.  It returns broken-down
     "struct tm" in list context, but returns string ctime(3) in
     scalar context.

 (2) You want to avoid complex computations when the caller does
     not need full return values from you.  A good example is
     found in perlfunc.pod:

        return unless defined wantarray;	# don't bother doing more
        my @a = complex_calculation();
        return wantarray ? @a : "@a";

 (3) You are emulating Perl's built-in function that DWIMs for
     one of the above reasons, usually (1).
