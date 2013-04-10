From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 18:49:14 +0530
Message-ID: <CALkWK0=St08WGD82JqGpW7ZVrtv0RU8=X9kUqzYb+6Jm8X63aw@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net> <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org> <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org> <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 15:20:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPuwT-0001WX-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 15:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab3DJNT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 09:19:57 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:44450 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab3DJNT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 09:19:56 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so487571iec.13
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BXmqFb4dbg/oB2NP09D70VRezYC0uaVV6tdBil9udsw=;
        b=u2Mqc4Vcuxk+qshdyOXbNdsGsxBsojbwJ5bH2/AI0G634q7pq8eYfIb1e+3QDXbkha
         CT1qsQUL+ZsHdo2UPXWLl+py18GdFyrJWHOUxT6c0bRDy8mrxgvf9i+Q8ThEiN9F9bvf
         A8OwAhMtF1Z8J27VJk1KlKVYzxDsmwstlEPmpaFLzAV5uHWFdwgGtZ7HwvOsI/1jRjY8
         XP7OElIGxNeBsqKaWPKN6FkJq2GM5XwzUA3t1sLc23NYDz5PkGV+zdmdFb9LE2OU8zcA
         CIMIe1O0VjIanBb//0uoHzjr2mwRPhzbOi04SHfUFugUiKYNEX9WkrLjdeT2KSoznW5M
         vH8g==
X-Received: by 10.50.117.3 with SMTP id ka3mr12542338igb.107.1365599995805;
 Wed, 10 Apr 2013 06:19:55 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 06:19:14 -0700 (PDT)
In-Reply-To: <20130409231332.GZ30308@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220686>

Jonathan Nieder wrote:
>         git push origin korg -- master; # push master to 2 remotes
>         git push -- master next; # push two refs to default remote
>         git push origin -- master; # push master to origin, more explicitly
>         git push origin korg --; # push default refspec to 2 remotes, again

I definitely like the idea of using -- to disambiguate, as it is
consistent with existing git commands (that are internally using the
rev-list machinery).  However, I disagree with the idea of being able
to specify multiple remotes: what does 'git push A B -- master +next'
mean?  Do I know that master and next are present in both A and B?  Do
I know for certain that a force-push to next won't wipe any data on
either A or B accidentally?  As the number of remotes and refs
increase, the amount of information that the user must know about each
of the remotes is simply huge.  Therefore, I think it is unnecessarily
confusing and unnecessary.  Moreover, it can easily be achieved in
shell, and there is no advantage to supporting it in push unless we're
doing something like a parallel push.

>        git push host:some/path; # ambiguous argument. Please disambiguate.

Regression.  It should just treat host:some/path as a destination, not a ref.

>        git push origin; # is a remote name and not a refname. Good.
>        git push master; # is a ref name and not a remote name. Good.

This is what I finally want.  With your -- to disambiguate, the logic
for doing this has been simplified greatly.
