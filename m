From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9] vcs-svn: use strstr instead of memmem
Date: Fri, 6 Jul 2012 12:19:50 -0500
Message-ID: <20120706171950.GF31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:20:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnCCH-0000Si-MC
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab2GFRT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:19:56 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:35597 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab2GFRTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:19:55 -0400
Received: by gglu4 with SMTP id u4so8830565ggl.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pSE2NdY1WhlWhz1IPxEuRVWYUqdEOxOSfUsvCr64I98=;
        b=UAmmt8S6urNf62CoXtUkH6VShuQrQht8sBxH+lapQmt/0EdtmmfL36ldfDviRV4RV8
         0yWsb5hzHIsbIosEGIvk3st1RLlafWRMumUQisxuKI0j6awbVT65Qg8BAGCbRa85PWqt
         3QYQbYSvpLU4WqQPcUhs17wvAm6NgWqRpWooDw5iVeNDheXY85pTw7w4hgPbvGF2C/rc
         yIhQmaIpVmKKV65N5KR+ARZiZpXvGgj51FqCagI6bYe3L6rV+zdUCep7VqktY9cNv9wI
         hirysh7QxBeNi2hgWDzR0WOQe5YrY3CvoBbWUVePwMvF8+MDxfTTPd5UjEiGBuw9YOjy
         c+Cw==
Received: by 10.50.236.97 with SMTP id ut1mr3047373igc.50.1341595194235;
        Fri, 06 Jul 2012 10:19:54 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ga6sm2833916igc.2.2012.07.06.10.19.53
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:19:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201129>

From: David Barr <davidbarr@google.com>
Date: Fri, 1 Jun 2012 00:41:28 +1000

memmem is a GNU extension.

Avoiding it makes the code clearer and makes it easier for projects
that don't share git's compat/ code, such as the standalone
svn-dump-fast-export project, to reuse the vcs-svn/ library.

Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Clarified description.  No other change since v2.

 vcs-svn/fast_export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index b4be91cc..854b328d 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -158,7 +158,7 @@ static int parse_cat_response_line(const char *header, off_t *len)
 
 	if (ends_with(header, headerlen, " missing"))
 		return error("cat-blob reports missing blob: %s", header);
-	type = memmem(header, headerlen, " blob ", strlen(" blob "));
+	type = strstr(header, " blob ");
 	if (!type)
 		return error("cat-blob header has wrong object type: %s", header);
 	n = strtoumax(type + strlen(" blob "), (char **) &end, 10);
-- 
1.7.10.4
