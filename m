From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] i18n: leave \n out of translated diffstat
Date: Mon, 25 Jun 2012 06:33:29 -0500
Message-ID: <20120625113328.GA9270@burratino>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <20120624160411.GA18791@burratino>
 <7vzk7shvd0.fsf@alter.siamese.dyndns.org>
 <CACsJy8De_Toy+7jvsBueYZpcuakTxZupmwLYZVm29Ni3+1QuMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:33:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7Y6-0004K0-Np
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab2FYLdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 07:33:39 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51267 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2FYLdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 07:33:38 -0400
Received: by gglu4 with SMTP id u4so2668265ggl.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NxzLKtzNXd7y/ZOlWlZDUCbcvYzb3vF4E7rIPx+dn0w=;
        b=P4RrrVRl1S7mUiaibXGG3j7SDnEW+yBDcw2VilS/LjG4wQaKVa0osal/m8P7bcp2lU
         sD69rzyzbdNGrfFPezCE3xISP9nuzGr0D/TlvHl4tBbSQVkEBvWWRkXVvYGzr5Yo2/1n
         FnV1sgFiI6CuycixEeJ6h/Zwl5Pn/YT23GYmZv/xsmp8kjobKoX2QW74BTgKlGsUOFS3
         QZkvXRO7O1rFjj/lgUjB6c3nUuZGNOF4JJ9v/O/wL2A/GSO/4QlZEDDnWKddBWoP+Ng/
         ftmhywKxZDOzztKHc2UWqOgEVRDhLrIZ9Xz7I7VnCuVpSY4qN+mOk8KJM+kxkVtUyME+
         FYdg==
Received: by 10.50.42.165 with SMTP id p5mr7740997igl.68.1340624017433;
        Mon, 25 Jun 2012 04:33:37 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id yg6sm16011963igb.6.2012.06.25.04.33.36
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 04:33:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8De_Toy+7jvsBueYZpcuakTxZupmwLYZVm29Ni3+1QuMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200569>

Nguyen Thai Ngoc Duy wrote:

> That prints "0 files changed, 0 insertions(+), 0 deletions(-)" instead
> of "0 files changed". Two more changed lines to make it the latter.

Sloppy of me.  Yes, I meant

diff --git i/diff.c w/diff.c
index 1a594df4..287f310d 100644
--- i/diff.c
+++ w/diff.c
@@ -1395,11 +1395,6 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	if (!files) {
-		assert(insertions == 0 && deletions == 0);
-		return fputs(_(" 0 files changed\n"), fp);
-	}
-
 	strbuf_addf(&sb,
 		    Q_(" %d file changed", " %d files changed", files),
 		    files);
@@ -1412,7 +1407,7 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 	 * is probably less confusing (i.e skip over "2 files changed
 	 * but nothing about added/removed lines? Is this a bug in Git?").
 	 */
-	if (insertions || deletions == 0) {
+	if (insertions || (files && deletions == 0)) {
 		/*
 		 * TRANSLATORS: "+" in (+) is a line addition marker;
 		 * do not translate it.
@@ -1423,7 +1418,7 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 			    insertions);
 	}
 
-	if (deletions || insertions == 0) {
+	if (deletions || (files && insertions == 0)) {
 		/*
 		 * TRANSLATORS: "-" in (-) is a line removal marker;
 		 * do not translate it.
