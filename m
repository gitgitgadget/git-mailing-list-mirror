From: Junio C Hamano <junkio@cox.net>
Subject: Re: recent patch breaks the build ?
Date: Thu, 17 Nov 2005 02:33:02 -0800
Message-ID: <7voe4jy36p.fsf@assigned-by-dhcp.cox.net>
References: <437B6997.8010903@mc.com>
	<7v64qs8kuo.fsf@assigned-by-dhcp.cox.net> <437B8CEC.8040002@mc.com>
	<20051116203334.GA3968@reactrix.com>
	<Pine.LNX.4.63.0511170023040.9284@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051117004621.GB3968@reactrix.com>
	<7vd5l03whv.fsf@assigned-by-dhcp.cox.net>
	<20051117021014.GC3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 11:34:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ech4s-0002Iu-JB
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 11:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKQKdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 05:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVKQKdE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 05:33:04 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63670 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750732AbVKQKdD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 05:33:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117103239.SZAA3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 05:32:39 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051117021014.GC3968@reactrix.com> (Nick Hengeveld's message of
	"Wed, 16 Nov 2005 18:10:14 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12094>

Nick Hengeveld <nickh@reactrix.com> writes:

> Assuming --vernum does work, is there a reasonable/portable way to
> compare two hex values like 070801?

I would assume that it is always 6 lowercase hexdigits %06x when
supported, or showing nothing to stdout for ancient ones.

A horrible but probably portable way would be:

	case `(echo 070801; curl-config --vernum) 2>/dev/null |
        	sort -r | sed -ne 2p` in
	070801)
        	echo Happy ;;
        *)
        	echo Sad ;;
	esac

The obvious one is unfortunately not very portable:

	if test 070801 \< `curl-config --vernum`
        then
        	echo "Happy"
	else
        	echo "Sad"
	fi

This would work if your test is bash/dash-builtin.  The
following do not seem to know about '<' '>' string comparison:

	GNU /usr/bin/test from coreutils (version 5.2.1)
        OpenBSD shell builtin
        Solaris /usr/bin/test
