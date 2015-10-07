From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 38/43] refs: make some files backend functions public
Date: Wed, 07 Oct 2015 10:20:55 -0700
Message-ID: <xmqqk2qyvbm0.fsf@gitster.mtv.corp.google.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	<1443477738-32023-39-git-send-email-dturner@twopensource.com>
	<56123CE3.9070909@alum.mit.edu>
	<1444181145.7739.70.camel@twopensource.com>
	<56154194.9050607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 07 19:21:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjsOj-0008PG-M0
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 19:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbbJGRU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 13:20:58 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33697 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbbJGRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 13:20:57 -0400
Received: by pacex6 with SMTP id ex6so27049650pac.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DFlDkn4igEUra1BiTeZJoxxpkSqKUsWRtgkCLoMMx6s=;
        b=jVuUb7/h8P99ObfDdvd5ZdLb0j8GheXXISwhdseCfJomXhFSo2MbIUQRvJDXVd4Nun
         2Gmwm0UzLFLMByW146L+QGKGDMwlK3yIBMpLPhOQOiuLhcpK0Embjg28zMkjgn0LsiYu
         6lJt0mFm2pS2T0PYEjnEw3zEuHPj1MLK0oUSDIxAAArFJ1aaxiCl/chDy9Rxv7I0+m5C
         yp2RYKY12t17yr3TPR60Qu3mZNICPusSe8L2Ws9Du4D1MkRASkubYNM5Se5S2Ta0FEqW
         0VcaPBvRDyRV0Lh+4qOLK0yOZ9Ufbsn7FOjZoAeutcLwrVXWByBRj1MsAFc+rW4K1GW2
         9ITg==
X-Received: by 10.66.230.137 with SMTP id sy9mr2374575pac.154.1444238456725;
        Wed, 07 Oct 2015 10:20:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c434:fdeb:15ec:325c])
        by smtp.gmail.com with ESMTPSA id cn4sm40505826pbc.94.2015.10.07.10.20.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 10:20:55 -0700 (PDT)
In-Reply-To: <56154194.9050607@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 07 Oct 2015 18:00:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279186>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Right now, for cross-backend reads/writes, the lmdb code cheats. It
>> simply does the write directly and immediately.  This means that these
>> portions of transactions cannot be rolled back.  That's clearly bad. 
>
> That's a really good point.
>
> I hate to break it to you, but the handling of symrefs in Git is already
> a mess. HEAD is the only symref that I would really trust to work
> correctly all the time. So I think that changes needn't be judged on
> whether they handle symrefs perfectly. They should just not break them
> in any dramatic new ways.
> ...
> If everything that I've said is correct, then my opinion is that it
> would be perfectly adequate if your code would handle the specific case
> of HEAD (by hook or by crook), and if there are any other cross-backend
> symrefs, just die with a message stating that such usage is unsupported.
> Junio, do you think that would be acceptable?

I find it a very sensible approach.

> BTW I just realized that if one backend should delegate to another, then
> the primary backend should be the per-worktree backend and it should
> delegate to the common backend. I think I described things the other way
> around in my earlier message. This makes more sense because it is
> acceptable for per-worktree references to refer to common references but
> not vice versa.

Sounds good.

Thanks.
