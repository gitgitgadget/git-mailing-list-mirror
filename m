From: Michael Mueller <mmueller@vigilantsw.com>
Subject: Possible segfault introduced in commit.c
Date: Wed, 25 Apr 2012 00:59:28 -0700
Message-ID: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 09:59:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMx8R-0004dp-Gk
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 09:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380Ab2DYH73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 03:59:29 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:37556 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2DYH73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 03:59:29 -0400
Received: by qatm19 with SMTP id m19so3345472qat.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 00:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=pupceaweSuhxXqPJQIXT6pChWwyFowI0BRs9DvGod/c=;
        b=TmfOQDOdUoRNS7kcBHBC0eXwMXY6OFVL4zAL9+s27cVc7O+2ONkrG7GsbMyoN6C1Iv
         mu2N63g011JmEWlhOkBVbZABxREFaG8bdDxLiZrZGqVLMdNkHiIaO7xTrlMqM2aN0m85
         UODdNUmMHQ9huMHsv7rTVdemAgcBXsPeL8BCSXY8t0lQ6T/l2h5ANzU7NyzEINXcV3oV
         MBWZm2VIdV0zO6V+IyYWEMTUmT0quZGK+UcYiVf5rc0sXSLuJhYM4OzDVzMCYruRClv0
         yd7fGNrCou3DhvPPlcNF5EURbmoZeJtj1yX+gNaMeJs4ouBhl23i/Is63GreeTmBsECd
         wyGQ==
Received: by 10.224.111.67 with SMTP id r3mr1326413qap.36.1335340768208; Wed,
 25 Apr 2012 00:59:28 -0700 (PDT)
Received: by 10.229.15.139 with HTTP; Wed, 25 Apr 2012 00:59:28 -0700 (PDT)
X-Originating-IP: [67.180.177.185]
X-Gm-Message-State: ALoCoQmLpq/DE6lFHcqfMJJS5oOYb7wmXav4/qI7039Ed7Z0PnG4FgWwVxTeH3QKECgB2J9iyP3V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196300>

Hi all,

As you might already know, we analyze git regularly with Sentry (our
static analysis tool).  Today it picked up a new NULL pointer
dereference in commit.c:366:

    void commit_list_reverse(struct commit_list **list_p)
    {
        struct commit_list *prev = NULL, *curr = *list_p, *next;

        if (!list_p)
            return;
        /* function continues... */
    }

list_p is dereferenced on the first line, then tested for NULL on
the very next statement.  If it's possible that list_p is NULL, this
will be a segfault.  If it can't be NULL, then the check is
unnecessary (and probably misleading).

Introduced here:
https://github.com/gitster/git/commit/fbc08ea

Best,
Mike

-- 
Mike Mueller
Phone: (401) 405-1525
Email: mmueller@vigilantsw.com

http://www.vigilantsw.com/
