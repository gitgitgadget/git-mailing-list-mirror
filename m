From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: is there a fast web-interface to git for huge repos?
Date: Fri, 7 Jun 2013 10:05:37 -0700
Message-ID: <CAPKkNb5PyurX1eNsCsckdfiwgM3dqb5KpN9OS0NpLZw1+VsSdg@mail.gmail.com>
References: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com>
	<20130607063353.GB19771@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul06h-0005IW-Dm
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab3FGRFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 13:05:39 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:39709 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab3FGRFi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 13:05:38 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so312086lbi.20
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WIDK04hgToh8+Si0FaDVVcvpbTxHKroGV9r0MjUF4SE=;
        b=WaWIjs02U8IBvLrACJhNJ/+hk2H/6jSyZWzON9yWhK1zl/Z4a3exScPAWf7Mbj9FeX
         dqq7Kvs3qGFFuh5Z8ymMWcSSCANgRvf5fwIK9+4494s4CT/dnvT84jKhptgdz7KDgXR4
         rS4vFEFvFUZRihz5GI2lxKMFD5SZoDIPa3IwHWNTwiRB7/8sM/REYZIUz+iH6rSi19p8
         Wa5JMs6CSTlCPr2N+9qHhmuWUp8UZ5B0HQL6pZzNJQEYxfrXZbCpwRmHfPdv2gvnbxZE
         WhGhThotprPKo7FxQnXv1IJE3oeQHF/llTrKHXMIG0aSZu9SXM/GgNjLPgl3y1Y0RU/8
         WhOw==
X-Received: by 10.112.143.34 with SMTP id sb2mr1650467lbb.37.1370624737317;
 Fri, 07 Jun 2013 10:05:37 -0700 (PDT)
Received: by 10.114.77.1 with HTTP; Fri, 7 Jun 2013 10:05:37 -0700 (PDT)
In-Reply-To: <20130607063353.GB19771@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226650>

On 6 June 2013 23:33, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Thu, Jun 06, 2013 at 06:35:43PM -0700, Constantine A. Murenin wrote:
>> I'm interested in running a web interface to this and other similar
>> git repositories (FreeBSD and NetBSD git repositories are even much,
>> much bigger).
>>
>> Software-wise, is there no way to make cold access for git-log and
>> git-blame to be orders of magnitude less than ~5s, and warm access
>> less than ~0.5s?
>
> The obvious way would be to cache the results. You can even put an

That would do nothing to prevent slowness of the cold requests, which
already run for 5s when completely cold.

In fact, unless done right, it would actually slow things down, as
lines would not necessarily show up as they're ready.

> update cache hook the git repositories to make the cache always be up to
> date.

That's entirely inefficient.  It'll probably take hours or days to
pre-cache all the html pages with a naive wget and the list of all the
files.  Not a solution at all.

(0.5s x 35k files = 5 hours for log/blame, plus another 5h of cpu time
for blame/log)

> There's some dynamic web frontends like cgit and gitweb out there but
> there's also static ones like git-arr ( http://blitiri.com.ar/p/git-arr/
> ) that might be more of an option to you.

The concept for git-arr looks interesting, but it has neither blame
nor log, so, it's kinda pointless, because the whole thing that's slow
is exactly blame and log.

There has to be some way to improve these matters.  Noone wants to
wait 5 seconds until a page is generated, we're not running enterprise
software here, latency is important!

C.
