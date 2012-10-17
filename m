From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch --tree-filter'
 on Solaris?
Date: Wed, 17 Oct 2012 09:23:12 +0200
Message-ID: <507E5CE0.10002@viscovery.net>
References: <1109432467.20121017104729@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TONyQ-0005kK-Pr
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 09:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab2JQHXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 03:23:15 -0400
Received: from so.liwest.at ([212.33.55.24]:46042 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab2JQHXP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 03:23:15 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TONyC-0007ns-M2; Wed, 17 Oct 2012 09:23:12 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 69B8B1660F;
	Wed, 17 Oct 2012 09:23:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1109432467.20121017104729@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207900>

Am 10/17/2012 8:47, schrieb Ilya Basin:
> The filter-branch command, the contents of ~/.gitconfig and the tree
> are the same.
> The command succeeds on cygwin, but fails on Solaris due to
> unset GIT_AUTHOR_NAME and GIT_COMMITTER_NAME :
> 
> $ git filter-branch --tree-filter "env | grep GIT_ ; $CMD" b416b9bfc5e71531f2f05af4c396bb0ba7560741..HEAD
> Rewrite 214efc6eec82b015aefe23b2280979f05b351396 (1/16)GIT_DIR=/home/tester/.ilya/builds/makepkg.rap_0.1-1_sparc.XXXXXX/src/rap/.git
> GIT_INDEX_FILE=/home/tester/.ilya/builds/makepkg.rap_0.1-1_sparc.XXXXXX/src/rap/.git-rewrite/t/../index
> GIT_WORK_TREE=.
> GIT_AUTHOR_NAME=
> GIT_COMMITTER_NAME=
> GIT_COMMIT=214efc6eec82b015aefe23b2280979f05b351396
> fatal: empty ident  <my@email.com> not allowed
> could not write rewritten commit

Most likely, your sed has problems with a sed script in function
get_author_ident_from_commit. I tested it like this:

$ sh -c '. $(git --exec-path)/git-sh-setup;
		get_author_ident_from_commit HEAD'
GIT_AUTHOR_NAME='Johannes Sixt'
GIT_AUTHOR_EMAIL='j6t@kdbg.org'
GIT_AUTHOR_DATE='@1350025129 +0200'

-- Hannes
