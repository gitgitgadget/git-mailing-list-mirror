From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] gitk: Enhance UI popup and accelerator handling.
Date: Thu, 9 Oct 2008 11:27:51 +1100
Message-ID: <18669.20487.88439.584567@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 02:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnjSl-0003wN-KE
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 02:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbYJIAb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 20:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbYJIAb5
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 20:31:57 -0400
Received: from ozlabs.org ([203.10.76.45]:52517 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbYJIAb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 20:31:56 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1F37BDE077; Thu,  9 Oct 2008 11:31:55 +1100 (EST)
In-Reply-To: <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97817>

Alexander Gavrilov writes:

> - Popups are supposed to be marked transient, otherwise
>   the WM creates them in strange places. Besides, at
>   least under kwin, transients are automatically kept
>   above their parent.
> - Accelerators for menu items should be listed directly
>   on the items, to make them more discoverable.
> - Some more accelerators are added, e.g. F4 for Edit View.
> - Finally, dialogs can now be accepted or dismissed using
>   the Return and Escape keys.

Thanks for the patch series; a few specific comments follow.

> +    catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }

What is this key, or why is this line needed?

> @@ -2484,10 +2501,10 @@ proc keys {} {
>      }
>      toplevel $w
>      wm title $w [mc "Gitk key bindings"]
> +    wm transient $w .
>      message $w.m -text "
>  [mc "Gitk key bindings:"]
>  
> -[mc "<%s-Q>		Quit" $M1T]
>  [mc "<Home>		Move to first commit"]
>  [mc "<End>		Move to last commit"]
>  [mc "<Up>, p, i	Move up one commit"]
> @@ -2521,11 +2538,11 @@ proc keys {} {
>  [mc "<%s-plus>	Increase font size" $M1T]
>  [mc "<%s-KP->	Decrease font size" $M1T]
>  [mc "<%s-minus>	Decrease font size" $M1T]
> -[mc "<F5>		Update"]

I think it is useful to have the accelerator keys listed in the key
binding help.

> @@ -7501,6 +7534,7 @@ proc domktag {} {
>      addedtag $id
>      dispneartags 0
>      run refill_reflist
> +    return 1
>  }
>  
>  proc redrawtags {id} {
> @@ -7539,7 +7573,7 @@ proc mktagcan {} {
>  }
>  
>  proc mktaggo {} {
> -    domktag
> +    if {![domktag]} return

You need to change the error returns in domktag to say "return 0",
otherwise this will give a "can't use empty string as operand of "!""
Tcl error.

Paul.
