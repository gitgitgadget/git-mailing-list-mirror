From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] gitk: Allow displaying time zones from author and
 commit timestamps
Date: Sun, 29 May 2011 14:46:56 +1000
Message-ID: <20110529044656.GA8881@brick.ozlabs.ibm.com>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
 <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun May 29 12:20:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQd76-00069y-Tv
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 12:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab1E2KUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 06:20:47 -0400
Received: from ozlabs.org ([203.10.76.45]:58969 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab1E2KUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 06:20:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E419EB6F82; Sun, 29 May 2011 20:20:45 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174686>

On Wed, Jan 19, 2011 at 02:47:52PM -0500, Anders Kaseorg wrote:

> Now gitk can be configured to display author and commit dates in their
> original timezone, by putting %z into datetimeformat in ~/.gitk.
> 
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  gitk |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 5c6058a..a072593 100755
> --- a/gitk
> +++ b/gitk
> @@ -11018,7 +11018,18 @@ proc prefsok {} {
>  proc formatdate {d} {
>      global datetimeformat
>      if {$d ne {}} {
> -	set d [clock format [lindex $d 0] -format $datetimeformat]
> +	if {[string match {*%[zZ]*} $datetimeformat]} {
> +	    if {[catch {set d [clock format [lindex $d 0] -timezone [lindex $d 1] -format $datetimeformat]}]} {
> +		# Tcl < 8.5 does not support -timezone.
> +		global env
> +		set zone [lindex $d 1]
> +		set env(TZ) "IDK[string range $zone 0 2]:[string range $zone 3 end]"

What is this about?  Where is the IDK prefix for timezones defined or
described?

> +		set d [clock format [lindex $d 0] -format $datetimeformat]
> +		unset env(TZ)

Oops, we just lost any previous setting of TZ...

Paul.
