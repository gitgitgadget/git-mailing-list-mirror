From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/24] merge script: refuse to merge during merge
Date: Tue, 17 Aug 2010 02:03:58 -0500
Message-ID: <20100817070358.GN22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:05:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGEv-0000YI-1J
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086Ab0HQHFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:05:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63886 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969Ab0HQHFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:05:34 -0400
Received: by gwj17 with SMTP id 17so1309249gwj.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MtObwjXmVJAY5r7XNKIOmQhlq21G2r0COLpiC4Rx+VE=;
        b=dmZhHDWvPt7TI2k1qpV6Bw9nt6ss9XNEZ0HeYxpOjRBVnu65vELPj4DeunDvHam5mm
         BW+o0yFQSoAUSzP14/w3f+6/koZ6oYbz0DWYmjSrA3WVZWWGOJGKcr1YQMcQV5yZ7bcM
         GeK5RBp5KFh1NYKUnP8dhqCYaTXlKwhCV6Maw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FTCv9UgFHnroo0Kq3EVf2j1MM6jd/TnMB9SPEe6Xe/4mtZMlvcKzoQgzzwyB8s9MW0
         U+eTfEg4fN+3d9FnBGQ6Pp+3LGoFKd9rbixApCUqYAMmSVxrYP0XvS5qtnKfIErC/Nic
         ITZcSFILHl7UtzwHU4GwI7eJBcCCeR7rPxPlU=
Received: by 10.150.175.4 with SMTP id x4mr6579466ybe.325.1282028734096;
        Tue, 17 Aug 2010 00:05:34 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e7sm570298ybe.16.2010.08.17.00.05.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:05:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153717>

Check MERGE_HEAD and bail out if it exists.  Based on v1.6.3.3~3^2
(refuse to merge during a merge, 2009-06-01).  Without this change,
the scripted merge does not pass t3030.

Cc: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 99fe1f2..50042df 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -27,6 +27,9 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "Merge is not possible because you have unmerged files."
 
+! test -e "$GIT_DIR/MERGE_HEAD" ||
+	die 'You have not concluded your merge (MERGE_HEAD exists).'
+
 LF='
 '
 
-- 
1.7.2.1.544.ga752d.dirty
