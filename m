From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK)] gitk: Fix commit encoding support.
Date: Mon, 10 Nov 2008 22:46:14 +1100
Message-ID: <18712.7942.767651.569321@cargo.ozlabs.ibm.com>
References: <200811091806.07550.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 12:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzVGe-0002Cm-Ud
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 12:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbYKJLru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 06:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbYKJLru
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 06:47:50 -0500
Received: from ozlabs.org ([203.10.76.45]:47881 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306AbYKJLrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 06:47:49 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 95950DDDFB; Mon, 10 Nov 2008 22:47:48 +1100 (EST)
In-Reply-To: <200811091806.07550.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100517>

Alexander Gavrilov writes:

> +proc do_readcommit {id} {
> +    global tclencoding
> +
> +    # Invoke git-log to handle automatic encoding conversion
> +    set fd [open [concat | git log --no-color --pretty=raw -1 $id] r]
> +    # Read the results using i18n.logoutputencoding
> +    fconfigure $fd -translation lf -eofchar {}
> +    if {$tclencoding != {}} {
> +	fconfigure $fd -encoding $tclencoding

Does this mean there are two conversions going on, one inside git log
and another inside Tcl?  Is there a reason why it's better to do two
conversions than one, or is it just more convenient that way?

Would an alternative approach have been to read the output of git
cat-file with -translation binary, look for an encoding header, and do
an encoding convertfrom based on the encoding header?  What would be
the disadvantage of such an approach?

Paul.
