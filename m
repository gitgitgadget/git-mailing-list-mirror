From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 23:59:28 +0530
Message-ID: <CALkWK0nYRiPLnBXFarp8UzZgGvA5Y6motvr5HMFy56ANr161HA@mail.gmail.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com> <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com> <7v38x766b2.fsf@alter.siamese.dyndns.org>
 <20130208074813.GA7337@elie.Belkin> <7v622343uy.fsf@alter.siamese.dyndns.org>
 <5114D5B0.5080906@drmicha.warpmail.net> <7vobfu3ev3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:30:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3siC-0001HZ-O0
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946782Ab3BHS3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 13:29:50 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:58598 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946611Ab3BHS3t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 13:29:49 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so4395261oag.9
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MvLmVmUOR+7Nv5M8+dT/QiYYaZt1vqbl+H2hW7/w6SQ=;
        b=NMsJBrxG3Yqn5JN1IdBme5Ngkcj70nsGO5pybuHdWMOboxkc6NQJraaf32gM5dpJOx
         WSP9+wDF5KyUAxgQkykQUY4mag/HiR98vJI8w1zuHspHQOx/TPzxkd8hQLkga+4cpOHE
         vSc9/Vic+V90NJuf5+eSTh/UMBB1FGo9QFONs2WGt07tARPx5XKuTogHQodNP5/Cux6D
         AVu+TVGW64MRWja8X/fLLa22vy27/kXNATwARs92xGUlyp1rPeuVNcIy6IqZ6L11Q3+m
         hnBUM/8pg83OY6u19weWeJFfyclHKCK/C7DndmV1HyFLMGbBJ/lzynW2+PFmUc1kDt6y
         07jg==
X-Received: by 10.60.22.198 with SMTP id g6mr5070768oef.45.1360348188904; Fri,
 08 Feb 2013 10:29:48 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Fri, 8 Feb 2013 10:29:28 -0800 (PST)
In-Reply-To: <7vobfu3ev3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215796>

Junio C Hamano wrote:
>         [remote "origin"]
>                 url = ... where Ram fetches and pulls from ...
>                 pushurl = ... where Ram pushes to ...
>                 fetch = refs/heads/*:refs/remotes/*
>                 updateTrackOnPush = no
>
> Then "git fetch" (or "git pull") will update the remote tracking
> branches Ram fetches from, and once his topic is finished, he can
> push to his publishing location, which won't touch the remote
> tracking branches used to keep track of the place he fetches from.

A "push" should never touch remote/refs/origin/* if there is a pushurl
configured.  Otherwise, it should.  I want my push to affect my
status.  The configuration variable makes no sense and should not
exist.

Unfortunately, pushurl doesn't get the same privileges as url even
though they're equal remotes.  How is my fork "inferior" to the
upstream project in any way?  A lot of us might be working on this
fork, and we will need something corresponding to refs/remotes/* to
inspect its state.  Like I said earlier, I think pushurl has a very
limited usecase: when the two URLs are actually mirrors (there is
really no fork; we're back in a centralized environment).  In fact, I
think it should be deprecated, because it interferes with my more
general approach.

Let's see what happens if we have two actual remotes.
remote/refs/origin/* will be updated when I fetch from, and push to,
origin.   remote/refs/ram/* will be updated when I fetch from, and
push to, ram.  It's very simple, and I don't need this complex rule of
when to update refs.  We should have a way to pair remotes together as
upstream/ downstream in the future.  Maybe even have a hierarchy of
remotes.
