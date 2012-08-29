From: Stijn Souffriau <stijn.souffriau@essensium.com>
Subject: dangling submodule references after rebase
Date: Wed, 29 Aug 2012 11:55:04 +0200
Message-ID: <503DE6F8.3030106@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 11:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6eze-0004Yv-2k
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 11:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab2H2JzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 05:55:08 -0400
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:40097
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2H2JzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 05:55:07 -0400
Received: from [172.16.0.18]
	by viper.mind.be with esmtp (Exim 4.69)
	(envelope-from <stijn.souffriau@essensium.com>)
	id 1T6ezJ-00063N-Br
	for git@vger.kernel.org; Wed, 29 Aug 2012 11:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120714 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204473>

Hi all,

I am using a repository that has a sub module which is being committed 
to frequently by myself as well as others. Because of the heavy 
concurrent development I need to do a lot of rebasing. Since the sub 
module commit hashes referenced by the parent repository can become 
dangling as a result of rebasing the sub module I am required to do lots 
of manual "fixing" of the references in the parent repository using an 
interactive rebase. This is a tedious, error-prone procedure which I 
would like to automate.

I was wondering if anyone has thought about solving this problem yet in 
the past and what might be a good solution?

I was thinking something along the lines of extending the add and commit 
commands so that a parent repository would signal to the sub modules 
that it's index or some if it's commits reference certain sub module 
commits; and also the rebase command so that it would update the parent 
repository commits with new hashes using the information stored by the 
add or commit commands. The procedure would have to be made recursive 
because changing commits in the parent repository might also require 
changing commits in it's parent repository as well.

I'm still no quite sure for which sub module rebase operations the 
referencing parent repository commits would actually have to be 
"updated". The reason being that the rebased commits might still be 
referenced by another branch and so they might continue to exist after 
the rebase which raises the question if the parent repository commits 
need to be udated or not. I think this question would have to be 
answered by the add and commit commands which would also have to specify 
a referenced branch in addition to referenced commits so that the parent 
repo commits would only have to be updated if the commits on this branch 
are rebased. By default this could be the branch checked out in the sub 
module at the time the referencing commit was made.

For obvious reasons this should only be done for newly made, unpushed 
and unpulled commits in the repository. However, it might be interesting 
to also enable people to manually bind a parent repo commits to a 
submodule branch so that the commits in this parent repo branch are 
updated when the sub module branch is rebased.

I would like see this end up in the mainline and so I'm very interested 
in your opinions.

Thanks,

Stijn
