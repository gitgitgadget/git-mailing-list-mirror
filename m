From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] bundle: remove stray single-quote from error message
Date: Thu, 26 Apr 2012 00:53:59 -0500
Message-ID: <20120426055359.GA2483@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-11-git-send-email-pclouds@gmail.com>
 <xmqqipgnbffm.fsf@junio.mtv.corp.google.com>
 <CACsJy8CzNx9GP2PSszs2rrkQHr0P6fPVe4+-z4QXJ8k_4hqh9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 07:54:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNHei-0005iA-Be
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 07:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab2DZFyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 01:54:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58868 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2DZFyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 01:54:09 -0400
Received: by iadi9 with SMTP id i9so1106675iad.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qj9bwsiCZjMVTZLBGCKya5vyKc57u2AVh+WEXfCAoko=;
        b=fvtU+vggWUeN0oYklume3YJg3002CWQ26aZR8K9xWdjEFXMWBB+k5e6CGBvzHBRHbH
         ZdnZX0mBreYaHSeTso1BvVi/sLIyYoNFc8kQODOQ2fr9DwoVEeCh/zsMvBhjsmwjTxp1
         peNRNPiVvypOkHfxKAdpU8jTSpnu3syl/1leQHExH2GR82k5WuPhHOK+2LFZxy3By2mk
         BDYFUSxpDtYd5DCF3DQnYOmIhdGwkAYeIAtEWFy2p5lDvlCC0M0vVg5wXivta8hUdepX
         vnJGmlDb9XjnGEayh6EY/gLgJttQlfRSdnEnvsRh2VRw8d4kvvhUISBAATfvD+P+1Xrt
         nfcg==
Received: by 10.50.15.227 with SMTP id a3mr5089490igd.15.1335419648174;
        Wed, 25 Apr 2012 22:54:08 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wf10sm23115322igb.8.2012.04.25.22.54.04
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 22:54:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8CzNx9GP2PSszs2rrkQHr0P6fPVe4+-z4QXJ8k_4hqh9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196353>

After running rev-list --boundary to retrieve the list of boundary
commits, "git bundle create" runs its own revision walk.  If in this
stage git encounters an unfamiliar option, it writes a message with an
unbalanced quotation mark:

	error: unrecognized argument: --foo'

Drop the stray quote to match the "unrecognized argument: %s" message
used elsewhere and save translators some work.

This is mostly a futureproofing measure: for now, the "rev-list
--boundary" command catches most strange arguments on its own and the
above message is not seen unless you try something esoteric like "git
bundle create test.bundle --header HEAD".

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Nguyen Thai Ngoc Duy wrote:

> Yeah. I searched the code and that seems the only place with
> unbalanced quotes (both single and double quotes). I'll leave it to
> you to either drop it or add another one there.

Ok, here you go.

 bundle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index d9cfd905..27ab32e4 100644
--- a/bundle.c
+++ b/bundle.c
@@ -289,7 +289,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	if (argc > 1)
-		return error("unrecognized argument: %s'", argv[1]);
+		return error("unrecognized argument: %s", argv[1]);
 
 	object_array_remove_duplicates(&revs.pending);
 
-- 
1.7.10
