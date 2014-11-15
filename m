From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Don't make $GIT_DIR executable
Date: Sat, 15 Nov 2014 08:26:17 +0100
Message-ID: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 08:26:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpXky-0002FF-28
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 08:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbaKOH0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 02:26:47 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54775 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755104AbaKOH0o (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2014 02:26:44 -0500
X-AuditID: 1207440f-f79f06d000000bbf-a7-54670027ecba
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A0.91.03007.72007645; Sat, 15 Nov 2014 02:26:31 -0500 (EST)
Received: from michael.fritz.box (p5DDB2373.dip0.t-ipconnect.de [93.219.35.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAF7QTal011566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 15 Nov 2014 02:26:30 -0500
X-Mailer: git-send-email 2.1.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKvOkB5iMKVdz6LrSjeTRUPvFWaL
	hf+OslvcXjGf2WJ/U5IDq8ff9x+YPHbOusvucfGSssfnTXIezVPOswawRnHbJCWWlAVnpufp
	2yVwZ+w5f5i5YC9bxeWl85kaGPtZuxg5OSQETCSOzmhhhLDFJC7cW8/WxcjFISRwmVHi1r5W
	ZgjnBJPEw8UvwDrYBHQlFvU0M4HYIgJqEhPbDrGAFDELTGWU2PNoOQtIQljAWOJOy1owm0VA
	VWLl9PtgNq+As8SPdSeYIdbJSeydvJplAiP3AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	Jnq5mSV6qSmlmxghQcK/g7FrvcwhRgEORiUe3guT0kKEWBPLiitzDzFKcjApifIW3AEK8SXl
	p1RmJBZnxBeV5qQWH2KU4GBWEuE98h0ox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpa
	kFoEk5Xh4FCS4C3+B9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRDwr2+GJguIOk
	eID23gBp5y0uSMwFikK0nmLU5WhpetvLJMSSl5+XKiXOuxykSACkKKM0D24FLCW8YhQH+liY
	9w1IFQ8wncBNegW0hAloCeOxVJAlJYkIKakGxgk/VLLKOX50PNj/eo7mjPn7+57lGZ+0V37T
	sTzp+aKjyzQ9FfbeKJNwOfD/Kkto+Klr3z4eUMndd/b/5BMik33O+3wo7F1+5XevedW79l13
	VhXwvc913BXNFh6z92z0JLtrhprPZDU21JwW9JtUHZmnGZMR7RLuZrNqqXmh9Ndo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting with v2.1.0, "git init" creates $GIT_DIR/config with its u+x
bit set. These two patches are "belt and suspenders"--either one would
fix the bug, but IMO it makes sense to apply both of them. Plus, the
second patch will help repair repositories that were created while
this bug was in the wild.

I think these patches should go into "maint". They apply cleanly
there. When merging forward to master, there are two conflicts in
config.c which can be resolved by

    s/lock->filename/lock->filename.buf/

in two places.

Michael Haggerty (2):
  create_default_files(): don't set u+x bit on $GIT_DIR/config
  config: clear the executable bits (if any) on $GIT_DIR/config

 builtin/init-db.c |  1 +
 config.c          | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.1.1
