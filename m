From: David Kastrup <dak@gnu.org>
Subject: Re: RFC GSoc Idea: blame: do not overly favor earlier parents
Date: Thu, 06 Mar 2014 21:21:39 +0100
Message-ID: <87siqvcc30.fsf@fencepost.gnu.org>
References: <xmqq8usnxfi1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:21:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLenY-0001i2-UG
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 21:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbaCFUVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 15:21:41 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:53218 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbaCFUVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 15:21:40 -0500
Received: from localhost ([127.0.0.1]:52260 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WLenT-0007du-DT; Thu, 06 Mar 2014 15:21:39 -0500
Received: by lola (Postfix, from userid 1000)
	id 0A826E0478; Thu,  6 Mar 2014 21:21:39 +0100 (CET)
In-Reply-To: <xmqq8usnxfi1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 06 Mar 2014 12:02:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243546>

Junio C Hamano <gitster@pobox.com> writes:

> When looking at a merge, "git blame" inspects the blob object names
> of all parents and if one of them exactly match the merge result,
> pass the entire blame down to that parent.  This is very much in
> line with the history simplification done with "git log" when
> traversing a history with merges.

[...]

> Now, imagine if you amend M to create N, to add a single line at the
> end of path.  M:path != N:path but there is very small difference
> between the two.  That means B:path != N:path but the difference
> between this merged result and the second parent is very small.

That sounds very much like

commit d5df1593f27bfceab807242a538cb3fa01256efd
Merge: 7144168 0b4e246
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Feb 28 13:51:19 2014 -0800

    Merge branch 'bl/blame-full-history' into pu
    
    By disabling the tree-same optimization (which is consistent with
    the default behaviour of "git log"-family of commands), make "git
    blame" sometimes produce different result from the original code.
    
    Because the "git blame" output can give result for each line from
    only one lineage of the history, however, this can be only useful
    when you are lucky---unlike "--full-history" of "git log"-family,
    where we can show commits from both lineages of histories with an
    equal weight.  See $gmane/240392 for more detailed discussion.
    
    * bl/blame-full-history:
      blame: new option --prefer-first to better handle merged cherry-picks

-- 
David Kastrup
