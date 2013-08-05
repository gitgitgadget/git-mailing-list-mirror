From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] gc: reject if another gc is running, unless --force is given
Date: Tue, 6 Aug 2013 00:07:43 +0530
Message-ID: <CALkWK0kZ=5TguAh9krAzFNuF0_sTRxcQKuZMnuQG7FQU0dJe=g@mail.gmail.com>
References: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
 <1375712354-13171-1-git-send-email-pclouds@gmail.com> <7vsiyoj932.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 20:38:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Pfo-0006bQ-Sw
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 20:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab3HESiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 14:38:24 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:35807 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab3HESiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 14:38:24 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so7126757oag.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w9zGDXj3wDQaZpaeg54JviZkPe6LKn2s1hmOaUuG2Mo=;
        b=LItJHAlEhYtOvNwU2dgP91boEw/mnwGVc9lDPRiIlv/l/q79+KAbbthABpGkkuB7Zp
         DU+8nUpeg+nYccmUHGZJkuQ742QDnys+0bMRraJrSSxydBkviFcPMGPos1KQcWus6dRE
         jcyqJPovJJHuC11d6Ne+8yOTtENUXwSrxBbTDC/SACQpMWaB9mBpHkg+Z77gYqJksIb2
         IW2NskefgujHOOZxrpi4GZiOJuxu3fsIcBI2NK7T6Z9KsDVntzm97MqORHDjL3u9sDt1
         adezV+ywr6saCYrFt9ld7CoB4wdAjlvZXf7Ue0qeq95rZBbTwAMvQSTTKVtfZvomdkrf
         iGKA==
X-Received: by 10.50.73.74 with SMTP id j10mr1209214igv.50.1375727903405; Mon,
 05 Aug 2013 11:38:23 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 5 Aug 2013 11:37:43 -0700 (PDT)
In-Reply-To: <7vsiyoj932.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231687>

Junio C Hamano wrote:
> [...]

The other comments mostly make sense.

> After reading what the whole function does, I think the purpose of
> this function is to take gc-lock (with optionally force).  Perhaps a
> name along the lines of "lock_gc", "gc_lock", "lock_repo_for_gc",
> would be more appropriate.

The whole point of this exercise is to _not_ lock up the repo during
gc, so I can do minimal commit/ worktree/ ref update operations when
it's running.  I can't expect the reflog to work, so complex
history-rewriting operations should be avoided; that's about it, I think.
