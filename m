From: Duy Nguyen <pclouds@gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for git
Date: Fri, 31 Jul 2015 18:24:13 +0700
Message-ID: <CACsJy8AfYHOCBdSNyBZP0CdYJGkXbipn0t7E_C8j7c25LET4Qg@mail.gmail.com>
References: <55bb53d17f78c_2d71521318537c@scan.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL8Qi-0006kp-6X
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 13:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbbGaLYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 07:24:44 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34666 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbGaLYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 07:24:43 -0400
Received: by ioea135 with SMTP id a135so82145974ioe.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fQCyprhfNEYhbujizW1geGDT2aSU/8dTqXWSbjSibzw=;
        b=RBUhq5u7nMiHm5qfEk9yDNJuB74E1wEBI+c4cJPyawBVF6fBQpUZTum9hAEEXi+12z
         9s27TS6IllCKEcTORIUaqSDtQN0Q8/6hgqmpBgU5IblIX+iX2fbjd//y4jt19B48+nic
         AGFiyWqYCq4LI2SI8pZChCsZvM+5lkhX6lTHjmfFGzW68U8yhGyhE+Z5erH9nlfRGHCB
         l5VGwapwV55yQKKBpM1nwAEOzwztT7H+yGdkWOrL4aU9HzrtsgwozJG1OxlVVs/Z2F5j
         b5qe+ZHivIesMzGbpOrUcgk668E/CGZ9I0Twd1SofVWmveiv2N816gDGsnIp63jDsp+4
         O6RA==
X-Received: by 10.107.15.210 with SMTP id 79mr3788992iop.192.1438341882913;
 Fri, 31 Jul 2015 04:24:42 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Fri, 31 Jul 2015 04:24:13 -0700 (PDT)
In-Reply-To: <55bb53d17f78c_2d71521318537c@scan.mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275046>

Jeff, I suppose you are the admin of git on scan.coverity, or knows
him/her, perhaps we can add a model for xmalloc to suppress these
"null pointer deferences" reports? We are sure xmalloc() never returns
NULL. Qemu did it [1] and it looks simple.. I think something like
this would do

void *xmalloc(size_t size)
{
   void *mem = malloc(size);
   if (!mem) __coverity_panic__();
   return mem;
}

[1] http://git.qemu.org/?p=qemu.git;a=blob;f=scripts/coverity-model.c;h=4c99a85cfc292caa9edd9d041e2683ee53490a8d;hb=e40cdb0e6efb795e4d19368987d53e3e4ae19cf7#l104


---------- Forwarded message ----------
From:  <scan-admin@coverity.com>
Date: Fri, Jul 31, 2015 at 5:54 PM
Subject: New Defects reported by Coverity Scan for git
To: pclouds@gmail.com

_______________________________________________________________________________________________________
*** CID 1313836:  Null pointer dereferences  (FORWARD_NULL)
/rerere.c: 150 in find_rerere_dir()
144                     return NULL; /* BUG */
145             pos = sha1_pos(sha1, rerere_dir, rerere_dir_nr,
rerere_dir_sha1);
146             if (pos < 0) {
147                     rr_dir = xmalloc(sizeof(*rr_dir));
148                     hashcpy(rr_dir->sha1, sha1);
149                     rr_dir->status_nr = rr_dir->status_alloc = 0;
>>>     CID 1313836:  Null pointer dereferences  (FORWARD_NULL)
>>>     Assigning: "rr_dir->status" = "NULL".
150                     rr_dir->status = NULL;
151                     pos = -1 - pos;
152
153                     /* Make sure the array is big enough ... */
154                     ALLOC_GROW(rerere_dir, rerere_dir_nr + 1,
rerere_dir_alloc);
155                     /* ... and add it in. */

** CID 1313835:  Null pointer dereferences  (FORWARD_NULL)
/builtin/fetch.c: 795 in prune_refs()
-- 
Duy
