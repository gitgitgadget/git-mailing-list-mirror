From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: git am oddity
Date: Mon, 31 Mar 2014 14:58:22 -0700
Message-ID: <CAGdFq_gZoiE_ah0VT5ZfQwg-zHNj6Q-RSB80f=BTf=U6+9L5UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mario Ferraro <fadinlight@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:59:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkEX-0005pt-Tu
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbaCaV7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:59:05 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:42199 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaCaV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:59:03 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so8390563iec.38
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=p1sHiX5umBKyZbjRNuTnU0a9yu69fXdNTVX1Z9RJ12c=;
        b=FWjG8WDvibh0KJMSvho+/UVjBYk0pm8kcHTmr41nzM6VKeQn2IHGE9mnumFop1BsWn
         1mZ4L3zF9aVkel9LK+8GFmCuMWIzpXLKamGef6r4lSVSwzYWq6CTRQDjfDRZDrmXky1j
         kF5EYYr9hPw4EOVkIxFcYGRHZaC86v598LQkYrvIMK9Ohm+ghphfK8HmCbUZY8TWqo0f
         W6YdsAkcmaadguq0FmZPuVnzTWZUNxmlyr3M5mJBHKheXO3yM0Gpz3yQ6BQJJcvEBzZ8
         pEoyhi7ZVcYu6x0m26Dol9udqaRMq/yhm/b8J4rrccY5TQA9BvzwdvYZ7F2ZNnxWxm99
         NmxQ==
X-Received: by 10.43.75.2 with SMTP id yy2mr25833340icb.54.1396303142742; Mon,
 31 Mar 2014 14:59:02 -0700 (PDT)
Received: by 10.50.7.236 with HTTP; Mon, 31 Mar 2014 14:58:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245547>

Hi,

I noticed something very odd with git am, and have been able to narrow
it down to a minimal example.

 git init tmp
 cd tmp
 mkdir -p foo/bar/baz
 cd foo/bar/baz
 echo file > file
 git add file
 git commit -m "1"
 echo other > other
 echo more >> file
 git add file other
 git commit -m "my test"
 git format-patch HEAD~..
 git reset --hard HEAD~
 # apply the patch in the current directory, chop off the leading directories
 git am -3 -p 3 0001-my-test.patch
 cd ../../..
 git ls-files

Expected output:
foo/bar/baz/file
foo/bar/baz/other

Actual output:
baz/other # the file addition was applied to the root of the
repository, instead of the current directory
foo/bar/baz/file # the file modification was correctly applied, yay

Is this expected behavior?

-- 
Cheers,

Sverre Rabbelier
