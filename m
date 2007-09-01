From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sat, 01 Sep 2007 11:07:25 -0700
Message-ID: <7vir6us1ia.fsf@gitster.siamese.dyndns.org>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRXNg-0007R8-1C
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 20:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbXIASHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbXIASHb
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 14:07:31 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbXIASHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 14:07:30 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EF23412C792;
	Sat,  1 Sep 2007 14:07:48 -0400 (EDT)
In-Reply-To: <11886421573285-git-send-email-robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Sat, 1 Sep 2007 12:22:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57279>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 5ed1821..1fef857 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -64,12 +64,34 @@ __gitdir ()
>  
>  __git_ps1 ()
>  {
> -	local b="$(git symbolic-ref HEAD 2>/dev/null)"
> -	if [ -n "$b" ]; then
> +	local g="$(git rev-parse --git-dir 2>/dev/null)"
> +	if [ -n "$g" ]; then
> +		local r
> +		local b
> +		if [ -d "$g/../.dotest" ]
> +		then
> +			local b="$(git symbolic-ref HEAD 2>/dev/null)"
> +			r="|REBASEING"

I might be in the middle of resolving a conflicted "git am".

But I love the idea.  We need to think about cleaning up our
"state machine" mechanism to make this kind of thing easier to
do.  We've had a few suggestions on the list in the past but
they never passed the suggestion/speculation stage.
