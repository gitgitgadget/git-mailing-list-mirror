From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format - Progress Report week 8
Date: Mon, 11 Jun 2012 22:53:12 +0200
Message-ID: <20120611205312.GB18686@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 22:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBc2-0008WM-IE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab2FKUxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:53:18 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47852 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2FKUxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:53:17 -0400
Received: by weyu7 with SMTP id u7so2373689wey.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=enh6cwe+qfwJ+qaYZ9VMijlKFNCnd75PrByC7XxXZRE=;
        b=VBvDOqdmxpyZSaIQmXU+wAJ1SP/ELxkIOb9Il5ZyXntewUEPTgJ1ma6ddFmURlJpup
         Sv5hNFfxRphTLtnZNagPdeaQUSjFT5b+fQFMVGGXVwFNCid8yJ+d6F+U5qhmcfkJAZla
         fzqJlN5iiunrWi6VYkcizYaFcQaEuS6qmxxXvKQXOJgIKzNUarmkFL3/e7YApF5Q/jdd
         iWOhdKfkO8xBbOqL+vl5ufoaCzxy2y/3KAXsmlbF2E8mK0cESkn04/AyIkBr0ddzpDmu
         Ih8Hz3FsEPOmN780rRt2oz6C6wVqIra4xqHRYqNoF4SOlEvhZBqQ+cYCz7+CkgnOEx6u
         8aGw==
Received: by 10.216.208.221 with SMTP id q71mr7910846weo.174.1339447995832;
        Mon, 11 Jun 2012 13:53:15 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id bn9sm822793wib.5.2012.06.11.13.53.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 13:53:15 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199727>


== Work done in the previous 7 weeks ==

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
- Read the index format format and translate it to the current in
  memory format. This doesn't include reading any of the current
  extensions, which are now part of the main index. The code again
  is on github. [4] Thanks for reviewing the first steps to Thomas
  Rast.

== Work done in the last week ==

- Read the cache-tree data from the new ondisk format. Same as the
  reading algorithm, this algorithm can (and will) still be optimized.
- Started implementing the API, but it's still in the very early
  stages.

== Outlook for the next week ==

- Continue implementing the API as discussed on [5].

[1] https://github.com/tgummerer/git/wiki/Index-file-format-v5
[2] https://github.com/tgummerer/git/blob/pythonprototype/git-convert-index.py
[3] https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
[4] https://github.com/tgummerer/git/tree/index-v5
[5] http://thread.gmane.org/gmane.comp.version-control.git/198283/focus=198474
