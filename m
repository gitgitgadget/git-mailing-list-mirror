From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report week 7
Date: Mon, 4 Jun 2012 22:07:46 +0200
Message-ID: <20120604200746.GK6449@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 22:08:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdZG-0000pW-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401Ab2FDUHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:07:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57471 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab2FDUHx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:07:53 -0400
Received: by wgbdr13 with SMTP id dr13so4399556wgb.1
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=2jeNEI+8aN8ewrcHUMqHQatZSMgxfJC5BWDQzh7t6Wk=;
        b=n+UXrXbcICBfydnpMKElqBab7WPbZvZdOylhZbxmqWBxw8+6qUearwGFqi8gi62WD0
         /iNNuwSDZ+TDHh2E7uxNb21cWh4rxe3qRaopb+PTppomTQiiU/BHsuPqigZFwQDjKe6D
         vYV2xmwgWTxoijlBDJ7jhi/9437QmuVtMzA7tCW10LSbK2FQg7IE1lqOw2wLObOEy14W
         feAEn4UHKKpWw9jO1Wm9rMZwjdo3dF2nc6lW9qdwwH9G6F8ovmSDS4OKODFNh6hUJG8y
         fjqUTRhsOZwaWkFbT6fRmStMfxi65yjyeCQj3OHeK/oWUpJYYkn150lVCpGIwfRmq0up
         yGJA==
Received: by 10.216.205.5 with SMTP id i5mr11622543weo.6.1338840470945;
        Mon, 04 Jun 2012 13:07:50 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id dg2sm35496130wib.4.2012.06.04.13.07.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 13:07:49 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199177>

== Work done in the previous 6 weeks ==

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
- Started working on the actual git code. Git is now able to read
  the index format v5, although the mapping of the new ondisk
  format to the internal format is not done yet. The latest code
  is not pushed to github yet, since it still needs some polishing,
  but if anyone is interested in the general direction it's going,
  the initial steps are on github. [4] Thanks for reviewing the
  first steps to Thomas Rast.

== Work done in the last week ==

- Continued working on the git code, which now maps the index to
  the internal format. This includes reading the conflicted data
  at the far end of the index. [4]

== Outlook for the next week ==

- Read the cache-tree (convert the directories on the disk to the
  current in-memory cache-tree structure)
- Start implementing an API, as it was discussed at [5]

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
[5] http://thread.gmane.org/gmane.comp.version-control.git/198283/focus=198474
