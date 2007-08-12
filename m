From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4, ping] gitk: let you easily specify lines of context in diff view
Date: Sun, 12 Aug 2007 13:17:45 +1000
Message-ID: <18110.31705.747583.463206@cargo.ozlabs.ibm.com>
References: <11856503182381-git-send-email-prohaska@zib.de>
	<11868462503722-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 07:33:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK65A-0002nt-Fr
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 07:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbXHLFdl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 01:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbXHLFdl
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 01:33:41 -0400
Received: from ozlabs.org ([203.10.76.45]:53257 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbXHLFdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 01:33:40 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 25BF3DDF14; Sun, 12 Aug 2007 15:33:39 +1000 (EST)
In-Reply-To: <11868462503722-git-send-email-prohaska@zib.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55664>

Steffen Prohaska writes:

> Any chance to get this patch applied? It works for me.

Some comments:

> @@ -731,7 +732,16 @@ proc makewindow {} {
>  	-command changediffdisp -variable diffelide -value {0 1}
>      radiobutton .bleft.mid.new -text "New version" \
>  	-command changediffdisp -variable diffelide -value {1 0}
> -    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left

Just add another pack command rather than extending this one.

> +    label .bleft.mid.labeldiffcontext -text "      Lines of context: " \
> +    -font $uifont

This is hard to read because the continuation line isn't indented
further that the first line.  Please indent continuation lines by an
extra 4 spaces.

> +# empty strings or integers accepted
> +proc diffcontextvalidate {v} {
> +    if {[string length $v] == 0} {
> +	return 1
> +    }
> +    if {[string is integer $v]} {
> +	if {$v > 0} {
> +	    return 1
> +	}
> +    }
> +    return 0
> +}

"string is integer" will already accept the null string and return 1.

> +proc diffcontextchange {n1 n2 op} {
> +    global diffcontextstring diffcontext
> +
> +    if {[string is integer $diffcontextstring]} {
> +        if {$diffcontextstring > 0} {

Once again, "string is integer" returning 1 doesn't guarantee the
string is non-empty.  Use "string is integer -strict" if you want
that.

> +            set diffcontext $diffcontextstring
> +		    reselectline

Inconsistent indentation.

> +set diffcontext 3
> +

It would be nice to save diffcontext in the ~/.gitkrc.

Paul.
