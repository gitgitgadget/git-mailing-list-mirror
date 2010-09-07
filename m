From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Several tests: cd inside subshell instead of around
Date: Mon, 6 Sep 2010 21:37:13 -0500
Message-ID: <20100907023713.GJ1182@burratino>
References: <4C85357A.8090000@web.de>
 <7vhbi2tqd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 04:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oso5h-0005hx-UF
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 04:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab0IGCjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 22:39:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59957 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab0IGCjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 22:39:16 -0400
Received: by gwj17 with SMTP id 17so1736161gwj.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qL1lxo/LMnKvkpQSpmLjcp8DWhfqyeDA1HUOPYneq7s=;
        b=D7DKY/ssCmyz6r941UhTcuRwhfCNopOQk9iWwfKcq+g4utfSrId1Ztw+fZXb6klere
         NjnWpZA51NYJsscvQL8J9vym3zEmfo/dvd18nmGWR81wu9bxK+79z/YSTz61ReisW7ZR
         MXyzJvrnQBQsEmN/Mx9l8FuFhDJG34I7xJJ1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jsQ6be81SwEDjCfCJYuj5g51R9sM2hcftKeHXKiiono6e9dyZ1+ID037UgvH0FdsbG
         OEHV4duhtZxLCMNZEerFlHol0KWCfeCgElzICrYmP9wnrgOsR3S5p/Bp6IKFFN7A+jKd
         HEgcDxXCL7V480f40TbGW+QVM0UIHZohxK/QI=
Received: by 10.100.33.18 with SMTP id g18mr1779596ang.68.1283827151565;
        Mon, 06 Sep 2010 19:39:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w10sm10396861ank.34.2010.09.06.19.39.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 19:39:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbi2tqd0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155667>

Junio C Hamano wrote:

> If we were to insist that no matter how an individual test fail, the test
> that follows it must start in a known location (namely, $TRASH), then we
> might want to use something like the attached patch.

I like it.  Affected test scripts:

  t0003-attributes.sh		t0050-filesystem.sh
  t1007-hash-object.sh		t1020-subdirectory.sh
  t1301-shared-repo.sh		t1500-rev-parse.sh
  t1501-worktree.sh		t1504-ceiling-dirs.sh
  t2050-git-dir-relative.sh	t2300-cd-to-toplevel.sh
  t3407-rebase-abort.sh		t4119-apply-config.sh
  t5300-pack-object.sh		t5404-tracking-branches.sh
  t5406-remote-rejects.sh	t5510-fetch.sh
  t5515-fetch-merge-logic.sh	t5520-pull.sh
  t5530-upload-pack-error.sh	t5600-clone-fail-cleanup.sh
  t5700-clone-reference.sh	t5701-clone-local.sh
  t5710-info-alternate.sh	t6029-merge-subtree.sh
  t7001-mv.sh			t7103-reset-bare.sh
  t7400-submodule-basic.sh	t7401-submodule-summary.sh
  t7408-submodule-reference.sh	t7610-mergetool.sh
  t9101-git-svn-props.sh	t9103-git-svn-tracked-directory-removed.sh
  t9113-git-svn-dcommit-new-file.sh
  t9115-git-svn-dcommit-funky-renames.sh
  t9117-git-svn-init-clone.sh
  t9137-git-svn-dcommit-clobber-series.sh
  t9400-git-cvsserver-server.sh

and probably some others.

What is the ",$(pwd)" for?

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 29fd720..90ed4d9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -370,6 +370,11 @@ test_debug () {
 }
 
 test_run_ () {
+	if test ",$(pwd)" != ",$TRASH_DIRECTORY"
+	then
+		error "bug in test script: starting from a different directory"
+	fi
+
 	test_cleanup=:
 	eval >&3 2>&4 "$1"
 	eval_ret=$?
@@ -377,6 +382,11 @@ test_run_ () {
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
 	fi
+
+	if test ",$(pwd)" != ",$TRASH_DIRECTORY"
+	then
+		error "bug in test script: moved to a different directory"
+	fi
 	return 0
 }
 
-- 
