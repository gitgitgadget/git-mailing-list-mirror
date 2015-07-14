From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log fails to show all changes for a file
Date: Tue, 14 Jul 2015 12:16:48 -0700
Message-ID: <CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 21:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF5hG-0005sv-1g
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 21:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbbGNTQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 15:16:50 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33916 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbbGNTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 15:16:49 -0400
Received: by igvi1 with SMTP id i1so61505611igv.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=44+m2To6wYBU8pvzVryQvdScyR745sLoktaSwWRzb1w=;
        b=0UCtFHDNpmOjEkQf0f1EuccGaB5pOOoJyERH6AtBTO+eSW85NqxJVtuiRKr8R1GqSd
         gHw2hWSGn/ckB3fvFRHeiXNu3LUi255gJJfKvnEjmvishS1/6Rn7L6DA8G/YL+4m3LUH
         rpsMQCsHh9JexX3HKWam+W50IbMgHy3WNI43t/0isoFVClZqr1754pfTyF99N2qy25sT
         6V2J+wT8WOnDnTfqDsQJmSJJG2XhsuiogWL4zPj+ScsFXHFYxuTXJtnJJVv100HVjazt
         Vl19dda4ZO4PtGb5y+xTV5mgGy2x6mtyrgXCJkSv3CpPOnTm/FjAFtS61wv/fx+oLUta
         RZ0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=44+m2To6wYBU8pvzVryQvdScyR745sLoktaSwWRzb1w=;
        b=X2isd1TvrBjt3j9OXfPl4s71PPEUCZTO3aooSiAFVfMrCrXAhF1I4t6tOgFN6JeYq+
         Sika/aXY6R06MsBDwbTYWUphwjsQzP8cJHl8/wTL+XnkC0N5YNlAAzoO1WQYhpHyyIF/
         6x4vvYvw5fRjIrl4BCv6Z5sramvYa1HXkYJ5c=
X-Received: by 10.107.157.4 with SMTP id g4mr254815ioe.66.1436901408851; Tue,
 14 Jul 2015 12:16:48 -0700 (PDT)
Received: by 10.36.78.7 with HTTP; Tue, 14 Jul 2015 12:16:48 -0700 (PDT)
In-Reply-To: <20150714075955.GA24577@aepfle.de>
X-Google-Sender-Auth: Oad3oTY5OCIfISMlucqjyHO1sNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273973>

On Tue, Jul 14, 2015 at 12:59 AM, Olaf Hering <olaf@aepfle.de> wrote:
> On Tue, Jul 14, John Keeping wrote:
>
>> It was added in an evil merge (f9da455b93f6ba076935b4ef4589f61e529ae046),

That's not an evil merge. That's just a regular merge. One side had
changed the argument to "const":

 - 1b9d48f2a579 ("hyper-v: make uuid_le const")

while the other side had renamed the function and added an argument,
and changed the return type:

 - d3ba720dd58c ("Drivers: hv: Eliminate the channel spinlock in the
callback path")

an "evil merge" is something that makes changes that came from neither
side and aren't actually resolving a conflict.

That said, I do wonder if we should just make "-p" imply "--cc". Right
now we have the kind of odd situation that "git log -p" doesn't show
merge patches, but "git show <cmit>" does show them. And you kind of
have to know a lot about git to know the "--cc" option.

In fact, that "git show" behavior really is very subtle, but very
useful. It comes from show_rev_tweak_rev(), which is a magic git-show
thing.

               Linus
