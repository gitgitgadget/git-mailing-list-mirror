From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Fri, 11 Jul 2014 10:59:32 +0200
Message-ID: <CAP8UFD0_m5aFVcBQr3d9pXR=9rLjAVPGrj=UsBYFcnTQFwNKGA@mail.gmail.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
	<xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
	<xmqqr41t88dz.fsf@gitster.dls.corp.google.com>
	<xmqqegxt86ba.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:59:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Wg7-0007mY-H0
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 10:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaGKI7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 04:59:35 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:59710 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaGKI7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 04:59:33 -0400
Received: by mail-vc0-f170.google.com with SMTP id hu12so352444vcb.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YwLx7UEJRfpaDWWcI3nuMZ8D8t8m486Gcooyhf3OU5o=;
        b=FQ1Gos3L4l1iJNsLO2nS/q0QoX4ZQrJA9Wj5h6Q4NxfkBGPWs2pwQngpbRX1CjteW/
         3ewHyeT2qr9nOBeu2kyNSx9iEheQrlrxF9VxZ1QaqicMwWHwHxZXRBE1QOCh5QYAIxpn
         aYqN2bmyB5QOKTscAHLmXVfpuAEMva2lgMNTI9udBLh6VFiexVUzLnZg8yFwqTs3N5li
         Gfc0BwazyOpw10nDWNinBJiW2LfdDXg6e6bvIWhzn77gCNrRfQOtjiPQsfupCpr/GskG
         l0pHO1/tg7c1ri8x5bHUdjH1Eba8ASeJb1g4NglPG5b3yOHftZYlUomuhtgSrOyoNNZ4
         dUlQ==
X-Received: by 10.58.34.169 with SMTP id a9mr50520585vej.5.1405069172714; Fri,
 11 Jul 2014 01:59:32 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Fri, 11 Jul 2014 01:59:32 -0700 (PDT)
In-Reply-To: <xmqqegxt86ba.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253263>

On Thu, Jul 10, 2014 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>
>>> As the user might expect that a new replace ref was created on success
>>> (0 exit code), and as we should at least warn if we would create a
>>> commit that is the same as an existing one,...
>>
>> Why is it an event that needs a warning?  I do not buy that "as we
>> should at least" at all.

Here you ask why this event needs a warning...

> Ehh, it came a bit differently from what I meant.  Perhaps s/do not
> buy/do not understand/ is closer to what I think---that is, it is
> not like I with a strong conviction think you are wrong.  It is more
> like I do not understand why you think it needs a warning, meaing
> you would need to explain it better.
>
>> If you say "make sure A's parent is B" and then you asked the same
>> thing again when there already is a replacement in place, that
>> should be a no-op.

(When there is already a replacement in place we error out in
replace_object_sha1() unless --force is used. What we are talking
about here is what happens if the replacement commit is the same as
the original commit.)

>> "Making sure A's parent is B" would be an
>> idempotent operation, no?  Why not just make sure A's parent is
>> already B and report "Your wish has been granted" to the user?

... and here you say we should report "your wish has been granted"...

>> Why would it be simpler for the user to get an error, inspect the
>> situation and realize that his wish has been granted after all?

... but for me reporting to the user "your wish has been granted" and
warning (or errorring out) saying "the new commit would be the same as
the old one" are nearly the same thing.

So I wonder what exactly you are not happy with.

Is it the fact that I use the error() function, because it would
prefix the message with "fatal:" and that would be too scary?

Is it because with error() the exit code would not be 0?

Is it because the message "new commit is the same as the old one:
'%s'" is too scary or unnecessarily technical by itself?

Is it ok if I just print the message on stderr without "warning:" or
"fatal:" in front of it?

By the way, when I say "As ... and ..., I think it is just simpler to
error out in this case.", I mean that it is simpler from the
developer's point of view, not necessarily for the user.

Of course I am ok with improving things for the user even if it
requires more code/work, but it is difficult to properly do that if I
don't see how I could do it.

Thanks,
Christian.
