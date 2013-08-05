From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG?] gc and impatience
Date: Mon, 5 Aug 2013 23:04:24 +0530
Message-ID: <CALkWK0=djXdPMOvk8359nOs=rGLbBepxyXnpELfWs+wjjN7YZw@mail.gmail.com>
References: <1rpxs5pa827iefbyduyodlc7.1375495435629@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Martin Fick <mfick@codeauror.org>
X-From: git-owner@vger.kernel.org Mon Aug 05 19:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Ogc-0007HW-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 19:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab3HERfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 13:35:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39408 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab3HERfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 13:35:05 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so6194437obb.33
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qWDl/GXMZmgO+jcRXCm+JHyiF5scYs8rSf4BM+IpC1k=;
        b=u82KhGBWu0M4F5RA4V4NORaQP1xmM87iebDJg0TTh5o8bMpjdsWpOIdFCk5UT8OTL1
         Vbm/k6VHaT2LqDH5yvGFuPgj9gS+yclnDNVc2skMjd8Anq919+e178/tdL1K4y3iGkkJ
         vAfYg/YRh8urp8HxvaspDHBhiWTuWnth1E8CqTsW+NsrbEPfDWDJ2qlYimglOAyZZx0r
         gGQvP6qz9p8YiZ3dqvVUJXqTsYOKy1Yq/K79uGzA0EMf7+LS4ODo/snmXdBPpXp5CrgU
         GLQ6QGaKzIEAo3k47vsRKD7otq9GOIYU+gG9Kyb3Kvh5B8IVasLoFhfUzxjGdQhCpeEV
         bzaQ==
X-Received: by 10.50.131.137 with SMTP id om9mr688716igb.55.1375724104224;
 Mon, 05 Aug 2013 10:35:04 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 5 Aug 2013 10:34:24 -0700 (PDT)
In-Reply-To: <1rpxs5pa827iefbyduyodlc7.1375495435629@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231681>

Martin Fick wrote:
> https://gerrit-review.googlesource.com/#/c/35215/

Very cool. Of what I understood:

So, the problem is that my .git/objects/pack is polluted with little
packs everytime I fetch (or push, if you're the server), and this is
problematic from the perspective of a overtly (naively) aggressive gc
that hammers out all fragmentation.  So, on the first run, the little
packfiles I have are all "consolidated" into big packfiles; you also
write .keep files to say that "don't gc these big packs we just
generated".  In subsequent runs, the little packfiles from the fetch
are absorbed into a pack that is immune to gc.  You're also using a
size heuristic, to consolidate similarly sized packfiles.  You also
have a --ratio to tweak the ratio of sizes.

I've checked it in and started using it; so yeah: I'll chew on it for
a few weeks.

Thanks.
