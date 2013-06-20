From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Fri, 21 Jun 2013 02:52:28 +0530
Message-ID: <CALkWK0mTthYyHRkxqK2Z3uP3uUmtQADyZt7CERY_40iQSQyzAA@mail.gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
 <1371640304-26019-4-git-send-email-artagnon@gmail.com> <7v38sdzx8o.fsf@alter.siamese.dyndns.org>
 <7vk3lpwkt6.fsf@alter.siamese.dyndns.org> <CALkWK0=v25wC1r8ScUkKDhFjctZCDLJtpDx2g2avyYgJVmZCWg@mail.gmail.com>
 <7vd2rgtwl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 23:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpmK5-0006Id-Qz
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 23:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab3FTVXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 17:23:12 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63935 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204Ab3FTVXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 17:23:09 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so17759859iec.22
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mD5HQbvPDINRqHuWC8IOJTH49Tvfnx8QqzhL58Ipmdo=;
        b=GWkcdTElz+Jdp0dZl7tVQIhE3CVS5CTWBUXb0dhbAZB6tpNk4XygHDxWZuU+pm9YtG
         aUEoexytAWSoJMwhvlDG+0TY64tZmmtep5GGl9WXukDFL/fhzEblHKrC3JUE93o9FZxq
         DWw18jpl5lCNbIL6CjRuKJmb9oZlIrZm7OZPUGPmXsRe+atDu6cp9a9yDTzGfFFK9hAf
         2O9VDzUBMOePncHoqla8kUn8K2lo/fif1gKeqdbHbTcJIH+3GXNvnJ8g/cO2Y7uRuQWZ
         k+jR/snSsMJ2vS3q8ZHT7u9dDzg8D1fELOJA2dMpWCiDwMfN2o2OobLe0+IMHR6ImqCI
         yFWg==
X-Received: by 10.43.88.3 with SMTP id ay3mr875406icc.61.1371763388681; Thu,
 20 Jun 2013 14:23:08 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 14:22:28 -0700 (PDT)
In-Reply-To: <7vd2rgtwl3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228541>

Junio C Hamano wrote:
>> They're not the same thing.  It is very much intentional and intended:
>> the safety net is not to "ensure that the push and pull are
>> symmetrical" (i.e. among other things, error out if
>> branch.$branch.merge is unset), but rather "ensure that the push and
>> pull are never asymmetrical".
>
>     not to "ensure that the push and pull are symmetrical"
>     rather "ensure that the push and pull are never asymmetrical".
>
> They still talk the same thing to me.  What am I missing?

Never mind the wording then.  I am proposing preventing asymmetry by
explicitly disallowing a push when $branch is different from
branch.$branch.merge, instead of shutting down immediately when
branch.$branch.merge is unset.

>> Now I'd like to question what you are labelling as "safety".  What is
>> the consequence of erroring out when branch.$branch.merge is unset
>> when pushing using `upstream`?
>
> Nothing noteworthy.
>
> I wasn't suggesting to change what `upstream` does at all.

No, but I did.  I just argued for a sane default for
branch.$branch.merge (the part you snipped out).

> The conclusion is that using push.default=`upstream` is meaningless
> when you are using a triangular workflow.

Yes, and I agreed with that.

> If you are using a
> centralized workflow, and if a branch does not have branch.*.merge
> configured, we do not know to which branch you are pushing it back,
> so we error out.

And I said: have a sane default.

> What I am changing from the patch you posted with the "how about
> this on top" patch back to the current behaviour is what 'simple'
> does for centralized workflow.

Yes, I know.  I read the patch.

> When you are doing a centralized workflow, 'simple' was defined

Again, I'm well aware what it _was_ defined as.  Was it not clear that
I argued for a change from the very first email where I posted the
patch and changed a test?  Do you have a counter-argument, or is it
simply that we must respect its historical meaning?

> Now, no existing series has casted in stone the best behaviour for
> `simple` in a triangular workflow.  With this series (and also with
> my fixup patch I sent last night), it is defined to act as `current`,
> but it may need a bit more safety to help new users avoid pushing
> branches they did not intend to (perhaps pushing out `current` only
> when the branch with the same name already exists at the destination?
> I dunno).

I see no reason to plan safety features in advance, especially since
we have neither branch.$branch.push nor @{push} yet.
