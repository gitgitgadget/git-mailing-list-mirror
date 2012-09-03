From: haasip satang <haasip.satang@googlemail.com>
Subject: Automatic repacking when cloning - Only seems to work via file but
 not ssh or git
Date: Tue, 4 Sep 2012 01:20:48 +0200
Message-ID: <CAEz-yfibq5M=qTfoR5rkCyUJ=zC=VLSRcL+p618VXR-8td7d8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 01:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8fwv-0006lk-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 01:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab2ICXUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 19:20:50 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64801 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753936Ab2ICXUt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2012 19:20:49 -0400
Received: by lagy9 with SMTP id y9so3814688lag.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=drgqf3O2kWmVOID97xkThqESfrt28Cpzx3HGENA4Ilg=;
        b=m77v4mZ0ZonDCMj2RKk7ipT7gzU6/FoY0KZq5jxrIG71AjOFvdWgs/IDljgdgVE6VP
         NaBKJ5TWhv2YtS/hI+EE5J3rbgw6iYCmsyUU6nzRurWOCCEBNsALC3l4Ip0TRfSALopO
         xaa2Wikl8yBt4wyDjOSufoO192mn3PmGoHMxIkdEn1YgKPrR/mtHv8QR3f2eiLQmlMdr
         mShzg7Ok8EV780fvZkb+Sr1MB8cPj2CHLSe2MNyIx+wbBffRU/ZS3LDRLZvK0284FQg5
         NcqJhuNpAgj/aaCiX0a61qCCbKxQY51QscZCJ180MmDZoNrQBcaaXZThzL+Oadah8ozx
         3SJg==
Received: by 10.152.105.145 with SMTP id gm17mr15239226lab.55.1346714448195;
 Mon, 03 Sep 2012 16:20:48 -0700 (PDT)
Received: by 10.112.130.230 with HTTP; Mon, 3 Sep 2012 16:20:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204713>

Hi all,

I already posted this question in the git users groups
(https://groups.google.com/forum/?fromgroups=#!topic/git-users/dguTJFrw5MI)
but was advised to better ask the experts in this list. So here we go:

The question is regarding the packs and the repacking of those during
cloning. I'm migrating a big repository which after initial commit of
all files contains only one pack file of 120MB in size (about 800
extracted).

On this big repo I created various subtree branches (using git subtree
split) so I can clone some of the folders individually (without
getting the whole big thing). The problem is, however, that all my
subtree branch clones seem to get a copy of the big 120MB pack (where
often only 2MB will be extracted from it).

After testing a little bit I figured that this only happens if I use
ssh or the git protocol to clone the repo. When using file:// to
specify the remote repository some repacking seems to happen
automatically and I end up with a new pack file for my clone that only
contains the stuff that is really needed for my branch (which
obviously results in much smaller size).

Running the following commands on the clone created via ssh or git
helps removing the unnecessary overhead and repacks my repo creating a
small pack, discarding the unneded stuff:

git pack-refs --prune
git reflog expire --all
git repack -a -d -f -l

So although that helps me getting a small clone via ssh I have some
questions / doubts:

1. Is it "as designed" that the repacking only happens automatically
when cloning using the file url or could it be a bug that it is not
supported for ssh and git native protocol?
2. Is there already a way to achieve the repacking when cloning using
ssh or git protocol (as obviously I'd prefer to use those over file://
)?
3. Can I provide multiple pre-made packs for my different subtree
branches already on server side to make the cloning even faster and
avoid always having to repack when someone clones a subtree branch?

Thanks a lot,
Haasip
