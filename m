From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 0/2] fast-import: tighten parsing of mark references
Date: Mon,  2 Apr 2012 21:51:48 -0400
Message-ID: <1333417910-17955-1-git-send-email-pw@padd.com>
References: <20120401225407.GA12127@padd.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 03:52:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEsue-0000xZ-5k
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 03:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab2DCBvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 21:51:55 -0400
Received: from honk.padd.com ([74.3.171.149]:47806 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab2DCBvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 21:51:55 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id AFA1D20CE;
	Mon,  2 Apr 2012 18:51:53 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 02AD3313CD; Mon,  2 Apr 2012 21:51:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc2.57.gb1c2d
In-Reply-To: <20120401225407.GA12127@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194584>

Thanks Dmitry, Jonathan and Junio for the comments.  I'm happy to
have fast-import be strict about its format, and have added code
and tests that demand exactly one space, or an end-of-line, as
necessary.  I also made sure the other error messages involved
with parsing datarefs are correct.

Jonathan, good observation on CRLF users.  If we did want to
cater to them, doing it centrally in read_next_command() would be
the way to go.  But why bother.

Regarding fixing up all end-of-line number parsing, I think the
only other one is dates.  Both "raw" and "now" check for garbage
at end-of-line, but "rfc2822" uses a generic function that
accepts junk.  I'm not motivated to add a lot of code to fix that
corner case.

Junio, I made the commit message more clear.  For the idea of
combining find_mark + parse_mark, that isn't general enough for
all users.  This is the construct used in many places:

    oe = find_mark(parse_mark_ref_space(p, &x));

Also, I did the unit tests first, to make sure things were broken
as I expected.  You can squash it all together if you prefer.

		-- Pete

Pete Wyckoff (2):
  fast-import: test behavior of garbage after mark references
  fast-import: tighten parsing of mark references

 fast-import.c          |   97 ++++++++++++++----
 t/t9300-fast-import.sh |  267 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 342 insertions(+), 22 deletions(-)

-- 
1.7.10.rc2.2.g38670
