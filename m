From: Fabian Schmied <fabian.schmied@gmail.com>
Subject: git-svn performance
Date: Fri, 17 Oct 2014 22:47:20 +0200
Message-ID: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 22:47:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfERE-00030Y-47
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 22:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaJQUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2014 16:47:42 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:41850 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbaJQUrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2014 16:47:41 -0400
Received: by mail-yk0-f170.google.com with SMTP id 20so687661yks.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2014 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=p0jrQeFNfgbmTAtVD5H8EiLtCNr64MruaHzpVvJcc4s=;
        b=fM2TICQkUNi9cM0WwBJN2u7xtsRHZoPBXdp8WEp91NkQtZT7dssbBuqY0pl8uQ90Kt
         UGDoggGX+UIx6Px7P5xyMnxkyhhHaKVXipoedFqRms3dbPTe2me4ai508a0R8pSuzUDt
         kqnUy7Kp8X+GcwulEYW0pkeLJFP5WD/iCSsvOensbIk2UMw4mIUDvzQ0J1q+dxTWUYtN
         LBxHJwx8Q7FI5+lmDQyS9Is4V1Pv6pwg+xbxUSyG3ZXj9shiDjP+SDlAXF5Zyp7Lbeu8
         3ksT/ojZmczB699HuBYEKNOtTPKO7h46SOeqSQwwrNvwmWmnYqtGcUqVRMUD3xD/XTGM
         Hlow==
X-Received: by 10.236.65.134 with SMTP id f6mr15155466yhd.57.1413578860364;
 Fri, 17 Oct 2014 13:47:40 -0700 (PDT)
Received: by 10.170.188.149 with HTTP; Fri, 17 Oct 2014 13:47:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm currently migrating an SVN repository to Git using git-svn (Git
for Windows 1.8.3-preview20130601), and I'm experiencing severe
performance problems with "git svn fetch". Commits to the SVN "trunk"
are fetched very fast (a few seconds or so per SVN revision), but
commits to some branches ("hotfix" branches) are currently taking
about 9 minutes per revision. I fear that the time per these commits
is increasing and that indeed the migration might not be finishable at
all.

For the commits that take such a long time, git-svn always outputs
lots of warnings about ignored SVN cherry-picks, and it tells me it
can't find a revmap for the path being imported. (See [1].)

