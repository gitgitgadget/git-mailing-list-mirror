From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Remove filename from conflict markers
Date: Wed, 01 Jul 2009 12:33:10 +0900
Message-ID: <20090701123310.6117@nanako3.lavabit.com>
References: <20090628154559.GA29049@old.homeip.net> <7v63ed5pvi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Martin Renold <martinxyz@gmx.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 05:34:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLqaM-0005M4-9A
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 05:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZGADeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 23:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbZGADeD
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 23:34:03 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49141 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbZGADeC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 23:34:02 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 6B1A311B7F0;
	Tue, 30 Jun 2009 22:34:04 -0500 (CDT)
Received: from 4662.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id OMQG58PHFZJU; Tue, 30 Jun 2009 22:34:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=bJqlKSxASxJSpp4Pmov5yIIPBkQSIP3pGvEbd1bGsSp9K8cImCi5hK2mME5wEcToAsUk5bMWQ4UFRVZ6ICfuqP0LXtJ99Vugxs6WFIbYbGYnE49YMxaHN0+/PLF3y9nXtG/DZZGmgkNDHgxKyn8HoOdZybaJk5YIDJ011IciebM=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v63ed5pvi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122563>

Quoting Junio C Hamano <gitster@pobox.com>:

> Martin Renold <martinxyz@gmx.ch> writes:
>
>> Put filenames into the conflict markers only when they are different.
>> Otherwise they are redundant information clutter.
>>
>> Signed-off-by: Martin Renold <martinxyz@gmx.ch>
>> ---
>>  merge-recursive.c             |    9 +++++++--
>>  t/t3404-rebase-interactive.sh |    4 ++--
>
> The change seems to break more tests than just 3404.
>
> I also wondered briefly if it will break people's existing scripts;
> I suspect it will not likely to be a huge problem.

I needed to apply the attached patch to make the tests pass. The last part clearly shows that this change introduces a usability regression. In the error message the user can no longer see which file was problematic.

I request Martin's patch to be dropped.

 t/t6024-recursive-merge.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 129fa30..a9c4a02 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -65,18 +65,18 @@ test_expect_success "combined merge conflicts" "
 "
 
 cat > expect << EOF
-<<<<<<< HEAD:a1
+<<<<<<< HEAD
 F
 =======
 G
->>>>>>> G:a1
+>>>>>>> G
 EOF
 
 test_expect_success "result contains a conflict" "test_cmp expect a1"
 
 git ls-files --stage > out
 cat > expect << EOF
-100644 da056ce14a2241509897fa68bb2b3b6e6194ef9e 1	a1
+100644 439cc46de773d8a83c77799b7cc9191c128bfcff 1	a1
 100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
@@ -93,7 +93,7 @@ test_expect_success 'refuse to merge binary files' '
 	git add binary-file &&
 	git commit -m binary2 &&
 	test_must_fail git merge F > merge.out 2> merge.err &&
-	grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
+	grep "Cannot merge binary files: HEAD vs. F" \
 		merge.err
 '

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
