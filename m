From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Anyone have a commit hook for forbidding old branches from being
 merged in?
Date: Thu, 1 Dec 2011 16:34:06 +0100
Message-ID: <CACBZZX4LyTaz=fU1vvgpeL904QFjJULCMVSP0uutcuxZT+-vWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 01 16:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW8ef-0000Nv-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 16:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab1LAPe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 10:34:29 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60859 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab1LAPe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 10:34:28 -0500
Received: by ghrr1 with SMTP id r1so1906428ghr.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=CqlodPzDsnblkWJPSFxuLFtWTQrwBCIG+bTWOSVxTxI=;
        b=ZBIqmYfBMwHB/TfKEX7EYkhnkrQ9I1C6LeMlFPQHAlThJ2itEJqzhMV2LAJcruQ2Ys
         7C46dLBl0OWrRRKoIKp0TnUSSV0wQqdvF20FHUYagnPJs8YcfoOQh9zM9UxZd9hXU0T8
         Rc5hDkIwopC8SwAYM1fcv3OjuQp7KXBlU1Pm8=
Received: by 10.204.14.208 with SMTP id h16mr7800590bka.2.1322753667468; Thu,
 01 Dec 2011 07:34:27 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Thu, 1 Dec 2011 07:34:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186171>

I work on a web application that due to underlying database schema
changes etc only even compiles and runs for a given 2 week moving
window.

Thus if someone started a branch say 1 month ago, works on it one and
off, and then merges it back into the mainline it becomes impossible
to bisect that code if it has a problem. You either have to:

 * Revert the whole merge
 * Manually eyeball the code to see where the error might be
 * Brute-force manually bisect it by checking out only the files
   altered in those commits instead of the commit at a given
   data. Usually individual files are still compatible with the new
   code.

But the whole reason this is a problem is because people don't rebase
their branches before merging them in, unintentionally causing
problems.

So before I write a hook to do this, is there anything that implements
a hook that:

 * Checks if you're pushing a merge commit
 * If so, is that merge based off and old version of $MAINBRANCH
 * Is the base of that branch more than N days old?
 * If so reject the push
