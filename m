From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010] The 2nd week
Date: Tue, 1 Jun 2010 14:41:01 +0800
Message-ID: <AANLkTinelswhPBZJNBDo8VesCxBgRlEZezwcY9dWyaF4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 01 08:41:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJLA6-0000CE-AM
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 08:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab0FAGlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 02:41:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41842 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab0FAGlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 02:41:04 -0400
Received: by vws11 with SMTP id 11so567997vws.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Gb/jvk4qFMKKHTTlOAdr+ZjqOG+mOq7sJaYicE2mKW4=;
        b=FE8i0UmpYIc7jRajMdzm6Xo2/GDppgddqz+9QSlincOkZ/2OF5g/aRJhZH5xaGq9EI
         OFSrJgfPrP/X05gp1EP7Kw9C7zCARblUV6+xCW2uH4D9MCbTFcwzXAWNCBB6Au+rl86V
         WLkbJhhrBziy4L+1y/3lqVN5O2BvGVs/S274A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Ldi140yzlv1UEAiqjMpXWB6s9/oiOc64A080SP+kGNfMYxs/FNyXs4XpeCX1lZ8BkF
         sSrjW6DOa1qlO5kzjLgJoun2M/WcjB835d2z5o4gj6z28ebDbZtgcd9EVsjiKz+g0cAV
         cJ3nsVF0lYg0NXyI5tXO8gFUPxSrX1cBaxpfs=
Received: by 10.224.88.25 with SMTP id y25mr2094701qal.226.1275374462068; Mon, 
	31 May 2010 23:41:02 -0700 (PDT)
Received: by 10.229.110.18 with HTTP; Mon, 31 May 2010 23:41:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148083>

Hi,

   I have deal with many graduated works personally in my college, so
it is a busy week for me and this update comes a little later.  Of
course, I get progress on git development. Generally:
1. follow the issues of '--graph improvement' series;
2. try to find out a way to deal with the range split/combine problem.

And I think it is worth to mention how we will deal with the line
ranges when we follow the history, my mentor Thomas give the idea to
use a topo-order traverse, and I get a detail solution from that.

The line level browser will start at certain commit and its line
ranges, the ranges will not split/combine when we just encounter
linear history. But when it comes the merge commit, one branch will
take part of the ranges and other branches will take others. That
means the ranges will split here and will combine again after we reach
the common ancestor of all branches. Since, we will not know what a
commit's interesting ranges until all its children branches' commit's
ranges combine, so we need to walk the commits in topo-order and to
get the parents' commits' interesting ranges when we reach a commit.
This will make sure, when we reach some commit, its ranges is combined
and valid. Generally,
1. Sort all the commits in topo-order and put the sorted list in [list];
2. Pull one commit from [list], split the ranges according parents of
current commit, output the diff between current commit and each
parent;
3. Loop 2 until exhaust the [list];

Of course, the commit touch no interesting ranges will be ignored.

The point here is we will traverse the commit graph twice to achieve
this, I think it is the only way to do this and if there is some
smarter way to do this, please point me out, thanks!

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
