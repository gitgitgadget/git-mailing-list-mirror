From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Thu, 21 Mar 2013 00:08:54 +0530
Message-ID: <CALkWK0mCVb6N76QU+U3iTO_gmU4PmhrTOgU53DAMd5x1bCQEtA@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-4-git-send-email-artagnon@gmail.com> <20130320182830.GJ3655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:39:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINvO-0000G1-7X
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902Ab3CTSjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:39:17 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42434 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159Ab3CTSjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:39:15 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so2473073ief.21
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zoNkqPPOD4NxDxb7YBGIkrHjVwKDYDSPUD5fhkUqlJQ=;
        b=FYT6mbGojcubZQ4ED4/WeaYzSCywfYN3KZOVeVcnBZq9ZNJihtlZeQ3X6D9SrPWRZK
         dBdXneCyo0+J4X1yFdFZZ7x0n6iPDWP4MTQo/DgMnt8qT5dmjLyc8QV4ffh9P+3bZr8R
         +HfoB8WsI/p7/vzwOami4qOVn2G1mRaZmiDyh/OSL+0i6AVQEDxS/BwjspjXea+VyzR8
         Q6Y7Fu7SrAVszuRHYxKV38mPO6jH4FXfufdOTBsGqsk+V5bgAt9kopnp8osx8GOAsen4
         Z1VcDbxOrxWVsGLFvI3JMOetX5zfSeGreFLlGDfRpR69nfTWzjjj/g77CCnKq6poclPG
         aM8A==
X-Received: by 10.50.17.71 with SMTP id m7mr111018igd.14.1363804754759; Wed,
 20 Mar 2013 11:39:14 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 11:38:54 -0700 (PDT)
In-Reply-To: <20130320182830.GJ3655@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218646>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> mk_test() creates a repository with the constant name "testrepo", and
>> this may be limiting for tests that need to create more than one
>> repository for testing.  To fix this, create a new mk_test_with_name()
>> which accepts the repository name as $1.  Reimplement mk_test() as a
>> special case of this function, making sure that no tests need to be
>> rewritten.
>
> Why not give mk_test an optional parameter?
>
>         repo_name=${1:-testrepo}
>
> Oh, it is because mk_test already takes arguments naming refs to push.
> I suppose the change description could make this clearer.

Isn't it obvious?

> Why not use mk_test and then rename, like so?
>
>         mk_test ...refs... &&
>         mv testrepo testrepo-a &&
>
>         mk_test ...refs... &&
>         mv testrepo testrepo-b &&
>         ...

No.  This is ugly.  mk_test() should not hardcode "testrepo".

> I dunno.  The helper functions at the top of this test are already
> intimidating, so I guess I am looking for a way to avoid making that
> problem worse.  One way would be to add an opening comment before
> the function definition explaining how it is meant to be used.  See
> t/test-lib-functions.sh for examples, such as test_cmp.

My patch does not make the situation worse in any way: it just adds
one line that passes $1 as a parameter to existing code.  Yes, the
functions and tests can be improved greatly, but I refrained from
doing so because of your series.  We can save it for later.
