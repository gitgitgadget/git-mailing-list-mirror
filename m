From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Support customized reordering in version sort
Date: Fri, 20 Feb 2015 21:12:49 -0800
Message-ID: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
 <20150220071342.GB8763@peff.net> <CAPc5daVJ_nYk=tWqpUYPpsX6Z50H429jOh8QfMwUdNDdTDMq9w@mail.gmail.com>
 <20150221030209.GA567@lanh> <CAPc5daXtmvfgkFA_YeQxunjSWYGUQB0uWCQVgfxMP_M9fB9qEw@mail.gmail.com>
 <CACsJy8BFZ2O62f+QofSqZRoQ9BOX0SLnXHY_g93iMnyikW8H7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 06:13:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP2NP-0000Vh-Py
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 06:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbbBUFNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 00:13:11 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:54229 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbBUFNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 00:13:10 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so28323369obc.4
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 21:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mIVefUbpR1nM7O1MPp/qIzzFqR+/0xN+0ypwYYxN+ps=;
        b=LONRHfzkUSwZF5fKCCIyeZqvrvo2GZdNVlam4qhrXfcpD+VKGSaRLjsQxU9/GNH0Wr
         8/TD/vEz3sGspZX9+5u7ciKMwzrffQq9OiWQ8VNcwJM3L+9pGPHjbKAoUuJJPfaW1xFc
         x0y1qVUipCo1kaluaPVtcsdlgOanjgTGM7zdyhu2iQX1GBbsqpA2a5KnKhL92gFTZ+BE
         /+mGZ4HRMykjMRQ7fPmfgcdvSkg0HaSGN3qLJRdyaUdyeTF1eK0Bd68yu0mXmiGzzmRv
         Ie8IFwiCGVEzrYDy7S2lqpP39b9rAJk2K6FZGk0oka7kM2qgQ9SXMzp4tJ/ALADLCqWI
         L3ag==
X-Received: by 10.182.20.195 with SMTP id p3mr715904obe.1.1424495589677; Fri,
 20 Feb 2015 21:13:09 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 20 Feb 2015 21:12:49 -0800 (PST)
In-Reply-To: <CACsJy8BFZ2O62f+QofSqZRoQ9BOX0SLnXHY_g93iMnyikW8H7g@mail.gmail.com>
X-Google-Sender-Auth: qSRirD0Oh4IDZDs_T7ySiyuId70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264206>

On Fri, Feb 20, 2015 at 7:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Feb 21, 2015 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Fri, Feb 20, 2015 at 7:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>
>>> My idea is to make it easy for the user to change the sort algorithm.
>>> And it's probably intuitive to just substitute a string with
>>> something. So if "1-rc1" is put incorrectly before "1.1" and you
>>> realize that "1.999" ought to be the last one before "2". You could
>>> tell git to internally replace "1-rc1" with "1.999".
>>>
>>> This patch does that. The user feeds substitution rules via
>>> versionsort.substitute config keys, e.g.
>>>
>>>     git config versionsort.substitute "-rc .999"
>>
>> I would say 1-rc1 comes and then 1-rc2 and then 1-rc3 ... 1-rc10 and then
>> 1-rc11 and then finally 1. It will probably be followed by 1.1-rc1, 1.1-rc2, ...
>> and then 1.1 (aka 1.1-final).
>>
>> If 1-rc1 is equated with 1.9991 because -rc is replaced with .999, how does
>> it make 1 come after 1.99911, and 1.1.9992 come before 1.1?
>>
>> I didn't read the patch text and perhaps the explanation above is the only
>> thing faulty about your message, or perhaps my reading is faulty and the
>> above describes a sound idea, but I do not see how the above makes sense.
>
> No, faulty thinking. Back to the whiteboard..

One version of vercmp() I read went like this:

 (1) Chomp the version strings into an alternate runs of digits and
non-digits. e.g. 1.2.13 becomes
      "1", ".", "2", "." and "13" while 1.2.9 becomes "1", ".", "2",
"." and "9".
 (2) Compare corresponding elements with strcmp() for runs of
non-digits, and numerically for
      runs of digits. In the above example, up to the shared "1.2."
would compare equal, and the
      final run of digits, "13" and "9" are compared numerically and
we declare that 1.2.13 comes
      later.

I think you can add a twist by introducing "optionally this can
appear" substring. When there is
such an optional substring defined, you also define if the side that
lack the optional substring
comes before or after the side that has one. For example, you declare
"[-]rc" as "optional
substring that makes the owner of such a substring sort before others"
(call it "optional negative
substring") and comparing 2.0-rc12, 2.0-rc2 and 2.0:

 - "2.0" becomes "2", ".", "0" and "2.0-rc2" becomes "2", ".", "0",
"-rc", "2". Comparing them
   from left to right, the first difference is "lack of anything (2.0
side runs out tokens)" and
   "-rc", which is marked as optional negative. Hence 2.0-rc2 sorts before 2.0

 - "2.0-rc12" and "2.0-rc2" splits into tokens similarly. The first
difference you see will be
   after you match "-rc" and "-rc", which is "12" vs "2". Comparing
them numerically, you
   know "2.0-rc12" comes later.

You can define values to optional negatives and optional positives to
express a more
elaborate sort order e.g.

  1.0-pre12 < 1.0-rc0 < 1.0 < 1.0-post1

even though "-post" does not have to be declared as optional positive.
