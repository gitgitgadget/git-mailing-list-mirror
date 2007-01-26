From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git fetch over ssh trouble
Date: Fri, 26 Jan 2007 00:34:00 -0500
Message-ID: <20070126053400.GB18058@fieldses.org>
References: <20070126050842.GA18058@fieldses.org> <7vmz462wdh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 06:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAJiz-0004fx-RK
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 06:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030754AbXAZFeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 00:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030755AbXAZFeE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 00:34:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:59309 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030754AbXAZFeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 00:34:03 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HAJiq-0001Zi-Vt; Fri, 26 Jan 2007 00:34:00 -0500
Content-Disposition: inline
In-Reply-To: <7vmz462wdh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37801>

On Thu, Jan 25, 2007 at 09:24:42PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Any idea why this is happening?:
> >
> > bfields@pickle:git$ git fetch linux-nfs
> > Password:
> > /usr/local/bin/git-parse-remote: line 145: test: !=: unary operator
> > expected
> 
> Ouch.
> 
> I wonder what should happen when you do not have anything
> defined for "linus-nfs" shorthand.

Oops; I didn't notice that!

> Should it fetch HEAD?

In my case I'd want it to either default to what I actually wanted
(+refs/heads/*:refs/remotes/linux-nfs/*), or just fail with something
helpful:

	"Nothing to fetch"?
	"No refspec given, and no default fetch configured for linux-nfs"?
	"What do you want me to fetch?"?

I don't know.

> 
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 1122c83..12023d2 100755
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -82,6 +82,7 @@ get_remote_default_refs_for_push () {
>  # a merge candidate
>  expand_refs_wildcard () {
>  	first_one=yes
> +	test "$#" = 0 && echo empty
>  	for ref
>  	do
>  		lref=${ref#'+'}
> 

Yep, now it does nothing much more quietly....

--b.
