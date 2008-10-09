From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/7] gitk: Make cherry-pick call git-citool on conflicts.
Date: Thu, 9 Oct 2008 21:57:41 +1100
Message-ID: <18669.58277.929130.165032@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-3-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-4-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-5-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-6-git-send-email-angavrilov@gmail.com>
	<18669.46569.45285.170033@cargo.ozlabs.ibm.com>
	<bb6f213e0810090124i62a51e92n45836ee02577331a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 13:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KntJR-00045w-3l
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbYJILCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbYJILCx
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:02:53 -0400
Received: from ozlabs.org ([203.10.76.45]:33805 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319AbYJILCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:02:52 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7CEC3DDF1E; Thu,  9 Oct 2008 22:02:51 +1100 (EST)
In-Reply-To: <bb6f213e0810090124i62a51e92n45836ee02577331a@mail.gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97838>

Alexander Gavrilov writes:

> If I understand correctly, using a shell would require composing the
> command as a string, which itself requires quoting the author name & email,
> and other argument strings. I did not feel confident enough to do that, so
> chose a dumb but safe solution.

You're right.  I think we should do it basically the way you suggest,
but the saving/restoring of the environment can be done a bit more
concisely like this:

proc exec_citool {args {baseid {}}} {
    global commitinfo env

    set save_env [array get env GIT_AUTHOR_*]

    if {$baseid ne {}} {
	# as before ...
    }

    eval exec git citool $args &

    catch {array unset env GIT_AUTHOR_*}
    array set env $save_env
}

> I'm more used to languages where lists and strings are very different types...
> Even in perl you have to use [] for an empty list ref, and '' for an
> empty string.

In Tcl, everything is a string. :)

Paul.
