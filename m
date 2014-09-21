From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 22/32] checkout: support checking out into a new
 working directory
Date: Sun, 21 Sep 2014 16:50:21 +0700
Message-ID: <CACsJy8CH8mQjexFU1jO1orzajiwTXy4wJ022nq1PEY2GLUGAZA@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com> <1410388928-32265-23-git-send-email-pclouds@gmail.com>
 <5411B98C.1090905@xiplink.com> <20140921024101.GA6275@lanh> <CAPig+cRbfxUHmxbxxXLw=WKuV3JvBPEhuT4CvrZEOhWR-fbMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 11:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVdnF-0007da-SQ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 11:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbaIUJux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 05:50:53 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:46301 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaIUJuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 05:50:52 -0400
Received: by mail-ig0-f179.google.com with SMTP id l13so1265540iga.6
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HTc3KHpJSkW3IPoeESyrkUoFgwjZ5K0WWa5/CQmibLo=;
        b=fBuk4urGcnTKjcnTznddQXVS5B74wXa9I+8jYLFBPnGk81QUb/lZVP8QFMBR/sUfaV
         jB2Ku32loO9FHbNI7QpSNoJ9byMkOk+lZzxGCpURjQuPTgb2Rl887ZuEV0emBooEnKja
         VcbN1YFXrbOqHpoMpzcbfpWEBoWZSMWSRNVFnUs6RcD8MIcfb1nhWC6v7MkKUX4KyHNF
         nFjk4IWAQYpgPWwBi/Ub3w4rzXyE1tbsAu92+tsIcCsCWaJwRuMsB3YpVDaUcl3kExQD
         i52eYYr00gTd1GFOjteWqmXx8G+dHEn6P1AG4qze862qeMhuc0CNxDkMyCPHo0X62KQi
         BsWg==
X-Received: by 10.42.101.77 with SMTP id d13mr10839787ico.53.1411293052077;
 Sun, 21 Sep 2014 02:50:52 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Sun, 21 Sep 2014 02:50:21 -0700 (PDT)
In-Reply-To: <CAPig+cRbfxUHmxbxxXLw=WKuV3JvBPEhuT4CvrZEOhWR-fbMHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257348>

On Sun, Sep 21, 2014 at 10:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Would it make sense for this "rule of thumb" summary to be presented
> first, and then the explanation of that rule after, rather than the
> reverse as is currently the case?

You mean like this?

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c101575..fd77631 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -420,6 +420,11 @@ $GIT_COMMON_DIR is set to point back to the main
working tree's $GIT_DIR
 (e.g. `/path/main/.git`). These settings are made in a `.git` file located at
 the top directory of the linked working tree.

+See linkgit:gitrepository-layout[5] for more information. The rule of
+thumb is do not make any assumption about whether a path belongs to
+$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
+inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
+
 Path resolution via `git rev-parse --git-path` uses either
 $GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
 linked working tree `git rev-parse --git-path HEAD` returns
@@ -429,11 +434,6 @@ rev-parse --git-path refs/heads/master` uses
 $GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
 since refs are shared across all working trees.

-See linkgit:gitrepository-layout[5] for more information. The rule of
-thumb is do not make any assumption about whether a path belongs to
-$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
-inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
-
 EXAMPLES
 --------



-- 
Duy
