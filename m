From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Fix a bug with update-ref "verify" and no oldvalue
Date: Thu, 11 Dec 2014 00:47:50 +0100
Message-ID: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:48:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqzP-0008KL-3O
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365AbaLJXsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:48:05 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63121 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758097AbaLJXsE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 18:48:04 -0500
X-AuditID: 12074412-f79e46d0000036b4-67-5488dbafd446
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 12.23.14004.FABD8845; Wed, 10 Dec 2014 18:47:59 -0500 (EST)
Received: from michael.fritz.box (p5DDB0BBF.dip0.t-ipconnect.de [93.219.11.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBANlut8003387
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 10 Dec 2014 18:47:57 -0500
X-Mailer: git-send-email 2.1.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLv+dkeIwdWfChY710lYdF3pZrJo
	6L3CbPH25hJGi9sr5jNb9PZ9YrXYvLmdxYHd4+/7D0weO2fdZfdYsKnU4+Oz5eweFy8pe3ze
	JBfAFsVtk5RYUhacmZ6nb5fAnfHiTwtzwTrOioMnFrM1MF5l72Lk5JAQMJFYtOYHC4QtJnHh
	3nq2LkYuDiGBy4wS7UueM0I4J5gkJvZsYgapYhPQlVjU08wEYosIqElMbDvEAlLELPCFUWL9
	vj9gCWEBd4kXE28DJTg4WARUJTr6XEHCvALOEm9OtzOBhCUE5CS2rvOewMi9gJFhFaNcYk5p
	rm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZI8AjtYFx/Uu4QowAHoxIP74qr7SFCrIll
	xZW5hxglOZiURHl7r3eECPEl5adUZiQWZ8QXleakFh9ilOBgVhLhTboBlONNSaysSi3Kh0lJ
	c7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuD1uwXUKFiUmp5akZaZU4KQZuLgBBnOJSVS
	nJqXklqUWFqSEQ8K9PhiYKiDpHiA9naCtPMWFyTmAkUhWk8xKkqJ81qAJARAEhmleXBjYSnh
	FaM40JfCvC9AqniA6QSu+xXQYCagwcu3gA0uSURISTUwuqxq4bzB7V503bPh8LyX1SdEwp+U
	qVbOiVZVFVh1tjPrcemhytnZYXKlS85K9M7WP21WcWXCVpVrXSIbORPcP9sGLJK6Lz+T4d5L
	3g95IV6xR/h+MzzNtK94ydPEFXY/VcCn5bMGk9oVg2Clw+9n8uZNnN6RenfiSv6a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261260>

Ever since the --stdin option was added to "git update-ref" in

    c750ba9519 update-ref: support multiple simultaneous updates (2013-09-09)

the "verify" command has been broken. If no <oldvalue> is specified,
the documentation says that the "verify" command will verify that the
reference doesn't currently exist. But in fact, it unconditionally
*deletes* the reference (!)

Hopefully this is not a common usage idiom, but this is nonetheless a
serious bug.

Add some tests for this and related functionality, then fix the bug.

These patches are also available from my GitHub repository [1] as
branch "update-ref-verify-fix-v1".

This fix applies to "maint", for which I think it is appropriate. It
also merges through to "master" with no conflicts, though it conflicts
trivially with "pu".

[1] https://github.com/mhagger/git

Michael Haggerty (2):
  t1400: add some more tests of "update-ref --stdin"'s verify command
  update-ref: fix "verify" command with missing <oldvalue>

 builtin/update-ref.c  | 14 +++-----
 t/t1400-update-ref.sh | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 9 deletions(-)

-- 
2.1.3
