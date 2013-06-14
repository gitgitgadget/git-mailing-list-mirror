From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-gui: bring Wish process to front on Mac
Date: Fri, 14 Jun 2013 10:54:42 -0700
Message-ID: <7vwqpwo9wd.fsf@alter.siamese.dyndns.org>
References: <1l424u5.uk987q18u3oxfM%lists@haller-berlin.de>
	<1370642211-34416-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Haller <stefan@haller-berlin.de>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 19:54:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnYD4-0001zs-9O
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 19:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab3FNRyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 13:54:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab3FNRyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 13:54:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38224280DB;
	Fri, 14 Jun 2013 17:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NjRivOESxVm8Q/wYwUzdc91CwJE=; b=DMjqMD
	sg7UTTPBw7dT4gAXotEhsolLHN+wSBewwQwufRCRDSoNz5emKGZqFiEjGE8Dpr84
	lMhWQxZ132U4Uk5FRl2MBU14VOhjobeTdOCVBRTsmwOV8/nka+q2wKuZyNcPs5dB
	bVDF3Pqho5S7lb4EvaDwcXmxBvaosp9CAeacM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KesNKxWi/FSMk5V2V8+iNd8fsRp44hyg
	n6Y7oeXFtnE8U2ECFsmdUMTKs+xzybzCZnXbQs1iCUGrcLprH3ZMEXUvkWph5lJT
	H7sona433vvZiGYSQk0uSYTuxU3v/UD4PHY4OwwD6YrYd4cWaJklXIGzN6/UNJS7
	jO8XhGjF6bA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AF92280DA;
	Fri, 14 Jun 2013 17:54:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C14C280D9;
	Fri, 14 Jun 2013 17:54:44 +0000 (UTC)
In-Reply-To: <1370642211-34416-1-git-send-email-stefan@haller-berlin.de>
	(Stefan Haller's message of "Fri, 7 Jun 2013 23:56:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EFC65AE-D51B-11E2-B726-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227905>

Stefan Haller <stefan@haller-berlin.de> writes:

> On Mac OS X, any application that is started from the Terminal will open
> behind all running applications; as a work-around, manually bring ourselves
> to the front. (Stolen from gitk, commit 76bf6ff93e.)
>
> We do this as the very first thing, so that any message boxes that might pop
> up during the rest of the startup sequence are actually seen by the user.
>
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---

Pat, is there any progress on this?  I do not mind, and I actually
would prefer, a pull request early in the development cycle.

"I've been busy and haven't got around to it", is a perfectly
acceptable response.  Just pinging to check.

> Changes since the first patch: 
>  - add catch
>  - specify full path to /usr/bin/osascript
>
>  git-gui.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index e133331..a792924 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -29,6 +29,21 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA}]
>  
>  ######################################################################
>  ##
> +## On Mac, bring the current Wish process window to front
> +
> +if {[tk windowingsystem] eq "aqua"} {
> +	catch {
> +		exec /usr/bin/osascript -e [format {
> +			tell application "System Events"
> +				set frontmost of processes whose unix id is %d to true
> +			end tell
> +		} [pid] ]
> +	}
> +}
> +
> +
> +######################################################################
> +##
>  ## Tcl/Tk sanity check
>  
>  if {[catch {package require Tcl 8.4} err]
