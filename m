From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 6
Date: Mon, 28 May 2012 23:44:01 +0200
Message-ID: <20120528214401.GB6449@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 23:44:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ7ja-0003Vh-2o
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 23:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab2E1VoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 17:44:08 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38744 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2E1VoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 17:44:06 -0400
Received: by weyu7 with SMTP id u7so2173651wey.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=og9h7a1MtDPYSxS+47G3fjZz80OsuJLx8Msng/5vK88=;
        b=zjKnL45nSKPyzowPIbCfqLUM+JjAmzmEKI2mlyqHE0piM8raKLUvzt6umDFqTz8uQJ
         NOkwKXKEN8ofAndQmgbjqX4Ud55WISNK6Z7OyT8aODYvW+JU5wpGT7DZvOjQY02+F0k2
         IcvTktco49vn/D1HI3WXqpmnjQALzvS8M8uauoOeUwY5HKVU4FPGVVSskL/NMEwGTIPY
         C2gfbvd0FK6+FaKBFoB31/nAS5q/JmJhlzHxrjFUIxRI5IhR0p3bWU050gp5uRUV27zx
         Bkmd7E55DxH4iVXtQDDd04WY67K0Ekggd413oxD3IyI4mG/ZAAtpfIYRwb+OUH5i4E1s
         Eksg==
Received: by 10.216.213.22 with SMTP id z22mr4253343weo.184.1338241445002;
        Mon, 28 May 2012 14:44:05 -0700 (PDT)
Received: from localhost (host172-20-dynamic.4-87-r.retail.telecomitalia.it. [87.4.20.172])
        by mx.google.com with ESMTPS id j4sm23848947wiz.1.2012.05.28.14.44.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 14:44:04 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198726>

Here is another quick overview of the current progress of my
Google Summer of Code project. I'm currently planning to do
those weekly, to keep you up to date with the progress.

== Work done in the previous 5 weeks ==

- Definition of a tentative index file v5 format [1]. This differs
  from the proposal in making it possible to bisect the directory
  entries and file entries, to do a binary search. The exact bits
  for each section were also defined. To further compress the index,
  along with prefix compression, the stat data is hashed, since
  it's only used for comparison, but the plain data is never used.
  Thanks to Michael Haggerty, Nguyen Thai Ngoc Duy, Thomas Rast
  and Robin Rosenberg for feedback.
- Prototype of a converter from the index format v2/v3 to the index
  format v5. [2] The converter reads the index from a git repository,
  can output parts of the index (header, index entries as in
  git ls-files --debug, cache tree as in test-dump-cache-tree, or
  the reuc data). Then it writes the v5 index file format to
  .git/index-v5. Thanks to Michael Haggerty for the code review.
- Prototype of a reader for the new index file format. [3] The
  reader has mainly the purpose to show the algorithm used to read
  the index lexicographically sorted after the full name which is
  required by the current internal memory format. Big thanks for
  reviewing this code and giving me advice on refactoring goes
  to Michael Haggerty.

== Work done in the last week ==

- Started working on the actual git code. Git is now able to read
  the index format v5, although the mapping of the new ondisk
  format to the internal format is not done yet. The latest code
  is not pushed to github yet, since it still needs some polishing,
  but if anyone is interested in the general direction it's going,
  the initial steps are on github. [4] Thanks for reviewing the
  first steps to Thomas Rast.

== Outlook for the next week ==

- Refactoring of the read_index_v5 code, and possibly mapping of
  the read index to the current internal format (If there's enough
  time)
- Make git ls-files read the new index format directly, to show
  some of its advantages. (Thanks to Nguyen Thai Ngoc Duy, and
  Junio C Hamano for the suggestion)

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
