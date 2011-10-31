From: Michael Wookey <michaelwookey@gmail.com>
Subject: git-p4: problem with commit 97a21ca50ef8
Date: Tue, 1 Nov 2011 10:11:02 +1100
Message-ID: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:11:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL11C-0000Ut-7c
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 00:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934778Ab1JaXLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 19:11:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39489 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934704Ab1JaXLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 19:11:45 -0400
Received: by eye27 with SMTP id 27so5796429eye.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 16:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=vAgRFxdZLUv2Nwt1ZhwoUvcvixa7HtXTPkJ8bBPN9MA=;
        b=gZivotpSZ6JSWPEpUC5kRULaZkbSZDYNI6NKIfBMS5Ra+uYlvJ6tNFjHFWNwbfGpyc
         S2GJM0JDltiXDrH3ZtIRy4Oq3jyoFUWH4RsFHwt+kOLgPJdcPPMlIyDW7Ne2EuSd2jFG
         dlIWKozi+os/VQEXDMCI+NDopT6slv+8iuLAo=
Received: by 10.213.34.65 with SMTP id k1mr1549017ebd.101.1320102703256; Mon,
 31 Oct 2011 16:11:43 -0700 (PDT)
Received: by 10.213.17.209 with HTTP; Mon, 31 Oct 2011 16:11:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184544>

[ please CC me as I am not subscribed to the list ]

Hi,

Commit 97a21ca50ef893a171a50c863fe21a924935fd2a "git-p4: stop ignoring
apple filetype" isn't correct. Without knowing too much about how
git-p4 works, it appears that the "apple" filetype includes the
resource fork, and the "p4 print" that is used to obtain the content
from the perforce server doesn't take this into account, or maybe some
post processing of the file needs to be done to include the data, but
not the resource fork, before inclusion into the git repo.

With the above commit, a binary blob that literally contains the
resource fork and data is included within the git repo. Of course,
without the above commit, the intended file was never included in the
git repo at all. Perhaps the resource fork issue was a known problem
by the original git-p4 author.

A sample file that that demonstrates what the above commit produces is
here (use curl/wget):

  http://dl.dropbox.com/u/1006983/sample_image_fail.png

This is literally a binary blob with about 110 KiB of resource fork
plus the PNG data. The same image, minus about 110 KiB of resource
fork is here:

  http://dl.dropbox.com/u/1006983/sample_image_correct.png

I'm happy to test patches as we have a perforce repository with files
of the "apple" filetype.

Thanks
