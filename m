From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 10:36:29 -0800
Message-ID: <20130208183629.GA8461@google.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com>
 <7v38x766b2.fsf@alter.siamese.dyndns.org>
 <20130208074813.GA7337@elie.Belkin>
 <7v622343uy.fsf@alter.siamese.dyndns.org>
 <5114D5B0.5080906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:37:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3soo-0006va-14
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760098Ab3BHSgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 13:36:39 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35138 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab3BHSgi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 13:36:38 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so2213792pab.36
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=izZfU+fROFSs+wZEfKU1fDhDrvyQSIS9GGYAZJxgbZk=;
        b=RbZZXMpPgffojC1MceWtN8CrLob/naVIKcVd1hRnb+C5uY2PM6yNOneDbY4jXDtq83
         ZAvjOf0nQFcLwMjNMYb3Qss6TYKNxrtVzwBVeUqIVkPftFGZYMpYPWVKb8mQ18yebC0+
         oJee56ImvvxyejnO5uUTEdntuqM5iRvVFOKgH87jV0dPmQxSmlsSiLirKKeK5LrEb5Uf
         +VmQMgl88L/BjrSCENXQlHjSVlq+okfe4ub9jGG6vBxuMHfnXk8pwj7MvdwwhNXHSVTO
         sg6CrIMZPtG4APdttrG+kyX81MR5yKVk6AOPfI3rwW0814D2jZyAtdIUq7lzHI+X9PNX
         33cA==
X-Received: by 10.66.84.3 with SMTP id u3mr19524953pay.51.1360348598000;
        Fri, 08 Feb 2013 10:36:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id m3sm56345584pav.4.2013.02.08.10.36.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 10:36:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5114D5B0.5080906@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215799>

Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 08.02.2013 09:16:
>> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> "Wait, why did the remote rewind?"
>>
>> Oh, I am very well aware of that glitch.
>>
>> "git push" has this hack to pretend as if the pusher immediately
>> turned around and fetched from the remote.
>> 
>> It shouldn't have been made to do so unconditionally; instead it
>> should have been designed to give the pushee a way to optionally
>> tell you "I acccept this push, but you may not see it to be updated
>> to that exact value you pushed when you fetched from me right now".

Yes, I agree with this.

The "git push" hack does seem to be useful in practice for helping
people just starting to use git.  If they have a separate "gitk --all"
window open, they can refresh it and see the remote-tracking branch
corresponding to the branch that has been pushed advancing.  It matches
a model in which remote-tracking refs represent "git's idea of where
these branches are in the remote repository".

And in that model, a remote being able to respond to a push with
"ref update queued, but please keep in mind that it may take me a
while to chew through that queue" should be perfectly reasonable.

[...]
> And this seems to be more natural, too. It can keep the internals (the
> auxiliary ref on the server side) hidden from the user.

Just to clarify: this is not an internal ref being exposed.  No
auxiliary refs/for/master ref actually exists.  The ref Gerrit users
push to is a UI fiction.

That's important because otherwise two developers could not propose
changes for the same branch at the same time.

Jonathan
