From: David Kastrup <dak@gnu.org>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 17:02:34 +0100
Message-ID: <87mwhb1azp.fsf@fencepost.gnu.org>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
	<851tynz2yg.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 17:02:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJPtY-0008HE-0T
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 17:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbaB1QCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 11:02:36 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:52715 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaB1QCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 11:02:35 -0500
Received: from localhost ([127.0.0.1]:51757 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WJPtS-0008O3-Of; Fri, 28 Feb 2014 11:02:35 -0500
Received: by lola (Postfix, from userid 1000)
	id 4ABC2E0BFA; Fri, 28 Feb 2014 17:02:34 +0100 (CET)
In-Reply-To: <851tynz2yg.fsf@stephe-leake.org> (Stephen Leake's message of
	"Fri, 28 Feb 2014 09:12:07 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242980>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> Brandon McCaig <bamccaig@gmail.com> writes:
>
>> On Thu, Feb 27, 2014 at 9:57 PM, Stephen Leake
>> <stephen_leake@stephe-leake.org> wrote:
>>> You might be adding other files for other reasons. But if you add a file
>>> that does resolve a conflict caused by 'git stash pop', it is not
>>> guessing.
>>
>> Staging a file doesn't tell git that you resolved a conflict. Git will
>> happily accept a blob full of conflict markers. Git doesn't know the
>> difference. Git expects the user to know what is right. The user has
>> the freedom to manipulate the index as they see fit, which means both
>> adding and removing from it anytime they wish.
>
> But git has a notion of "unresolved conflict".

Not really.  It has a notion of "unmerged path".

> For example, when I have conflicts from a 'git stash pop', 'git
> status' shows:
>
> stephe@takver$ git status
> # On branch master
> # Unmerged paths:
> #   (use "git reset HEAD <file>..." to unstage)
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #	both modified:      CommandBasedAutonomous.java
> #	both modified:      DriveByInches.java
> #
> # ...
>
> How does it know those files are "unmerged"? I'm guessing it has
> recorded the fact that they had conflicts. Where does it record that?

The index contains the unmerged versions of the file.  Possibly also the
version with conflict markers, but it's been too long since I last
checked.

After "git add", there is only one version in the index.

If you apply a stash with unmerged paths to a worktree/index, possibly
containing unmerged paths of its own, possibly getting new unmerged
paths by failing to apply the stash, you get unmerged paths from several
different unresolved conflicts.

Git has no idea about the history of unmerged paths.  So having "git
add" modify the operation of "git reset" whenever "git add" overwrites
an unmerged path in the index could lead to quite funny results.

-- 
David Kastrup
