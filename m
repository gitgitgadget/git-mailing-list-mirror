From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: workaround Tcl/Tk Cmd-TAB behavior on OSX
Date: Sat, 20 Apr 2013 13:19:55 +1000
Message-ID: <20130420031955.GA30856@iris.ozlabs.ibm.com>
References: <5165B758.4070308@bee.kz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tair Sabirgaliev <tair.sabirgaliev@bee.kz>
X-From: git-owner@vger.kernel.org Sat Apr 20 05:20:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTOLe-0007JG-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 05:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965657Ab3DTDUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 23:20:00 -0400
Received: from ozlabs.org ([203.10.76.45]:52883 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965608Ab3DTDT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 23:19:59 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D66792C021C; Sat, 20 Apr 2013 13:19:58 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <5165B758.4070308@bee.kz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221831>

On Thu, Apr 11, 2013 at 01:02:48AM +0600, Tair Sabirgaliev wrote:
> On OSX Tcl/Tk application windows are created behind all
> the applications down the stack of windows. This is very
> annoying, because once a gitk window appears, it's the
> downmost window and switching to it is pain.
> 
> The patch is trivial: if we are on OSX, emulate Cmd-Shift-TAB
> key event, so that the gitk application window is brought
> from bottom to top.
> 
> Signed-off-by: Tair Sabirgaliev <tair.sabirgaliev@gmail.com>
> ---
>  gitk | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/gitk b/gitk
> index 572f73f..60a87fc 100755
> --- a/gitk
> +++ b/gitk
> @@ -11687,6 +11687,19 @@ if {[catch {package require Tk 8.4} err]} {
>      exit 1
>  }
>  +# On OSX workaround the Tcl/Tk windows going down the stack of Cmd-TAB
> +if {[tk windowingsystem] eq "aqua"} {
> +    exec osascript -e {
> +        tell application "System Events"
> +            key down command
> +            key down shift
> +            keystroke tab
> +            key up shift
> +            key up command
> +        end tell    +    }
> +}

Is this really the only way to do it?  It seems a bit hacky to me.  I
would think you should be able to use the "wm" command to achieve what
you want.  I don't use Mac OS, so I don't know exactly how Tcl/Tk
behaves on it, but this page looks like it might hold some clues for
what you want to do:

http://teapot.activestate.com/package/name/windowlist/ver/1.4/arch/tcl/file.tm

Paul.
