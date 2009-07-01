From: Martin Renold <martinxyz@gmx.ch>
Subject: Re: [PATCH] Remove filename from conflict markers
Date: Wed, 1 Jul 2009 09:56:34 +0200
Message-ID: <20090701075634.GA18326@old.homeip.net>
References: <20090628154559.GA29049@old.homeip.net> <7v63ed5pvi.fsf@alter.siamese.dyndns.org> <20090701123310.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:12:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLutM-0005N3-RA
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 10:10:08 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLugS-0003Qv-5O
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:56:48 +0200
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLugS-0003Qs-4M
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:56:48 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx4.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLugQ-0002sg-Hw
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbZGAH4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 03:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbZGAH4e
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 03:56:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750782AbZGAH4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 03:56:33 -0400
Received: (qmail invoked by alias); 01 Jul 2009 07:56:35 -0000
Received: from 84-74-83-103.dclient.hispeed.ch (EHLO bazaar) [84.74.83.103]
  by mail.gmx.net (mp031) with SMTP; 01 Jul 2009 09:56:35 +0200
X-Authenticated: #1936982
X-Provags-ID: V01U2FsdGVkX18tWF5Fbqgt6JLUDCIycqnubeO7pG/ReLyv8GcF5h
	xty1wbc+QLKuyY
Received: from martin by bazaar with local (Exim 4.69)
	(envelope-from <martinxyz@gmx.ch>)
	id 1MLugE-00060q-Fp; Wed, 01 Jul 2009 09:56:34 +0200
Content-Disposition: inline
In-Reply-To: <20090701123310.6117@nanako3.lavabit.com>
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 5DC3ABB55F13F8C395358DE7ADE008391A5275FF
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 266 total 2552077 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122572>

On Wed, Jul 01, 2009 at 12:33:10PM +0900, Nanako Shiraishi wrote:
> The last part clearly shows that this change introduces a usability
> regression.  In the error message the user can no longer see which file
> was problematic.

Not true. The filename is still printed two times in the case of "git
merge", and four times with "git rebase".  The user still sees the required
information, there are just fewer repetitions.

The previous warning was a bit nicer for copy-paste, allthough I don't see
why it should print things so differently compared to textual conflicts.

> -     grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
> +     grep "Cannot merge binary files: HEAD vs. F" \
>               merge.err

We could als fix that test by expecting the filename on stdout:

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 129fa30..0c6b1ea 100755
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
-100644 da056ce14a2241509897fa68bb2b3b6e6194ef9e 1      a1
+100644 439cc46de773d8a83c77799b7cc9191c128bfcff 1      a1
 100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2      a1
 100644 fd7923529855d0b274795ae3349c5e0438333979 3      a1
 EOF
@@ -93,8 +93,8 @@ test_expect_success 'refuse to merge binary files' '
        git add binary-file &&
        git commit -m binary2 &&
        test_must_fail git merge F > merge.out 2> merge.err &&
-       grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
-               merge.err
+       grep "Cannot merge binary files: HEAD vs. F" merge.err
+       grep "Merge conflict in binary-file" merge.out
 '
 
 test_expect_success 'mark rename/delete as unmerged' '

bye,
Martin
