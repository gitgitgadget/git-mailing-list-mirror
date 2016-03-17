From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Thu, 17 Mar 2016 03:28:58 -0400
Message-ID: <CAPig+cRkAE4BzbgniP=peHE-pBfKt1i2C4MqJcJ36sMfsSh3KQ@mail.gmail.com>
References: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
	<20160317015044.GB12830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:29:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agSMi-00075n-KF
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 08:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbcCQH3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 03:29:00 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36627 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbcCQH27 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 03:28:59 -0400
Received: by mail-vk0-f43.google.com with SMTP id q138so87250vkb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0J7DsU7La7wY2L+whOmFJ3Xl5FyUd6D7jMF+QY0sOzY=;
        b=q0gVztLUKdOz6J6GhnI+bJFFQ8r6zNwK+8w9KGXdeEcGsJAiu84/aZ4hxg0i2ww894
         p+qrGBBNZk0O1SNAtB0kbGcH0EPGrFcGGkjbNYq9RCpdHRHPrEId/pAdUv2puc2ogeY8
         VNyQVkoJYbv6fjIn3zN/ys526yaeIEe9/RJlaLhSYxrKlc9Sy0WvR+SCJYegFhZbiNFO
         vw/sqOlFu5q99TuPeV9dCuwrMR+G1JtvdCRfs3RNHHMSEwXv/yaeUYuM3Oo9O/mfVhMe
         RqhCp/pRC17eipJHcRqcPz0clBSrS39thK579u1RenZBLW1QxqQvAtDnVOqHVJ8yNsi2
         cKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0J7DsU7La7wY2L+whOmFJ3Xl5FyUd6D7jMF+QY0sOzY=;
        b=GJMEHtN6mKkcb024NWaVVm55e6wqRbJxZ7Z3rYR16WgZiH0/acl1jw0W2aKh42KMua
         znMC9Xxrrj2ROVk5B9vvM2i4dQeipq6A/mIObNivOembECWKheJTFNc1XpL4T4uSdd47
         P7AcNclgQ9VOK3PbjIsX6tXoa38CEaKuebuah6OLgK67+YWMjpGpO6N7+p4uRpT4BAJB
         ooFb5rDR2FMp/VjSB7RjANvnVL/F1v088PtdtNxc7N2V1ZJBjrZsQBioIcLBlhwQFsm+
         dOfLWQNrv41CELLIVKF1OfTpubsIFoy6ggsPnQaOf3RBtCMLgt6OyYF0I/SGh1/Tsk1P
         aVDg==
X-Gm-Message-State: AD7BkJI5cBIMN6eeO0iTLqEsA28/w2dSvFaQltLRUC435KlRupTYqFjO/S6iWRiIe6mDfaHS2xuFfFOdUe8syw==
X-Received: by 10.31.8.142 with SMTP id 136mr10167904vki.14.1458199738375;
 Thu, 17 Mar 2016 00:28:58 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 00:28:58 -0700 (PDT)
In-Reply-To: <20160317015044.GB12830@sigill.intra.peff.net>
X-Google-Sender-Auth: 3ZqQChmbseI3wApl1B76X2J2RZI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289081>

On Wed, Mar 16, 2016 at 9:50 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 16, 2016 at 11:16:58PM +0000, Pranit Bauva wrote:
>> The reason to make it consider negative values or more specifically
>> "unspecified" values is to differentiate between the option passed
>> once, multiple times or with --no-option. This makes the receiver

This is inaccurate and rather confusing. It's not that an
"unspecified" value gives you the ability to "differentiate between
once, multiple time or with --no-option", but rather that it allows
you to determine wether --option or --no-option was encountered at
all.

>> know what actually happened with the arguments which is particularly
>> required with option have multiple levels of that option.
>>
>> Eg. :
>> initialize verbose = -1
>> `git commit` => verbose = -1
>> `git commit -v` => verbose = 1
>> `git commit -v -v` => verbose = 1
>> `git commit --no-verbose` => verbose = 0
>
> This second to last example would be 2, right?

Right.

I'm not sure that this example block is helpful, though. A clearer
commit message which does a better job of explaining the reason for
the change would likely eliminate the need for an example.

> That aside, this patch does mean that one can no longer use
> OPT_COUNTUP() for negative values (i.e., the caller must start it at
> either 0 or 1, and it must always go up from there).
>
> And we would need to verify that all of the existing callers are OK with
> this. Did you check that that (not rhetorical; I suspect they are all
> OK, but somebody needs to check)?
>
> We are also changing semantics without changing the interface, which
> means any topics in flight (that you _cannot_ review, because you have
> not seen them yet) may be subtly broken. To me that is not an absolute
> deal-breaker, but something to weigh against the utility of the change.

Indeed, I was envisioning a more conservative approach of having
OPT__VERBOSE use a custom callback or perhaps introducing a new
'flags' value or even (probably too ugly) abusing the 'defval' field
to specially indicate that it wants the "negative means unspecified"
behavior; the other consumers of OPT_COUNTUP would not request this
special behavior. But, as you say, changing the behavior of
OPT_COUNTUP unconditionally may not be a deal-breaker.

I also realized that Pranit can achieve the desired behavior without
modifying OPT__VERBOSE at all. Specifically, rather than initializing
his opt_verbose variable to -1, he can instead initialize it to 1.
Then:

* if --verbose is seen (one or more times), opt_verbose will be >=2,
and the real verbosity level will be (opt_verbose - 1)

* if --no-verbose is seen, opt_verbose will be 0

* if neither is seen, then opt_verbose will remain 1

However, I think this approach is far too ugly and non-obvious to
seriously suggest using it, whereas the change to OPT__VERBOSE is
easily understood and could prove useful in the future for other
commands with multiple verbosity levels.

> When looking more carefully at builtin/commit.c for the other thread, it
> occurred to me that OPT_BOOL might be a better fit for commit's "-v". It
> really is a boolean "show the diff or not" and thus unlike the other
> "make me more verbose". And OPT_BOOL already has the behavior you want,
> I think.

For completeness (for readers of this thread), it was pointed out in
the other thread[1] that git-commit does indeed recognize multiple
verbosity levels, so changing it to use OPT_BOOL would be undesirable
(wrong).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=289074
