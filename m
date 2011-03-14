From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git stash: status from current dir not top dir?
Date: Mon, 14 Mar 2011 20:45:41 +0100
Message-ID: <4D7E7065.20908@gmail.com>
References: <4D7A8AC9.1030506@gmail.com> <20110311223232.GA21410@sigill.intra.peff.net> <4D7B358A.5010101@gmail.com> <7v1v2agnww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:47:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDjI-00058C-68
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab1CNTqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 15:46:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35482 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab1CNTqs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:46:48 -0400
Received: by fxm17 with SMTP id 17so3282588fxm.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=81vQ71D9RPay6nwyQztat9qYwTlWe4uOwEgtV4ZZ71Q=;
        b=XHAHpjOWB6h/WNzLv2jvdnDVEg9rpEOJt3YJtUS3KU9xyv7KppG2u5TCNxmGFUYC5J
         Oo/86pmAQZOfKMDODzghP6de4wBf5gycvnjZUTouInQ13GBaKaSd4pzYnzh6gmgaRVq9
         LJi3/NRQ3gLb5REl8XozAmmNjnZfiTyOcLKZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hP/HDKSIajy13PusicGcpjZ7tG+VeekPquALgwlAM0X84ibKgh0qWPgCTJhmhab0kE
         v2cwEPdVd7YvIFe0Y9OIF884pN/YnTYL0sNGdtzcuVGy6KrVbSL6mQxCIUtl39W1xkwv
         UiYR+exLFaejheJ6pLxPCd/myBK+xkwFueOKE=
Received: by 10.223.54.213 with SMTP id r21mr1975139fag.54.1300131950152;
        Mon, 14 Mar 2011 12:45:50 -0700 (PDT)
Received: from [192.168.1.101] (amm95.neoplus.adsl.tpnet.pl [83.26.68.95])
        by mx.google.com with ESMTPS id c11sm3261858fav.2.2011.03.14.12.45.48
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 12:45:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7v1v2agnww.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169019>

W dniu 14.03.2011 08:29, Junio C Hamano pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> Subject: [PATCH] git stash: show status relative to current directory
>>
>> git status shows modified paths relative to current directory, so it's
>> possible to copy&paste them directly, even if you're in a subdirectory.
>>
>> But "git stash apply" always shows status from root of git repository.
>> This is misleading because you can't use the paths without modifications.
>>
>> This is caused by changing directory to root of repository at the
>> beginning of git stash.
>>
>> This patch makes git stash show status relative to current directory.
>> Instead of removing the "cd to toplevel", which would affect whole
>> script and might have other side-effects, the fix is to change directory
>> temporarily back to original dir just before displaying status.
>>
>> Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
>> ---
> 
> Sensible. Thanks.
> 
> Don't we want to protect this output with some tests?

Right. Wrote a test but it fails mysteriously. Looks like a debug output
is added when test is run as "sh t3903-stash.sh" (the "Merging Version" etc).
No such output when "git apply" is run by hand.

Not sure what to do with it?

With --verbose I see:

[...]
[master b27a2bc] subdir
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 subdir/subfile1
Saved working directory and index state WIP on master: b27a2bc subdir
HEAD is now at b27a2bc subdir
--- ../output	2011-03-14 19:39:42.473685001 +0000
+++ ../expect	2011-03-14 19:39:42.489685001 +0000
@@ -1,9 +1,3 @@
-Merging Version stash was based on with Stashed changes
-Merging:
-virtual Version stash was based on
-virtual Stashed changes
-found 1 common ancestor(s):
-virtual 13419d0b4f5b097f61dde4c911de99a154f8286f
 # On branch master
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
not ok - 41 stash apply shows status same as git status (relative to current directory)


---8<---
From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Mon, 14 Mar 2011 20:19:36 +0100
Subject: [PATCH] Add test: git stash shows status relative to current dir


Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 t/t3903-stash.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 6fd560c..3682f1c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -556,4 +556,19 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
+test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
+	git stash clear &&
+	echo 1 > subdir/subfile1 &&
+	echo 2 > subdir/subfile2 &&
+	git add subdir/subfile1 &&
+	git commit -m subdir &&
+	cd subdir &&
+	echo x > subfile1 &&
+	echo x > ../file &&
+	git stash &&
+	git stash apply > ../output &&
+	git status > ../expect &&
+	test_cmp ../output ../expect
+'
+
 test_done
-- 
1.7.4.1.228.g9e388



-- 
Piotr Krukowiecki
