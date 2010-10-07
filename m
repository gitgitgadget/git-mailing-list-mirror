From: Christoph Mallon <christoph.mallon@gmx.de>
Subject: Re: git diff --check always shows line 1 for blank at EOF for new
 files
Date: Thu, 07 Oct 2010 14:33:05 +0200
Message-ID: <4CADBE01.4000901@gmx.de>
References: <4CAC411E.3010204@gmx.de> <20101007093258.GA10941@burratino>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060507030702000005020601"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 14:33:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3pfC-0007Pd-Db
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 14:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760459Ab0JGMdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 08:33:13 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:53257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1760426Ab0JGMdM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 08:33:12 -0400
Received: (qmail invoked by alias); 07 Oct 2010 12:33:10 -0000
Received: from p5B14CD7D.dip.t-dialin.net (EHLO tron.homeunix.org) [91.20.205.125]
  by mail.gmx.net (mp014) with SMTP; 07 Oct 2010 14:33:10 +0200
X-Authenticated: #1673122
X-Provags-ID: V01U2FsdGVkX19V6jxIHepVPqEGYdYFnmSX8um0mWQwux1VKLyzYT
	HyvRDInuQKl/77
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; de-DE; rv:1.9.2.9) Gecko/20100919 Thunderbird/3.1.4
In-Reply-To: <20101007093258.GA10941@burratino>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158397>

This is a multi-part message in MIME format.
--------------060507030702000005020601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.2010 11:32, Jonathan Nieder wrote:
> Try this:
>
>      git init test
>      cd test
>      printf 'a\nb\nc\n'>  file
>      git add -A
>      echo hello>>  file
>      echo>>  file
>      git diff --check
>
> As you can see, it still returns line 4, which is the beginning of the
> hunk that adds the blank line.
>
> A change to make it print the line number of the blank line itself
> does not sound so bad, though.

You're right. I think, the attached patch corrects the issue.

--------------060507030702000005020601
Content-Type: text/plain;
 name="0001-When-git-diff-check-detects-a-blank-line-at-EOF-show.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-When-git-diff-check-detects-a-blank-line-at-EOF-show.pa";
 filename*1="tch"

>From 45eaa882dae35f2976e77cf0b6b06be78283c13f Mon Sep 17 00:00:00 2001
From: Christoph Mallon <christoph.mallon@gmx.de>
Date: Thu, 7 Oct 2010 14:22:02 +0200
Subject: [PATCH] When git diff --check detects a blank line at EOF, show the line number of the empty line, not the line number of the beginning of the hunk.

---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 71efa8e..452fdf4 100644
--- a/diff.c
+++ b/diff.c
@@ -2153,7 +2153,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 
 			ecbdata.ws_rule = data.ws_rule;
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
-			blank_at_eof = ecbdata.blank_at_eof_in_preimage;
+			blank_at_eof = ecbdata.blank_at_eof_in_postimage;
 
 			if (blank_at_eof) {
 				static char *err;
-- 
1.7.3


--------------060507030702000005020601--
