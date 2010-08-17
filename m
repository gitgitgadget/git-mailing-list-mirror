From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/24] merge script: forbid merge -s index
Date: Tue, 17 Aug 2010 02:06:06 -0500
Message-ID: <20100817070606.GR22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:07:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGGx-0001PV-MN
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab0HQHHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:07:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37535 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab0HQHHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:07:42 -0400
Received: by gyg10 with SMTP id 10so2251366gyg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Xnuhl47wgn9odiPryHUWVGDmm4IAdGKsYwZv8HvukBg=;
        b=XXJjgdATznkfUYB3GJiI2WCmEeaJIQFcgM23Oga60TwftSaP0MoDKG01NTUf2lYulO
         bIkRmtcAZ74N3T+NXPl35OKLVGsWIxKVS7zZUKyy6nD1BdWOOqCVf43kz0ZkiD2/rr/Z
         2Mg9fLrC29wrveKnhC6vOkHmbqmna+Z2NN8io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TeYj0HA0fYMXWeqpK6iPgmRFCdTgrnTH3kIOIQm9KypbOUkFhnZr01RFoETzU2Yev5
         AGV0GGnzIoQBT9QdpolS3mReuQ6uaT/sZHp1+i8z/RTzR2v+JLqQ5raWtSOHtCudaIRa
         ppjjathzO9Qq+0XeD/LlN/+JUWWjKi2+bIp5o=
Received: by 10.100.120.14 with SMTP id s14mr7028482anc.151.1282028861437;
        Tue, 17 Aug 2010 00:07:41 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id l6sm11764686ang.18.2010.08.17.00.07.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:07:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153721>

Some git-merge-* commands are not merge strategies.  This is based on
v1.6.1-rc1~294^2~7 (builtin-merge: allow using a custom strategy,
2008-07-30) but it is less smart: we just use a hard-coded list of
forbidden strategy names.  It is okay if this falls out of date, since
the code is just an example.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 49d8265..bab3da9 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -36,6 +36,7 @@ LF='
 
 all_strategies='recur recursive octopus resolve stupid ours subtree'
 all_strategies="$all_strategies recursive-ours recursive-theirs"
+not_strategies='base file index tree'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
 no_fast_forward_strategies='subtree ours'
@@ -196,6 +197,10 @@ parse_config () {
 				use_strategies="$use_strategies$1 "
 				;;
 			*)
+				case " $not_strategies " in
+				*" $1 "*)
+					false
+				esac &&
 				type "git-merge-$1" >/dev/null 2>&1 ||
 					die "available strategies are: $all_strategies"
 				use_strategies="$use_strategies$1 "
-- 
1.7.2.1.544.ga752d.dirty
