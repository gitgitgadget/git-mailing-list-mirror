From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Another minor cleanup involving string_lists
Date: Mon,  5 Nov 2012 09:41:21 +0100
Message-ID: <1352104883-21053-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 09:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVIFy-0001eT-DM
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 09:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab2KEIlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 03:41:53 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:56307 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052Ab2KEIlw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 03:41:52 -0500
X-AuditID: 1207440f-b7fde6d00000095c-0a-50977bcf8653
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.95.02396.FCB77905; Mon,  5 Nov 2012 03:41:51 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA58fjnO015704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Nov 2012 03:41:49 -0500
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqHu+enqAwelWTYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xv7NbewF
	nRwV55YeY25gvMzWxcjJISFgIvFpZgMLhC0mceHeeqA4F4eQwGVGiU+3prFCOKeZJK7/WgHW
	wSagK7Gop5kJxBYRkJX4fngjI4jNLJArsfjdbXYQW1jAUeJy9wowm0VAVeLBmZ9gG3gFXCS+
	rjjFCrFNTuLDnkfsExi5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQI
	CQj+HYxd62UOMQpwMCrx8H6UmB4gxJpYVlyZe4hRkoNJSZR3ZSVQiC8pP6UyI7E4I76oNCe1
	+BCjBAezkggvBwNQjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwSsD
	DHwhwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCoxxcDgx0kxQO0VwGknbe4IDEX
	KArReopRl+Pom7kPGYVY8vLzUqXEeb1BigRAijJK8+BWwOL/FaM40MfCvKYgVTzA1AE36RXQ
	EiagJdsvTQFZUpKIkJJqYOx/mlNQc/+bR7btZ8EdF9sywq7M+ze/SfiTUmW6v8pJqX9iLa9E
	WvSXxq1Y+bIsxe6CaILiIuaUNCmLd3revwMED+mpp+5akf9u4Q7ZzKudGen721a+N8xIFp7b
	GMs0wVrCx0X5S+UtyS9bbFVO34/kVsq0D5s5u+rNtftf6u02WLvFOl0LVmIpzkg0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209052>

Nothing really earthshattering here.  But it's funny how every time I
look closely at a site where I think string_lists could be used, I
find problems with the old code.  In this case is_absolute_path() is
called with an argument that is not a null-terminated string, which is
incorrect (though harmless because the function only looks at the
first two bytes of the string).

Another peculiarity of the (old and new) code is that it rejects
"comments" even in paths taken from the colon-separated environment
variable GIT_ALTERNATE_OBJECT_DIRECTORIES.  The fix would be to change
link_alt_odb_entries() to take a string_list and let the callers strip
out comments when appropriate.  But it didn't seem worth the extra
code.

Michael Haggerty (2):
  link_alt_odb_entries(): use string_list_split_in_place()
  link_alt_odb_entries(): take (char *, len) rather than two pointers

 sha1_file.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

-- 
1.8.0
