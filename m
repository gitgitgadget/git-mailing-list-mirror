From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 02/12] t4150: am fails if index is dirty
Date: Tue, 7 Jul 2015 14:35:59 +0800
Message-ID: <CACRoPnSTNxR4+NLX_f6FaOJPLj4k9ESaLrdwjfxhSZCZYHUOSw@mail.gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
	<1435861000-25278-3-git-send-email-pyokagan@gmail.com>
	<eb790f13314192dcf4787c54d4cd3cfb@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 08:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCMUB-0007b3-4e
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 08:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbbGGGgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 02:36:03 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:36567 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbbGGGgA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 02:36:00 -0400
Received: by lagc2 with SMTP id c2so181561298lag.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ttk/WqOXESP/bZrY9BkIlbVGgmOWQ+6sUvTTJBOOSWA=;
        b=LcpjFLRV8vtXoDuTsmTZjDADXzuWt9VvMxBNl2SKr/ZMKxgl1oTIjf93E5Z7wbjgTA
         C8me5u+t2IByvVYw2Mg8+Tt/cd4P6XH5AKOvOX1eXwPOMGM2V2lisrCPzWtOUwNCPXCe
         upvfbIuQVZSQVxeqqRFhBRQRpIqNhdq9QSg84ewdsUxPQT3F+bXsdIO6HfOSr1ShBxMJ
         O8ZhCt289NkBTlkhOItxJRksV/hban+TJXuImhI7SwTAAtnPsontdrO9BnUAoq2QqLXC
         qr9Hl9qxSR8rnv+FdJUL/pXVJnHg5Nv7Jf45+OfN63b53PCXl9sh5RqPNriZADV7lmCx
         IXbQ==
X-Received: by 10.113.10.135 with SMTP id ea7mr2476082lbd.65.1436250959370;
 Mon, 06 Jul 2015 23:35:59 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 6 Jul 2015 23:35:59 -0700 (PDT)
In-Reply-To: <eb790f13314192dcf4787c54d4cd3cfb@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273478>

On Sun, Jul 5, 2015 at 11:38 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-07-02 20:16, Paul Tan wrote:
>
>> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
>> index 3f54bdf..0a19136 100755
>> --- a/t/t4150-am.sh
>> +++ b/t/t4150-am.sh
>> @@ -154,6 +154,17 @@ test_expect_success 'am applies patch correctly' '
>>       test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
>>  '
>>
>> +test_expect_success 'am fails if index is dirty' '
>> +     test_when_finished "rm -fr dirtyfile" &&
>
> Seeing as you `git add` that file further down, how about `git rm -f dirtfile` here?

But "git rm -f" would fail if the file is not in the index, no? (Which
could happen if the git-reset or git-checkout fails) Anyway, the
purpose of the "rm -f" is to remove the dirtyfile, and not to clean up
the index (we would use git reset --hard for that).

(But yeah, I see that Junio noticed correctly that it should not be a
rm -fr, but a rm -f instead.)

Thanks,
Paul
