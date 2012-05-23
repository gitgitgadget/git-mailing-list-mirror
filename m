From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress report
Date: Wed, 23 May 2012 14:21:35 +0200
Message-ID: <20120523122135.GA58204@tgummerer.unibz.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, gitster@pobox.com, pclouds@gmail.com,
	mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 14:22:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXAa2-0001dz-QH
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 14:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229Ab2EWMVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 08:21:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60342 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab2EWMVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 08:21:39 -0400
Received: by wgbdr13 with SMTP id dr13so7095367wgb.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=lR8NwX2hbit58tPB2RZlLwpa7vQX/Fo/fgUxK2H19ko=;
        b=q0RaSv86bdpy9HaGPx7W/K5BpElU4N09cvC1nRSzZomdUkvAUxn7fQgpwrTDFuUhO3
         r01huWDrrfNW/gdjVYuSwQz2XrUx9f6JG8oHJOufQSUaCNfWfD56lcc8QVMZ/j2gBT8e
         pWS4xRaSz1EYvp3dgHUmeovg+Fhm4wVBy/K7kUE260tGaUxkEtVqPWOxLQJJZxVKJGj9
         BV2cpVUqm9eCrU/rxa9uiqTqqkC5tYvPDcoKB/QJK340q6S/g2HY7m7mL/W8/SWD7asb
         DzZB9LELsIHO3zcZJ7MwHlQbHhnQagXr4Erb9wWvUqh1JZHaeCd4s+CNFIWEcKlbcXxl
         +SCQ==
Received: by 10.180.92.65 with SMTP id ck1mr45538061wib.14.1337775698068;
        Wed, 23 May 2012 05:21:38 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id fo7sm39860232wib.9.2012.05.23.05.21.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 05:21:37 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198283>



mhagger@alum.mit.edu, pclouds@gmail.com
Bcc: 
Subject: [GSoC] Designing a new index format - Progress update
Reply-To: 

As Thomas Rast suggested yesterday on IRC, I'll give you a quick
overview of the work that has already been done in my GSoC project.


== Work done in the past 5 weeks ==

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

== Outlook for the next week ==

- Start working on actual git code
- Read the header of the new format

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
