From: Elliot Wolk <elliot.wolk@gmail.com>
Subject: move detection doesnt take filename into account
Date: Mon, 30 Jun 2014 02:38:18 -0400
Message-ID: <53B105DA.30004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 08:38:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1VEO-0004Yj-4x
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 08:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbaF3GiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 02:38:21 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:48575 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbaF3GiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 02:38:20 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so6756139qcz.9
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=m1utwMgIPW5BCejA1nM+XLkwOUIuyTrFcUvRtW6Ge40=;
        b=KRagfTGAL3OVwyZqc6TRUn1nOKs9CdtelYQaaQtMXCGFJiYSCt4ORSKrmf2RGOxL4p
         G7PjMtYFpa1oVAjsHJEJO30kIOLR2COwNXwmRi+zOcuZE7FQCsnkttzXYqa7HHJkFgLP
         IEvT3mye47RgohMB5T/6gBcbvvLbzPnFOZXxdA/QC8LQ03Je7cajB3L7OD0vMlE0ktRa
         wWj9wATQ10ZqaHtUSadZGNIMBKP+5BovCPG/YqdiPXqDJjzUq1Z1OS7bxr2gW510HQwU
         U9grutz6ymbUR+md3WWIO4oL4d7Q5NTK6QijQVro30M+z2/PKCLKmF0aZaEEnn7N9Smm
         vQHQ==
X-Received: by 10.224.130.201 with SMTP id u9mr57046368qas.98.1404110299776;
        Sun, 29 Jun 2014 23:38:19 -0700 (PDT)
Received: from [192.168.11.50] ([98.113.246.12])
        by mx.google.com with ESMTPSA id j1sm30610321qaa.11.2014.06.29.23.38.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jun 2014 23:38:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Icedove/30.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252655>

if you move two identical {e.g.: empty} files to two new locations in a 
single commit, the move detection picks them {seemingly?} arbitrarily. 
it should use a statistical algorithm to compare the filenames and pick 
a likely match.

my apologies in advance if this isnt the right venue or is improperly 
formatted, or if this is extraneous noise, or widely known, etc.

+ cd /tmp
+ mkdir repo
+ cd repo
+ git init
Initialized empty Git repository in /tmp/repo/.git/
+ touch a1 b1 c1
+ git add a1 b1 c1
+ git commit -m 1
[master (root-commit) 72f8c89] 1
  3 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 a1
  create mode 100644 b1
  create mode 100644 c1
+ git mv a1 a2
+ git mv b1 b2
+ git mv c1 c2
+ git commit -m 2
[master 359da78] 2
  3 files changed, 0 insertions(+), 0 deletions(-)
  rename c1 => a2 (100%)
  rename b1 => b2 (100%)
  rename a1 => c2 (100%)
+ git log --name-status -M
commit 359da78caaaf06848ae32359abfeb87db35cdb30
Author: Elliot Wolk <elliot.wolk@gmail.com>
Date:   Mon Jun 30 02:26:49 2014 -0400

     2

R100    c1      a2
R100    b1      b2
R100    a1      c2

commit 72f8c89b418e3b1d13ec350f4c30b5088fc69e83
Author: Elliot Wolk <elliot.wolk@gmail.com>
Date:   Mon Jun 30 02:26:49 2014 -0400

     1

A       a1
A       b1
A       c1
