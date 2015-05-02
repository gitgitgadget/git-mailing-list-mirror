From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Remove mc parameter from proc show_error
Date: Sat, 2 May 2015 20:05:13 +1000
Message-ID: <20150502100513.GA19038@iris.ozlabs.ibm.com>
References: <1430536400-22008-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bernt@norang.ca, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 12:36:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoUm6-0003vl-7M
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 12:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbbEBKfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 06:35:53 -0400
Received: from ozlabs.org ([103.22.144.67]:50968 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbbEBKfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 06:35:52 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A7FE2140310; Sat,  2 May 2015 20:35:51 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1430536400-22008-1-git-send-email-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268225>

On Fri, May 01, 2015 at 09:13:20PM -0600, Alex Henrie wrote:
> This is a better fix for 8d849957d81fc0480a52570d66cc3c2a688ecb1b.
> 
> All that was required to fix the original issue was to remove the extra
> mc call, i.e. change [mc "Sorry, gitk cannot run..."] to simply
> "Sorry, gitk cannot run..." Changing the signature of proc show_error
> was unnecessary and introduced two new bugs: It made "OK" untranslatable
> and "mc" translatable when the opposite should be true.
> 
> This new fix makes the string "OK" translatable and the string "mc" not
> translatable, while leaving the string "Sorry, gitk cannot run..." not
> translatable. It will take effect the next time `make update-po` is run.

To test this, I changed {package require Tk 8.4} to {package require
Tk 8.7}, in order to deliberately trigger the error.  When I run gitk
with that change (and your patch applied), I get this in the xterm
where I run gitk:

$ ./gitk
Error in startup script: invalid command name "mc"
    while executing
"mc OK"
    (procedure "show_error" line 7)
    invoked from within
"show_error {} . "Sorry, gitk cannot run with this version of Tcl/Tk.\n Gitk requires at least Tcl/Tk 8.4.""
    invoked from within
"if {[catch {package require Tk 8.7} err]} {
    show_error {} . "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
                     Gitk requires at least ..."
    (file "./gitk" line 12012)

and no pop-up window.  So this patch still isn't quite right.

Given that old versions of tcl/tk probably don't have [mc], I think
it's inevitable that "OK" will have to be untranslated for that
particular error path.

Paul.
