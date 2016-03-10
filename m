From: Gregor Jasny <gjasny@googlemail.com>
Subject: Git subtree stumbles over annotated tags
Date: Thu, 10 Mar 2016 16:51:37 +0100
Message-ID: <56E19809.5040305@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080903020505050005060303"
To: git@vger.kernel.org, jupp0r@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 10 16:51:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae2sK-0000TR-QK
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 16:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbcCJPvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 10:51:42 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34769 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcCJPvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 10:51:40 -0500
Received: by mail-wm0-f51.google.com with SMTP id p65so34335510wmp.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=btRJFA8P2JAsaJ0DhUL1SPpIHXiJ0lmX8wGGvc2JgOU=;
        b=cXvMEWb39UXmPaPAXoiVGt628OA4mTN8W0aGOaL2OpT8AQ491Ao/Gv04CPQhQnB/KA
         ztpmkCxK8kd/PEc1SpBaITpK8FqSwt10fkWZt+VtSY2ku8NtrYM1jA/MAjBFiHTaIetV
         Id57tm8w21X/4t2KqTp00EXUhFCaItf+Z4AZaeNoqBT67N67ljzZgH9vUmdebKIyUAOs
         4xHM6z3MjjMWHoAA+j6EKQtka+7eIYNQVuVcNPj1zq6x6A962vIlQqhfomxWnmUhvisj
         m8ZLaDhWZnus+JKxx+HN5bYvHp/28bEjKMoca7D6HBtnQFpnzfmp5Fnafvjddr4Vl7xO
         YmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=btRJFA8P2JAsaJ0DhUL1SPpIHXiJ0lmX8wGGvc2JgOU=;
        b=YVrqT4pzMd/jiY1G3ZdrfygdxalLhSOCq6er7/034QrZZAVTGNai6JykWFd0XuaIER
         SdfnKFk77/o5edWrtN4r4oNNhjBzp5DIPnb1OrqQPO60vrCViNAF0ygYaiGdfp+rf2fu
         ppoCDegvnLKbQcD3h+o5aYgZBQ1NiOp2iwGT9bQNOXLq8ADeHpPNQS7q1mcnxAhkyIjP
         o1mS3+v3mISTifvTP1H/RWfBj3wvUH2bzhniohVQG8GbN33ZLj8RxU2WG9ij0jwsRAgW
         PrmroHmpHGE7P1yzvEWlfAH8RlxJFnrE6MzrJ0OXFjzXfZyKcX3lwA9nSSTsghrJGNRt
         7JrQ==
X-Gm-Message-State: AD7BkJJtc/8t1m+wG52XsXc5VTPfyq7GgtrkA+JT1TEAK6X00RaZujRLKbd7jN6KkYhBog==
X-Received: by 10.28.214.6 with SMTP id n6mr4815511wmg.49.1457625099185;
        Thu, 10 Mar 2016 07:51:39 -0800 (PST)
Received: from gjasny01.ad.corp.expertcity.com ([2a02:810a:83c0:88fc:a845:9811:8b2e:8293])
        by smtp.googlemail.com with ESMTPSA id g203sm3526775wmf.23.2016.03.10.07.51.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 07:51:38 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288626>

This is a multi-part message in MIME format.
--------------080903020505050005060303
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

today I discovered that it's a bad idea to "git subtree pull" from an
annotated tag. This issue got discussed in those two threads:

http://comments.gmane.org/gmane.comp.version-control.git/247503
http://comments.gmane.org/gmane.comp.version-control.git/248395

I was under the impression that it is fixed in recent versions of git
but my homebrew 2.7.0 still behaves badly. If I run the attached script
to reproduce the issue I get the following error message:

> git push using:  sub somebranch
> fatal: 6d621d73ca18dc90424de0929357b5ae62988e00 is not a valid 'commit' object
> Can't copy commit ab38e3fe1ff27f7f87505db37d35adc5c3ceed27

> git ls-remote sub
> 99be40f8e3a4c926d45507be53ab6918789b3a52	HEAD
> 99be40f8e3a4c926d45507be53ab6918789b3a52	refs/heads/master
> 6d621d73ca18dc90424de0929357b5ae62988e00	refs/tags/sometag
> 99be40f8e3a4c926d45507be53ab6918789b3a52	refs/tags/sometag^{}

Besides handling this bug could you please give me a hint how to repair
my main repository? The problematic subtree pull happened some time ago
so I cannot alter the pull itself. I could go the brutal approach and
remove, then re-add the subtree but I guess there is a smarter approach.
Any help is appreciated!

Thanks,
Gregor

--------------080903020505050005060303
Content-Type: application/x-sh;
 name="reproduce.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce.sh"

#!/bin/bash

set -e

mkdir main sub

cd sub
git init .
echo A > foo
git add foo
git commit -m "A"
git tag sometag -a -m "some"

cd ../main
git init .
echo initial > version
git add version
git commit -m "main initial"

git remote add sub $PWD/../sub
git subtree add --prefix mysub sub sometag --squash

echo B > mysub/foo
git add mysub/foo
git commit -m "B"

git subtree push --prefix mysub sub somebranch --squash

--------------080903020505050005060303--
