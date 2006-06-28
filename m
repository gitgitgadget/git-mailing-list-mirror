From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] git-svn: SVN 1.1.x library compatibility
Date: Wed, 28 Jun 2006 02:02:47 -0700
Message-ID: <7virml4pqg.fsf@assigned-by-dhcp.cox.net>
References: <11514623542848-git-send-email-normalperson@yhbt.net>
	<11514623563534-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:03:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvVwk-0000fw-JE
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423233AbWF1JCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423235AbWF1JCu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:02:50 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:958 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1423232AbWF1JCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:02:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628090248.VNGS12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 05:02:48 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11514623563534-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Tue, 27 Jun 2006 19:39:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22782>

Eric Wong <normalperson@yhbt.net> writes:

> Tested on a plain Ubuntu Hoary installation
> using subversion 1.1.1-2ubuntu3
>
> 1.1.x issues I had to deal with:
>
> * Avoid the noisy command-line client compatibility check if we
>   use the libraries.
>
> * get_log() arguments differ.

Maybe you would want to have a single wrapper sub {} for this,
instead of repeating it all over, perhaps like this:

	sub log_get {
        	my ($SVN_LOG, @args) = @_;
        	if ($SVN::CORE::VERSION ge '1.2.0') {
                	splice(@args, 3, 0, 0);
                }
                $SVN_LOG->get_log(@args);
	}

> -if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
> +if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL |grep '\.UTF-8$' >/dev/null
>  then

Hmph.  I tend to do something like this instead of pipeing echo
to grep:

	case "$LC_ALL" in
        *.UTF-8)
        	# it is utf-8
                ;;
        *)
        	# otherwise
                ;;
	esac
