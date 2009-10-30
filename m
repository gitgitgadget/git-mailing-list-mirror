From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] clone: detect extra arguments
Date: Fri, 30 Oct 2009 06:19:19 -0500
Message-ID: <20091030111919.GA13242@progeny.tock>
References: <20091029081030.GA11213@progeny.tock>
 <20091029160614.GB7622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 12:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3pM7-0000Jk-0F
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 12:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbZJ3LJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 07:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbZJ3LJH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 07:09:07 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:34888 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZJ3LJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 07:09:06 -0400
Received: by yxe17 with SMTP id 17so2564542yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6ua6HtYo0PNO9pIJzia4ikZCCfkuNwnLqRowBryAF30=;
        b=Z8F72lq3ThQFDlvFR2U9htz1EjLJgIwa0nO0f+j0mzqp/Ob3JAG5Obld/c5+FPgsUA
         KdPc5x4Epu6UrvQIjGXQWoTlAXmbcP76zaoFveoRzN2JgAxNlvk7tdsTJbGIxkrM4RLP
         nmUKD7um+aYyRTC8v2W/AqxnJEAlujJ7ZEHCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DRsgQxUge3805/rGUdBFLM6J1urIJri/qkXi6J0vGsPF25WTjAsR5JzhCdXoRuDDcG
         +HFkt/8ldJB2A8CxYY3I7slO8j1iSRP06lgmtG3hDzoT7r9RbgNyRvRegxYJyKH2VdUE
         2hfQzoGZSsZqoPzvCJZpJiMe6TI4Nk+G5StTY=
Received: by 10.150.30.40 with SMTP id d40mr2721025ybd.133.1256900950521;
        Fri, 30 Oct 2009 04:09:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm71662gxk.15.2009.10.30.04.09.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 04:09:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091029160614.GB7622@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131695>

Jeff King wrote:

> Should we maybe be showing the usage in this case?

Sounds reasonable.  How about this patch on top?

-- %< --
Subject: [PATCH] clone: print usage on wrong number of arguments

git clone's short usage string is only 22 lines, so an error
message plus usage string still fits comfortably on an 80x24
terminal.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-clone.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 76ad581..736d9e1 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -378,10 +378,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			     builtin_clone_usage, 0);
 
 	if (argc > 2)
-		die("Too many arguments.");
+		usage_msg_opt("Too many arguments.",
+			builtin_clone_usage, builtin_clone_options);
 
 	if (argc == 0)
-		die("You must specify a repository to clone.");
+		usage_msg_opt("You must specify a repository to clone.",
+			builtin_clone_usage, builtin_clone_options);
 
 	if (option_mirror)
 		option_bare = 1;
-- 
1.6.5.2
