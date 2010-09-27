From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 10/15] t6016 (rev-list-graph-simplify-history): add
 missing &&
Date: Sun, 26 Sep 2010 19:10:37 -0500
Message-ID: <20100927001037.GA7490@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-11-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Adam Simpkins <simpkins@facebook.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 02:14:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P01M0-0000qr-Bj
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 02:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158Ab0I0ANu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 20:13:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41663 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab0I0ANt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 20:13:49 -0400
Received: by qyk33 with SMTP id 33so6942110qyk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5cd9/zGwotfv/A2MMiXy8xakKo1GSi4tmwE3lbujvjU=;
        b=msf5EKeyC6lOfEEkVJrcdEzgSSffPID7+oAY3VZn2Xk2a530JN+dNW2rHa9CMPMZ9S
         RNemJ6Y6Wcl7ElHbr2mezLPxfW8+PgHXRv/xJZxaOH1m0piEzYU4pHRvZjK2fJTWqT7H
         dFABG1dykU2dV73gV/eRxGVt/pApxXdNr6/h4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UH+r/efgEQSKk3cLQjregxDNIvf2eTcRjlhbQJcH2JzBVxfWzELzGKsQbE4+xhtXM2
         pEqfERI5c+pggdWqCiiSN1WQt+KhoQ/qt1RUgwYxuKRsziXWWI19rbHDTtSts1LgRbqR
         aXJ7V2lufRH6UwfsVOXHh2NQmkODlFhEHJs5Q=
Received: by 10.220.124.213 with SMTP id v21mr2019130vcr.75.1285546428695;
        Sun, 26 Sep 2010 17:13:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id s7sm214686vcc.2.2010.09.26.17.13.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 17:13:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285542879-16381-11-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157282>

(+cc: Adam Simpkins)
Hi,

Thanks for doing this tedious work.

Elijah Newren wrote:

> Also removed several repeated tag and branch deletions

Nit: present tense

> , since the tags and
> branches had already been deleted.

I suspect the repeated deletions were to allow skipping individual
tests.  Maybe something like the following on top of your patch
would achieve that.

The rest looks good to me, for what it's worth.

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index e640c41..5036940 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -116,12 +116,15 @@ test_expect_success '--graph --simplify-by-decoration' '
 	test_cmp expected actual
 	'
 
-# Get rid of all decorations on branch B, and graph with it simplified away
-test_expect_success '--graph --simplify-by-decoration prune branch B' '
-	rm -f expected &&
+test_expect_success 'setup: get rid of decorations on branch B' '
 	git tag -d B2 &&
 	git tag -d B1 &&
-	git branch -d B &&
+	git branch -d B
+'
+
+# Graph with branch B simplified away.
+test_expect_success '--graph --simplify-by-decoration prune branch B' '
+	rm -f expected &&
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
-- 
