From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 18/31] rebase: extract merge code to new source file
Date: Wed, 29 Dec 2010 22:31:32 +0100
Message-ID: <201012292231.33333.j6t@kdbg.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-19-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 22:31:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY3cS-0006aG-OO
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 22:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab0L2Vbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 16:31:36 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:56738 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753524Ab0L2Vbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 16:31:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A06B313004D;
	Wed, 29 Dec 2010 22:31:33 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6D78819F6A0;
	Wed, 29 Dec 2010 22:31:33 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1293528648-21873-19-git-send-email-martin.von.zweigbergk@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164331>

On Dienstag, 28. Dezember 2010, Martin von Zweigbergk wrote:
> -run_interactive_rebase () {
> +run_specific_rebase () {
>  	if [ "$interactive_rebase" = implied ]; then
>  		GIT_EDITOR=:
>  		export GIT_EDITOR
>  	fi
>  	export onto autosquash strategy strategy_opts verbose rebase_root \
> -	force_rebase action preserve_merges upstream switch_to head_name
> -	exec git-rebase--interactive
> +	force_rebase action preserve_merges upstream switch_to head_name \
> +	state_dir orig_head onto_name GIT_QUIET revisions RESOLVEMSG \
> +	allow_rerere_autoupdate
> +	export -f move_to_original_branch

Is export -f portable?

> +	test "$type" != am && exec git-rebase--$type

I'd prefer to dispatch to the final rebase type using

	. git-rebase--$type

This way, you can avoid to export the huge list of helper variables and the 
function. (And it might be faster by a millisecond - or a few dozens on 
Windows.)

-- Hannes
