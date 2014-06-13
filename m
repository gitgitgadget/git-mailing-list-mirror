From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 11:20:19 -0700
Message-ID: <CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 20:20:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvW5W-00064c-SV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 20:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbaFMSUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 14:20:23 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:39363 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbaFMSUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 14:20:20 -0400
Received: by mail-vc0-f173.google.com with SMTP id lf12so2629308vcb.4
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VAvZHKY6T4ri6UFx1XQdr3GIGdG0gMNDQlHf1ANQOBQ=;
        b=iDMVKyefUZfUnIoXO6O2c9nE0Ic1Jqv6HMTSJUHrSBELF7YGTdrLafxoFtJB5Nv1B0
         QpzK8Pf02b4CRelFsBut77u0/wXnlpz9KuBw/g+K3xzGHSxuZBZXvWVDhTKscfLBD+HG
         X6KG/lekEftEfEbeGoFbWiHTqfOIhzlSFlqNwSL+52BcyW7qZ+UzQ0/selwG8WXnMZgd
         AQwikaLz8YuyF7c54VRcM840lpEhIKGfPLz7tSIDY+YUlAfiuBPMPccvkdzQq+KuXxov
         kxUArvDK+/E+MIcqFxK4j73GJclDCgHBx3mftWj+B92Z1oUtH30eWa1UJqCutzTMCsy+
         VJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VAvZHKY6T4ri6UFx1XQdr3GIGdG0gMNDQlHf1ANQOBQ=;
        b=agbiV+JBisOiYHsXAwQyn7dzD9y/m3NI89jIgm/fSAGWCHXvaBLDIUGRJBJUaibSON
         q5+O2zdjAdEavnoaXM8BS489q4YSSdzXX3hb4k2FEqsyw+FNrnDZPo349YcB1+3aOtW0
         hlWZ/5oSOUtpXsz6rWKYItRjJpaXFJo8nTM39qa+m1+IHII23XmjiNRmhe/AbpGg+0zt
         cSqYUcnIQCzFqVlGu2U88+fHBKmeblwkm8H5goim/HVQ6yW1G8JZ2N8TzKsAUKwP//Zb
         ibiU65xRXQoB8SIj0CUNN5kB2mMMFwAiWVNPhJ2y8Onf9tlWCHSYnV5JYwPHPLjtdI0F
         9c2g==
X-Gm-Message-State: ALoCoQlXo46mp+QVzGIY4k4XMy1V16DFSbvFt5HLnKbwirCecMsExcNrIdOQj2oXP715ctlInu8O
X-Received: by 10.52.12.129 with SMTP id y1mr46132vdb.59.1402683619203; Fri,
 13 Jun 2014 11:20:19 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Fri, 13 Jun 2014 11:20:19 -0700 (PDT)
In-Reply-To: <xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251626>

On Thu, Jun 12, 2014 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Turner <dturner@twopensource.com> writes:
>
>> This issue bit us again recently.
>>
>> In talking with some colleagues, I realized that the previous version
>> of this patch, in addition to being potentially slow, was incomplete.
>> Specifically, it didn't handle the case of refs/heads/case/one vs
>> refs/heads/CASE/two; these are case clones even though they strcasecmp
>> different.
>
> Good catch to realize that two refs that share leading paths that
> are the same except for cases are also problematic, but that makes
> this feature even less about "case clones", doesn't it?
>
> Also it somehow feels that the patch attempts to solve the issue at
> a wrong level.
>  On a platform that cannot represent two refs like
> these (e.g. trying to create "FOO" when "foo" already exists, or
> trying to create "a/c" when "A/b" already exists---ending up with
> "A/c" instead, which is not what the user wanted to create), would
> it be more sensible to fail the ref creation without touching the
> users of ref API such as receive-pack?  That way, you would also
> catch other uses of refs that are not supported on your system,
> e.g. "git branch a/c" when there already is a branch called "A/b",
> no?

It gets even more hairy :
If the server has A/a and a/b and you clone it it becomes A/a and A/b
locally. Then you push back to the server and you end up with three
refs on the server:  A/a A/b and a/b.
Or what we end up with locally could either be a/a  and a/b or A/a and
A/b depending on which order the server sends the refs back.
Since the ordering I think is not formally defined, is it?, this could
mean that we would end up with something but it would be difficult to
deteministically decide what the outcome would be.
As the refs handling is pretty complex as is I think we want to avoid
adding undeterministic residuals after a clone/fetch/* has failed.

That then IMHO means that we should wait with implementing something
until we have finished the ref API rewrite. If nothing else, having
atomic transactions would mean that
when things fail due to case collissions we would have a deterministic
outcome : transaction failed so nothing was created locally.



But I think this is the wrong level to solve this issue at.
receive-pack.c is only one out of many place where I think this would
come into effect.
You also have reflogs, remotes and all sorts of other things that
would have to be fixed up.

If we want to add this kind check-fails, we should wait until after we
have ref transactions because then we will have one single path,
transaction_update_sha1(), through which every ref creation/update
will have to pass. and thus then we have one single place where such a
check-fail could cover all cases of ref creations.




>
> CC'ing those who are more active in the ref API area recently than I
> am for their inputs.
