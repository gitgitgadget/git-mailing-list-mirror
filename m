From: Johan Herland <johan@herland.net>
Subject: Re: Re: Possible regression in master? (submodules without a "master" branch)
Date: Fri, 28 Mar 2014 00:21:23 +0100
Message-ID: <CALKQrgdAhe0AKk51=__fDWX9QqFH=WVCO=gU+mtO6sb250==0A@mail.gmail.com>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
	<xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
	<5334606F.5010109@web.de>
	<20140327185405.GS4008@odin.tremily.us>
	<xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
	<20140327202702.GA3984@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 00:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJcd-0002sN-C0
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 00:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177AbaC0XVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 19:21:32 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:65510 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbaC0XVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 19:21:31 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WTJbz-0005VJ-5U
	for git@vger.kernel.org; Fri, 28 Mar 2014 00:21:28 +0100
Received: by mail-pd0-f174.google.com with SMTP id y13so4002059pdi.19
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 16:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b24nMMWQJ1NYkbN0nFp7gq336XLas7EDGeGJjg7qUDg=;
        b=lyssg6uXld2vm0nzlZkNTJAjv1NIHuoLnnKeQdB/Afi0n5TfiqUByCZ3B7brUUp/F8
         AOAR/Hr4Q7GTZIWPWaZeKfbtgO0ogjEc2qDfxRpRTM/AeoBK6KOFcSGmQGJxneDdHXZ4
         t5d1Z4JO1t+IKuB9/dtAuNvVnIMh0fKBoPhHoG2nGvU7MGcTYwEEGpCmQMhPj3C67dEq
         Bd9rAHJMgoqEFKHl+5Ayci1GiXaxzuQfNWICiW7vUXOaOidTe0NXKT1LkIJxL6ED0CT4
         F2EyrXB8lN/6t/QI8/XeHRstpf/68/TyN6Ufq28mVpt1rSWe+3mSTBtwib4FDzfC0Jzr
         NNEA==
X-Received: by 10.68.138.165 with SMTP id qr5mr4715578pbb.123.1395962483450;
 Thu, 27 Mar 2014 16:21:23 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Thu, 27 Mar 2014 16:21:23 -0700 (PDT)
In-Reply-To: <20140327202702.GA3984@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245339>

(Thanks to all of you for picking this up and more or less resolving
it while I was away from email for a few hours...)

On Thu, Mar 27, 2014 at 9:27 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Thu, Mar 27, 2014 at 12:39:03PM -0700, Junio C Hamano wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>> > On Thu, Mar 27, 2014 at 06:31:27PM +0100, Jens Lehmann wrote:
>> >> Am 27.03.2014 18:16, schrieb Junio C Hamano:
>> >> > Johan Herland <johan@herland.net> writes:
>> >> >> I just found a failure to checkout a project with submodules where
>> >> >> there is no explicit submodule branch configuration, and the
>> >> >> submodules happen to not have a "master" branch:
>> >> >>
>> >> >>   git clone git://gitorious.org/qt/qt5.git qt5
>> >> >>   cd qt5
>> >> >>   git submodule init qtbase
>> >> >>   git submodule update
>> >> >>
>> >> >> In current master, the last command fails with the following output:
>> >> >
>> >> > ... and with a bug-free system, what does it do instead?  Just clone
>> >> > 'qtbase' and make a detached-head checkout at the commit recorded in
>> >> > the superproject's tree, or something else?
>> >>
>> >> After reverting 23d25e48f5ead73 on current master it clones 'qtbase'
>> >> nicely with a detached HEAD.

...which is exactly the behaviour I (and the Qt project - I assume) expected.

>> > Fixing this for initial update clone is pretty easy, we just need to
>> > unset start_point before calling module_clone if
>> > submodule.<name>.branch is not set.
>>
>> There is this bit for "update" in git-submodule.txt:
>>
>>   For updates that clone missing submodules, checkout-mode updates
>>   will create submodules with detached HEADs; all other modes will
>>   create submodules with a local branch named after
>>   submodule.<path>.branch.
>>
>>   [side note] Isn't that a typo of submodule.<name>.branch?
>
> Yep, thats is a typo. Trevor will you fix that as well? Or how should be
> do that? Since its just such a small change.
>
>> So the proposed change is to make the part before semicolon true?
>> If we are not newly cloning (because we already have it), if the
>> submodule.<name>.branch is not set *OR* refers to a branch that does
>> not even exist, shouldn't we either (1) abort as an error, or (2) do
>> the same and detach?
>
> I would expect "(1) abort as an error" since the user is not getting what
> he would expect.

FWIW, here is the behaviour I would expect from "git submodule update":

 - In checkout-mode, if submodule.<name>.branch is not set, we should
_always_ detach. Whether or not the submodule is already cloned does
not matter.

 - In rebase/merge-mode, if submodule.<name>.branch is not set, we
should _always_ abort with an error.

 - If submodule.<name>.branch is set - but the branch it refers to
does not exist - we should _always_ abort with an error. The current
checkout/rebase/merge-mode does not matter.

In other words, submodule.<name>.branch is _necessary_ in rebase/merge
mode, but _optional_ in checkout-mode (its absence indicating that we
should detach).

>> > However, that's just going to
>> > push remote branch ambiguity problems back to the --remote update
>> > functionality.  What should happen when submodule.<name>.branch is not
>> > set and you run a --remote update, which has used:
>> >
>> >     git rev-parse "${remote_name}/${branch}"
>> >
>> > since the submodule.<name>.branch setting was introduced in 06b1abb
>> > (submodule update: add --remote for submodule's upstream changes,
>> > 2012-12-19)?
>>
>> Isn't --remote about following one specific branch the user who
>> issues that command has in mind?  If you as the end user did not
>> give any indication which branch you meant, e.g. by leaving the
>> submodule.<name>.branch empty, shouldn't that be diagnosed as an
>> error?
>
> Well to simplify things there was this fallback to origin/master
> (similar to the master branch we create on init) since that is a branch
> which many projects have.

I think the analogy to "the master branch we create on init" is false.
A better analogy is running "git pull" or "git pull -rebase" in a
branch where branch.<name>.merge has not yet been set. And this
currently fails with "Please specify which branch you want to merge
with." So I would be inclined to agree with Junio here: We should
error out.

> E.g. for the users that share one central
> server and just directly commit, push and pull to/from master. They
> would have an easy way to start working in a submodule, by simply saying
> --remote and then committing to master. At least that is what I
> imagine.

If there are compelling arguments for providing a default fallback
(and I'm not sure the above argument is enough), I say we should
rather follow clone's lead, and use the submodule's upstream's HEAD,
instead of blindly assuming "origin/master" to be present. I expect in
most cases where "origin/master" happens to be the Right Answer, using
the submodule's upstream's HEAD will yield the same result.

>> > gitmodules(5) is pretty clear that 'submodule.<name>.branch' defaults
>> > to master (and not upstream's HEAD), do we want to adjust this at the
>> > same time?
>>
>> That may be likely.  If the value set to a configuration variable
>> causes an established behaviour of a program change a lot, silently
>> defaulting that variable to something many people are expected to
>> have (e.g. 'master') would likely to cause a usability regression.
>
> IMO this branch configuration should completely ignored in the default,
> non --remote, usage. Since we simply checkout a specific SHA1 in this
> case, that should be possible.

Yes. Checkout-mode with no submodule.<name>.branch configured should
always detach.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
