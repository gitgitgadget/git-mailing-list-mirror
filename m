From: George Karpenkov <george@metaworld.ru>
Subject: Error:non-monotonic index after failed recursive "sed" command
Date: Mon, 14 Jan 2013 22:40:31 +1100
Message-ID: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 12:46:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuiV9-0004Ok-NU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 12:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab3ANLqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 06:46:32 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:53788 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab3ANLqb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 06:46:31 -0500
Received: by mail-la0-f46.google.com with SMTP id fq13so3736988lab.19
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=ny3JruUP9iZENVdyHtTb/6K4VrqfKIN3VBOV3Z7aNJk=;
        b=lpqwxU5yUDpRjevLqL5aMwjkTteRmaUgrLIJS37bw1jkmGn1JUOZ1etPXlZrAb84DQ
         l+63ud2fDt3A5EZPTSMnyV6XK+qRrPT7lEZBrI4FIKleMCCmtpfbHOplSevwoshP7G/R
         j31btq/Gk+Mi2IEgD5JPnwkKG5jCYxKSia9JBEvztj1kTzqb4uHAuN143XjLRcnguyTO
         lpNavryqgNhQUt34U2axdnJBJ+h8nj4iG/N+HOUnoy/+/ho311odXrVRncj7bhr3Xj8o
         RcC5IzWG5BJdu05Tl2g4qvGOFmZeOmTI3GibZ/RN1a7cJc1B6iLWodLS5k1bBBcCZoFF
         UqvQ==
Received: by 10.112.98.134 with SMTP id ei6mr34573258lbb.62.1358163652164;
 Mon, 14 Jan 2013 03:40:52 -0800 (PST)
Received: by 10.112.59.1 with HTTP; Mon, 14 Jan 2013 03:40:31 -0800 (PST)
X-Google-Sender-Auth: v97vJ7hZqAZLyO9LiAXn044sifk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213482>

Hi All,

I've managed to corrupt my very valuable repository with a recursive
sed which went wrong.
I wanted to convert all tabs to spaces with the following command:

find ./ -name '*.*' -exec sed -i 's/\t/    /g' {} \;

I think that has changed not only the files in the repo, but the data
files in .git directory itself. As a result, my index became
corrupted, and almost every single command dies:

> git log
error: non-monotonic index
.git/objects/pack/pack-314b1944adebea645526b6724b2044c1313241f5.idx
error: non-monotonic index
.git/objects/pack/pack-75c95b0defe1968b61e4f4e1ab7040d35110bfdc.idx
...
error: non-monotonic index
.git/objects/pack/pack-3da0da48d05140b55f4af1cf87c55a2d7898bdd5.idx
fatal: bad object HEAD

Output for git fsck is even worse:

> git fsck
error: non-monotonic index
.git/objects/pack/pack-434f8445672a92f123accffce651bdb693bd8fcb.idx
...
error: non-monotonic index
.git/objects/pack/pack-0c9d5ae4e2b46dd78dace7533adf6cdfe10326ef.idx
error: non-monotonic index
.git/objects/pack/pack-e8bd5c7f85e96e7e548a62954a8f7c7f223ba9e0.idx
Segmentation fault (core dumped)

Any advice? I've lost about 2 weeks worth of work.
Is there anything better I can try to do other then trying to
reconstruct the data manually from git blobs?
