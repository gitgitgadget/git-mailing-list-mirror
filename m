From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/4] rev-parse: improve reporting of invalid log references
Date: Sat, 21 Aug 2010 11:43:38 +1000
Message-ID: <1282355022-17795-1-git-send-email-jon.seymour@gmail.com>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 03:44:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omd8I-00056H-QZ
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 03:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab0HUBoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 21:44:13 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50220 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0HUBoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 21:44:12 -0400
Received: by pxi10 with SMTP id 10so1444133pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 18:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=13rTA5qaguTRS8ZfkqSdWR/Hby5r4z7EW7DpsaNpFKc=;
        b=E+eTfuRrTNlXST4TvXQdZVREWgIph9pi0V45sF1Ah46ogZ/9BoXpKQ4+WU9q9Ek1lf
         tdUYOuj6rbO/up1glmJTks9UCO4jwWZl4UfxIOCJNbZ/l4hYLjxkmEyOYoe9JZzrJtDR
         c313+CHDFv56BEfKnlYEDccUVYb7MqNdxNd38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rT75uDmCYnK1bfHBR9qKCNvmwNooBcrAmYtXVmxUYNnvTwkKf7lbDwc42dCrsb1yYF
         Ge5DrSlZhjPUUAQCBt69SVqPMxcD8lB2RioNbsLWI8CJtBr70js+qd/OMd7DQWCx3TaI
         Ks+/5TaHoq+krgSpAUHA51u2xHpcA0QnfeIM8=
Received: by 10.114.111.15 with SMTP id j15mr2340148wac.187.1282355051917;
        Fri, 20 Aug 2010 18:44:11 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id d38sm6038069wam.8.2010.08.20.18.44.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 18:44:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.156.gf148c
In-Reply-To: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154088>

This series fixes git rev-parse so that references of the form ref@{n}
cause rev-parse to fail with non-zero status codes when n >= N, where
N is the size of the reflog for ref.

The first commit causes git rev-parse to exit with a non-zero 
status code but has the flaw that the error message is duplicated 
if --verify is not specified.

The second commit fixes the duplicate error messages produced by
the first commit, but prevents the diagnostic being displayed
if the --verify option is specified.

The third commit restores the diagnostic if the --verify
option is specified.

The fourth commit adds tests for the changed behaviour.

Jon Seymour (4):
  rev-parse: exit with non-zero status if ref@{n} is not valid.
  rev-parse: suppress duplicate log limit exceeded message.
  rev-parse: introduce get_sha1_with_gently
  rev-parse: tests that git rev-parse --verify master@{n}

 builtin/rev-parse.c            |    2 +-
 cache.h                        |    1 +
 sha1_name.c                    |   52 ++++++++++++++++++++++++---------------
 t/t1503-rev-parse-verify.sh    |   11 ++++++++
 t/t1506-rev-parse-diagnosis.sh |    9 +++++++
 5 files changed, 54 insertions(+), 21 deletions(-)

-- 
1.7.2.1.152.g499e.dirty
