From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Mon, 02 Jun 2008 20:56:52 -0700
Message-ID: <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 05:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3NfI-0006Xk-Qo
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 05:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbYFCD5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 23:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYFCD5J
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 23:57:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYFCD5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 23:57:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3C4A32F3;
	Mon,  2 Jun 2008 23:57:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1889632F1; Mon,  2 Jun 2008 23:57:00 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 2 Jun 2008 19:05:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 206AF7E2-3121-11DD-88E7-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83613>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio: see kernel commits a733a5da9 and 52b097fff89, done as lately as 
> February of this year. We shouldn't allow that kind of thing,...

Well, we even allow fast-forwrad to be recorded as a true merge if the
user asks these days.

And the thing is, that "a733a5da9" commit has a smoking-gun evidence that
a nonsense is asked by the committer.

    commit a733a5da97b238e3e3167d3d0aee8fe1e8d04e97
    Merge: 299cfe3... 299cfe3... 9e52797...
    Author:     Len Brown <len.brown@intel.com>
    AuthorDate: Thu Feb 7 03:38:22 2008 -0500
    Commit:     Len Brown <len.brown@intel.com>
    CommitDate: Thu Feb 7 03:38:22 2008 -0500

        Merge branches 'release' and 'fluff' into release

        Conflicts:

            drivers/acpi/scan.c
            include/linux/acpi.h

        Signed-off-by: Len Brown <len.brown@intel.com>

"Merge branches 'RELEASE' and 'fluff' into RELEASE"?  That happens if you
are _on_ release branch and say "git merge release fluff".

Having said that, I think what is happening is that the final set of
"other parents" is computed inside git-merge out of MERGE_HEAD and that is
usually what is recorded in the resulting merge, but if the merge results
in a conflict with manual resolution, that information is not given to the
final "git commit".  The resulting commit records the parents out of HEAD
and MERGE_HEAD.  I do not think this part has changed from scripted
version of git-commit.
