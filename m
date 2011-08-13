From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH/RFC] git-svn: remove auto_abbrev (Getopt::Long option)
Date: Sat, 13 Aug 2011 22:33:32 +0200
Message-ID: <4E46DF9C.8040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 13 22:33:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsKtw-00084U-SG
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 22:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab1HMUdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 16:33:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33260 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab1HMUdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 16:33:42 -0400
Received: by fxh19 with SMTP id 19so2919011fxh.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=USquGQUJqem0I8Pq2Nt8LLGC0fcJTVTAlek3ggR3xjQ=;
        b=UFDnLoPI56vjfenRpKu61uOPFNm2EpUurfpPDsnzWUwR0+Izxy/iZx6VPd4kLe0Hm9
         9tnfHakgHLEYh+O4zVsTVwP2Atq0ZTptykJHYefmlVspQH+uEagcsSayemnraJAd8zdE
         ZEhEutMkdTBFjkTxyD5RNxv5z/wd/+x6wyyJs=
Received: by 10.223.160.75 with SMTP id m11mr1428172fax.42.1313267620729;
        Sat, 13 Aug 2011 13:33:40 -0700 (PDT)
Received: from [192.168.1.101] (aagb212.neoplus.adsl.tpnet.pl [83.4.157.212])
        by mx.google.com with ESMTPS id c4sm106100faa.16.2011.08.13.13.33.38
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 13:33:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179293>


RFC because this changes user interface (no option abbreviation),
but I know no other good way to fix the --author problem.

The --author option would be useful, because I usually use
  git svn log --oneline
and paste the changes with svn revision numbers to bugzilla etc.

All tests pass with this change.

--------8<--------
From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Sat, 13 Aug 2011 21:00:56 +0200
Subject: [PATCH] git-svn: remove auto_abbrev (Getopt::Long option)

auto_abbrev allows to specify shortest unique option prefix.
For example '--authors-file' can be written also as '--author'
given there is no other option which begins with '--author'.

'git-svn log' passes all unrecognized options to 'git log'. It should
also pass '--author' but due to auto_abbrev it recognizes it as
'--authors-file'. In result it's not possible to use this option.

Fix this by removing auto_abbrev. No other perl script seems to use it,
also other git commands seems to have no option abbreviation feature.
The side effect is that you can not abbreviate options to git-svn, obviously.

In fact only log and blame requires no option abbreviation, because only they
use pass_through option (pass unrecognized options), but I think it would not
be natural if some git-svn commands had options abbreviations and some didn't.

Alternative would be to handle all conflicting blame/log options, but
maintaing it would be a nightmare...

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..3e2e276 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -56,7 +56,7 @@ use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
 use File::Spec;
 use File::Find;
-use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
+use Getopt::Long qw/:config gnu_getopt no_ignore_case/;
 use IPC::Open3;
 use Git;
 use Memoize;  # core since 5.8.0, Jul 2002
-- 
1.7.6.GIT

-- 
Piotr Krukowiecki