AFAICS, the offending commits take place on some branches that include
a lot of manually merged ("SVN cherry-picked") revisions. Git-svn
seems to be checking something (though I don't know what) that makes
importing these revisions really slow. And it repeats this for every
revision on these branches with increasing work to do.

Is there anything I can do to speed this up? (I already tried
increasing the --log-window-size to 500, didn't have any effect.)

Thank you, best regards,
Fabian

[1]
        M       foo/bar/XXX.xml
        M       foo/bar/YYY.xml
W:svn cherry-pick ignored (/branches/frob:6940-7068) - missing 12
commit(s) (eg abeaece820ceae44ebf2c06011cf43bbcbf4b1ce)
W:svn cherry-pick ignored (/branches/feature:3316-4798,4811,4827) -
missing 10 commit(s) (eg e255fff14ab1e581f21671ca8b36c0747869cf8c)
W:svn cherry-pick ignored
(/hotfixes/ZZZ.159:2131,2133,2145-2146,2148,2169) - missing 10
commit(s) (eg e04b0326c998f0611c18144b3ed8f686d3b52f4c)
W:svn cherry-pick ignored
(/hotfixes/ZZZ.333:4536,4610-4611,4625,4665,4669,4685,4713,4745,4785,4788,4908-4917,4920,4933-4944,4955,5003,5103,5174,5222,5227,
5261,5267,5306,5310,5321,5360,5416,5467,5501,5508,5599-5614,5650-5651,5757,5761-5762,5764,5778-5779,5784,5811,5814,5819,5823,5825,5836-5838,5860,5862,5873,5889,
5910,5924,5948) - missing 137 commit(s) (eg
9daec24cbdf55200d2cdfb0cd6b3f10485e296ac)
C:\Program Files (x86)\Git\bin\perl.exe: *** WFSO timed out
W:svn cherry-pick ignored (/hotfixes/ZZZ.333.39:5696,5847) - missing
84 commit(s) (eg 9daec24cbdf55200d2cdfb0cd6b3f10485e296ac)
W:svn cherry-pick ignored (/hotfixes/AAA:5905,6095) - missing 119
commit(s) (eg 9daec24cbdf55200d2cdfb0cd6b3f10485e296ac)
W:svn cherry-pick ignored (/hotfixes/BBB_1.1:6971) - missing 198
commit(s) (eg 9daec24cbdf55200d2cdfb0cd6b3f10485e296ac)
W:svn cherry-pick ignored
(/hotfixes/CCC:6134,6164,6168,6174,6206,6211,6237,6239,6244-6245,6250,6257,6269,6271,6276,6289-6292,6294,6296,6301-6302,6313,6315-6316,6329,6333,6379,6383,6394,6405,6411,6456,6478,6483,6491,6519,6537,6557)
- missing 194 commit(s) (eg 9daec24cbdf55200d2cdfb0cd6b3f10485e296ac)
W:svn cherry-pick ignored (/hotfixes/DDD:7635) - missing 1 commit(s)
(eg 6a3ba817635eb3a9411a307924dec393311d93be)
W:svn cherry-pick ignored
(/hotfixes/EEE_1.2:7786,7794,7797,7803,7829-7830,7843,7886,7889,7933,7937,7949,7953)
- missing 80 commit(s) (eg e78b1bc68f7a9b041588a39f3fa5e1a61f98942b)
W:svn cherry-pick ignored
(/hotfixes/EEE_1.3:8159,8170,8173-8174,8177,8181-8182,8185,8187,8194-8195,8201,8203,8206,8251,8255,8257,8259-8262,8265,8280,8286,8294,8296,8304-8305,8312,8318,8323,8327,8363,8387-8388,8390,8422-8423,8432,8446,8536-8537,8548-8549,8556,8559,8566,8569,8572,8578,8597-8598,8602,8617,8619,8655,8687,8720)
- missing 104 commit(s) (eg 33febd4591f42a9d871ba330432840917b157f9e)
W:svn cherry-pick ignored
(/hotfixes/EEE_1.4:8766,8768,8770,8777-8779,8795-8796,8802-8809,8812-8814,8816-8817,8820,8823,8825,8827,8831,8836,8841,8845,8848-8852,8854-8855,8866,8868-8869,8871-8873,8875-8878,8880,8888,8892,8911-8912,8917-8918,8946,8956-8957,8964,8984,8994,9003,9008,9011,9029,9038,9040,9046-9048,9055,9086,9101,9108,9111,9113,9124,9129,9133,9138-9139,9150,9152,9154,9156,9172,9174,9188-9189,9208,9211,9217)
- missing 44 commit(s) (eg 0621fb44de682650d762c707b102bc2472c088f8)
W:svn cherry-pick ignored
(/hotfixes/EEE_1.5:9412,9421,9430,9433-9436,9439,9441,9449,9459,9468,9529,9548,9561,9568,9605-9606,9612,9614,9617,9628,9630-9631,9637,9687,9807)
- missing 41 commit(s) (eg 1bd1a9b72336bf4d3839a00348b7f2a52368c16c)
W:svn cherry-pick ignored
(/trunk:9852-9853,9857,9859,9862,9868,9872,9876,9879,9890,9895,9926-9927,9933,9953,9956,9960-9962)
- missing 60 commit(s) (eg 3322e7ffc6ab49181976d9e94c91a4556951f38a)
Couldn't find revmap for https://the-svn-server/svn/something/trunk/foo
r9963 = 597df48cb830825f9029d1cfdf45df024d7fd3dd (refs/remotes/EEE_1.6)
