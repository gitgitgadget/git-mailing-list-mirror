From: Jay Soffian <jaysoffian@gmail.com>
Subject: fast-import [mis?]-honors core.ignorecase
Date: Mon, 25 Jun 2012 16:48:36 -0400
Message-ID: <CAG+J_DygPXtjD-0gv8XXpV0JErw_jpwRLOZ00H9bem5hN8g7ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 22:48:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjGDB-0001Cr-Tk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 22:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753Ab2FYUsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 16:48:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59732 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722Ab2FYUsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 16:48:37 -0400
Received: by pbbrp8 with SMTP id rp8so7056802pbb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HXW+TtpR0ZUzMAH75LtHJCioZYH13txNf2DaWFn5QYQ=;
        b=byP3qc3lR0VqwSwYLn6AQN1mXYxeonUT6WtfA+LM/SyRIs7W4lSYYN3l0tFn1hOCcm
         6cn9MEuifjz+120r+dnlndr4gSym9sbjDO1/4YL7WJEnS5wYz6Kv/2Bf7qCkomyg3Hrx
         HpeV3FiTqKywVWB/UxqPLxppQ6V+vAu8xRTCb5jDV49OGKJJlMusU2WTAuoi9WKWi+um
         3/AAZ1S72/Zh6ArDzFypbmHXPPmgzb19YkPVuxtUyDcXVAwjQgrTsNGrg5j9dKO5SZKr
         MEjp/W8bSjLvmbvbnVJ7ITATMxzeWHxRtjMbYI/RU1JH7xzy9K0FrvAhm2yzNBr+5IaT
         NUOQ==
Received: by 10.68.239.164 with SMTP id vt4mr43167556pbc.166.1340657316980;
 Mon, 25 Jun 2012 13:48:36 -0700 (PDT)
Received: by 10.66.236.168 with HTTP; Mon, 25 Jun 2012 13:48:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200597>

I was using a "fast-export | <filter program> | fast-import" as a much
faster filter-branch --env-filter (I needed to rewrite
author/committer email-addresses) and was surprised that after the
pipeline was done, the new ref's trees didn't match the old ref's
trees. i.e.:

  $ cmp <(git log old-ref --pretty='%T')  <(git log --pretty='%T' new-ref)

didn't return 0. Comparing one of the differing tree-pairs indicated
it was due to a case-difference in a file which had been renamed.
After some experimenting I finally tracked this down to having
core.ignorecase set to "true" on the repo in which I was running the
pipeline. By setting it to "false" the filtering pipeline completes
with new-ref (and all its ancestors) being tree-identical to old-ref.

Is there any reason for fast-import to honor ignorecase?

j.
