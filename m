From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 00/16] git bisect improvements
Date: Fri, 26 Feb 2016 03:04:26 +0100
Message-ID: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:05:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7ml-0007Dq-HI
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbcBZCFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:65394 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbcBZCFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:34 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LoVOE-1a1Qau2EMU-00gUD0; Fri, 26 Feb 2016 03:05:30
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
X-Provags-ID: V03:K0:6EJAjm8mlmYu9tFtzjRV4I4Oz1XdwB6iaQUTcyJZmD62i4sQ4ut
 uJxhV3hdYv6oYrgBLCI0keOy3BmdEvWdyRNCENEOltanhSjXEQ93FdVKApr5iBcUcYMlWQ1
 zDS3lpYFLuXoVYzx/7dj2ALKKmGVfL2CCLPo/E14Rd9f45r/mQUC+AVxWiXafiavX+TJ33R
 Mb1F7TfNjbN/Nv9LrQI8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kRLorlzTdu0=:7D/7WD0Qda4e+VkdVFvML2
 xLgWw71QgtCD0ZGgF5sp+F9frVAY2rU2OarHCNu3JA35uP62/UvT5eFsMY/+dYhrPhICjk/ZM
 vvkTzU+TOz0mhELEvmffhj4RHt2Qk2xGLq5tENkOuEMfEFBISomewkk1K73BkJJXIRnMN6HHp
 nd3QOZlX5iYq5oMdiZC7woj+p6/v5Czo6Oc+nBaXhytQ1ukKHjWuG4NR3GelzRkdZssQCj+wi
 fbR0K+jtj++EYcbCMTd5zM9a05NuYoH2ntDHh7/rJ9wBiVVI5CNMxmFqHQZQpYd0jD/CG3KaY
 2LY+mOEJgqrfgxJcW5bsNHRWS+mT/+ow6p/SfOv0i8JMN9E7TwE+o4HdAphrNEyMtDm99+195
 ZnvpHn7ZWr80CQF02jfw3Injgbb8xiPLZAHifK79bJCe98jA4L5o884Chscbq0g5Ve9Exzf10
 DFaJ3CaMB+Mof2efUCB1YB+BGEFr23S9Jmj5QfVj5pHoHed8LZ0c6bYnKJFCMYv0B6oO+2qcf
 wz8x31NYq0tMTbiY1qImG3mIsg75AeFl3HWgM0UOyT+po53ZOA4b9/BwXg0UgS3TGTPodngfF
 +PE74APUQtZG1IQO4t39/u2NRUlyWTMfBzUiD4LCi8QcNQd9FT9nqhPe5hBoW85FL6bcmFahR
 AnLizxRFghf9W0h63vXy7RJzvYW1EZRkU8An6E+NI8DBA6JRdBGegW3iy9kdRXVxcqFhhfBR/
 jQYrNjs8pcXRpYu/3EL0fapkjZ4fHnlbjp52QIcjf4MVcaiplYO/ivSe6uE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287513>

Hi,

this set of patches provides improvements for git bisect.

Quick summary of changes
 - relevant for users:
   - `git bisect next` is documented and motivated
   - git bisect implementation becomes much faster
     (or: is now working) for big repositories**
 - relevant for developers:
   - a test for the git bisect algorithm is added
   - fix: bisect.c compiles also if DEBUG_BISECT is set

The ** marked change is the most interesting one.
To be more accurate: the use case is when you want to bisect in a
repository with a huge amount of merge commits (and having these
merge commits relevant for the actual bisect process).
For example, a bisect in the whole git master branch took
~50 seconds, now it takes ~4 seconds.


Note that the patches have finer granularity (especially the performance
improvements are splitted into several preparing commits).
For some patches, there is some more patch-related story as
"cover letter material" in these patches.

Btw: I also wondered about the internationalizaton: no string in bisect.c
is marked for translation. Intentionally?

Cheers

Stephan Beyer (16):
  bisect: write about `bisect next` in documentation
  bisect: add test for the bisect algorithm
  bisect: make bisect compile if DEBUG_BISECT is set
  bisect: make algorithm behavior independent of DEBUG_BISECT
  bisect: get rid of recursion in count_distance()
  bisect: use struct node_data array instead of int array
  bisect: replace clear_distance() by unique markers
  bisect: use commit instead of commit list as arguments when
    appropriate
  bisect: extract get_distance() function from code duplication
  bisect: introduce distance_direction()
  bisect: make total number of commits global
  bisect: rename count_distance() to compute_weight()
  bisect: prepare for different algorithms based on find_all
  bisect: use a modified breadth-first search to find relevant weights
  bisect: compute best bisection in compute_relevant_weights()
  bisect: get back halfway shortcut

 Documentation/git-bisect.txt |  25 +++
 bisect.c                     | 473 ++++++++++++++++++++++++++++---------------
 git-bisect.sh                |  15 +-
 t/t8010-bisect-algorithm.sh  | 162 +++++++++++++++
 4 files changed, 502 insertions(+), 173 deletions(-)
 create mode 100755 t/t8010-bisect-algorithm.sh

-- 
2.7.1.354.gd492730.dirty
