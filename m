From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] fast-import: allow 'ls' and filecopy to read the root
Date: Sat, 10 Mar 2012 03:01:33 -0600
Message-ID: <20120310090132.GF1992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120310085354.GE1992@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 10:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6IBL-00081q-18
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 10:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab2CJJBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 04:01:38 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42405 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab2CJJBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 04:01:38 -0500
Received: by ghrr11 with SMTP id r11so1466597ghr.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 01:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dt1bC8dxp9ow0p/+RAOdobIic9fx3ElTWnQ5GGcp0PQ=;
        b=uKi1e5cEadartYw1eSmdCfYtzUeVwQcld2DNpWGuosqVDRQW3WVUSxaQPhRl5sVaY+
         VjX9Wn3w+TGbONtoTFw7a/WaaII1NGhSQfuOXvEPKU3LrSCQGltYBTxuBq1vqtaSCapI
         ow5RnZEm6453kNLpEfRXQsb9VbEGwqADstDbCqDh0YiXpEqv+lqjY2Upir4xTODRs4xN
         etsqMDmz5py4MKb2b2El8haI1ezJgL4NdEqstsLQVLRWVw4ZuohV5XMQaVK3xnbINWSk
         RAJww54WgCbau6maTW1bn1fpFzyUI+z5+snCDRIl30vd4wAH7geT++RoNIpioX8ChSnx
         CPRw==
Received: by 10.60.21.134 with SMTP id v6mr1920349oee.52.1331370097448;
        Sat, 10 Mar 2012 01:01:37 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id u5sm11072005obk.16.2012.03.10.01.01.36
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 01:01:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120310085354.GE1992@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192774>

Jonathan Nieder wrote:

> It has a semantic conflict with the fast-import-ls-fixes series that
> I sent separately
[...]
> I'll send a fixup patch as a reply, for squashing into the merge or
> this patch, whichever is the first commit that contains both topics.

With this tweak, the merge passes the merged set of tests.

diff --git i/fast-import.c c/fast-import.c
index 51cdda29..fe1c8643 100644
--- i/fast-import.c
+++ c/fast-import.c
@@ -1658,8 +1658,6 @@ static int tree_content_get(
 		n = slash1 - p;
 	else
 		n = strlen(p);
-	if (!n)
-		die("Empty path component found in input");
 
 	if (!root->tree)
 		load_tree(root);
@@ -1669,6 +1667,8 @@ static int tree_content_get(
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
 			if (!slash1)
 				goto last_component;
+			if (!slash1[1])
+				die("Empty path component found in input");
 			if (!S_ISDIR(e->versions[1].mode))
 				return 0;
 			if (!e->tree)
