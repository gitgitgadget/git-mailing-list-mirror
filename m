From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/6] wt-status: protect against invalid change_type
Date: Wed, 16 Mar 2011 06:37:50 -0500
Message-ID: <20110316113750.GG15739@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
 <20110316105709.GC8277@elie>
 <20110316113540.GB15739@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:38:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzp3A-0001mL-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab1CPLh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:37:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51645 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1CPLhz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:37:55 -0400
Received: by ywj3 with SMTP id 3so612758ywj.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tRL++otjV66+BgelgcErDtKrY3XEHdbsC/NEAAbmgGk=;
        b=pZ0OuB0W3tw0T65Gazrl3RCgZQtvg1h59eQ5i9p/hGrxT07TYdLsGgpnS7jtujbXAM
         KA/pGO6kHZ20pq2zQkEzpTnY0Sa36CUzjj08/hIQbBsCkxpSNrhFtcZY1ODA8nyi6PNR
         u0nXLgUpUKA8juscjt4HA8yey6LfUioXoliq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q4qw+k7TcBZwQvEsIKLfOCrX1XNLT8xeemSNuW9yS952GwUbKQVaHB1L3+YaXUVKBe
         aWsPQSg9qz0H9LeAarSlIHJoa330xXsBO4PjolwZGRz9LktNgWYY2ilFv/4o3deHVEDx
         ypyW5HIReDK6nb+3iSVxzLeQqeX+7yQ5M2RBU=
Received: by 10.150.251.28 with SMTP id y28mr1229302ybh.323.1300275475232;
        Wed, 16 Mar 2011 04:37:55 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id v35sm3498924yba.16.2011.03.16.04.37.53
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:37:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316113540.GB15739@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169146>

Noticed with gcc -Wuninitialized.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 wt-status.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 3298897..25a411b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -181,6 +181,8 @@ static void wt_status_print_change_data(struct wt_status *s,
 		}
 		status = d->worktree_status;
 		break;
+	default:
+		die("BUG: invalid change_type");
 	}
 
 	one = quote_path(one_name, -1, &onebuf, s->prefix);
-- 
1.7.4.1
