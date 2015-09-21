From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Mon, 21 Sep 2015 12:52:28 -0700
Message-ID: <xmqq6133a6tf.fsf@gitster.mtv.corp.google.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<1441633928-18035-1-git-send-email-bernat@primeranks.net>
	<CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
	<xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
	<CAPig+cS7ObsWjqbLytCKp1PGF+224TYhC734dNa_HXYQ7p+GgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: =?utf-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 21:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze78e-0005kE-5u
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 21:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbbIUTwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 15:52:32 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35584 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbbIUTwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 15:52:31 -0400
Received: by pacfv12 with SMTP id fv12so127669582pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=e7Dc6lCqZqYBgja68mdLQKIcKGUTYRgw1JEiNsle68k=;
        b=bjLRR9Wg+3ZaZJBjq+CqPYG3TABQzhAwOHUQY2F2eCXf1oXzETNdEA/hstHJIYQq0h
         4ja7NqAgNGi8I3QIGn8+jUYpFzXA0X9ADAk5eipfKuze5LP8hiofPXMg3eIvGQB/VAST
         kEsViugf4s1Pf/MHgo6QMLw2Ig0DqnWu/fRJqi09UFkh3WE0y9t1ARnAkWldV5g+uiCN
         GlKGXmoGp08C0k1zPe3OqPKMG11DiLEkfvZ+k21IIJOhKTDQfY1cRVdvtPIbF4nw3zLa
         il0gBS4839niTMWr8KLwvkD+F6ebNf4qasPyLOjJMHHah12L5NaNd20w+T4HYwZQvP+K
         3jcQ==
X-Received: by 10.66.124.198 with SMTP id mk6mr26034991pab.114.1442865150527;
        Mon, 21 Sep 2015 12:52:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id qe3sm26010915pbc.73.2015.09.21.12.52.29
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 12:52:29 -0700 (PDT)
In-Reply-To: <CAPig+cS7ObsWjqbLytCKp1PGF+224TYhC734dNa_HXYQ7p+GgQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 8 Sep 2015 13:59:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278328>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Sep 8, 2015 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> On Mon, Sep 7, 2015 at 9:52 AM, G=C3=A1bor Bern=C3=A1t <bernat@prim=
eranks.net> wrote:
>>>...
>>>>  # Rewrite the commits
>>>> +report_progress ()
>>>> +{
>>>> +if test -n "$progress"
>>>> +then
>>>
>>> Indent code within the function...
>>
>> Also git_filter_branch__commit_count is now used only inside this
>> function, so it is easier to follow to increment it here.
>
> Make sense.
>
>>>> +printf "\rRewrite $commit ($git_filter_branch__commit_count/$comm=
its)$progress"
>>>
>>> The "\r" causes this status line to be overwritten each time throug=
h,
>>> and since the processed commit count always increases, we know that
>>> the original (without ETA) will never leave junk at the end of the
>>> line. However, with estimated seconds also being displayed, does th=
is
>>> still hold?
>>
>> Good point.
>> Perhaps like this squashed in?
>>
>> -printf "\rRewrite $commit ($git_filter_branch__commit_count/$commit=
s)$progress"
>> + printf "\rRewrite $commit
>> ($git_filter_branch__commit_count/$commits)$progress "
>
> Yes, for an expedient "fix", this is what I had in mind, although I
> would also have added an equal number of backspaces (\b) following th=
e
> spaces, as a minor aesthetic improvement.

This topic seems to have stalled.  I do not want to discard topics
because that means all the effort we spent to review and polish the
patch so far gets wasted, but we cannot leave unfinished topics
linger for too long.

=46or now, I'll queue this SQUASH??? on top as a minimum fix (renaming
of variables and other things noticed during the review may be worth
doing, but they are not as grave as the issues this fixes, which are
show stoppers).

I do not think our in-core progress code does that (and we do not
use ESC[0K either), so I'll leave it out of the minimum fix.


 git-filter-branch.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 565144a..71102d5 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -277,9 +277,8 @@ test $commits -eq 0 && die "Found nothing to rewrit=
e"
 # Rewrite the commits
 report_progress ()
 {
-if test -n "$progress"
-then
-	if test $git_filter_branch__commit_count -gt $next_sample_at
+	if test -n "$progress" &&
+		test $git_filter_branch__commit_count -gt $next_sample_at
 	then
 		now_timestamp=3D$(date +%s)
 		elapsed_seconds=3D$(($now_timestamp - $start_timestamp))
@@ -292,8 +291,7 @@ then
 		fi
 		progress=3D" ($elapsed_seconds seconds passed, remaining $remaining_=
second predicted)"
 	fi
-fi
-printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)$=
progress"
+	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)=
$progress    "
 }
=20
 git_filter_branch__commit_count=3D0
--=20
2.6.0-rc2-220-gd6fe230
