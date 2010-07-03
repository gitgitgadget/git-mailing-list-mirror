From: David <bouncingcats@gmail.com>
Subject: *Non*-interactive squash a range ?
Date: Sat, 3 Jul 2010 23:38:14 +1000
Message-ID: <AANLkTimTx2dVlK9KKi1nZpOadwDcfyzhE8nffCyK1Sqm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 15:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV38T-00075A-So
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 15:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab0GCNiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 09:38:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63160 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab0GCNiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 09:38:15 -0400
Received: by vws5 with SMTP id 5so4704029vws.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=z0Jg61acLyi0CltgSY8mb5ucCLq1O//TstOHH8xEF/g=;
        b=V8+lLqCGhkB+7gadM8qdG0b5/u7r46ElbhRgDoz9q5qxh0i7w3PJhFDQS6q9UmroGJ
         QjPvDmNiruq7L6MXTjQp+hrBz/U777RiK3v0MrNxLnImVpCXLJ1ZDQXUgI8vX4hkhhCn
         mY0j56UdqXwNWgFBkir5G8C2EUDx1YQyjUXtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=N2UAyJgMdlfSqKuR0tBg0M1ZtO9/ThcKK4nUcfDbJtYNMLPnxUYkT7nA/EW1kZL8IL
         hLDhyfk+/zuTCKgsPtRHgVX7UzeJk+Lr+X7Oa6fcF83QRFgUKBc3V6FwZcUisGTY9AZ4
         LucXCqJg0Qh54W2mfz+v2cXJ0CAA3gkYkBSPo=
Received: by 10.229.250.194 with SMTP id mp2mr202272qcb.27.1278164294352; Sat, 
	03 Jul 2010 06:38:14 -0700 (PDT)
Received: by 10.229.80.144 with HTTP; Sat, 3 Jul 2010 06:38:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150191>

Thanks for the awesome git. I have a basic question. I am subscribed
to this list.

Having successfully used rebase -i to squash, I wonder about some
method to *non*-interactively squash a sequence of intermediate
commits. On a local experimental branch.

Lets say the starting point is this branch named "uglybranch" with HEAD=J

    E---F---G---H---I---J  <uglybranch>

where commit G added a previously untracked file.

My desired result is this:

      ------------------K  <cleanbranch>
     /
    E---F---G---H---I---J  <uglybranch>

where K and J are identical worktrees.

I've used rebase -i as follows:
 $ git checkout uglybranch
 $ git checkout -b cleanbranch
 $ git rebase -i E
 # used interactive editor to squash all F..J onto E to produce K, on
cleanbranch only, uglybranch is not changed.

This gives exactly the result I want, in particular the file added at
G is preserved, but the drawback is that the method is needlessly
interactive. I want a foolproof non-interactive method that achieves
the same result. Namely squashing *all* the commits in the range F..J

I tried this which seems to work:
 $ git checkout uglybranch
 $ git checkout -b cleanbranch
 $ git reset --mixed E          # worktree same as uglybranch
 $ git add .                    # adds any untracked files
 $ git commit -a                # -a detects any removed files

So I'm thinking of using that method in a script. Have I overlooked
anything? Is there a better way?
