From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Fri, 13 Feb 2009 20:37:15 -0800
Message-ID: <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
 <1234578258-48870-1-git-send-email-git@randomhacks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 05:39:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYCJR-0007um-4d
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 05:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbZBNEh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 23:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbZBNEh1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 23:37:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZBNEh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 23:37:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 910B199515;
	Fri, 13 Feb 2009 23:37:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1CF2999514; Fri,
 13 Feb 2009 23:37:17 -0500 (EST)
In-Reply-To: <1234578258-48870-1-git-send-email-git@randomhacks.net> (Eric
 Kidd's message of "Fri, 13 Feb 2009 21:24:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BD594A8-FA51-11DD-9F2B-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109819>

Eric Kidd <git@randomhacks.net> writes:

> Proposed usage:
>     git submodule split [--url submodule_repo_url] submodule_dir \
>         [alternate_dir...]
>
> Replace submodule_dir with a newly-created submodule, keeping all the
> history of submodule_dir.  This command also rewrites each commit in the
> current repository's history to include the correct revision of
> sumodule_dir and the appropriate .gitmodules entries.
>
> If the submodule has moved around the source tree, specify one or more
> values for alternate_dir.  To specify the URL of the newly created
> repository (for use in .gitmodules), use the --url parameter.

Unfortunately, I do not think we have designed fully (nor implemented at
all) behaviour to check out different points of history that has the same
submodule moved around in the superproject tree.

There were several unconcluded discussions done in the past (and I admit I
participated in a few of them), but it may be hard to use the resulting
repository out of this tool.

I am not saying the split-submodule-history tool is bad in any way, of
course.  I'm just saying that the "git submodule" side needs to be updated
to support such a history better; otherwise the tool's output won't be
usable effectively.  You may want to Cc "submodule" people in the
discussion.

> Johannes Schindelin provided extensive help with the UI and
> implementation of this command (but has not yet reviewed the code).
>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

Please drop these two lines.  They belong to e-mail headers.

> Open questions:
>
>   1) Right now, this command is actually git-submodule-split.sh.  Should
>      I include this code directly into git-submodule.sh, or move it
>      to git-submodule--split.sh and hook it into git-submodule.sh?

How about in contrib/ somewhere?

>   2) Should I implement a --force flag based on filter-branch?  Johannes
>      Schindelin has suggested that it might be better to remove the
>      --force flag from filter-branch and just rely on the reflog to keep
>      backups.

Sounds sensible to me, but I do not have strong feeling about this either way.

>   4) We're obviously going to need to support revision arguments other
>      than --all (which is what we currently pass to filter-branch).  Should
>      we default to the current branch only, or to --all?

Matching what filter-branch defaults to would be the most natural,
wouldn't it?

I didn't look at the patch, though.
