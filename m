From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/7] t7900: Start testing usability of namespaced remote refs
Date: Tue, 7 May 2013 23:52:59 +0200
Message-ID: <CALKQrgctyZGf2z+=+qjcW-s0uyVCqw01pv6X2NG+8yyC3FoTvQ@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-3-git-send-email-johan@herland.net>
	<7va9o7pogo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 23:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpou-0004vf-KK
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab3EGVxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:53:07 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:59102 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab3EGVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:53:06 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZpol-0007cR-O9
	for git@vger.kernel.org; Tue, 07 May 2013 23:53:03 +0200
Received: from mail-ob0-f182.google.com ([209.85.214.182])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZpol-000J85-Gy
	for git@vger.kernel.org; Tue, 07 May 2013 23:53:03 +0200
Received: by mail-ob0-f182.google.com with SMTP id eh20so1098479obb.13
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=uvFtR/aDHnQ55SHze9JRpjVNFyITyCBZw7g8rBOlPAw=;
        b=VCroh8ESlpW4+4srkVltVNND/ywqfL/ugwUAwLlmArwZn/mINvgeeSe6b8fY+SZ76r
         lywHlRSmfRwJcdVADx+oLuhdnaA4S5uAXdpC4ybnT9xRstRWVGYYb2FYwOZuFswV1SOF
         U9Gfcxb0KpjecDSYIAD0rBzSvzDcrLQz1TUg0aE7eKG1eWK8sN1Ie3OPGGaGVb66qq1o
         RuvtPdM63x4wG0N4DG2TbcO9q+pZk3tzlEYEU1qyuUdMkyxbqxxFI5DgHJyELo+oApoL
         Zmyh7c7cobOwArxECTBvtMY4UJv8hWx9AzXf7mdU1JsnbGBhQucsuHBvxbTzIlT0+Mb2
         HV9A==
X-Received: by 10.60.42.135 with SMTP id o7mr1111989oel.97.1367963580110; Tue,
 07 May 2013 14:53:00 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Tue, 7 May 2013 14:52:59 -0700 (PDT)
In-Reply-To: <7va9o7pogo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223604>

On Tue, May 7, 2013 at 3:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> +test_expect_success 'work-around "clone" with namespaced remote refs' '
>> +     rm -rf client &&
>> +     git init client &&
>> +     (
>> +             cd client &&
>> +             git remote add origin ../server &&
>> +             git config --unset-all remote.origin.fetch &&
>> +             git config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/heads/*" &&
>
> If you were to do this, I think you should drop the "remote add
> origin" step and illustrate what configuration variables should be
> prepared (at least minimally---the final implementation of "git
> clone --separate-remote-layout" may add some other configuration
> variable as a hint to say "this remote is using the new layout" or
> somesuch) in this "client" repository.

Sure, I can change the test into doing:

	cd client &&
	git config remote.origin.url ../server &&
	git config --add remote.origin.fetch
"+refs/heads/*:refs/remotes/origin/heads/*" &&
	git config --add remote.origin.fetch
"+refs/tags/*:refs/remotes/origin/tags/*" &&
	git config --add remote.origin.fetch
"+refs/notes/*:refs/remotes/origin/notes/*" &&
	git config --add remote.origin.fetch
"+refs/replace/*:refs/remotes/origin/replace/*" &&
	git config remote.origin.tagopt "--no-tags" &&
	git fetch &&
	git checkout master

> That would make the test more self documenting.
>
> I am not convinced that it is a good idea to reuse "remotes/origin"
> hierarchy which traditionally has been branches-only like this,
> though.  It may be better to use
>
>         refs/$remotes_new_layout/origin/{heads,tags,...}/*
>
> for a value of $remotes_new_layout that is different from "remote",
> and teach the dwim_ref() machinery to pay attention to it, to avoid
> confusion.  Otherwise, you wouldn't be able to tell between a topic
> branch that works on tags named "tags/refactor" under the old layout,
> and a tag that marks a good point in a refactoring effort "refactor"
> under the new layout.

I see your point, although I'm not convinced it is common among users
to have branch names of the "tags/*" form (or tag names of the
"heads/*" form, for that matter). I'm also not sure it's worth messing
with the "remotes" name which has had a long time to work its way into
our brains and into git's user interface.

That said, I could have a go at using "refs/peers/*" instead of
"refs/remotes/*", and see how that works out.

If it sticks, how pervasive do we want this renaming to be? I guess we
don't want to rename the "git remote" command to "git peer" just
yet... What about the config? Do we rename "remote.origin.url" to
"peer.origin.url" for new-style remotes? For how long do you
anticipate having "peers" and "remotes" living side-by-side as
concepts in git?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
