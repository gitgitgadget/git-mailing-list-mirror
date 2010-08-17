From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/24] merge script: allow custom strategies
Date: Tue, 17 Aug 2010 02:05:32 -0500
Message-ID: <20100817070532.GQ22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:07:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGGa-0001Hc-EF
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128Ab0HQHHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:07:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43256 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab0HQHHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:07:07 -0400
Received: by gyg10 with SMTP id 10so2251154gyg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zzYccdxIdfwDuygxjylzwTQ36R9rMTlSiEMo7969CyA=;
        b=ZllS/1VzVjico+qkwjf5BhcdHsZwa1C8ZPdqaN2ZQSa1Xvd7Y3D99v9UtqY4aIQ/6n
         algqCk6YpJ22OSexmN6zQzsdQY6/aGPy34UoY6dFkKWcR+k+L37PHGmYZF307zT6jwRn
         mmXuOd540hnTpT0FZhlMz0GyeHPQqE9CtGCjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iGA8Zob2Pdb/QmhBHNu8xcllQ2L6SHtrn09DHA50gc+HyeBIB/BGt2LosXlJ2QmmkW
         arofY7NoxRsTDLQzEwZ1+7V16SjL1Vpx9T7E9C7ai7wjVpyoHW6Gfuu6HpJMm6NvvCm2
         D/1yYydOooFa5VDvHkMlwnVqAZGXpY1PwAT1o=
Received: by 10.100.25.23 with SMTP id 23mr7015754any.225.1282028827105;
        Tue, 17 Aug 2010 00:07:07 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w6sm11772278anb.3.2010.08.17.00.07.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:07:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153720>

The idea comes from v1.6.1-rc1~294^2~7 (builtin-merge: allow using a
custom strategy, 2008-07-30).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 0d53735..49d8265 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -193,9 +193,13 @@ parse_config () {
 			shift
 			case " $all_strategies " in
 			*" $1 "*)
-				use_strategies="$use_strategies$1 " ;;
+				use_strategies="$use_strategies$1 "
+				;;
 			*)
-				die "available strategies are: $all_strategies" ;;
+				type "git-merge-$1" >/dev/null 2>&1 ||
+					die "available strategies are: $all_strategies"
+				use_strategies="$use_strategies$1 "
+				;;
 			esac
 			;;
 		-X)
-- 
1.7.2.1.544.ga752d.dirty
