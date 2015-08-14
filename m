From: Dmitry Oksenchuk <oksenchuk89@gmail.com>
Subject: git merge changes file mode from 644 to 755
Date: Fri, 14 Aug 2015 15:02:43 +0300
Message-ID: <CA+POfmsohJAGVYHM3nHJydoyxe92QFd59eWT_UG+_0fM46SATA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 14:02:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQDhA-0000Td-81
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 14:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbbHNMCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 08:02:44 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34818 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbHNMCn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 08:02:43 -0400
Received: by igbjg10 with SMTP id jg10so10374151igb.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=q4df6c9Y/vOGAZhi8JKll2q9P9ptrbCUqvciCjF0dcQ=;
        b=UYNwhWL6OcJMlAZm3J3kWjTWdzJq106gQIpKR+N5Tb5YMpoq/k28yU/lHjJqaCSB7W
         bZtpGRXbexKyKZ/UermMKCxTvFXXeILyFG4GVwJfqB1lndRwcJjjQIxVdJFuoWPVHTYF
         SHTpxvBJ8rfVEf6R7emYTgHpC/5KsHWc7AvYCHa9ZVfa7FK8Z3mGqUL0j7LgmSEM2IrM
         GPVt3zCF44LllPc6/kzz9Ppb8j9njoWENUEgh5e+mqUr29hmyY54vbdUR86IpSxUUPTI
         46/eHPzAeeWq7Xi3lWywz4p2jdWExRdFc8YnR4Tru/S6oOQ2kv7Vr2zLqtwVYQ0+Jdvw
         9rMA==
X-Received: by 10.50.79.129 with SMTP id j1mr2166106igx.16.1439553763113; Fri,
 14 Aug 2015 05:02:43 -0700 (PDT)
Received: by 10.79.78.16 with HTTP; Fri, 14 Aug 2015 05:02:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275902>

Hello,

I've noticed strange behavior of git merge on Windows with
core.filemode=false (set by default). Git changed mode of some files
from 644 to 755 for unknown reason. One of the files is stdafx.cpp,
it's absent in the common ancestor, it was added in the first branch
(master) with mode 644 and it's still absent in the second branch
(feature). So, git merges the file without conflicts but changes mode
from 644 to 755.

Example with git merge:
$ git reset --hard 9b90bac - the first branch
$ git merge-base 9b90bac f41bd44 - the second branch
e44b025b000fe71cf621b5aadad88e71d209e301 - the common ancestor
$ git ls-tree 9b90bac stdafx.cpp
100644 blob 0bf386d4ae494503129921f5b5077a74976c8f91    stdafx.cpp -
644 in the first branch
$ git ls-tree e44b025 stdafx.cpp - absent in the common ancestor
$ git ls-tree f41bd44 stdafx.cpp - absent in the second branch
$ git merge f41bd44
Auto-merging stdafx.cpp
$ git ls-files -s stdafx.cpp
100755 0bf386d4ae494503129921f5b5077a74976c8f91 0       stdafx.cpp -
755 after merge

Example with git read-tree:
$ git reset --hard 9b90bac
$ git read-tree -m e44b025 9b90bac f41bd44
$ git ls-files -s stdafx.cpp
100644 0bf386d4ae494503129921f5b5077a74976c8f91 0       stdafx.cpp -
644 after read-tree -m

Why git merge changes mode from 644 to 755? Is it a known issue?

I use git version 1.9.5.msysgit.0. Maybe the issue was fixed in a later version?

Regards,
Dmitry
