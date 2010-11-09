From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 9 Nov 2010 08:36:01 -0600
Message-ID: <20101109143601.GB18960@burratino>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
 <1285649702-24773-1-git-send-email-pclouds@gmail.com>
 <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
 <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
 <AANLkTinKNF6OEX=k1aepD-Zrm2_4GzHaB+SVHdfTMG-j@mail.gmail.com>
 <20101109140615.GA18960@burratino>
 <AANLkTi=2q1-1zmR=JquN75DP9sGGuPVkAu4mVs1U9DZo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 15:36:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFpJE-0001oa-7I
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 15:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab0KIOgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 09:36:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44980 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab0KIOgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 09:36:21 -0500
Received: by eye27 with SMTP id 27so3524527eye.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0/u0VyvMcBeihS3cj9eMz2p41ZL7yHtX7+wgeRfN6Us=;
        b=jcq8UfquG/R5uGzIfyFtyKT6uJTNhOO5xb2cC2TJtKKnltmEtIwlrHfwhNCRMn4qVd
         szoOb7mESHxlL7tmzfRPDjS416Ie5Vh+gw1xMmRHnqCCs7sMW/YdeqIVwc3euhq2UGcY
         1XBtCkkhXnYN3nTInvwslQo9/v3o2nPtdG6FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w6p0VjClD+KhMe3RV9UEBLB35Z8S+OGz8dSuwMki8vnuJAH02Pum2LeEC9R5kQpxRn
         lSDRg1ETn7QmwQjn2nUT+bONtsqrfJrxIgW8I5L6uSwBAqE/xx1EOil0itFN6dPmVEIK
         ERUJ81PQxr7yfjudIMyk2Rf+W+5PxXvYUa2oM=
Received: by 10.216.50.75 with SMTP id y53mr6935071web.85.1289313380269;
        Tue, 09 Nov 2010 06:36:20 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id o43sm908065weq.47.2010.11.09.06.36.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 06:36:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=2q1-1zmR=JquN75DP9sGGuPVkAu4mVs1U9DZo@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161051>

Sverre Rabbelier wrote:

> And then here you smash my hopes that you were suggesting we stop
> asking the user to mess around in the .git directory :(. After all, if
> we let that rm be handled by some 'git rebase' mode, it could also
> unlock any branches it has locked.

Well, I think that is worth doing, too.  It's just that it's hard to
change existing practices and much easier to change the tools to
keep supporting them.

I don't think the manual advertises .git/rebase-merge anywhere.  I
have witnessed people succumbing to the temptation to delete it when
another rebase fails.

Maybe "git rebase" should have a --override-rebase-in-progress option?
The following is simpler, sort of imitating the "git bisect reset"
command.  With it applied, if you do

	git rebase --abort HEAD

then the rebase will abort without changing the current HEAD (yes,
I know this interface is stupid; please feel free to pick it up
and do better).

Other practices worth abstracting away:

	- Reading .git/rebase-merge/patch and
	  .git/rebase-merge/message when a patch had conflicts
	- Checking for the existence of .git/rebase-merge in $PS1
	  prompt
	- Tweaking .git/rebase-merge/todo to reflect a change of plan

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30e5c0e..3a587a1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -227,6 +227,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --abort::
 	Restore the original branch and abort the rebase operation.
 
+--abort HEAD::
+	Abort the rebase operation, without changing the current branch.
+
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a27952d..2e1c074 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -772,6 +772,14 @@ first and then run 'git rebase --continue' again."
 		do_rest
 		;;
 	--abort)
+		if test "$2" = HEAD
+		then
+			shift
+			is_standalone "$@" || usage
+			get_saved_options
+			rm -rf "$DOTEST"
+			exit
+		fi
 		is_standalone "$@" || usage
 		get_saved_options
 		comment_for_reflog abort
diff --git a/git-rebase.sh b/git-rebase.sh
index e5df23b..0f88a00 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -273,6 +273,11 @@ do
 		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
 			die "No rebase in progress?"
 
+		if test "$2" = HEAD
+		then
+			rm -r "$dotest"
+			exit
+		fi
 		git rerere clear
 		if test -d "$dotest"
 		then
