From: Junio C Hamano <gitster@pobox.com>
Subject: Re: builtin command's prefix question
Date: Wed, 05 Dec 2007 15:43:13 -0800
Message-ID: <7v8x48lnce.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com>
	<7vlk88n648.fsf@gitster.siamese.dyndns.org>
	<7vk5nsloa8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J03u1-0005Vx-LG
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 00:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbXLEXnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 18:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbXLEXnV
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 18:43:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50831 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXLEXnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 18:43:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1C77E2F0;
	Wed,  5 Dec 2007 18:43:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C6429D188;
	Wed,  5 Dec 2007 18:43:36 -0500 (EST)
In-Reply-To: <7vk5nsloa8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Dec 2007 15:22:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67212>

Junio C Hamano <gitster@pobox.com> writes:

> I am not convinced this is giving any natural user experience, nor an
> alternative:
>
>       $ cd $HOME
>       $ GIT_WORK_TREE=$HOME; export GIT_WORK_TREE
>       $ cd $HOME/gits/vimrc.git
>       $ edit $HOME/.vimrc
>       $ git commit .vimrc
>       $ cd $HOME/gits/pinerc.git
>       $ edit $HOME/.pinerc
>       $ git commit .pinerc
>
> While I still think the combination is simply crazy and does not make
> any sense, if enough users on the list agrees that it makes sense, I
> wouldn't mind setup() did (1) to (3) mentioned above.  The alternative
> is simply to declare GIT_WORK_TREE without GIT_DIR is a nonsense and
> either error error out or ignore GIT_WORK_TREE, which might be easier to
> explain to people.
>
> Opinions?

Side note.

By saying the above, I do not mean it is nonsense to try supporting a
work tree that is an overlay of disjoint set of work tree files from
multiple repositories/projects.  I do think it is a worthwhile goal to
support such a layout.

What I do not like is the way the ugly workaround does it, by
encouraging (rather, requiring) to issue git commands from a location
that is completely separate from the actual editing of the content
happens.

An independent issue of supporting such a overlayed work tree layout is
what to do with .gitignore files.  I think, especially with the recent
addition of --exclude-standard to ls-files and setup_standard_excludes()
in dir.c, we could have a per repository configuration that names the
per repository exclude files, so that .gitignore-vim and .gitignore-pine
can co-exist in $HOME, each excluding everything other than the
project's own files.
