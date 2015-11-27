From: Daniele Varrazzo <daniele.varrazzo@gmail.com>
Subject: Bug: git crashes on rebase reporting bogus memory corruption
Date: Fri, 27 Nov 2015 14:08:52 +0000
Message-ID: <CA+mi_8Y5bx-RDCV2oFfFRVZz-Jjcii7QbB6k45B5YsLoed-b8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 15:09:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2Ji5-0006Wc-Ec
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 15:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbbK0OJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 09:09:14 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33197 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbbK0OJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 09:09:12 -0500
Received: by obbww6 with SMTP id ww6so83356351obb.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=itPklR9ULdB5QGyqti9a5glZfcVeb0c9Zovo7JwA/RA=;
        b=h0BH6/gVxbPat2s54VRW9ecKS5a44U6el0Z+zDta9RnounTDt9aPW15C/HjzfSo6O9
         7apiX/XQTrOUICmpSm+XJ14FiI2zd8LT0Kos9FqDiiSEHZzRsPqIr0FDHgQs3M6DYNJy
         euN/LPBQH+nB5mZ/Sob/p6mfmtP/2tJ4UpZud2FUS8SOJFWD4sXG5dwYe9eqWYX78jIk
         HBTaCDGCrfN0By7wQ+psAAuTRwiGCQ+KQitQI3IJCc/5lvPT7ay7ffAQk65SJ6ASvhWM
         dp0BCrc278wejat9c7geXIwT/24tiffodf6Ix8RUot5673x+XD55taTbXJ4JqGak4g9r
         fwgw==
X-Received: by 10.60.142.137 with SMTP id rw9mr35289321oeb.0.1448633351611;
 Fri, 27 Nov 2015 06:09:11 -0800 (PST)
Received: by 10.202.90.131 with HTTP; Fri, 27 Nov 2015 06:08:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281775>

Bogus corruption is bogus because I've reproduced it on different machines.

I was trying to rewrite history in a small repos and replace
indentation tabs with spaces. Steps to reproduce:

git clone https://github.com/dvarrazzo/suponoff.git
git checkout -b gitbug
git config core.whitespace
trailing-space,tabwidth=4,tab-in-indent,space-before-tab
git rebase  6af85bcde9a30c3841b754bbb60c03ba58b88a50 --whitespace=fix

error reported on crash is:

Applying: Read configuration from supervisor config itself, added groups tags
*** Error in `git': malloc(): memory corruption: 0x00000000023f9420 ***


Tested with:

CentOS Linux release 7.1.1503 (Core)
git: 1.8.3.1
Linux 3.13.0-66-generic #108-Ubuntu SMP Wed Oct 7 15:20:27 UTC 2015
x86_64 x86_64 x86_64 GNU/Linux
libc: 2.17-78.el7

Ubuntu 14.04.3 LTS
git: 1.9.1
libc: 2.19-0ubuntu6
kernel: Linux 3.13.0-24-generic #47-Ubuntu SMP Fri May 2 23:30:00 UTC
2014 x86_64 x86_64 x86_64 GNU/Linux


-- Daniele
