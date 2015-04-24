From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Fri, 24 Apr 2015 11:12:36 -0700
Message-ID: <20150424181236.GK5467@google.com>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
 <xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
 <xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 20:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yli5q-0002Hn-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 20:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933704AbbDXSMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 14:12:40 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36314 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933009AbbDXSMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 14:12:39 -0400
Received: by igblo3 with SMTP id lo3so21227420igb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ThDqMeJeFNqam6GVSukqHyDySdWwmSFA1K0eAfbRGdo=;
        b=B45o6CQEJJb96s3FNo20Ab2A6sXfvU54DDksokZA0FcRkYJvT0rpjUFm5eqh3cqy0D
         JkiR8d74zZL3t93f+ucUvBw9MXrSZ58CYxF9g0gVqXJWh5GV1UvH9ddgaJXRdU189/te
         5TmBU/WZkpGIRLSqgk+mRFTdWKZW31B9PDGbVKd8UA8DmyVI7WOX9DxC0gWrILuv+Nf+
         IPLv7acMRak4R/ywhMVlaYdOfH8uUYSZUHmJp0G4/Hsn9CLpK9kbFaBfHO+JH8kpEsfZ
         L8YEhvFdhPcN9oOf09yVrta4nLdzf6ohgHHCbsFxz9KuACxxSQMqlLiO6kl6pjW3qwcM
         i/Pg==
X-Received: by 10.43.65.201 with SMTP id xn9mr289030icb.64.1429899158986;
        Fri, 24 Apr 2015 11:12:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:553e:8bc4:6cac:ca8b])
        by mx.google.com with ESMTPSA id k16sm51235igf.19.2015.04.24.11.12.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Apr 2015 11:12:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267747>

Stefan Beller wrote:

> I understood that you were talking about Could being capitalized.
> Though it's distributed 30/70 which hints to me we do not care in
> enough to explain the capitalized letters as slip-throughs on review
> or such, but it looks like the authors choice to me.

Lowercase, brief, with no period at the end is the convention.  This
is user-facing UI, so consistency matters.  It's not author's choice.

Existing examples of capitalized messages fall into a few categories:

 - shell scripts used to tend to use the capitalized form, and when
   they got rewritten as builtins the messages weren't cleaned up at
   the same time

 - some patch authors have different habits and it wasn't worth going
   back and forth to fix it (but the convention still stands, and the
   result of a program that can't decide how to talk to the user is
   still harmful)

 - once there are a few examples, they get copy/pasted and imitated

> I think it's a mistake to s/Could/could/g for all errors in the code base
> as it reduces the information provided in the error messages.

This seems like an after-the-fact justification for a mistake.

Often there is a choice about whether the caller or the callee to a
function prints an error.  If the caller does, it can say more about
the context.  If the callee does, the message is in one place and can
be tweaked more easily to be more useful.

To get the benefits of both, we could print a backtrace with every
error.  That way, the callee can describe the error in one place but
the context is all there.  But I'm really glad we don't do that!

The main purpose of most error messages is instructional: they give
information to the user in a way that is abstracted from the
implementation (the user doesn't care what function it happened in!)
that tells them what happened and what they can do next.
Gratuitous inconsistency in formatting doesn't help with that.

Actually, I wouldn't mind an environment variable that tells error()
to include a backtrace if someone wants it.  (See backtrace(3)
for implementation hints if interested in doing that.)

> Just 3 days ago ("Regular Rebase Failure"). I used different
> capitalization to get a better understanding where the error may be.

Wouldn't it be better if there weren't so many similar messages
produced in different contexts in the first place?  (I.e., this
suggests to me that we should move more in the direction of
callee-produces-error.)

Sorry, that was a long way to say very little.  I just wanted to
emphasize that when a UI inconsistency has a useful side effect, while
that can be useful to understand and learn from, we should not be
afraid to fix it.  And to clear up any ambiguity about git's error
message convention. :)

Thanks and hope that helps,
Jonathan
