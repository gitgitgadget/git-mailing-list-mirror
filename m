From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git/spearce.git (Oct 2008, #02; Sun, 12)
Date: Sun, 12 Oct 2008 19:05:33 -0700
Message-ID: <7v3aj1fdw2.fsf@gitster.siamese.dyndns.org>
References: <20081012212543.GG4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 04:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpCuW-0006L4-Fr
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 04:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbYJMCFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 22:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260AbYJMCFk
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 22:05:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbYJMCFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 22:05:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D4BE8A6ED;
	Sun, 12 Oct 2008 22:05:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6BBAF8A6EA; Sun, 12 Oct 2008 22:05:34 -0400 (EDT)
In-Reply-To: <20081012212543.GG4856@spearce.org> (Shawn O. Pearce's message
 of "Sun, 12 Oct 2008 14:25:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E90DC86-98CB-11DD-859F-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98073>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> * pb/rename-rowin32 (Fri Oct 3 12:20:43 2008 +0200) 1 commit
>  - Do not rename read-only files during a push
>
> Supposedly fixes pack file renames on Windows, but it makes the
> test suite fail on Linux.  I haven't debugged why yet.

I am kind of surprised that it actually passes the test on Windows, which
implies that these cats shown in the patch to fix this breakage below do
not honor ro-ness of the file, which in turn makes me doubt if making the
resulting packfiles read-only has any effect on that platform whatsoever..

 t/t5300-pack-object.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git i/t/t5300-pack-object.sh w/t/t5300-pack-object.sh
index b335c6b..544f59e 100755
--- i/t/t5300-pack-object.sh
+++ w/t/t5300-pack-object.sh
@@ -248,6 +248,7 @@ test_expect_success \
      git index-pack test-3.pack &&
      cmp test-3.idx test-1-${packname_1}.idx &&
 
+     rm -f test-3.pack &&
      cat test-2-${packname_2}.pack >test-3.pack &&
      git index-pack -o tmp.idx test-2-${packname_2}.pack &&
      cmp tmp.idx test-2-${packname_2}.idx &&
@@ -255,6 +256,7 @@ test_expect_success \
      git index-pack test-3.pack &&
      cmp test-3.idx test-2-${packname_2}.idx &&
 
+     rm -f test-3.pack &&
      cat test-3-${packname_3}.pack >test-3.pack &&
      git index-pack -o tmp.idx test-3-${packname_3}.pack &&
      cmp tmp.idx test-3-${packname_3}.idx &&
