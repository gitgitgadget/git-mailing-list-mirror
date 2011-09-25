From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for corrupt/non existent ref
Date: Sun, 25 Sep 2011 13:06:20 +0800
Message-ID: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 07:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7gyI-0002nt-OI
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 07:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab1IYFJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 01:09:41 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65024 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab1IYFJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 01:09:41 -0400
Received: by pzk1 with SMTP id 1so11291205pzk.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 22:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LZwN/VT853FDq9BWkWaQEsILQcdvKFlmZVcWvdfGdU0=;
        b=x0t1li/okgfB8VrktkVCLtGDe+2mqpEmuJ3lf33ikQFXpOeSZv6PkQRNKOMsTOiIgo
         vETir97FzEb231YUg7NmbSpXOlF0teofSOidQiyhFwf6S+0UodVwKrC1/zTjZxiqGlGG
         Y0OXNKGJgKN+DzyyElsBcPAMiXYu//KQ8D9+A=
Received: by 10.68.8.233 with SMTP id u9mr20486082pba.30.1316927380504;
        Sat, 24 Sep 2011 22:09:40 -0700 (PDT)
Received: from localhost (bb116-14-45-233.singnet.com.sg. [116.14.45.233])
        by mx.google.com with ESMTPS id p9sm17127368pbq.12.2011.09.24.22.09.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 22:09:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc3.2.g6432
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182056>

Hi list,

Currently, receive-pack runs the pre-receive, update, post-receive and
post-update hooks during a push to delete corrupt or non-existent refs, eg:

	git push origin :refs/heads/foo

where refs/heads/foo is missing from the remote origin.

The issue is reported here [1]


This is a patch series which teaches receive-pack not to run update hook for
corrupt or non existent refs during a push.

Patch 1/2 isn't really relevant to the topic. It's just something I stumbled
across while reading the code. It removes a redundant assignment in the is_url
function.

Patch 2/2 teaches receive-pack not to run update hook for corrupt or non
existent refs. In summary, I reordered the statements in the update function
so that the update hook is not run for corrupt / non existent refs.

Perhaps this isn't a good enough solution since the pre-receive, post-receive
and post-update hooks are still run. Also the tests aren't exactly good looking.

Any advice is highly appreciated. Thanks!

[1] http://thread.gmane.org/gmane.comp.version-control.git/181942 

Pang Yan Han (2):
  is_url: Remove redundant assignment
  receive-pack: Don't run update hook for corrupt or nonexistent ref

 builtin/receive-pack.c |   50 +++++++++++++++++++++++++++--------------------
 t/t5516-fetch-push.sh  |   33 +++++++++++++++++++++++++++++++
 url.c                  |    1 -
 3 files changed, 62 insertions(+), 22 deletions(-)

-- 
1.7.7.rc3.2.g29f2e6
