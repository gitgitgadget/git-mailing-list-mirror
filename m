From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 13:08:13 -0800
Message-ID: <CA+55aFz4Dy=-bC8ccWfmHpquAWH+Fm0abmkW_dVB9M5wpm3qkQ@mail.gmail.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>
	<54E31405.5040502@gnu.org>
	<xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
	<54E3A5E2.6060806@gnu.org>
	<CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
	<xmqqiof01ca9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNpNU-0000MR-8x
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 22:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbbBQVIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 16:08:16 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:45092 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbBQVIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 16:08:14 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so32627855igk.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 13:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7hLw0anNPKIGe9bQnpOlGjUuDakM4u3Np1f22LUDobA=;
        b=Z4DyRdKrpPBK8nuX5ZBy1bKRq0aAJPIhnwpp7QXgOLJWB0B50GWjoDSTC9yns3yXvz
         D9f0MU3PW9dYFNqowq7E1zFZcAkhYLA9HdbGq2S6lnbOcYEL0FwG9dJr+aMp0OPZyCKn
         hoKHyZrA/BdBH6SqttSJPf9SzA64hbr6BkoOceHXZrLko6DImKI7LQyyG/tJGGKfP4Dg
         qZAs4HyEkWGDQMxlW3LJbm1Yol5UpuvjJy7lbh6GEhe3kHRGpp3fK/BpkohrDhOkJKbS
         La+931y3quN6k5kTn8OpS65AIkWcOev+lY9/F8FNlPpoeBq8rFE/1EfUducBHUEZ89DP
         4DYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7hLw0anNPKIGe9bQnpOlGjUuDakM4u3Np1f22LUDobA=;
        b=fNh3hczK+VaKdGiBKI9RWFlUYZqjd4NVVRfX6Yw5R1VALpW2T80bxlYrpGtUaBpcXH
         ZYSgjWVaznfOhBP+Nc7s8thgl8IWYg9c704h6wksPcj3qFKy2dtDfU/nNC32zkqf5zp8
         s930zWFYxjaWQsPgWoAhqOXHQJoJVLlfsAd4E=
X-Received: by 10.42.152.201 with SMTP id j9mr31990972icw.25.1424207293675;
 Tue, 17 Feb 2015 13:08:13 -0800 (PST)
Received: by 10.36.60.10 with HTTP; Tue, 17 Feb 2015 13:08:13 -0800 (PST)
In-Reply-To: <xmqqiof01ca9.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 9cCS0__CgnhjpZp2myZK5eN_ymQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263986>

On Tue, Feb 17, 2015 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "HEAD should resolve as a tag" is not sensible, but "HEAD should
> locally DWIM to something sensible" is still possible, no?

I disagree. Why? Because what you have locally is *not* necessarily
the same thing you have remotely.

And that's *exactly* why people used to send me broken pull requests.
"git pull-request" would guess on things, and it would get the guesses
wrong, and write the pull request wrong.

> We could for example make the rule for unset $3 case like this:
> instead of the current "missing $3 is a request to pull HEAD":
>
>     If you have one and only one signed tag that happens to point at
>     the commit sitting at HEAD, behave as if that tag was given as
>     the third argument from the command line.

If you verify that "one and only" to be true both locally and
remotely, then I guess I would be ok with it. But it really would have
to be unique. And truly unique, as in no confusion about branches or
tags, only one or the other. Because the "tag vs branch" was one of
the main sources of confusion that made me repeatedly get bad pull
requests, particularly when there was something locally that wasn't
actually named the same thing remotely.

                         Linus
