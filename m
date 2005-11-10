From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Strange merge conflicts against earlier merge.
Date: Thu, 10 Nov 2005 13:38:35 +1300
Message-ID: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Nov 10 01:39:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea0Se-0001gn-1z
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 01:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVKJAih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 19:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVKJAih
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 19:38:37 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:64967 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751131AbVKJAig convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 19:38:36 -0500
Received: by zproxy.gmail.com with SMTP id j2so289735nzf
        for <git@vger.kernel.org>; Wed, 09 Nov 2005 16:38:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ahLpU3wWSTp8/Cb+dwUdU25pt6uKlBNi/1OIxOYPGfpRaQABAzq7l0vqoZMkKKii4WcVtvKe5nCr2srZTFk7DiowOvIRGfWIO/IkD5jOt0nz63fjpvjfZPmYliXbKt74I+dHDHIvHKMKI9Og0CAJ9178AcH9GNky4XLVrQOKyYQ=
Received: by 10.65.15.15 with SMTP id s15mr153704qbi;
        Wed, 09 Nov 2005 16:38:35 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Wed, 9 Nov 2005 16:38:35 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11456>

We are working with a series of closely related heads, and merging
among them. I am sometimes finding merge conflicts that I don't think
I should be seeing. Assuming two branches, 'local' and 'remote', where
local has with remote before (*), and I have no conflicting changes in
local...

 1 - pull and merge from remote. The merge touches file A, B and C
 2 - on local, develop on unrelated files O,P,Q, commit
 3 - pull and merge from remote. The merge touches file B, C and D. I
am sometimes seeing conflicts on file B and C, which was never touched
on local.

* - In the case i have, the ancestry before the merge is a bit
convoluted. AFAIK, this shouldn't affect us going forward. Both
branches have a common ancestor, though, and are now merging often
from remote to local.

We are using cogito for this, although on step 3 I have also tested
with git-merge.sh and I get the same result.  It could still be a
problem related to how the merge on step 1 is recording the merge.

For an example, clone
http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti and
register also the
http://locke.catalyst.net.nz/git/moodle.git#mdl-local branch. Create
two heads:

 master: 214e6374d49e6d014f0ba6f159d585a3fe468909
 remote: 05059be73c9e09e22b98bc796be35c595e551ed6

On git-merge 'testing merge' master remote you'll see conflicts over
mod/quiz/editlib.php -- doing the same with cg-merge gets an
additional conflict on mod/quiz/export.php. Neither of those files
were ever modified on local -- however, both merges brought in changes
to the same lines of code.

I suspect this is because the merge itself is being considered a
commit on the local branch. Fair enough -- git has no way of ensuring
that I haven't slipped in a few changes of mine in the merge. OTOH,
it's pretty unexpected to see this on files that are not one char
different from the 'remote' branch. Am I doing something wrong?

cheers,


martin
