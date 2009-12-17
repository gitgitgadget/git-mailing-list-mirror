From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Thu, 17 Dec 2009 12:40:05 +0100
Message-ID: <4B2A1895.2000803@viscovery.net>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de> <4B29106C.1040501@viscovery.net> <20091217093547.GA25451@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 12:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLEiY-0007Qh-8G
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 12:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764509AbZLQLkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 06:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764520AbZLQLkK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 06:40:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22787 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764515AbZLQLkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 06:40:09 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NLEiD-0000gv-Lj
	for git@vger.kernel.org; Thu, 17 Dec 2009 12:40:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4B8151660F
	for <git@vger.kernel.org>; Thu, 17 Dec 2009 12:40:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091217093547.GA25451@pcpool00.mathematik.uni-freiburg.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135367>

Bernhard R. Link schrieb:
> * Johannes Sixt <j.sixt@viscovery.net> [091216 17:53]:
>> Bernhard R. Link schrieb:
>>> --prune-tree makes rev-list without paths equivalent to
>>> "git rev-list $options -- ." (or .. or ../.. and so on,
>>> if you are in some subdirectory).
>>> This is the new default for format-patch and rebase
>> Why do you need a new option when you can just add "-- ." to the rev-list
>> invocation?
> 
> I want the default for format-patch changed.

I do not see why format-patch would have to be changed. The case that you
outline (a merge -s ours happened and you want to follow only one parent)
is rare enough and even more rarly will somebody want to apply
format-patch to such a history.

But I guess that you are actually not interested in format-patch per se,
but rather in rebase (which uses format-patch).

> For this I think it is easiest to add a new rev_info flag, as otherwise
> format-patch would need to duplicate parsing the rev_list options
> and either duplicate applying revs->prune_data or changing the argv for
> setup_revisions with some special casing of bare repository and non-bare
> repository cases.

I haven't looked at the code, but wouldn't it be matter of "if we do not
have any pathspec, add '.'" *after* all options are parsed?

> And when there is that option, I think it is more robust to use that
> in merge -m and merge -i, as "-- ." only does the right thing by chance
> because both only work with a non-bare repository and have
> cd_to_toplevel.

git rev-list -- . works in a bare repository, too. If you hard-code "-- ."
in the rev-list invocations in git-rebase[--interactive], then it cannot
be said that this works "by chance" due to cd_to_toplevel.

-- Hannes
