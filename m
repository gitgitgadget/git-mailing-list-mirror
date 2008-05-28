From: "Geoffrey Irving" <irving@naml.us>
Subject: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 11:06:10 -0700
Message-ID: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 20:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Q3X-0003bP-8b
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYE1SGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYE1SG3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:06:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:56181 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYE1SG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:06:29 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3637712rvb.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=oqVV64l+WINzR6nqXkPsC3qSOiPIV+1Ms8GQl6hzCYI=;
        b=R2sdXo0nE7mIyPKXdzESKXXk4wxK36vWjE+9qiwNJrr/6jY33DmwOuzshxV6hpAJ1gTP4DftNNKjN6CyP0el7b8LciEUQb6Li8hJkpGu3+WOe5yzLlOwafm5/Oc8ei2HqOJ6bPLcKNDx0zOMK4eXKcfPIJFJZbDsZSbxluX72lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=w+HsQOPoixp572LIdiKSSWEswX/V4roMvOTjU59T7mBQROC/C8+/36ougbRqO3scTe0LoDJfqyDkEoNar+CFoICXCX+50q23en5gZqEUsXQp2p30UkOeHFfuqW60qWZtpWINEWkzJFHmGhSVRgosaycSeglzT4FI+IXznGob1V0=
Received: by 10.140.193.15 with SMTP id q15mr1483058rvf.191.1211997988666;
        Wed, 28 May 2008 11:06:28 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Wed, 28 May 2008 11:06:10 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 1d101818f5826d18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83119>

I have a project stored in a git repository with other versions stored
in both cvs and perforce (sadly).  I want the ability to propagate
changes back and forth between all three repositories without mangling
the git history.  I specifically want to avoid (1) having two copies
of each commit (e.g., an initial version and a version pulled from
cvsimport) and (2) commits full of git-p4 metadata (the [git-p4] lines
in commit messages).

One way to do this would be to have cvs branch imported using "git
cvsimport", and a perforce branch imported via "git-p4", and
communicate between the cvs/p4 branches and the main git branches
entirely through cherry picking.  Unfortunately, "git cherry" doesn't
recognize when commits with potentially different author names or log
messages polluted with "[git-p4]" produce the same changeset, so if I
export a change from the git master branch through cvsexportcommit and
update the cvs branch with cvsimport, "git cherry" will report that
the change doesn't exist on the git master branch.

Has anyone tackled this problem before?  Would it be straightforward
to add an option to "git cherry" to ignore differences in metadata?
The cherry documentation doesn't give its criteria for when commits
match, and I'm not familiar enough with the code yet to figure out
those criteria directly from cmd_cherry in builtin-log.c.

Thanks,
Geoffrey
