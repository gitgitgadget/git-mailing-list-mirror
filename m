From: Christofer Jennings <boz.lists@gmail.com>
Subject: Sanity Check: scrum teams, shared 'story branches', rebasing shared branches
Date: Sat, 9 Jun 2012 16:51:28 -0700
Message-ID: <3EA7D039-9D6E-4945-A982-43DB53AAE43A@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 01:52:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdVSC-0008Mh-Dr
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 01:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab2FIXvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 19:51:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51280 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2FIXvk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 19:51:40 -0400
Received: by obbtb18 with SMTP id tb18so4539030obb.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=k7r9INRXa9jTlFNljCPXL+qO6UU6oXc5mO5slukehug=;
        b=vVYOES+XQRgCp+syfI5Tdy+M01wKVrQplGnETr5QalxhMrmLt95Okdp8svYYAJrfNd
         yhi5FbRDc9BLM6MofpIWzdGVFHSfnKb9VVdnRLpQVwJseDDprsZonY5FFAF2+mU8HDCn
         cElcxFqlwtRsxopGBJ7N8BcfymYZs//sxnUUsBOIdytLCPa7C7WWsRBQS2H6KzZTnSh6
         fDCOrIcgkjs+joo/+Zxrju6h+xcdbRlc0pHc00pPhqC/vl3IMHFb6TQnAbbhNtKQmqnm
         AFtH/mqtffBYONom63OfQaAtX+o2SZFgC0+vauI4ZALltLikJsqgWYBh3Z3nGYWYqahh
         2wuw==
Received: by 10.60.6.132 with SMTP id b4mr11742120oea.22.1339285899872;
        Sat, 09 Jun 2012 16:51:39 -0700 (PDT)
Received: from [10.0.1.2] (ip72-197-63-152.sd.sd.cox.net. [72.197.63.152])
        by mx.google.com with ESMTPS id g1sm6718585oei.4.2012.06.09.16.51.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 16:51:39 -0700 (PDT)
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199565>

Hi All,

(New to this list. Please tell me if this is the wrong forum for this thread.) 

I've been using Git and GitHub for ~6 months. Working on a SCM plan for a Scrum project with 50+ developers in ~8 dev. teams. Each team will be working on one or two stories simultaneously, so expect ~16 'story branches' (and master) at any given time. We've got GitHub Enterprise and are working out how to manage story development on shared branches that get merged to master only after going through acceptance & peer review. We hope stories will only be 3 - 5 days to complete, but may take 2 weeks. We're promoting frequent pushes to story branches.

After a number of experiments and doing online research, we're thinking to use rebase to keep the story branches up-to-date with master while the story branches are in development. This seems to be the best approach because it will allow us to use bisect to isolate issues, and it will give us the most linear history graph. 

So, here's my question: Can we use "rebase -s recursive -Xtheirs" as shown below?

In this experiment, we're on 'story' branch 's1'. It's behind master because another story has been merged to master. We need to rebase to master and then rebase to origin/s1to be up-to-date. So we...
git fetch -v
git rebase origin/master
... resolve stuff ...
git rebase -s recursive -Xtheirs origin/s1
The "-s recursive -Xtheirs" part seems to result in all the right code at the end. We only had to "git add && git rebase --continue" for deleted files.

Would this approach always work? Or do we actually need to step through each conflict while rebasing to origin/s1 too?

(I don't want to step through each conflict while rebasing to origin/s1 because it brings up conflicts that the s1 developer may know nothing about.)

Thanks!
chris