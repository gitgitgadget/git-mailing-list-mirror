From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [BUG?] retrying with "am -3" doesn't work anymore
Date: Wed, 30 Mar 2016 12:18:30 +0800
Message-ID: <CACRoPnSrKyNS8EdFM119TT9qoUTdNy_+P5q-7rWMahpDzzGAKw@mail.gmail.com>
References: <20160330021502.GA16077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 06:18:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al7aW-0000c3-9N
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 06:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbcC3ESc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 00:18:32 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34785 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcC3ESb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 00:18:31 -0400
Received: by mail-lb0-f181.google.com with SMTP id vo2so23617471lbb.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 21:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Kl2d6nFmYUz0AMnZAsl6Kiz+5GKiOr4nrh4nXB+VR64=;
        b=IFiasAQwDVMrMZSiFNYoFKRR7AFZGQ/DHUq/VQWnlz5Yhv2GBRplQfVCUeqtg0X9oq
         OGoYSQV4l4y69wD9atUxL9jhQ2nPB5RdDicb2avyH+m92lkzGEaomgsvht8LcmHUYBn/
         2AGHVkoh9CRunuCMoy5P9qMM657IOgFv4+FHfZEtPOX7ekMwW5Aw1liYHAIGi2wwLllP
         CazL+Rid0BEbSkTKhYBUBXWBBAB3SPvQQBO7q99Wvl7+OhUcz9uxZAq8lvdzpjxzP3JS
         we3wDnbZEdLy/qHkz94aTw8zN1opdD3Wp9EWAfiKXpfu3nC2WAcyqxGCDY/qajFRLQPD
         y8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Kl2d6nFmYUz0AMnZAsl6Kiz+5GKiOr4nrh4nXB+VR64=;
        b=QoqRLIRN1fAYASVe46fA3M5wVOKGHhtZvJHXkQg+lesnlmc4NeMXNGcsJYTTDxezoD
         DERv8XhLdoUBCUMquyd0ungfQIXjWOJBh8owwG4K73u2ReTSc3RFOqqiOQhHZyih04LD
         J7R1MY3FJLievNB2aLxaG5cbvuhaoI/YBY68ZXVdnUUfDb4UUM1x7YJXqJzg3cL/qRip
         I76ciJ7vSppjDWANmsj7/j3NQMxwCkyzbrsVjLbqCzyr3rr0hwAHaMxQClTTeskcg/CT
         a2sHYQ3CcJJLJ3VY5IyttVzNtDoejQgjfEB+Mh5U2YnggfJJMre3ilM0VvGmgreCRg9I
         mZdg==
X-Gm-Message-State: AD7BkJK1Fj2dQep4Ebhca2CmeJZukVVwyciy9792wCkL3t8eZhj8QOSSeJdpwRv+7CL9LWMhbxb3K8Brf4Ilqw==
X-Received: by 10.112.141.197 with SMTP id rq5mr2762897lbb.5.1459311510138;
 Tue, 29 Mar 2016 21:18:30 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Tue, 29 Mar 2016 21:18:30 -0700 (PDT)
In-Reply-To: <20160330021502.GA16077@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290267>

Hi Jeff,

On Wed, Mar 30, 2016 at 10:15 AM, Jeff King <peff@peff.net> wrote:
> I noticed that I could not get a patch from Junio to apply earlier
> today, and I think it is a regression in the builtin git-am
> implementation.  I had trouble reproducing with a basic test case,
> though.
>
> Basically, I picked up the three patches from this sub-thread:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/288987/focus=290222
>
> and tried to apply them on top of v2.8.0.
>
> Doing it with "git am -3 patches" works. But doing it with:
>
>   git am patches
>   git am -3
>
> doesn't. Bisecting shows that it did work before 783d7e8 (builtin-am:
> remove redirection to git-am.sh, 2015-08-04).

Yeah, with "git am -3" when resuming, the -3 will only affect the
current conflicting patch since 852a171 (am: let command-line options
override saved options, 2015-08-04).

Regards,
Paul
