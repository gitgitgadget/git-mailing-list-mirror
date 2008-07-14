From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [PATCH/Test] Build in merge is broken
Date: Sun, 13 Jul 2008 19:15:00 -0700
Message-ID: <402c10cd0807131915u6567cba9h361d26d3dc003739@mail.gmail.com>
References: <loom.20080713T073129-112@post.gmane.org>
	 <20080713124100.GB10347@genesis.frugalware.org>
	 <20080713174659.GE10347@genesis.frugalware.org>
	 <20080713184300.GF10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 04:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIDbt-00033T-PW
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 04:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbYGNCPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 22:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbYGNCPT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:15:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:41889 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbYGNCPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:15:18 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2311524ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 19:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HFWKIFQ60a66uUbu0/z/JqAhXJeRBpXoQnb01IRlUfk=;
        b=VJQedOdCTnjaxl3+Ujleq7up6d+DhPOKLQ2sNCtc80JS7QZ7yUJiwCG6EvizaODhp8
         mQi2NijZt/F8OTFPatb+0A+hOHSpmOem9a+y3FRlbtkC1YXWxE0NKP3OwDwETpodj52H
         6C1rrsrP8eyvnpnIgpAwNJiDQt3nXEFSB5/u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Pq1zvKzVXb0Zch9JYNiNDjqSk06zfbIApbS0KrYHe1QiyqhzwHaFnOHUlJpdMGKviu
         GnvCd9zDtFENXxpc9ENGiO+2I/UkULXnHcUnRHLDqB+7w5FLuHa2awCFbFyUPVuW4wZF
         O2uavSjNNWRC3L60JIYTkrC9Gnvd/YdDTOwrs=
Received: by 10.150.123.16 with SMTP id v16mr19487576ybc.40.1216001700994;
        Sun, 13 Jul 2008 19:15:00 -0700 (PDT)
Received: by 10.150.197.6 with HTTP; Sun, 13 Jul 2008 19:15:00 -0700 (PDT)
In-Reply-To: <20080713184300.GF10347@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88366>

Test cases for build in merge.
---
After applying Miklos's fix there still are some breakages.  I have squashed in
another test case.  c1 is merged with c1 and c2.  Three parents are
recorded in the
merge commit object; c1, c1, and c2.

 t/t7600-merge.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 16f4608..80cfee6 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -465,4 +465,26 @@ test_expect_success 'merge log message' '

 test_debug 'gitk --all'

+test_expect_success 'merge c1 with c0, c2, c0, and c1' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c0 c2 c0 c1 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c1 and c2' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 c2 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.5.54.gc6550

-- 
Sverre Hvammen Johansen
