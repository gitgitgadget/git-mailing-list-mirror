From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch submodules
 too
Date: Wed, 15 Sep 2010 13:32:46 +0200
Message-ID: <4C90AEDE.4070300@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Sep 15 13:33:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvqEU-00058U-4R
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 13:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab0IOLcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 07:32:51 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:44557 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0IOLcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 07:32:50 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 16C1017099CF3;
	Wed, 15 Sep 2010 13:32:49 +0200 (CEST)
Received: from [93.240.123.162] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OvqEK-0002PO-00; Wed, 15 Sep 2010 13:32:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
In-Reply-To: <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18qgg7pM+8GvytnvlLiudR31xWOnm9fykHQOaY/
	w5/9e9cDFc8nSiuVsZxoe7ePfqyBH8EbsqGYONoHSvI3NX73KM
	4JgP1ispDXqFLpxbZn6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156232>

Am 15.09.2010 02:18, schrieb Kevin Ballard:
> The first is `git remote update`, which I am fond of using, causes buggy behavior where it fetches all submodules twice.

I'll look into that, fetching the same submodule twice should not
happen. (But I'm not sure what you mean by "buggy behavior where it
fetches all submodules twice" though, is there something else going
wrong?)


> The second is this submodule fetch doesn't appear to be recursive.

That is strange as fetch now executes a 'git fetch' inside each
populated submodule, which should automagically recurse. So I assume
that you don't have a .gitmodules file inside your first level of
submodules which describes the deeper nested ones?


> The third issue is `git fetch` doesn't have any business fetching submodules when the submodule reference was never changed as part of the fetch, especially if the main fetch itself didn't even find any changes. It seems to me that the correct behavior would be to look at all the fetched commits to see if any of them change the submodule reference, and only in that case should it automatically fetch any submodules whose references were modified. The stated desire of avoiding "(commits not present)" when doing a diff will still be met, but it will avoid slowing down the normal case of a `git fetch`.

I was thinking about implementing that optimization too but came to
the conclusion that you always have to fetch submodules too no matter
if the superproject has any new commits fetched for them. Because
when you don't do that you wouldn't get a chance to test and commit
e.g. a new feature added by a colleague in a submodule and pushed by
him, as that would not be fetched into your repo before it was
committed inside the superproject. That leads to a 'chicken or the
egg' problem.


> It also seems like there ought to be a config variable one can set for the default behavior if submodule.<name>.fetch is not present in .gitmodules or in .git/config.

I'll take this as a 'yes' to my question if such an option is wanted.


In your other mail you wrote that the output of the recursive fetch
does not prepend the names of the higher level submodules. I did not
think about that and will post a fix for that problem soon.


Thanks for your feedback!
