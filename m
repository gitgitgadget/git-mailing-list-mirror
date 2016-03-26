From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tag.c: move PGP verification code from plumbing
Date: Sat, 26 Mar 2016 02:33:28 -0400
Message-ID: <CAPig+cSQ2+yc6UCM08zMUDXKFgRBj5FUUEe+wFLxGkykE2yKxA@mail.gmail.com>
References: <1458866017-15490-1-git-send-email-santiago@nyu.edu>
	<CAPig+cQe5bwHXq4_qegBCM8Kqoqiz7K2ZtVk0FGMSEUPWQHyYA@mail.gmail.com>
	<20160325144509.GA20375@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sat Mar 26 07:33:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajhn1-0001l5-Vl
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 07:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbcCZGdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 02:33:31 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34002 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcCZGd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 02:33:29 -0400
Received: by mail-vk0-f49.google.com with SMTP id e185so109244028vkb.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Idd9TAoixaBx/q1fAB6MhfWtG1wCDBpK+OAbTwkyGlE=;
        b=Hdhbqi2j2YxfpH2V4f4EuvC4IiT7PttjG7YziXqyhECB1a8AROFIogC6CmZhn2abQJ
         BVYthM8tru3YHEN3+Aa6adTaD1iO/ItKhxXx3+2cGEM18Rqqbew/MDtTfrkKhaVBU8eo
         bHIGNFj17dCJX+C/6RyqUYZtLLAlnP5n2eErRq6MEoqZjWvraRiAEIonn8AucJ907Tan
         f8H9B5bDZHtrv64epNhHHGdbCBik1nja++aLEsoeJxmUfhr4baDtTBG+TDkZZabdJQOZ
         ny4Hrcu+/k4fWTrwAPvLI6s1lb530JPzBtzijkYzBEikENZgTXUfQtrUoPPSR+BdAfQr
         mZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Idd9TAoixaBx/q1fAB6MhfWtG1wCDBpK+OAbTwkyGlE=;
        b=D/eAR3SyA7LIt0ZT2bwUtsblmHY2OdAMihQ/NhWiuvvqRI6D32Ltfj/O2x6TzuM0hF
         ZsABwpCloDkt8MUD7ydiFEfd0k0T4V3g44wbMcgrl7HIBcU1Zibdfhceg8pOqrY1d+11
         yPEd+F1AmpvNHFAr7NxkTL54+MGGkxt4A/b5avgpZxH7FQuQLZill2MsgVmEt8VAMAK/
         sQO/TCSNncv/UjvkSXULw1pcuSW/IqY9WeSgGi1sro9GWE0OPR3cSAG68XBKDh5tTJuB
         Y3ZVDhF6LaB4r7A1lM1PLQlKLXogCEvLpUSCOSH3Xkrsi2gQFV3JlxMYrkoaNF3x+uyW
         Wqzw==
X-Gm-Message-State: AD7BkJK7v4fTqMtU2ACin+NFajkjhLZrG8PdmTf/BWHdRx/Vb+i0SmGleaCQwK/luz/A3bO7u44bdVZPk28eLA==
X-Received: by 10.159.33.206 with SMTP id 72mr2588527uac.14.1458974008414;
 Fri, 25 Mar 2016 23:33:28 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 23:33:28 -0700 (PDT)
In-Reply-To: <20160325144509.GA20375@LykOS>
X-Google-Sender-Auth: 8p747WGg9Os8xsRK3KStdPVqE4I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289977>

On Fri, Mar 25, 2016 at 10:45 AM, Santiago Torres <santiago@nyu.edu> wrote:
>> >         while (i < argc)
>> > -               if (verify_tag(argv[i++], flags))
>> > +               name = argv[i++];
>> > +               if (get_sha1(name, sha1))
>> > +                       return error("tag '%s' not found.", name);
>> > +
>> > +               if (pgp_verify_tag(NULL, NULL, sha1, flags))
>> >                         had_error = 1;
>>
>> Meh, this isn't Python. Due to the missing braces, the only thing
>> inside the while() loop is the assignment to 'name'; all the other
>> indented code is outside the while().
>>
>> Did you run the test suite following this change? Did it all pass? If
>> so, perhaps an additional test or two to catch this sort of error
>> would be warranted.
>
> Wow, you're right! I just re-ran the tests again to make sure I didn't
> miss anything. All the tests pass for me, so I'll write an extra case to
> avoid this. Just to be sure, I should include it in t7030-verify-tag.sh
> right?

Generally speaking, it is desirable to have test coverage for all
functionality you're refactoring to ensure that the refactoring
doesn't break that functionality.

t7030-verify-tag.sh indeed seems like a good place to add a new test
for catching this sort of regression.

t7004-tag.sh is also of interest since, in an earlier version of this
patch, if I recall correctly, Peff caught a regression where "git tag
-v" failed to pass the GPG_VERIFY_VERBOSE flag, and I don't think
t7004-tag.sh would have caught that problem either, so a new test for
that would be good, as well.

Speaking of GPG_VERIFY_VERBOSE, now that I'm examining the changes
more closely, it appears that this version of the patch no longer
respects GPG_VERIFY_VERBOSE at all but is instead hard-coded to be
verbose. Is that desirable or intentional?
