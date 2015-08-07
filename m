From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git
Date: Fri, 07 Aug 2015 09:40:06 -0700
Message-ID: <xmqqh9obyrvd.fsf@gitster.dls.corp.google.com>
References: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
	<1438816453.10324.0.camel@twopensource.com>
	<xmqqk2t91e5y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 18:40:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNkgr-0000wB-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 18:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbbHGQkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 12:40:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35074 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbbHGQkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 12:40:09 -0400
Received: by pabxd6 with SMTP id xd6so73493609pab.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=310lmwjS+fJ557m2Qo2+UdWKeH+ABrgOoUq0UC337M0=;
        b=EsynHjX27kUGLTNhLUTICN1Zd0E7XH0TGzMhvT80xhMGD7qzHU7a7Gz9uAEgf5hP9j
         5oH+XiU9Klw499Au0PjvlgWtaW68r0DOrtuEWLshY6TEbFqCEF7TwvcvP3XG7gsvV/pF
         +1LxGY0lEQfEDKzUFB2UvP84gz3qMpLCuDuR/a1N4jyu2UlGrfSboMKbaFpFMtLJ1eeS
         D9y2Rnm0v1PZjEGaslHmUihU3lEI6ZaKEtiElYz54ws0MIjyYh7zM1o6xnFwyNeLZwsb
         udgxe1X8jroYQctrorZoc5/YLaDN8cJEuqPq2mcrz7zWWRYUC6KslxOh7FpiOye1ytvV
         3UDA==
X-Received: by 10.66.236.70 with SMTP id us6mr16499169pac.39.1438965609007;
        Fri, 07 Aug 2015 09:40:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id u16sm10659238pdl.71.2015.08.07.09.40.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 09:40:08 -0700 (PDT)
In-Reply-To: <xmqqk2t91e5y.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Aug 2015 16:58:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275471>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> On Wed, 2015-08-05 at 15:55 -0700, Junio C Hamano wrote:
>>> * dt/untracked-subdir (2015-08-05) 2 commits
>>>  - DONTMERGE: Waiting for an Ack from Duy
>>>  - untracked-cache: fix subdirectory handling
>>>  (this branch uses dt/untracked-sparse.)
>>> 
>>>  This seems to break some tests.
>>
>> All tests pass for me locally.  What's broken for you?
>
> *** prove ***
> t7063-status-untracked-cache.sh .. Dubious, test returned 1 (wstat 256, 0x100)
> Failed 3/30 subtests
>
> Test Summary Report
> -------------------
> t7063-status-untracked-cache.sh (Wstat: 256 Tests: 30 Failed: 3)
>   Failed tests:  28-30
>   Non-zero exit status: 1
> Files=1, Tests=30, 27 wallclock secs ( 0.04 usr  0.01 sys +  0.15 cusr  0.67 csys =  0.87 CPU)
> Result: FAIL

So it turns out that you run "strace -k -o /tmp/tr" and never look
at /tmp/tr; I am guessing that this was a remnant of your debugging
while developing the test, sign of lack of proofreading before
sending the patch out, perhaps?

I didn't carefully read the remainder of the patch, but at the
minimum this needs to be squashed in.  They may be a reroll with
some more tweaks from you after other people comment on it, so I'll
keep this separate and squashable.

Thanks.

 t/t7063-status-untracked-cache.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index bb0e2a9..ca8dc3a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -486,7 +486,7 @@ test_expect_success 'test sparse status with untracked cache and subdir' '
 	avoid_racy &&
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
-	strace -k -o /tmp/st git status --porcelain >../status.actual &&
+	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
  M done/two
 ?? .gitignore
