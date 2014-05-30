From: Nathan Neulinger <nneul@neulinger.org>
Subject: Re: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent,
 but processed BEFORE .gitconfig
Date: Fri, 30 May 2014 14:58:47 -0500
Organization: Neulinger Consulting
Message-ID: <5388E2F7.606@neulinger.org>
References: <5388CBA5.9030403@neulinger.org>	<20140530182746.GK12314@google.com> <5388D175.3060500@neulinger.org> <xmqqvbsn82u6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 21:58:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqSx3-0002OF-Nw
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 21:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933236AbaE3T6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 15:58:50 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:57687 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303AbaE3T6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 15:58:49 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so2357814oag.13
        for <git@vger.kernel.org>; Fri, 30 May 2014 12:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BD1RpnOpW0pPbllDM7HPEc1TrHBgW8yY2TLwQv4yyOk=;
        b=EVQ6Oqt2an1N7lbqqYA+AAx+1qLmaAtai+MvqU3ZZeMZlEn9oYaqPP7OKdbldrY+Be
         IiBLTomUTnRZFux0KIMsqvjRejA1WHBn1YXTxKlIjQ105jLP4BEHtNY3e5TC/5UTsOJK
         vPosD4mWbJs5w0ww0kFI85pIhA4UoXgtIx23hi8O8fZzUPKoKKtelcOVEJ4+li1nNO83
         NiKEfMLjSSWQEelVABmdL5kPyX2yh5DgfEa2TwYuOUsv/kJu53QuMxDAuvu3kX7OIYMs
         T49V2i1R60mhnp/Sz/0Q7AboMQx8inFVKthyvrEbtOMh+nY7pYfYBEBlGNbvqrl5v4kR
         lvsw==
X-Gm-Message-State: ALoCoQlRQohHXHokWgth/YRw1t8HuYnJcv/FE8PB3U29nzEz6bajFuEg0Y6LI3SXdU6ev/fnQFQk
X-Received: by 10.182.29.8 with SMTP id f8mr20096387obh.43.1401479928602;
        Fri, 30 May 2014 12:58:48 -0700 (PDT)
Received: from infinity.srv.mst.edu (infinity.srv.mst.edu. [131.151.49.1])
        by mx.google.com with ESMTPSA id x5sm16610794oei.16.2014.05.30.12.58.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 May 2014 12:58:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqvbsn82u6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250472>



On 05/30/2014 02:48 PM, Junio C Hamano wrote:
> Nathan Neulinger <nneul@neulinger.org> writes:
>
>>> I wouldn't mind having a GIT_EMAIL envvar with the semantics you mean,
>>> but can you say more about the use case?  What's wrong with the usual
>>> EMAIL environment variable?
>>
>> EMAIL actually worked for this case for me, but there wasn't any
>> equivalent for author name, so the commits all look like
>> "sharedaccount <myuser@mydomain>".
>
> I do not want to go into the discussion on the sanity/insanity of
> using such a "shared account", but I am guessing that you already
> have a concrete and workable mechanism in mind to allow you to set
> these environment variables such as GIT_WEAKER_AUTHOR_NAME to
> individual real users who share that account, and I further guess
> that that is what you use to set EMAIL.  Am I guessing right?

Yes, the behavior currently is:

	If I can figure out "who", I'll set the EMAIL/attributes based on that.
	If not, it'll default to the "don't know" behavior that throws up the list

Ideally, I'd prefer the second option be:

	Force user to specify --author if a good default can't be determined

But there doesn't appear to be a way to do that.

> If so, wouldn't it be a better option to use that mechanism to set
> separate $HOME (or XDG_CONFIG_HOME if you prefer) to these real
> users who share the account, so that separate $HOME/.gitconfig files
> can be used by them?

Not really, since there are lots of servers, and lots of application/service accounts. Where filesystem acl'ing can be 
used reasonably, it is, making this moot, but it still boils down to example case of "I have a team of X people 
maintaining Y different applications, each on their own dedicated account". I'd just like a good mechanism to set 
defaults based on information other than what is in the home dir on the occasions that users log in directly to the app 
account, as opposed to doing updates offline on their own systems/to central repo/etc.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
