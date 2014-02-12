From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 10:34:24 -0800
Message-ID: <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 12 19:34:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDedi-00030M-H2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbaBLSe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:34:26 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:61830 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbaBLSeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:34:25 -0500
Received: by mail-vc0-f175.google.com with SMTP id ij19so7258042vcb.20
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fsvDP6HOHpCr8T/1GXmQ1S6Fk3naLJ2pRvGr60Lwhbs=;
        b=m0CCbBECSjHZYCwLOlDCApmXT2++akHfenFKzp5ypzJ6FqFRFUHuAC6+ehfOAlIZzw
         AZf1Xv5sTvO8ChO3FUGdqqUk+thqUlePiXFctVT5BcGGw8a61hrRvvJU1ayif1JVoVxa
         F2syvXjreeCDGDZnp/bC1iKrHgwBKdtOBZ3qwFPUYcu1IwvsXpAwfvYiX61rfdzYDeUh
         RH7W2KcgWf3t5akYAxirXiEZf5ceaeDRl4Dh5v+hUxOvyDly0hhCA33y13K1b8LFHz23
         a2K0GWRX0A6+U+JqGMbKd2FbcVGrauwPVuGcDEwh9zPkWm20oBqgc4UUd+4+q6cBrDHR
         oVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fsvDP6HOHpCr8T/1GXmQ1S6Fk3naLJ2pRvGr60Lwhbs=;
        b=LyzSQMqMkWAt2tzbT1zxZJs/4jl2XGNFMvdM/RLWI4R5ky7k2/DFYb5e3unvOd307f
         FrMJVMVi+JTPt1K1lZlTBAFMgB2lxXPkBfsB3DtEJaNBhzShOLsu+XMJTlqqew5J3Dyk
         AykqhMlGgXG7RzH6y9DHbLNs7RA5wSBS9jDbxVN1S0oSoGnmRzy7IH+IzRn7BmmnwHpH
         XgOuvtoUg/LoN6tXbXch8HXuj1bLiegNlWR6eXweQcZJ4/EGQAdT8YCFJsH+7+tgy7K4
         BnGWyvmfNDErEnytF6yGCr4qIQ0s0lEFCJfdFwPN7iiFXHN0jxsGdoRU2iTRi0LB8WXe
         g7sg==
X-Gm-Message-State: ALoCoQnZZ3IcmIpGp40TSgVZFH/Rdj9PFurZg6Os2KBO8XrM3wxVEvcBgrOiWIGxA+Hr1RxaVk7Bd2NHfeq4JyXF60Ev3oK2L7esy8aLk3Ekue1PZK9in/XsvrfXXQsSEFD6dMQmLpksSgNxmb6mGnThPMWq9+4zucVSndF5aSqwH551EYc9/1ve2IgYi2D1Pz1osiLBLna8
X-Received: by 10.221.29.196 with SMTP id rz4mr33882954vcb.8.1392230064670;
 Wed, 12 Feb 2014 10:34:24 -0800 (PST)
Received: by 10.52.168.226 with HTTP; Wed, 12 Feb 2014 10:34:24 -0800 (PST)
In-Reply-To: <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242006>

On Wed, Feb 12, 2014 at 10:27 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Wed, Feb 12, 2014 at 7:20 PM, Stefan Zager <szager@google.com> wrote:
>>
>> I don't want to steal the thunder of my coworker, who wrote the
>> implementation.  He plans to submit it upstream soon-ish.  It relies
>> on using the lpOverlapped argument to ReadFile(), with some additional
>> tomfoolery to make sure that the implicit position pointer for the
>> file descriptor doesn't get modified.
>
> Is the code available somewhere? I'm especially interested in the
> "additional tomfoolery to make sure that the implicit position pointer
> for the file descriptor doesn't get modified"-part, as this was what I
> ended up butting my head into when trying to do this myself.

https://chromium-review.googlesource.com/#/c/186104/
