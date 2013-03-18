From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] Support triangular workflows
Date: Mon, 18 Mar 2013 18:46:11 +0530
Message-ID: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 14:15:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZub-0003sO-3T
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 14:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab3CRNPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 09:15:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58389 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3CRNPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 09:15:07 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so6415548pbc.33
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=V8n7q3o/ZRPc6vVveJAP6NsqIvYWaKhxiLX/CFcb6z4=;
        b=NL7Y+TlbRmqVEkJPq+EjQ8f0OQTd8t61erwQrKXZWQG6BzzJRxHGxnXDi+qKAMdEWG
         3/E3fTi4FifcKUXGAhxn8l/hA1w1Lbn0QNhwLVGmfUbkosYv5HAaRyD9NzzLO+8cES1I
         BNp5hw4tEOcO1rC7/pZOKTl37iMMumDLS+iIOHmfXVQj8wlIIQHjo04S3emHMyuUBPVs
         wuw4sVnmv8WaoCFaUCC7rc4gdMiPVVY+kkDwH78+g2vxkcrD00V758TCbkfGm8LdHano
         PJ3agna5zc/kTK0JKhIGBSnYTdL5qLmjfzgYpFABEPVafGguvGlcH/iXhqOCDdoi0rjQ
         AW7A==
X-Received: by 10.68.11.135 with SMTP id q7mr32943809pbb.5.1363612506601;
        Mon, 18 Mar 2013 06:15:06 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y1sm20178280pbg.10.2013.03.18.06.15.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 06:15:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218410>

Hi,

This series follows up a previous discussion with Junio and Jeff [1].
It attempts to support the triangular workflow, where the remote
you're fetching from is not the same as the remote you're pushing to.
`remote.<name>.pushurl` has already been discussed, and deemed as a
poor solution to the problem [2].

[1/4] is a minor cleanup patch to make other patches consistent with
the existing style.

[2/4] introduces the infrastructure needed to allow [3/4] and [4/4] to
be simple configuration-adding patches.

[3/4] and [4/4] add the proposed configuration options.  They're very
simple patches, but the documentation is not so simple: I've
documented all the side-effects of the other configuration option in
each configuration option, to give the reader a comprehensive picture
when reading one configuration option.

I've put off implementing remote.default corresponding to
remote.pushdefault, as Jeff suggested in [1], because it's currently
not an itch; apart from the obvious symmetry, I don't know what
purpose it serves: why would anyone want to fetch from a remote other
than origin by default?  Why wouldn't they simply swap that remote's
name with "origin"?  However, it's a nice thing to have for symmetry,
and it should be trivial to implement: any interested person is
welcome to pick it up.

The series works as expected, and all tests pass.

Thanks for reading.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/215763
[2]: http://thread.gmane.org/gmane.comp.version-control.git/215702/focus=215717

Ramkumar Ramachandra (4):
  remote.c: simply a bit of code using git_config_string()
  remote.c: introduce a way to have different remotes for fetch/ push
  remote.c: introduce remote.pushdefault
  remote.c: introduce branch.<name>.pushremote

 Documentation/config.txt | 23 ++++++++++++++++---
 builtin/push.c           |  2 +-
 remote.c                 | 60 +++++++++++++++++++++++++++++++++++-------------
 remote.h                 |  1 +
 4 files changed, 66 insertions(+), 20 deletions(-)

-- 
1.8.2
