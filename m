From: Johan Herland <johan@herland.net>
Subject: Re: Storing refs in the odb
Date: Mon, 20 May 2013 19:37:45 +0200
Message-ID: <CALKQrgdWx5mw3NCd4JOr3x9M34c2rNjm_tz_C7fm7g7g-LUJZQ@mail.gmail.com>
References: <CALKQrgcBkdoJdJGam=VkE=nXHQ8WB5judY3C3nNQBJCns-_f+A@mail.gmail.com>
	<7vbo85wos9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 20 19:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeU1z-0001fG-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 19:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab3ETRhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 13:37:51 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:53404 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3ETRhu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 13:37:50 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeU1t-000Dh5-Bv
	for git@vger.kernel.org; Mon, 20 May 2013 19:37:49 +0200
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeRTt-000GFR-C0
	for git@vger.kernel.org; Mon, 20 May 2013 16:54:33 +0200
Received: by mail-ob0-f175.google.com with SMTP id wo10so5844123obc.20
        for <git@vger.kernel.org>; Mon, 20 May 2013 10:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=APaWKooSXUwh715v8SOaaihp3NVeR8IbQ6WuG8cxJkU=;
        b=M942zvgXJxpIFsYfTA0RLbrTGNVVZmjhT3a8mLYrxfvuOqhJiNNYjiveRoagehgQpW
         ciN6wJggx1z8asB53WqaQqnOm6F+viJObdSAAojlCus5XFlOlVlgugMAlUetwAYa+Omp
         GgXZCkmPkKi0/dej2XWr5/4slUVyHfiCg/9dzjtgIV2ePSMRmbr2jO7QYUd0vqfVcBLR
         sqEM2ZVsdw7sl/beDPdUoKt3qrkXG9RjBMyISKYGwjj/MIG3uWPkwSi4EzWdqBSromUR
         UJCpNossJDRreiM2a6atb0qSSs4KYNhCs5DwMAzxkVBxOBLYJK0JYJI+tEdaMtGyiS93
         vI5g==
X-Received: by 10.182.129.4 with SMTP id ns4mr17639581obb.22.1369071465506;
 Mon, 20 May 2013 10:37:45 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 10:37:45 -0700 (PDT)
In-Reply-To: <7vbo85wos9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224967>

On Mon, May 20, 2013 at 7:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>>> Of course in either case we couldn't use a tree object directly, because
>>> these new "reference tree" objects would refer not only to blobs and
>>> other trees but also to commits and tags.
>>
>> Indeed. I don't know if the best solution would be to actually _allow_
>> that (which would complicate the object parsing code somewhat; a tree
>> entry pointing to a commit is usually interpreted as a submodule, but
>> that is not what we'd want for the ref tree, and a tree entry pointing
>> at a tag has AFAIK not yet been done), or whether it means we need to
>> come up with a different kind of structure.
>
> You can disallow that only by giving up on being able to express
> Linus's kernel repository, which has an oddball v2.6.11-tree tag.
>
> I do not think that that particular tag in the particular repository
> is too big a show-stopper; if it is only Linus, we can ask him to
> drop that tag (he has v2.6.11 tag object that points at the tree, so
> the users do not lose anything) and be done with it.
>
> But if there are other repositories that tag trees in a similar way,
> that would be a real regression.  We cannot just go ask people to
> change their workflow that depended on using refs that directly
> point at trees overnight.

I wasn't considering disallowing _anything_, rather open up to the
idea that a tree object might refer to tag objects as well as
commits/trees/blobs. E.g. in my suggested-but-pretty-much-retracted
scheme, I was considering whether the tree entry at the "virtual" path
"refs/tags/v1.0" should look like this:

  100644 blob 123456... v1.0

where the blob at 123456... contains the object id of the v1.0 tag
object, or whether we should allow the crazyness that is:

  ?????? tag 987654... v1.0

Just a thought experiment...

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
