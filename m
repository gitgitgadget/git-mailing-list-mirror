Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1513203C1
	for <e@80x24.org>; Thu, 21 Jul 2016 01:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbcGUBAH (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 21:00:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33282 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbcGUBAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 21:00:02 -0400
Received: by mail-io0-f194.google.com with SMTP id y195so4522231iod.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 18:00:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0648hDEkdHNJywNFB4+MUNJHTHNozi6j0swyMuZ//Zg=;
        b=Z76wuyGI25oYh7/ZCz2Ur9CXXXfOy5ES/hSYKJ6ltxX8YM/7Jyb/oAk/djVTRLnixZ
         tFubLzIDKO+NDphhKkQMn8HdQ/avHqk8cTb9rz61bwvsY1RHhKlNgRxU5DRupN4982od
         3SAexK3zL6WMPeGB7CR5vEW0gFPzkGpV1ZfeIyaLglcQHAya0iueLB8y3hcY/7fftxST
         g6JO59UGDrecm+Jn0y4n3+5Ccs+5e3MFceiDf+K3Gxaz8xxVyFwfmJ5q7ShcCqIcUZS7
         vYFJGXJ3+tNPfS4LJvFcFREShuNaiWRurvOWec6cxUj5YEsAPZFQnxkpe7zkmeyOFC/q
         39Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0648hDEkdHNJywNFB4+MUNJHTHNozi6j0swyMuZ//Zg=;
        b=PZE3w/U0gSn0zqLGETho4BVJrL6/cvx3yCugORd3XmqBF15LEcctZEB6sAMrhnJK5Z
         AzzSDSpRr5VzKbPC1zEypg+tpwxyas41MGA8lrsHm4ANoLn7c3gU1xTPxKLT3FEMavOm
         Vttl3AUb0GgyQ80ASbxnvRqlFky4VFRJ+lhBOs1LnvIFFvqA/L2JG1buS4cRKHYFjUKY
         P9Jwao6p3u2kUaGTy7bsFRwBI8TRhLxDtcUuBqog7GtHsGWFd2FbPk5q7y8Do3UGCvLF
         Bp2T0hVC2wV+G6+pHkNmLEI/A8cTJ4Q67HHHHhiDz59PMBecYEcIEzNAN4E3+QzGp4Sk
         GRBw==
X-Gm-Message-State: ALyK8tK/KdxYDUXb7QomcztCOUfjQaryKCjvnlE82PJtAOg0UNLHT6wrsv6iApupohbNy6oqPXljcI30nq71iA==
X-Received: by 10.107.132.104 with SMTP id g101mr54510395iod.147.1469062801204;
 Wed, 20 Jul 2016 18:00:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Wed, 20 Jul 2016 18:00:00 -0700 (PDT)
From:	Parker Moore <parkrmoore@gmail.com>
Date:	Wed, 20 Jul 2016 19:00:00 -0600
Message-ID: <CAOiOGAfWfEy60qg3AbbPNqkvJDMsXBHY8ZSXBCKJYha_gDB8mw@mail.gmail.com>
Subject: [PATCH] contrib/persistent-https: use Git version for build label
To:	git <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Parker Moore <parkrmoore@gmail.com>

The previous method simply used the UNIX timestamp of when the binary was
built as its build label.

    $ make && ./git-remote-persistent-http -print_label
    1469061546

This patch aims to align the label for this binary with the Git version
contained in the GIT-VERSION-FILE. This gives a better sense of the version
of the binary as it can be mapped to a particular revision or release of
Git itself. For example:

    $ make && ./git-remote-persistent-http -print_label
    2.9.1.275.g75676c8

Discussion of this patch is available on a related thread in the mailing
list surrounding this package called "contrib/persistent-https: update
ldflags syntax for Go 1.7+". The gmane.org link is:
http://article.gmane.org/gmane.comp.version-control.git/299653/

Signed-off-by: Parker Moore <parkrmoore@gmail.com>
---
 contrib/persistent-https/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/persistent-https/Makefile
b/contrib/persistent-https/Makefile
index 92baa3be..8248269 100644
--- a/contrib/persistent-https/Makefile
+++ b/contrib/persistent-https/Makefile
@@ -12,7 +12,7 @@
 # See the License for the specific language governing permissions and
 # limitations under the License.

-BUILD_LABEL=$(shell date +"%s")
+BUILD_LABEL=$(shell cat ../../GIT-VERSION-FILE | cut -d" " -f3)
 TAR_OUT=$(shell go env GOOS)_$(shell go env GOARCH).tar.gz

 all: git-remote-persistent-https git-remote-persistent-https--proxy \
