From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Fri, 21 Jun 2013 12:14:33 +0530
Message-ID: <CALkWK0k8-go979S9sMytBpqs_C9Jm6q6thqwHa4-GX-e5Czx=g@mail.gmail.com>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
 <20130620133422.GA18200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 08:45:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upv6J-0005mN-E2
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 08:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422965Ab3FUGpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 02:45:16 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:57568 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab3FUGpO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 02:45:14 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so18646245iec.21
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t9bmTgDsP4pUxfefUN7vLHObw1jZ7o4iVSceW1x2rhA=;
        b=U7DibtdsK0SwHFxk0YY6PdYa0VWvsi0aSmedHO5vT5bpF9Jk2KiaOQAoSG9zIchDCq
         cMhXGrWGwzFLg52eFILK16KTZXqYzYl7lHN06tRLqkpT0neXEcOU1VBvZyU18NzqEZgG
         /OBCpTjQS79gM6i7HDG0KSGEo+zGPYgNVHMXSIulPZspZjOW/4Y485+5XN7h1H/HpAZB
         +lv+SIszzIkx91F91rKdunHKBKPSaRGCaQILwZx6YuCI97NYoPxOHAiIFsvUPvN+aEnf
         CB0jso1FdtmpAiYLKgJRIxO+4URAdmqpzmOsDHg2uJuqpGfyJ6IlEa4AV/cX1lxNt7Or
         92Yw==
X-Received: by 10.50.87.71 with SMTP id v7mr1509211igz.29.1371797113953; Thu,
 20 Jun 2013 23:45:13 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 23:44:33 -0700 (PDT)
In-Reply-To: <20130620133422.GA18200@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228579>

Jeff King wrote:
> So I'm not sure if there is a better option than reverting 81d340d4 and
> living with the lesser of two evils (no good message when the helper
> dies silently).

I dug around, but I still can't justify that there is no better
option.  Could you write a commit message for this?

-- 8< --
diff --git a/transport-helper.c b/transport-helper.c
index 06c08a1..db9bd18 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -56,7 +56,7 @@ static int recvline_fh(FILE *helper, struct strbuf
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		die("Reading from helper 'git-remote-%s' failed", name);
+		exit(128);
 	}

 	if (debug)
