From: "Chris O'Kelly" <chris@mapcreative.com.au>
Subject: Re: Feature Request: provide cmdline args to git hooks
Date: Wed, 15 Apr 2015 10:21:39 +1000
Message-ID: <CAM-hpQf2hzjufYxmc2uGUhoqn3JVnwwcoOPOnya4MJbCnjkg3A@mail.gmail.com>
References: <CAM-hpQcgOgrAJBAZrH4icDtJMiHUYOz1tynYkoj7qzyVMZ0eVQ@mail.gmail.com>
	<xmqqwq1e3fy4.fsf@gitster.dls.corp.google.com>
	<CAM-hpQcowcRaRMnYcZD8oUDep-nSw1e4Sy3CHjCojpQd=238Ug@mail.gmail.com>
	<xmqq4moi1dej.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 02:23:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiB6o-0005vd-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 02:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbbDOAVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 20:21:41 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36984 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbbDOAVk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 20:21:40 -0400
Received: by igblo3 with SMTP id lo3so28853337igb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 17:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VOFEHosGeUT/HT4dzgWals+eI6otdBEJEQ1buGOvgow=;
        b=TlVb1reppqSd20VdmZquZTRskaRGzT0utCK9LpxlZLrSP1ZJlA9pkdGuXZe3UYw0s1
         OCoZUE8/zvDHsaWkzPEBG2t9mhxY2otf+FeyCJ3TghNjwioupbLlSRG97S6yOLTzUUWh
         u/LnDgv+mlOoZR4I06lJM8oUFukN7dMCCudzBnmxBULyZZrgZKWN3lulO7hMIb24fpIc
         8w/hhRCGyq6lLBCD2DY7FEeZpuGSqSBE6A6w9fDMkLZ/OvT9VZywvVnaV/Fbtbhhum8K
         uCkW7JbV8kYIR/ShXScer1qY2kmuzRtIKiNe7GJ0N+MGZ6SoIPDB25S8wh1HtVdm1B08
         y1gw==
X-Gm-Message-State: ALoCoQlwLCC+37aA+ZTJhAyfD/XFC5pNcRQK070gNImg/VaRuZYArOdcyKafHVRCzoW6kZm4qh/c
X-Received: by 10.50.141.164 with SMTP id rp4mr28376385igb.2.1429057299672;
 Tue, 14 Apr 2015 17:21:39 -0700 (PDT)
Received: by 10.64.76.84 with HTTP; Tue, 14 Apr 2015 17:21:39 -0700 (PDT)
In-Reply-To: <xmqq4moi1dej.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267177>

> I do not offhand know (I am on a bus with terrible connection so I
> won't bother checking the source now) if we send "this ref has to
> point at that object" even for STATUS_UPTODATE cases, to cause your
> remote to trigger the receive hook in the frist place, but if that
> is the case, then the code in run_pre_push_hook() that omits such
> refs from the hook input looks just *wrong*.  On the other hand, I
> do not offhand think of a valid reason for the push codepath (with
> or without the pre-push hook) to send "this ref has to point at that
> object" when we know the ref is already pointing at that object, so
> I am not sure if your claim (i.e. "when ... was already pushed
> previously") is true for a correctly built receiving side of Git.

No I totally understand that the pre-receive is the ideal place to do
it, and I can see that it's not feasible to rework how pre-push was
designed if it was specifically made not to handle this kind of
situation. In a perfect world I would just remove/modify the
post-receive hook causing the undesirable behavior, but I work within
the restrictions of my environment. To reiterate and clarify I'm not
saying the undesirable behavior is a built in part of git, just a
feature of our hosting platform's Git deployment mechanisms, although
if what you mean is that the post-receive hook on the receiving end
shouldn't be getting passed pushed tag refs that the local git
believed to be already up to date on the remote (as of most recent
fetch), then yeah... that is weird because it seems to be the behavior
in this case.

Anyway it sounds like the answer here is that it really isn't a
feasible task in a client side hook, and we should stick with the
current solution of "Don't use the GUI to push to Live" for now, which
is fine; I should probably stop trying to script around every single
problem anyway (https://xkcd.com/1319/).
