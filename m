From: William Pursell <bill.pursell@gmail.com>
Subject: characterizing commits
Date: Sat, 13 Dec 2008 08:28:12 +0000
Message-ID: <4943721C.7070200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 09:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBPsZ-0003Hi-BK
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 09:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbYLMI2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 03:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbYLMI2S
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 03:28:18 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:43852 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbYLMI2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 03:28:18 -0500
Received: by ewy10 with SMTP id 10so2144180ewy.13
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 00:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=korln6DBdvDwp1kw/WU/w82CAk7b2YQi/ysOBlR9bII=;
        b=mSSeGU5YImW9YJH9192Yz5Ce49w7TsHlOh+jlt0EoFEUI1YwsnJ8b90UnzfgRlONva
         OJVdDk4r3HyA+nv3UOlFpkz8GciozQZ78DY/JtCmkoyxN+fn1zVk11Hq4PkewaxUeys1
         hLmyT/51qNeE5lmo9BNZWjgACQrrG4xjhmHBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=L3XJgNkV0tLZ/JfyElZmpST37MHjh5v7Z2ulKYBQJ/kWvOoiAaYxRihjYhvxPmEDwb
         EV5Z/POSvZIkJGwwPb7xQAdm1pFFJwjX4pdzw0lr/Atxdr45lehOLS7dmugYJMq0cQiE
         cjhsZyfIxuHxhP1Wn5Rybi1MlSpCQSFRmvqjE=
Received: by 10.210.81.3 with SMTP id e3mr1901763ebb.197.1229156896301;
        Sat, 13 Dec 2008 00:28:16 -0800 (PST)
Received: from clam.local (5ace1311.bb.sky.com [90.206.19.17])
        by mx.google.com with ESMTPS id t12sm3296463gvd.25.2008.12.13.00.28.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 00:28:15 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102992>


I have a desire to add metadata to commits to characterize
their importance/type.  (Or I'd like another recommended
method to achieve the following behavior).

A lot of commits in any given project can be grouped into
different types.  eg, looking at the history for git,
there are a lot of merge commits, a lot of commits
that only touch gitk, a lot of 'auto-generated manpages',
a lot of 'typo in documentation' etc.  In my own
projects, I have a fairly high percentage of commits
that are trivial (eg whitespace only, typos, etc).
What I'm after is the ability to do something like:

git log --group=!trivial
git log --group=importance:3+

and only get the log for those commits that have been
not been classified "trivial" or that have a precedence
of 3 or greater.

For example, I'd like the following work flow:

$ git log --pretty=oneline
e62bb07a6894d282cdc0fdba6c67ae2ecd086cbb 5
b0986c6e8415c45e123e1838fbe8bf9e8518a90d 4
89916e36bae3208a76c338e91508759787563042 3
3942ef4e118dde3d844da5d84f466ac9666fae62 2
6fa2e40ed491d1dcbbfac9f2d301b517413bec3b 1
04dcd38a8cb6496e37594a273ca39542912ca1eb important
9bd23c2d08e254058a1a9709f963737dc9a71d16 trivial change
$ git group 6fa2e trivial
$ git group 9bd23 trivial
$ git log --pretty=oneline --group=!trivial
e62bb07a6894d282cdc0fdba6c67ae2ecd086cbb 5
b0986c6e8415c45e123e1838fbe8bf9e8518a90d 4
89916e36bae3208a76c338e91508759787563042 3
3942ef4e118dde3d844da5d84f466ac9666fae62 2
04dcd38a8cb6496e37594a273ca39542912ca1eb important

Is there already a mechanism for filtering
commits that I could extend to accomplish this?


-- 
William Pursell
