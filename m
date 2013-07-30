From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ANNOUNCE: git-integration -- Easily manage integration branches
Date: Tue, 30 Jul 2013 09:45:49 -0700
Message-ID: <7vli4ovvwi.fsf@alter.siamese.dyndns.org>
References: <20130730154620.GN2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 30 18:46:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4D3c-0006Jf-VF
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 18:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016Ab3G3Qpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 12:45:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641Ab3G3Qpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 12:45:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5C0834CF5;
	Tue, 30 Jul 2013 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RmgpPofbu/4Wrw1xfIKVwBR4k3c=; b=NO2V23
	mpUkumY7u47etI7s5NJrfYewuDDu1WRwr1o9GCPCmEwO9brSApLMfuuhuLWacd/t
	2pL05JhB85fHCocwiDx99UF58PoD306/QE4qdYtggqBqs7Br4opdAEEcziz/uatN
	GFIu9HOyqjvgBa8LZrRx/jhuqznASIyjzgTIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzMYT6kOppupM2Vt3nGLXo4uJpk0edBB
	8Z4lCfq9AqicZpdfykUasAMdEcdcrGcm93elJsIsEVCi4l27LRbGQdBkwobYffg0
	hpkpjTY53moZro+W5AioWseDx0xJE8ReKeEQXQoX1JZUSAoCPkje7yn1SIwr7rjX
	Xb26+72k9ik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA53034CF4;
	Tue, 30 Jul 2013 16:45:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7EB634CF1;
	Tue, 30 Jul 2013 16:45:50 +0000 (UTC)
In-Reply-To: <20130730154620.GN2337@serenity.lan> (John Keeping's message of
	"Tue, 30 Jul 2013 16:46:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E27EFAA-F937-11E2-BEE8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231373>

John Keeping <john@keeping.me.uk> writes:

> I wrote this script a few months ago and have been using it pretty much
> daily since then, so I figure it's time to see if anyone else finds it
> useful...
>
> git-integration [1] is a script to help manage integration branches in
> Git.  By defining a base point and a set of branches to be merged to
> form the integration branch, git-integration lets you easily rebuild an
> integration branch when anything in it changes, as well as showing you
> the status of all of the branches in the integration branch.
>
> For example, the instruction sheet for git-integration's "pu" branch
> recently looked like this:
>
> 	base master
>
> 	merge make-clean
>
> 	  Add a "clean" target to the makefile.
>
> 	merge version
>
> 	  Support for "--version" option.
>
> 	  N.B. this builds on "make-clean".
>
> 	merge skip-option
>
> 	  Needs more work to be able to handle "branch not found".
>
> This tells git-integration to base the "pu" branch on "master" and merge
> the "make-clean", "version" and "skip-option" branches in.  The comments
> following the "merge" instructions are added to the commit message for
> the corresponding merge commit.  When I want to rebuild the "pu" branch
> I simply do:
>
> 	$ git integration --rebuild pu
>
> To change the contents of the branch, I either edit the instruction
> sheet manually:
>
> 	$ git integration --edit pu
>
> or quickly add a new branch from the command line:
>
> 	$ git integration --add my-new-branch pu
>
> In fact, I can combine these to get the benefit of bash-completion on
> the branch name and the ability to edit the instruction sheet - when
> multiple commands are specified, git-integration performs each of them
> in a sensible order, described in the manpage [2].
>
>
> [1] http://johnkeeping.github.io/git-integration/
> [2] http://johnkeeping.github.io/git-integration/git-integration.html

Interesting.

Would it help me to replay "evil merges" I previously made and avoid
necessity to write merge log messages repeatedly?

In short, can I replace my Meta/Reintegrate and Meta/cook with this
(see Documentation/howto/maintain-git.txt)?
