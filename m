From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Juggling between hot branches
Date: Fri, 27 Sep 2013 17:40:25 +0530
Message-ID: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 14:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPWzA-0006Ti-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 14:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab3I0MRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 08:17:22 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48723 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab3I0MRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 08:17:19 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2517723pdj.36
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0cguYPmBQPO3dSzs8Qa4eE3ch9MQBOieAWiY5zuSjbU=;
        b=VXTgcT8wirQ3hPlxd5VZNmVc5z8ImNofCdCzWAF5ZJA63uS8TXc4//U/MrFVghmbr+
         oU29mYrRZB8SaMcz40P6qtX5HrTRa5pBjhWlZ0+qtbgZYvBOmYHXvuBxmE1YyWlZVfMv
         Iy+YPK/Vu5u3rt8mw0xlIFMFemHr1jBErHMfVXWvkotOLN5fz5To6CaD0J60ZJT9VHch
         zwWGiVTVvvl3kh/o7wtxDtWvbJxmhomdEYMzUuAI53YzCUK9g9cT9MdOaPcbOF61ubkv
         7sMz9EzxcvZsYaznaG1qRtvCyAZDJPvAk3PfZcxFQjrR3yrBFsyuuR7VWSA7J6VsaDYH
         XHpQ==
X-Received: by 10.68.223.131 with SMTP id qu3mr7086834pbc.4.1380284238788;
        Fri, 27 Sep 2013 05:17:18 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id xe9sm12229901pab.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 05:17:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.478.g55109e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235454>

Hi,

I juggle between several hot branches, and an alphabetical listing
from 'git branch' doesn't cut it for me. I've chosen to enhance
for-each-ref so that I get output like (with color):

  $ git hot
    um-build>
    perf-manifest=
  * master=
    sparse=
    ia32-asm-cleanup>
    menuconfig-jk<>
    perf-build=
    perf-completion<

where hot is the following alias:

  for-each-ref --format='%C(red)%(HEAD)%C(reset)
  %C(green)%(refname:short)%C(reset)%(upstream:trackshort)' --count 10
  --sort='-committerdate' refs/heads

While the alias might look a bit horrendous, I get the desired output.

The last time I tried to get this feature merged, there was some
confusion about unifying the format of for-each-ref with
pretty-formats, and enhacing git-branch while at it. I tried going
down that road, but got no reviews; everyone was generally more
unhappy due to the added complexity. Months have passed since, and we
still don't have this feature.

Let's keep it simple and stupid. A terse +84,-10 (with documentation)
for this wonderful feature now. Let's get it merged, and defer the
kitchen-sink-unification efforts.

Thanks.

Ramkumar Ramachandra (3):
  for-each-ref: introduce %C(...) for color
  for-each-ref: introduce %(HEAD) asterisk marker
  for-each-ref: introduce %(upstream:track[short])

 Documentation/git-for-each-ref.txt | 14 ++++++-
 builtin/for-each-ref.c             | 80 ++++++++++++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 10 deletions(-)

-- 
1.8.4.478.g55109e3
