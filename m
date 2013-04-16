From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Wed, 17 Apr 2013 01:53:21 +0530
Message-ID: <CALkWK0=JdJGf7+yWvi2xkoruixK5G5mnQXm8pFhK60NQB2qX0Q@mail.gmail.com>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com> <7vmwsyl3mv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCQC-0000a6-3k
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959Ab3DPUYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 16:24:03 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:35123 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3DPUYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 16:24:02 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so800217iah.31
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=isR4zkEdFNdB2rw8Uwxepqr6VxLWNWteXGfcC44ZBmM=;
        b=mrej5Wi3EupHXVTMU4P/GZI3zXBMyxN7zS8M4J8hlmmzgSLNIJVCwvO3MDJJczw/oc
         TNXfRj8GbQn2SDb+T/ZOsdR1A4v1x7LOz8fK3deYaFO2mmLKD5JVe5veEBjnlDEhfkHr
         eelvc4WrnGYJ+2LkuGQ3IJy3SbYPT1gLUB1YO+CK4o7uyl2iYcevq2047eK2QDk8wLVs
         848tzdKHIg5y6Sk17/YpzJZohywEVFxuqRrqByVoRF/gFj65+ioU/LyhnoExnTvnEyWG
         CoI3okPT8rjyL/7RBw7tU6dB/rk/15M9hFshjptULiqoSk7fXZasv4V2wr7Ixtrm4xcS
         6QMw==
X-Received: by 10.50.17.71 with SMTP id m7mr2412879igd.14.1366143841273; Tue,
 16 Apr 2013 13:24:01 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 13:23:21 -0700 (PDT)
In-Reply-To: <7vmwsyl3mv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221464>

Junio C Hamano wrote:
> I do not think anybody considered the approach to look at the commit
> object name and making sure it appears in the reflog that implements
> the stash. It sounds like a more robust check if done right.

Actually, if you think about it, there is really only one way to
specify revisions in the stash's reflog: stash@*.  Since these
commits don't have to be reachable from any refs in the general case,
all the other revision syntaxes are useless.  So, I would argue that
"${REV%@*}" is sufficient and correct*: anything beyond it is an
unnecessary overhead.

However, the initial bug is still valid:  show should not show
something that pop cannot operate on.

* although I'd have been more comfortable if we had a neater way to specify that
