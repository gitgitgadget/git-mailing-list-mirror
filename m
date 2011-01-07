From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation/checkout: explain behavior wrt local
 changes
Date: Thu, 06 Jan 2011 16:16:25 -0800
Message-ID: <7vtyhl8t5y.fsf@alter.siamese.dyndns.org>
References: <20110106154418.3348.29438.reportbug@localhost>
 <20110106173522.GB11346@burratino> <20110106225222.GA15900@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "r.ductor" <r.ductor@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 01:16:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb00c-0002DN-BT
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 01:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab1AGAQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 19:16:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1AGAQk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 19:16:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 505F343DF;
	Thu,  6 Jan 2011 19:17:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+u9GNrJciOszPkPte0XQcaCamfQ=; b=JALpIZ
	pqkG4PIOm9aWzheiZX2TVSMcoZbggzLrpR4u2aQCn1Ova1OPT/DhrGpIV34Q20iL
	WRHvbxyxTviBvwF7wzzafs7JzdJ+sOdRjfudeP6scF36GYWLgW6RPrqGqCPgC6lZ
	8t+hv7okKHBt/4PAITAmxavo+fm4LaHH1rXzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PtlOaDtlEDI54agbn8e/kwCLbrgQhy9C
	faxnIGpvu3usrXfTG5cf2jZjL/HB8vtHbkNFQI1vaE/7oIWE/dWDkgWCNABfgDSG
	1T+xIWDFL76YC8yuTY033it697DbPof/etWp1BmrvW01D65y0CxRRzlibxwEiDa/
	MHLDc3iW7VY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 089C743D9;
	Thu,  6 Jan 2011 19:17:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A107C43D4; Thu,  6 Jan 2011
 19:17:06 -0500 (EST)
In-Reply-To: <20110106225222.GA15900@burratino> (Jonathan Nieder's message of
 "Thu\, 6 Jan 2011 16\:52\:22 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 790FF18C-19F3-11E0-9B00-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164687>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  'git checkout' [<branch>]::
>  'git checkout' -b|-B <new_branch> [<start point>]::
>  
> -	This form switches branches by updating the index, working
> -	tree, and HEAD to reflect the specified branch.
> +	This form switches branches by changing `HEAD` and updating the
> +	tracked files to the specified branch.  'git checkout' will
> +	stop without doing anything if local changes overlap with
> +	changes to the tracked files.  (Any local changes that do not
> +	overlap with changes from `HEAD` to the specified branch will
> +	be preserved.)

Even though I am fully aware that "switch" was an attempt to match the
terminology from another SCM (e.g. svn), it may help readers in the longer
term if we stop using "switch" and instead explain this as "checking out a
branch" and what this action is _for_.  I suspect that an explanation of
the purpose would clarify the reason why the command does what it does.

You check out a branch to work on that branch, namely, eventually to
commit changes to that branch (as opposed to committing them to the
current branch).  For that purpose, the local changes obviously need to be
preserved.  And that is why it refuses to act if paths with local changes
need to be updated.

Side note.  When you check out a path (or a set of paths), you don't work
on these files (git does not track individual files), hence there is no
possible interpretation other than "get a fresh unmodified copy out of
something" when the command is used with paths, i.e. "checking out paths
(either out of the index or out of a named commit)".

In any case, your rewrite is certainly an improvement compared to an
unexplained "reflect", so I think this is a step in the right direction.

Thanks.
