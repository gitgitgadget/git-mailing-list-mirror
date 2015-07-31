From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: let command-line options override saved options
Date: Fri, 31 Jul 2015 09:04:08 -0700
Message-ID: <xmqqvbd05n5z.fsf@gitster.dls.corp.google.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
	<CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
	<xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
	<20150728164311.GA1948@yoshi.chippynet.com>
	<xmqqegjsfbtk.fsf@gitster.dls.corp.google.com>
	<CACRoPnR1df+uEnpFArJtwEBCh+HiQYDYGOyZ7KQEGtrdiaX3GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLCnD-0007OK-Fs
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 18:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbbGaQEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 12:04:15 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35626 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbGaQEO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 12:04:14 -0400
Received: by pdrg1 with SMTP id g1so44890967pdr.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=u+Eb/CwcDq765oQGLN2sYsj3lYETrjX0/7GCCjndUPA=;
        b=OEHozov+HKo/FGiWMpSRcSW+CbpL49F8amOW2mv/7BoqCDKp6SmDv51keE6sU0Gf5+
         bgUnhPGXwejXd5ysZuO4djOXO5j095BijvvdnS2NcqW/pmYgOvfYW7QAV7H+V4FySMvE
         OzN8ozOjijzTW6LmoRCBw4OObdxbIHqLc+XFP1e4DR+xKRBMiHc47XZq2SC6ufChEjyr
         Uv3pwqU5mnntLfvIVGb04Gxg7HdjArDqg1PeG2/mC9fdUbfTco0OKSP4kEhI5y+OABId
         YD9265mukFRozhVOzG+fvAQBJhWap/WoewqKXoaLDRv9SdyQlWm8ujeMH1t4mVa7RBtK
         DZZg==
X-Received: by 10.70.48.166 with SMTP id m6mr8520824pdn.13.1438358653712;
        Fri, 31 Jul 2015 09:04:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id r9sm8512444pdp.5.2015.07.31.09.04.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 09:04:09 -0700 (PDT)
In-Reply-To: <CACRoPnR1df+uEnpFArJtwEBCh+HiQYDYGOyZ7KQEGtrdiaX3GQ@mail.gmail.com>
	(Paul Tan's message of "Fri, 31 Jul 2015 18:58:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275051>

Paul Tan <pyokagan@gmail.com> writes:

> I think I will introduce a format_patch() function that takes a single
> commit-ish so that we can use tag names to name the patches:
>
> # Given a single commit $commit, formats the following patches with
> # git-format-patch:
> #
> # 1. $commit.eml: an email patch with a Message-Id header.
> # 2. $commit.scissors: like $commit.eml but contains a scissors line at the
> #    start of the commit message body.
> format_patch () {
>     {
>         echo "Message-Id: <$1@example.com>" &&
>         git format-patch --stdout -1 "$1" | sed -e '1d'
>     } >"$1".eml &&

I only said I can "understand" what is going on, though.

It feels a bit unnatural for a test to feed a message that lack the
"From " header line.  Perhaps

	git format-patch --add-header="Message-Id: ..." --stdout -1

or something?

> Ah, I was just following the structure of the code, but stepping back
> to think about it, I think there are 2 bugs:
>
> 1. The signoff is appended during the email-parsing stage. As such,
> when we are resuming, --no-signoff will have no effect, because the
> signoff has already been appended at that stage.
>
> A solution for this is tricky though, as there are functions of git-am
> that probably depend on the present behavior of the appended signoff
> being present in the commit message:
>
> * The applypatch-msg hook
>
> * The --interactive prompt, where the user can edit the commit message
> (to remove or edit the signoff maybe?)
>
> These functions are called before we attempt to apply the patch, so we
> should probably call append_signoff before then. However, this still
> means that --no-signoff will have no effect should the patch
> application fail and we resume, as the signoff would still have
> already been appended...

Ah, I see.  Let's not worry about this; we cannot change the
expectation existing hook scripts depends on.

> 2. Re-reading Peff's message, I see that he expects the command-line
> options to affect just the current patch, which makes sense. This
> patch would need to be extended to call am_load() after we finish
> processing the current patch when resuming.

Yeah, so the idea is:

 - upon the very first invocation, we parse the command line options
   and write the states out;

 - subsequent invocation, we read from the states and then override
   with the command line options, but we do not write the states out
   to update, so that subsequent invocations will keep reading from
   the very first one.

That sounds sensible.

> The tests will also need to be modified as well.
>
>>> +test_expect_success '--3way, --no-3way' '
>>> +     rm -fr .git/rebase-apply &&
>>> +     git reset --hard &&
>>> +     git checkout first &&
>>> +     test_must_fail git am --3way side-first.patch side-second.patch &&
>>> +     test -n "$(git ls-files -u)" &&
>>> +     echo will-conflict >file &&
>>> +     git add file &&
>>> +     test_must_fail git am --no-3way --continue &&
>>> +     test -z "$(git ls-files -u)"
>>> +'
>>> +
>
> ... Although if I implement the above change, I can't implement the
> test for --3way, as I think the only way to check if --3way/--no-3way
> successfully overrides the saved options for the current patch only is
> to run "git am --3way", but that does not work in the test runner as
> it expects stdin to be a TTY :-/ So I may have to remove this test.
> This shouldn't be a problem though, as all the tests in this test
> suite all test the same mechanism.

Sorry, you lost me.  Where does the TTY come into the picture only
for --3way (but not for other things like --quiet)?
