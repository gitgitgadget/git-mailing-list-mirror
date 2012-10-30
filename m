From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 11:12:24 -0700
Message-ID: <CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com> <1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGJf-0001Mt-6S
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288Ab2J3SNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:13:07 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36909 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965248Ab2J3SNF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:13:05 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2370389qad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8G3xkjXKDhzhUci8hi+QzIpMLq0nlicP+cNSE+dC8Ew=;
        b=fxUBJPqwk0UDsvPRbIdCYV0vSlaKf5qg7oa1drwjCW/Eaz077EEEZNPjd4KvAkjDM6
         1fQuF+PheMXpETI69L8hZ3j+/nHXGS3niHsTu3rp0y1dmvoK4nOsyN2defv2BNOvPQZ1
         1Vh2+aNOgIobc1u1Vu1GEx2Ci9asWNWTTk6PYwt3suP8hUNotjOIsynmgKT2HDx79UPz
         Dz5FrJEZ/NiKvl3fW8eOgrWkszQxKi0rMligo+PIovcjPt6UjF8dtwSi0rlc58WPBXRW
         ERvw33VQ/fzWYppz3ik9FS5xxvRA0p7Zc9HdwZxrYp12wvrySIHq3QA7ZtJVWXjlplBk
         t5PA==
Received: by 10.224.178.16 with SMTP id bk16mr5104812qab.59.1351620784848;
 Tue, 30 Oct 2012 11:13:04 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Tue, 30 Oct 2012 11:12:24 -0700 (PDT)
In-Reply-To: <1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208717>

On Tue, Oct 30, 2012 at 10:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> When an object has already been exported (and thus is in the marks) it
> is flagged as SHOWN, so it will not be exported again, even if this time
> it's exported through a different ref.
>
> We don't need the object to be exported again, but we want the ref
> updated, which doesn't happen.
>
> Since we can't know if a ref was exported or not, let's just assume that
> if the commit was marked (flags & SHOWN), the user still wants the ref
> updated.
>
> So:
>
>  % git branch test master
>  % git fast-export $mark_flags master
>  % git fast-export $mark_flags test
>
> Would export 'test' properly.
>
> Additionally, this fixes issues with remote helpers; now they can push
> refs wich objects have already been exported.

Won't this also export child (or maybe parent) branches that weren't
mentioned? For example:

$ git branch one
$ echo foo > content
$ git commit -m two
$ git fast-export one
$ git fast-export two

I suspect that one of those will export both one and two. If not, this
seems like a great solution to the fast-export problem.

-- 
Cheers,

Sverre Rabbelier
