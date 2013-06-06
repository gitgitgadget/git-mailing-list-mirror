From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH] git-gui: bring Wish process to front on Mac
Date: Thu, 6 Jun 2013 15:09:32 +0100
Message-ID: <CABNJ2G+h3zh+=wLA0KHjUn8TsfhqUK1Kn-1_=6hnXVRJUPhuuA@mail.gmail.com>
References: <1370506667-24576-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Thu Jun 06 16:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukasj-0004UH-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 16:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab3FFOJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 10:09:34 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:46267 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3FFOJd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 10:09:33 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so3326656pbb.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tUoxilHkXDWj856OzVQPVbtmTjH8LIVelhwSz7D3FOo=;
        b=zoxsVKxC5BmtNm1w/bgQfohaT8L9RfLHBYvx5xmOqZlKbof4SUiQd+1Zf/l7NeIovy
         AYp4jKpJ7R4SV9IMgnwZvCEw5ylrRg8CFGFAohM7/Py8KWHL2u4HMBTPZATCkQX6mH4I
         u8SbFD4VcM6Y/fymAqB8/V0T3NMmR4RkKrCByRKcVp5YE7KZUbNBIPPWd6tCv4pGw0S7
         oK0BkbV5HsEPOwOqGgnZfPJRqkNQlsl3ZXRPVTjgePGCg+mRUAwIapFpklGEOQzaSPAn
         2p537A75+gbrhwMxjDYqC6Fh33ttFX6pFR/ri6NRFvjY+mNI7duMxy1rCa14oPRLgUeo
         s+Mw==
X-Received: by 10.68.27.9 with SMTP id p9mr37978147pbg.139.1370527772734; Thu,
 06 Jun 2013 07:09:32 -0700 (PDT)
Received: by 10.68.63.132 with HTTP; Thu, 6 Jun 2013 07:09:32 -0700 (PDT)
In-Reply-To: <1370506667-24576-1-git-send-email-stefan@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226506>

On 6 June 2013 09:17, Stefan Haller <stefan@haller-berlin.de> wrote:
> On Mac OS X, any application that is started from the Terminal will open
> behind all running applications; as a work-around, manually bring ourselves
> to the front. (Stolen from gitk, commit 76bf6ff93e.)
>
> We do this as the very first thing, so that any message boxes that might pop
> up during the rest of the startup sequence are actually seen by the user.
>
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>  git-gui.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index e133331..c464928 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -29,6 +29,19 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA}]
>
>  ######################################################################
>  ##
> +## On Mac, bring the current Wish process window to front
> +
> +if {[tk windowingsystem] eq "aqua"} {
> +       exec osascript -e [format {
> +               tell application "System Events"
> +                       set frontmost of processes whose unix id is %d to true
> +               end tell
> +       } [pid] ]
> +}
> +
> +
> +######################################################################
> +##
>  ## Tcl/Tk sanity check
>
>  if {[catch {package require Tcl 8.4} err]
> --
> 1.8.3.14.g33f718c
>

Seems fine to me. I can't test this as I have no access to this
platform. Possibly you should run this in a catch statement so it can
ignore any errors and I would tend to use the 'auto_execok' command to
ensure that osascript actually exists. Something like

  set arg [format {tell application......}]
  catch {exec {*}[auto_execok osascript] -e $arg [pid]}

but possibly this is guaranteed to exist on all macs which would make
the above redundant. What I'm thinking is you dont want the app to
exit just because something goes wrong in this call.
