From: martyone <martyone@ubedi.net>
Subject: git log --graph --oneline - false parent-child visualization
Date: Mon, 5 Nov 2012 13:57:43 +0100
Message-ID: <CAMn6BBaeWfwa_mAyTBFOmFYs0GwUauzqZZP+NWM=8f0_hKDz3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 13:57:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVMFa-0001uU-8y
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 13:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab2KEM5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 07:57:45 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58499 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2KEM5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 07:57:44 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so4236426iag.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 04:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:x-gm-message-state;
        bh=mKDMyhfJJmabO7wtfmBF5C79ydQGQofCn7QTJYHL2bw=;
        b=A5k5d/+tGAsVSVyTyUPd6dZYbwcMvZuRgWTukBWGmKFlsqaQLQrZizaWKN0QKs4vBl
         kI9NP1JtwsjROnfVeVfnH8ybV56sU4d+7uEuISTtJTeGmYba37VjTfnSd9NSO2vk97NU
         KBn4YpYrqATvjz6QQ7Od/Lx2FIxz+9xaGtZ828Gmk3CG4TFYFLIoGkFq1/cxkvEEj5hB
         iOlssdPqICX/3afvXiAJaSyeb2Apf3k3LjiUU7jpMzqYVVP9u4GaJv34HYMKq3djSf+l
         yGtWCr3Qtd7MCfF9doiRhPvtbucgTl6qr65e7vhUmZifLwDsBPU3MeRGw2A5ZCCnLCsW
         ht+g==
Received: by 10.50.152.196 with SMTP id va4mr9307690igb.13.1352120263750; Mon,
 05 Nov 2012 04:57:43 -0800 (PST)
Received: by 10.64.163.37 with HTTP; Mon, 5 Nov 2012 04:57:43 -0800 (PST)
X-Google-Sender-Auth: alS-wCT5GqC4mkc1VCHBAsEJ73w
X-Gm-Message-State: ALoCoQl4c8EJhjGDjiMUnFDGr7awZJNkpx4UXbhDCFN36Nl/5yYf7B42Ap3qazzfUKeTpLJBgoNx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209057>

Hello,

the combination of --graph and --oneline sometimes produces output
which is -- at least for me -- not clear about parent-child relation
between commits. I noticed it when using with --simplify-by-decoration
switch but it should not be specific to the use of this switch.

See this example output (git version 1.7.11.3)

| | | * eead15f (origin/branchA) Lorem ipsum dolor sit amet
| |_|/
|/| |
| | | * 8da3b9f (origin/branchB) Consectetur adipisicing elit
| | |/
| | | * c4d6b9a (origin/branchC) Sed do eiusmod tempor incididunt ut labore
| | | * d623246 (origin/branchD) Ut enim ad minim veniam
| | |/
| | | * 458d305 (origin/btanchE) Quis nostrud exercitation ullamco laboris
| | |/

Here it seems commit c4d6b9a is based on d623246. But when the format
is more-than-oneline (or when checked with gitk), it is clear there is
no relation between commits c4d6b9a and d623246.

| | | * commit eead15f (origin/branchA)
| |_|/  Author: John Doe <john.doe@example.net>
|/| |
| | |       Lorem ipsum dolor sit amet
| | |
| | | * commit 8da3b9f (origin/branchB)
| | |/  Author: John Doe <john.doe@example.net>
| | |
| | |       Consectetur adipisicing elit
| | |
| | | * commit c4d6b9a (origin/branchC)
| | |   Author: John Doe <john.doe@example.net>
| | |
| | |       Sed do eiusmod tempor incididunt ut labore
| | |
| | | * commit d623246 (origin/branchD)
| | |/  Author: John Doe <john.doe@example.net>
| | |
| | |       Ut enim ad minim veniam
| | |
| | | * commit 458d305 (origin/branchE)
| | |/  Author: John Doe <john.doe@example.net>
| | |
| | |       Quis nostrud exercitation ullamco laboris
| | |

Correct output produced with --oneline switch should output an extra
newline when commit has no parent listed:

| | | * eead15f (origin/branchA) Lorem ipsum dolor sit amet
| |_|/
|/| |
| | | * 8da3b9f (origin/branchB) Consectetur adipisicing elit
| | |/
| | | * c4d6b9a (origin/branchC) Sed do eiusmod tempor incididunt ut labore
| | |
| | | * d623246 (origin/branchD) Ut enim ad minim veniam
| | |/
| | | * 458d305 (origin/btanchE) Quis nostrud exercitation ullamco laboris
| | |/

Best Regards,
Martin
