From: Junio C Hamano <gitster@pobox.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 10:41:54 -0700
Message-ID: <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:42:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5rF-0006ok-4y
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbbIJRl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:41:58 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33120 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbIJRl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:41:56 -0400
Received: by pacex6 with SMTP id ex6so49126029pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vfO40aHcee6itclzR1zXdA3sA8r/YyUdpiywILORGVE=;
        b=ESlI6LoJ1GZY+Qsp2OHk+C2sbI/ttxe6Acnzwpke4QVELspHi9Jdl1uNRjQLWX5xoE
         izeU/MoGGFgnHcn+bhpt4GrprOgiayvm9jguuUeaxaJA4QXY8NpPCaWEa7f/9Q6GcPbx
         w6D07sPwTBKxvJM8A1ge9wDOSsneWk/WCH0fqlB6YDfjzxFdFWoRA83NkJK7YK5gm+BD
         Mih4/a4gHobvdJ5mdGWLKtBQefV6cx9mBj54wqzkajJ9AOGSuuUOWUdM0Vzc4WzvSAfK
         grvC1/4iMNtteB2c/n9AcUkBBR2boUwJm3w5bbXO+cZQZqyMaO/UlU5KOpOZ22siYxvT
         iyWQ==
X-Received: by 10.68.189.161 with SMTP id gj1mr85471026pbc.4.1441906915954;
        Thu, 10 Sep 2015 10:41:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id pi9sm13152523pbb.96.2015.09.10.10.41.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 10:41:55 -0700 (PDT)
In-Reply-To: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	(Jacob Keller's message of "Thu, 10 Sep 2015 09:28:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277614>

Jacob Keller <jacob.keller@gmail.com> writes:

> Is there some other way? Would others be interested in such a feature?

Not me.

> I get very annoyed when I've written a nice long patch cover letter in
> vim before an email and then realize I should fix something else up,
> or accidentally cancel it because I didn't use the write "To:" address
> or something..

I smell a fallout of encouraging a suboptimal workflow made by
git-send-email here.  If you did not know that the command can drive
format-patch itself, your workflow would have been:

    $ git format-patch -o my-topic --cover master..my-topic
    $ vi my-topic/*.txt

and only after you gain confidence with the edited result

    $ git send-email $args my-topic/*.txt

which has no room for your grief/complaint to come into the
picture.  While rerolling, you can do the same

    $ git format-patch -o my-topic --cover -v2 master..my-topic

and reuse major parts of cover letter from the original round.

> I really think it should be possible to store something somehow as a
> blob that could be looked up later.

I think "should" is too strong here.  Yes, you could implement that
way.  It is debatable if it is better, or a flat file kept in a
directory (my-topic/ in the example above) across rerolls is more
flexible, lightweight and with less mental burden to the users.
