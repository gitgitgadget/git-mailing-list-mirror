From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2 0/4] Implements the GIT_TRACE_CURL environment variable
Date: Tue, 19 Apr 2016 15:10:40 +0000
Message-ID: <20160419151044.27814-1-gitter.spiros@gmail.com>
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 17:11:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXIq-00078I-87
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbcDSPK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 11:10:56 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:34553 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcDSPKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:10:55 -0400
Received: by mail-qg0-f68.google.com with SMTP id m8so1870511qgd.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3dKRxr7FWx7qgE2Xw79WJrEfpqb0SxsIIDqeeZHTC1Y=;
        b=Q3A/yFs8rlm1ZBZzr4w1rymgamREh1eqLMGrujtGPRPpLcKBqQN5beiFjNCPJgCkok
         BfmA8Semd45LAfBndA0dHzD20ihcrdV1bWiaa16UiY4A8smjyuDyEyU+gCuvdoczcq65
         x1P8MZ9FZrJXNiZYQY3qM1KitTglHlZwFrkQ4lmVot9njq8kJFgwLyafPi3MNnWKpmE4
         jBx0gFCxY+QbCWMo+1SrwBp+cQc8EZsamTYtIbXCsjGScTu0711XgHqe9g2u+e6r3PRx
         drEX8yXDexv1Q4I22rqBbxwMhz6MFIfjuMbIX10k+noJzwsyoL01qpfum/4KZr3LYMJC
         RtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3dKRxr7FWx7qgE2Xw79WJrEfpqb0SxsIIDqeeZHTC1Y=;
        b=YoWmEzqWTAjsL2o6DNGZ6oGajFrNljaeS6IgazaGVwhk627i+n5iSXYk28M++DDNI1
         deQSyJBunoo+rNRUUJGOoptRNpU3yg26VUYBRc06IhjYPGEY5pVTlKGjS/EvTxnuAD8A
         ysForw7LKrTCNXljLXlx4zzK+zE8zh6ftCEgSS9GcqQl3XIJrI45Lf6QJjBx/KL7grLF
         Iky1PR0gqeTxsmW+CqIsRSXvh90O5ptxcu00pH66Re9SjyJJJXjU/zT/2GZlxlx0T6pa
         fM8Xttvfv2TCom4uDZ+epfVgua+dvkc7+D0FewYTwRP375MWy9/9JRngcUI4QHchrj/N
         wRZg==
X-Gm-Message-State: AOPr4FVk+J+gdpffYp0ngMeBmtTOd2cr/PuuxYW+69zVTgebPDa4rQDaf7YyC3/CP7mCRA==
X-Received: by 10.194.92.132 with SMTP id cm4mr3674247wjb.25.1461078654189;
        Tue, 19 Apr 2016 08:10:54 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id u16sm4846168wmd.5.2016.04.19.08.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:10:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g0f2638b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291868>

This is the second version but in reality is the complete rewriting of the patches discussed here

$gmane/290520
$gmane/290521

Changes from V1

- introduced GIT_TRACE_CURL variable with its documentation
- changed the name of the temporary variable "i" in "w" in the helper routine
- used the c escape sequences instead of the hex equivalent
- dropped the previous GIT_DEBUG_CURL env var
- curl_dump and curl_trace factored out to a shared implementation
in http.c 

  
Elia Pinto (4):
  http.h: Add debug callback and helper routine for implementing     the
    GIT_TRACE_CURL environment variable in http.c
  http.c: implements the GIT_TRACE_CURL environment variable
  git.txt: document the new GIT_TRACE_CURL environment variable
  imap-send.c: introduce the GIT_TRACE_CURL enviroment variable

 Documentation/git.txt |  8 +++++
 http.c                | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                |  6 ++++
 imap-send.c           |  6 ++++
 4 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.5.0
