From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: [usability bug] git branch -a does not disambiguate remote and local branches
Date: Mon, 15 Dec 2008 21:15:15 +0300
Message-ID: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 19:16:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCHzn-0007cS-Fx
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 19:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbYLOSPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 13:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbYLOSPT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 13:15:19 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:50322 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYLOSPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 13:15:18 -0500
Received: by bwz14 with SMTP id 14so2446614bwz.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=RPs7ALbvSK9OYrBR6mkQDptPgptRVEW04885+ZU2dcE=;
        b=pDtzGyTqpCl09djxdkPtLbvIElGAi03ffpi/WQvpw6j2qi9qTNFNo10LlQqYPdF35I
         uXbtpy8x4V1PrDZ4oPl+ow0wv0Sm0EQBBmOBPL9E4k1H4HHy6pJcZLqVQ9wgVJFpPJ6a
         6kac0bshCUJEArTzu053FIQ0tG/ZqbF5pfb9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=mNBTrin+lzoVwjme2l00j0c7c1dpACNvGA87G3lrU4vWdR1uFosxI6AD4gE64dIm4W
         +Hchb8IMpIMogEV7y08NVwQt5qjX9ezCukztKI0ONFLq/4swpVSE5wcIS8i3buddlZ+F
         WsrKoOGZ6FbV+ZYz738Tfi5jW2xihYuFAYRig=
Received: by 10.181.139.10 with SMTP id r10mr2626035bkn.11.1229364915553;
        Mon, 15 Dec 2008 10:15:15 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Mon, 15 Dec 2008 10:15:15 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103194>

Let's consider the following scenario:

mkdir bare.git
mkdir local
cd bare.git
git --bare init
cd ../local
git init
echo test > test.txt
git add test.txt
git commit -m test
git remote add origin `pwd`/../bare.git
git push --all
git checkout -b origin/master master
echo updated > test.txt
git add test.txt
git commit -m updated

Note that that in this scenario, the user has created local branch in
the folder with the same name as a remote branch. While the supposed
user here is apparently shooting itself in the foot, the scenario is
still supported by git, and might happen as a result of more logical
git operations (like git fetch).

After this scenario is executed, git branch -a will give the following output:
  master
* origin/master
  origin/master

Note that there is two origin/master entries, but it is not clear
which is remote is and which is the local. I think that "git branch
-a" should print unambiguous names, qualifying them if needed.

Constantine
