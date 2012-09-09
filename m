From: David Chanters <david.chanters@googlemail.com>
Subject: Keeping two repos in sync
Date: Sun, 9 Sep 2012 09:12:32 +0100
Message-ID: <CACffvTqt9UHw1wLVDZ=PDqJuktcD8M7uUfnnuDZ5cf9gwxsSqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 10:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAceD-00087k-Gv
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 10:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab2IIIMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 04:12:35 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59213 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab2IIIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 04:12:33 -0400
Received: by obbuo13 with SMTP id uo13so1487668obb.19
        for <git@vger.kernel.org>; Sun, 09 Sep 2012 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=pu7phxOG3te2Am79IxaWvulkeVJNPdn2/nIqEtGX4Yg=;
        b=irZy+T4aTJajH17o8JHFMI3GO9LKv+hWAz/ffodI45y+DMHiDZEdQE6ISouhfHmpGR
         aV/Z6kS8eV9lBiRnOfSaWol+UhifQ3m6IRFq/LDNR1hWeSLKgRlqVfuX7SFHmkpKLJne
         rZjD3JvsmpGmkzAKDpBc9EOLAEM75w2k0QD3W7uylLynRA8uQphBkyLKUQU6WLo/E47+
         TAqE9WZG9T15bo36VbULUbktZ6qdNseMbUJtj18mr/EA8tqHCNlbdNop6a7FCMhgveIo
         Xgl5KHKK7VokGRxSGN2xenLEo9s8q6oLVQ4HhOGt3GeKOMXiMSVE0OezfoK2jPKg37z8
         RiHQ==
Received: by 10.182.174.68 with SMTP id bq4mr10645205obc.53.1347178352491;
 Sun, 09 Sep 2012 01:12:32 -0700 (PDT)
Received: by 10.76.85.170 with HTTP; Sun, 9 Sep 2012 01:12:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205066>

Hi all,

I'm wondering how best to go about this problem.  I've got two
separate git repositories -- one is a portable version which I'll call
"portable", the other is part of a BSD project, which I'll call "bsd".
 Both repositories have the same set of *conceptual* files in them,
it's just that the portable repository has additional files which are
not found in the bsd repository.  It should be noted that the bsd
repository is an automatically managed cvsexport clone of a CVS
repository -- but I don't think this matters here, as we're just
talking about two git repositories.

The "workflow" if you can call it that, is commits happen in the bsd
repository and are then put in the portable repo.  At the moment, I am
using git grafts to do this.  The important point to remember here is
the two repositories DO NOT have any common history to them -- it's
just that where the files are the same in both the bsd and portable
repository I can see and hence tell git, where to graft the two master
branches from each repository and for me to merge bsd:master ->
portable:master.

However, I am wondering how best to handle this situation.  It's
pretty convoluted -- not to mention the fact that git grafts are never
permanent.  What I'd like is for some "safe" way of setting up an
initial git graft which tied the two master branches between bsd and
portable to reflect changes on bsd:master not on portable:master and
then for me to treat those two branches as though they shared common
history so that I can merge one to the other.  Unfortunately, what I'm
doing at the moment is each time changes happen to bsd:master, I'm
having to reset the git graft each time; and since that operation is a
local one, it makes things rather awkward in a shared repository
situation as I am the sole person who can perform these merges.

I'm guessing I could rebase at some point and push those changes out?
I'm just wondering how other people handle this situation or if it's
just unique to me?

Kindly,

David
