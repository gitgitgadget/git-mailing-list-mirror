From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: help with git filter-branch
Date: Thu, 18 Mar 2010 16:19:11 +0100
Message-ID: <4BA2446F.1080002@viscovery.net>
References: <551f769b1003180743n2b2dde99laf00aa9bfe0141bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 16:19:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsHVR-00051e-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 16:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab0CRPTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 11:19:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39285 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab0CRPTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 11:19:15 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NsHVA-00063s-Rh; Thu, 18 Mar 2010 16:19:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AEF021660F;
	Thu, 18 Mar 2010 16:19:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <551f769b1003180743n2b2dde99laf00aa9bfe0141bf@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142477>

Yann Simon schrieb:
> The idea is to add a missing parent to a certain commit.
> I wrote the following bash script:
> 
> #!/bin/sh
> die () {
>     echo >&2 "$@"
>     exit 1
> }
> [ "$#" -eq 3 ] || die "usage: add_parent <commit_to_update>
> <present_parent> <parent_to_add>"
> git filter-branch --parent-filter \
>     'test $GIT_COMMIT = $1 && \
>     echo "-p $2 -p $3" \
>     || cat' \
>     --tag-name-filter 'cat' \
>     $2..master
> 
> When I try to use it an a test repository, I get the following error:
> 
> ./add_parent.sh ad12d20974cad91ddedd055f5335b7471e48dd1d
> 1541f3ae456556edc7e15cead1ae76f470961be0
> 88b5d6f190f9d7135148c67c4d949c0c06e179ff
> Rewrite ad12d20974cad91ddedd055f5335b7471e48dd1d (1/1)test: 3: =:
> argument expected

The $1, $2, $3 are expanded too late in your script, namely when the
--parent-filter is evaluated, not when it is passed as argument to
filter-branch. Make it

git filter-branch --parent-filter "
	test \$GIT_COMMIT = $1 &&
	echo -p $2 -p $3 ||
	cat" \
	--tag-name-filter cat \
	$2..master

Of course, you can achieve this particular task slightly easier using a
graft as the manual of filter-branch shows.

-- Hannes
