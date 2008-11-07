From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 3/6] gitk: Add accelerators to frequently used menu commands.
Date: Fri, 7 Nov 2008 22:50:03 +1100
Message-ID: <18708.11115.293282.71076@cargo.ozlabs.ibm.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-2-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-3-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-4-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 12:53:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyPuI-0003HL-Ef
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbYKGLwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 06:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYKGLwG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:52:06 -0500
Received: from ozlabs.org ([203.10.76.45]:52041 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbYKGLwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:52:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id B88FEDDDFB; Fri,  7 Nov 2008 22:52:03 +1100 (EST)
In-Reply-To: <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100308>

Alexander Gavrilov writes:

> -	eval $m add $params [lrange $i 4 end]
> +	set tail [lrange $i 4 end]
> +	regsub -all {\$M1T\y} $tail $M1T tail
> +	eval $m add $params $tail

This is solving the problem that the $M1T doesn't get expanded in the
call below because it's inside {}.  If we are going to have a magic
string that gets expanded like this, I'd rather it didn't look like a
variable reference, because that is confusing.

Alternatively, we could define a [meta] function that does this:

proc meta {x} {
    if {[tk windowingsystem] eq "aqua"} {
	return Cmd-$x
    }
    return Ctrl-$x
}

and then use -accelerator [meta F5] in the makemenu call, and not have
any magic string substitution in makemenu.  That will work since the
eval will evaluate the [].

Paul.
