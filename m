From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 20:36:16 +0200
Message-ID: <CAHXAxrPcmOQaLaJ1FCzChKXCFvwa=O7ASS=YHb3m-rQzmO6Lsg@mail.gmail.com>
References: <20130226172504.GA2271@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 19:36:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPON-0006y0-8j
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 19:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607Ab3BZSgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 13:36:18 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:46328 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab3BZSgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 13:36:17 -0500
Received: by mail-qa0-f44.google.com with SMTP id bv4so2701974qab.10
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=T2si/VT3sSd0UnC1SVsFWUKh3DKe8a/dXOTnkREWlAg=;
        b=zlX/Ou4ktxS4rlNgYhsPEKJ3hM29xWt6UTVEuNaMDFa1/R93HtSuGMaY6M3Wv/NQOj
         10Unfwouh8LeAEVNXMaYX8teJu5yGsmRM7Jj8Gj+sqt+/GtK4MHNmMOwGJE7JR583NkE
         +17mZZGjmWVGDOKr0f+sCNjdsUK18sS/CSwO3yep4nmWk0o/kR2wQnly9tHjgclgnb93
         HPr+qWSVqXNonD+XXgANApIUf8qPo3Mj5+v0Z5lIeSEWxqWOxeyMzS+D/ytxJSwOY6lE
         LqPkdXboXNJfryn2idWdwW8nhASN8og1jlj4ffsI7UJ056BEAwNYNNgk0TZxVMzaixul
         W9wA==
X-Received: by 10.229.107.33 with SMTP id z33mr4535690qco.144.1361903776315;
 Tue, 26 Feb 2013 10:36:16 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Tue, 26 Feb 2013 10:36:16 -0800 (PST)
In-Reply-To: <20130226172504.GA2271@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217156>

> Is there a point to the version checking?  I don't know that anyone
> has tried to build Git on QNX 4, so adding a case for it seems
> misleading.

getpagesize() was introduced in QNX 6.4.1, it is present in QNX 6.5.0
also. So at least for this version checking is requied.

> I didn't realize that QNX 6.3.2 provided getpagesize.  Its header
> files don't provide a prototype, so when I saw the warning, I assumed
> it wasn't available.  Since NO_GETPAGESIZE is only used by QNX, if
> it's OK to reintroduce the warning, NO_GETPAGESIZE might as well be
> removed entirely.

David asked to leave NO_GETPAGESIZE for other platform.

> I don't think it's a good idea to just enable thread support.  On QNX,
> once a process creates a thread, fork stops working.  This breaks
> commands that create threads and then try to run other programs, such
> as "git fetch" with an https remote.  If threads are enabled, I think
> that the uses of fork need to be audited and, if they can be called
> after a thread is created, fixed.

Do you have a testcase for this (without using git codebase)? I wrote
numerous resource managers since QNX 6.0 using threads and fork()s for
daemonization in different order and never experienced a problems.
There can be issues with pipes in case of external command run.
