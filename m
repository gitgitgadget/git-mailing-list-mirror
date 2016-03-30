From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/6] Some cleanups
Date: Tue, 29 Mar 2016 17:38:47 -0700
Message-ID: <1459298333-21899-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 02:39:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4A3-00042K-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbcC3Ai7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:38:59 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35102 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbcC3Ai6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:38:58 -0400
Received: by mail-pa0-f47.google.com with SMTP id td3so26231930pab.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RZJcXSBx8y3pumsI7kk4BK7WFtIj2LvgU3C45zmGCNY=;
        b=gxHtYGNYaYVMcMbXtvGmwCrPTZU0t1VD4nOlyJveuoPNnsQtC/w73bri69BQYI5lPN
         Jra5Tk0n4OAcch08lUw2MZMG9yibE/hDw3kadoff4fXiDe1blRz/uYbcUpKHi2yjbGBX
         IIbpBifzWeiPWiL9YtdyKyzWjB3jWyJV6aRv+a6SVFn1Qo2m+zQuVAn/3o7BLACwUBH5
         lojibvH5B6/JGC9MnfMB1tlgfpP7kwyXtT4OY+AGAW85gxxuV9s76ZXKdgoAO//f7mFK
         k+W8OqS0lcp/l5M6tkgPjQkeU1OJvdhJgntgJnST6OBiiQQrD5JqZF0OqZYupQ+zqUin
         Vjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RZJcXSBx8y3pumsI7kk4BK7WFtIj2LvgU3C45zmGCNY=;
        b=fYJ/uBdGz1eT8ZlAW4P09HhMt1RQZTI2vIBGebfErRww9fvtCJmRPROPOvth0+0Pis
         /TV6YxNoxu/LrgOXltOK9tyNB3PZB1eHKsSgnhSKwnvZAl+Y9DyeYbrJyWx+SgCyPSxG
         t5uX1+ZH61hafQb2md22hMAFZtFzQ3USMB+eisBYj6UaECGMtm8G0n0bFCNmqKSq2FHq
         8ogxAnCKc+pL4tP2tbh8a74SN02nygHDne638HraDrzp05Ufn0UDL88BroCB0GlMQqPZ
         iw2CGnCEjgNpsdjjOi6FHt3f2h98dinff8g0va5mjJrR136w2IBVX/lwOfbxJv1YRv09
         7A6A==
X-Gm-Message-State: AD7BkJILWl8npJg3A1cLdV8kZLNLeS5Uh8CCXczUn2mbIyGj6AXnJH2S7q50xWT3bqXpfrjT
X-Received: by 10.66.193.202 with SMTP id hq10mr8015978pac.6.1459298337442;
        Tue, 29 Mar 2016 17:38:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id n11sm980511pfb.74.2016.03.29.17.38.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 17:38:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.8.g27a27a6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290232>

One of my first patches to Git were cleanup patches, and I fell back
to my old pattern here, while thinking on how to write better commit
messages for the submodule bugfixes I currently have in flight.

Just some one liners to not leak memory or file descriptors.

They are bundled as a series, but no patch relies on any predessor.

This applies on v2.8.0.

Thanks,
Stefan

Stefan Beller (6):
  path.c: allocate enough memory for string
  imap-send.c, cram: allocate enough memory for null terminated string
  notes: don't leak memory in git_config_get_notes_strategy
  abbrev_sha1_in_line: don't leak memory
  bundle: don't leak an fd in case of early return
  credential-cache, send_request: close fd when done

 builtin/notes.c    |  1 +
 bundle.c           | 10 ++++++++--
 credential-cache.c |  1 +
 imap-send.c        |  2 +-
 path.c             |  2 +-
 wt-status.c        |  2 +-
 6 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.8.0.8.g27a27a6.dirty
