From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Yet another Git tutorial
Date: Mon, 28 Apr 2008 17:17:06 -0700
Message-ID: <7vskx5a519.fsf@gitster.siamese.dyndns.org>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Wiegley <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:18:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqdXw-0000ia-Nr
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 02:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934007AbYD2ARN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 20:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbYD2ARN
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 20:17:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765973AbYD2ARM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 20:17:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 862025877;
	Mon, 28 Apr 2008 20:17:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 94E615876; Mon, 28 Apr 2008 20:17:08 -0400 (EDT)
In-Reply-To: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com> (John
 Wiegley's message of "Mon, 28 Apr 2008 02:39:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80635>

Page #5; after teaching "cat-file -t" it would make sense to teach
"cat-file blob" to view what was stored.

Page #5; likewise, "cat-file -t HEAD" to inspect and "cat-file commit
HEAD" to show its contents would be a much better "bottom-up" way to show
how the pieces fit together, instead of doing "show --pretty=format:%T".

Page #6; "HEAD tag"???

Page #6; s/my system/my repository/, as you use that word a few lines
later.

You use "id", "hash id", "hash number", "hash" etc. and have your readers
guess that you are talking about the same thing.  It would be better to
use a single word consistently (the official name of this number is the
"object name").

s/index cache/the index/.

s/tree owns blob/tree holds blob/, perhaps.

Page #9; before this point, your tree owned blobs but now suddenly it
references trees and blobs.  There should be a mention of this recursive
construction of a tree earlier soon after you introduced the tree
objects. 

Page #11: s/name:file/name:path/; notice that it can be non-files such as
symlinks and trees.

Page #12: s/name{tree}/name^{tree}/.

Page #12: name1..name2; "between name1 and name2, inclusive"?  This
excludes the left end.  "Everything reachable from name2 except the ones
reachable from name1".

Page #12: name1...name2.  This is a symmetric difference for "git log"
family of commands (iow when you talk about set of commits) which means
"Reachable either from name1 or name2 but not from both".  When used with
"git diff" to name two endpoints, this means what you described
(differences since the common ancestor of these two to name2).

Page #12: master..; it would also be useful to mention ..other here.

Page #17: The example makes me wonder what you did exactly to commit I.
It would contain roughly an equivalent of squashed B+C together, which may
or may not be what you want.

Page #18: There is no "two different things" reason behind the name.  It
was originally called "directory cache" and then renamed to "the index".
These days, most of the time we use these two words interchangeably, but
when we are picky, index tends to mean the file on the filesystem
(i.e. $GIT_INDEX_FILE aka $GIT_DIR/index) while cache tends to mean the
in-core structure (i.e. the_index.cache aka active_cache).

Page #22: "git reset --mixed" will remove blobs???  You surely did not
mean that.  It just reverts the staged contents to that of the HEAD (or
whichever commit you named and moved your HEAD to).

Page #24: saves your work in the stash "for the current branch"???  There
is no per-branch stash.  You can stash, switch branches and then apply the
stashed change to the other branch.
