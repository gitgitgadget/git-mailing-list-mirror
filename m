From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: pruning recipe for destructive
 filter-branch
Date: Sat, 14 Feb 2009 11:29:46 -0800
Message-ID: <7vab8ou89h.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902141248220.10279@pacific.mpi-cbg.de>
 <1234621328-8998-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:31:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQEa-0004jM-5L
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZBNT35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbZBNT35
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:29:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbZBNT34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:29:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E4CE6991A5;
	Sat, 14 Feb 2009 14:29:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CDA02991A0; Sat,
 14 Feb 2009 14:29:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB84C334-FACD-11DD-84A5-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109905>

Thomas Rast <trast@student.ethz.ch> writes:

> +git-filter-branch is often used to get rid of a subset of files,
> +usually with some combination of `\--index-filter` and
> +`\--subdirectory-filter`.  If you want to physically shrink the
> +repository afterwards, you have some choices:
> +
> +* Make sure you really removed all variants of a filename, if a blob
> +  was moved over its lifetime.  `git log \--name-only \--follow \--all
> +  \-- filename` can help you find renames.
> +
> +* Make sure you really filtered all refs: use `\--tag-name-filter cat
> +  \-- \--all` when calling git-filter-branch.
> +
> +* Clone it with `git clone file:///path/to/repo`.  The clone will not
> +  have the removed objects.  See linkgit:git-clone[1].  (Note that
> +  cloning with a plain path just hardlinks everything!)
> +
> +If you really don't want to clone it, for whatever reasons, check the
> +following points instead (in this order).  This is a very destructive
> +approach, so *make a backup* or go back to cloning it.  You have been
> +warned.
> +
> +* Remove the original refs backed up by git-filter-branch: say `git
> +  for-each-ref \--format="%(refname)" refs/original/ | xargs -n 1 git
> +  update-ref -d`.
> +
> +* Expire all reflogs with `git reflog expire \--expire=now \--all`.
> +
> +* Garbage collect all unreferenced objects with `git gc
> +  \--prune-expire=now` (or if your git-gc is not new enough to have
> +  that option, `git repack -ad; git prune`).

I am sorry, but the above does not flow well.  The first two common
preparatory steps appear as if it is only for the "clone" method.

	... often used to get rid of ... and people expect the resulting
        repository to be smaller than the original, but you need a few
        more steps to actually make it smaller, because git tries hard 
        not to lose your objects until you tell it to.  First make sure
	that:

	* you really removed all...

	* you reall filtered all...

	Then, there are two ways to get a smaller repository.  A safer way
	is to clone, that keeps your original intact.

	* Clone it with ...

	If you do not want to ...

	* Remove the original refs...

	* Expire all...
