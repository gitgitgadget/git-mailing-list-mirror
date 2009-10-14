From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git hang with corrupted .pack
Date: Wed, 14 Oct 2009 11:03:02 -0700
Message-ID: <20091014180302.GL9261@spearce.org>
References: <20091014042249.GA5250@hexapodia.org> <20091014142351.GI9261@spearce.org> <alpine.LFD.2.00.0910141208170.20122@xanadu.home> <20091014161259.GK9261@spearce.org> <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8Je-0003vZ-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbZJNSDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbZJNSDj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:03:39 -0400
Received: from george.spearce.org ([209.20.77.23]:52881 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbZJNSDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:03:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 91A4B381FE; Wed, 14 Oct 2009 18:03:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130311>

> Nicolas Pitre <nico@fluxnic.net> wrote:
> ...
> > This is unfortunate that making a test case for this isn't exactly 
> > trivial.

Junio, can you please squash this in?

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 5132d41..5f6cd4f 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -275,4 +275,13 @@ test_expect_success \
      git cat-file blob $blob_2 > /dev/null &&
      git cat-file blob $blob_3 > /dev/null'
 
+test_expect_success \
+    'corrupting header to have too small output buffer fails unpack' \
+    'create_new_pack &&
+     git prune-packed &&
+     printf "\262\001" | do_corrupt_object $blob_1 0 &&
+     test_must_fail git cat-file blob $blob_1 > /dev/null &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     test_must_fail git cat-file blob $blob_3 > /dev/null'
+
 test_done

-- 
Shawn.
