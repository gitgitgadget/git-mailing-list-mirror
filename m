From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH RFC 0/8] introduce 'git remote add --push' and 'git clone
   --push'
Date: Tue, 21 Jul 2009 12:33:54 +0200
Message-ID: <4A659992.4020906@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org> <7vprbvt30u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Finn Arne Gangstad <finnag@pvv.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 12:36:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTChF-0004rT-CO
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 12:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbZGUKeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 06:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755036AbZGUKd7
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 06:33:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:32040 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbZGUKd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 06:33:58 -0400
Received: by fg-out-1718.google.com with SMTP id e12so676961fga.17
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=mItbByj7n25JIaTXLrfS6c6mzkuxOO1fElN+7qptLfA=;
        b=luJw6ZuemZmo8z+j4/SSwVtSrBEXniJThaBwaHATAfMh+qycVrs9EMS78jnnIbvzUY
         Stzu2zYcIwQbQudBe60Yf8mIG+Ra6HifUn3wt0/UjJQrenAN5ed+DxrqumomYJRhGWnt
         8dbWQenthWPowO7544PeAG8yUEkiipwIFKB3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IFzTy5XW1t+cyj8dmiq1W3/1OanDEnGgT4OvcMzQVcEFiFE6DKKE1kvn85lz9LRJnU
         sw1UZv1YnUQ9vHwFE7fNQBjYT9aWtXWgBa6zK7kQjc6rwYfexcCmD1FUAIAql3JApsq6
         pjcfMnCc1/rpwwXDQbWYVq819AqPedyWBMF6I=
Received: by 10.86.25.19 with SMTP id 19mr4407381fgy.71.1248172436891;
        Tue, 21 Jul 2009 03:33:56 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id d4sm7450645fga.7.2009.07.21.03.33.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 03:33:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <7vprbvt30u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123656>


> If I have a local branch X, is it conceivable that if I ever want to push
> it out to elsewhere on a regular basis, I would likely to push it to the
> same branch at the same remote?

Yes.  The exception could be if you push to multiple remotes---but in 
that case, you have to issue multiple push commands anyway.  X -> (R,Y) 
is not a function, but (X,R) -> Y is.

> Are these all?  What I am trying to get at is if we can tweak the rules
> without introducing too much configuration variables to cover all these
> cases.
>
> Traditionally, we said:
>
>      $ git push $there $ref
>
> is _always_ a shorthand for
>
>      $ git push $there $ref:$ref
 >
> If we somehow tweak
> this "$ref is a shorthand for $ref:$ref" rule to account for the tracking
> branch.*.merge gives us, perhaps we can make the push easier to use.

This is nice indeed.  My questions are:

1) can we assume backwards compatibility is not a problem?  Or, in other 
words, would this be 1.6.5 or 1.7.0 material?  In the past, the list has 
usually been very cautious about that, but if there's good reasons I 
guess the answer can be "yes".

>   (4) "git push" is a synonym for "git push R" where R is the value of
>       branch.X.remote, or "origin" if there is no such configuration.  This
>       will in turn trigger rule (1) above.
>
>       We could optionally make it a synonym for "git push X" (where X is
>       the name of the current branch), which would invoke rule (3) above,
>       which in turn would invoke rule (2) above.  Perhaps "push only the
>       current branch" option in the configuration, or "git push HEAD" from
>       the command line, would trigger this alternate behaviour.

[i.e., looking up branch.*.remote for the current branch].

2) if I understand correctly, then "git push HEAD" would behave like 
push.default=tracking rather than push.default=current.  If so, how do 
you provide push.default=current behavior?  (Or maybe you don't care).

Would this apply to remote.*.push = HEAD too?  (I think so).  Are the 
backward compatibility issues stronger in this case?  (I also think so).

3) if the previous item turns out to be a problem, should we invent a 
new kind of refspec?  "HEAD:" is free to use, is it a good idea?  (I 
don't like it).

4) From an implementation point of view, how well will it fit the 
existing code, or rather will it have to be special-cased all over the 
place?  I already didn't like the single special case I have in the "git 
push --current" patch, though I think it's unavoidable.

> I think one of the workflows quoted as the original motivation of Finn
> Arne's series that added push.default also falls naturally out of this.

That's true, and I actually liked the idea very much.  The fact that it 
raises many questions is not necessarily a point down---adding new 
configuration keys is definitely simpler to flesh out, but it may be 
that it only reaches a local maximum of simplicity/expressiveness.  In 
my case the combination refspec/autosetuppush/pushHeadOnly is very 
expressive, but it requires to be wrapped by porcelain "git remote 
add"/"git clone" for the average user.

In the past I've seen the development of git follow the line of adding 
more knobs to allow the experts to tweak them, but that could also be a 
byproduct of the audience that this ML reaches.

In this case, I think the choice depends on how much effort can be 
invested in answering the above questions.

Paolo
