From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify role of init command in git-submodules documentation
Date: Mon, 20 Aug 2007 14:14:37 -0700
Message-ID: <7vd4xhsybm.fsf@gitster.siamese.dyndns.org>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
	<11875937841178-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hjemli@gmail.com, skimo@liacs.nl
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 23:14:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INEaP-000614-WF
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 23:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759414AbXHTVOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbXHTVOq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 17:14:46 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757442AbXHTVOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 17:14:44 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C977125174;
	Mon, 20 Aug 2007 17:15:01 -0400 (EDT)
In-Reply-To: <11875937841178-git-send-email-madduck@madduck.net> (martin
	f. krafft's message of "Mon, 20 Aug 2007 09:09:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56263>

"martin f. krafft" <madduck@madduck.net> writes:

> As per the discussion in this thread:
>
>   http://marc.info/?t=118721709500008&r=1&w=2

I'd rather see you summarize the conclusion of the thread here.
Having the URL as additional supporting reference is fine, but
when one reviews the "git log" output, one is not necessarily
online.

> this patch updates the git-submodules documentation to make the situation
> a bit clearer and documents the intended workflow.
>
> Signed-off-by: martin f. krafft <madduck@madduck.net>

Thanks.  Some comments.

> ---
> ...
>  init::
> -	Initialize the submodules, i.e. register in .git/config each submodule
> -	name and url found in .gitmodules. The key used in .git/config is
> -	`submodule.$name.url`. This command does not alter existing information
> -	in .git/config.
> +	Initialize the submodules, i.e. register in $GIT_DIR/config each
> +	submodule name and url found in .gitmodules. The key used in
> +	$GIT_DIR/config is `submodule.$name.url`. This command does not alter
> +	existing information in $GIT_DIR/config, it only serves to initialise
> +	the local configuration from the defaults in .gitmodules.

	s/initialise/initialize/;

>  FILES
>  -----
> -When initializing submodules, a .gitmodules file in the top-level directory
> -of the containing repository is used to find the url of each submodule.
> -This file should be formatted in the same way as $GIR_DIR/config. The key
> -to each submodule url is "submodule.$name.url".
> +To work with submodules, a user has to prepare a repository clone with the
> +command `git-submodule init`.

Is it "a user _has_ to"?  Or "a user can use 'git submodule
init' to prepare?"

Another thing that bothers me with this description is this.
Imagine you are a complete "git submodule" newbie (say, myself),
and want to try applying this facility to your own project (say,
git.git).  So I first remove git-gui from git.git repository and
then try to add git-gui.git from Shawn as a submodule.  Surely,
I am interested in the recipe "To work with submodules" at this
point, right?  Does that description apply to me?  Not really.

So this is not about "_has_ to" at all.  It is more like...

    You may want to work on a project you cloned from somebody
    else (we call that 'the superproject'), and find that the
    superproject has .gitmodules file at the top.  This file
    lists the subprojects that can be checked out in the
    superproject.  To make a checkout of the subprojects of the
    superproject you are interested in, you can use "git
    submodule init" to help you prime data about submodules in
    .git/config of the superproject.

> .... This command copies the url of each submodule
> +listed in the .gitmodules file in the top-level directory of the containing
> +repository to $GIT_DIR/config. The key to each submodule url is
> +"submodule.$name.url".

I think we've seen most of that description in the above 'init::'.

I've read Sven's description on two files.  My suspicion is that
instead of saying there are two files involved, it may be easier
to understand if we tell the story like this:

 - "git submodule" subcommands typically use data from the git
   configuration "submodule.$name.$key";

 - Definition of $name (e.g. it is just a logical token, not
   necessarily the directory name, i.e. moving a subproject to
   another directory does not have to change the $name).

 - Definition of possible $key (e.g. 'url'; others?)

 - After the initial clone of the superproject, you would not
   have any of the necessary configuration variables in _your_
   copy of the superproject.  There is a facility to help you
   prime that information.  The project gives you .gitmodules,
   and the tool gives you "git submodule init" to read from it.
   Here is what the subcommand does...
