From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 5/9] receive-pack.c: move transaction handling in a
 central place
Date: Tue, 30 Dec 2014 15:33:54 -0500
Message-ID: <CAPig+cRWLKKw-AX_YqsKxLNUUCyMDmm_9AzkhUJGaYQhFmi=pQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-6-git-send-email-sbeller@google.com>
	<CAPig+cSYD+gBdEZ9TzWdeTEufzH6eJTbt=ZVS5imMJGjWnUFPA@mail.gmail.com>
	<CAGZ79kYufUcj858HGjJPTDGJgmTRv-YVR30zOtAURpP00NWEeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:34:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63UO-0001RI-PR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaL3Udz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:33:55 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36206 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbaL3Udz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:33:55 -0500
Received: by mail-yk0-f172.google.com with SMTP id 131so7404049ykp.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 12:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VP1WW49igC4HRxLMZIFDcSIMKEzdMyCvr+MLA/WY6fk=;
        b=bZ9Sqvzl9Aa09Gfqr+m9pqmqwKVT4fRcb6Vk5iX2Tyg8oChDGf/AY5k6GEfc4cnLlm
         jhsWaNLED/G/+C+7rrmUNWQBZcogGoY3mnVkaDf+IbvyQr/eyjPiKh2f7fvvYOB6X5Oi
         tdnBsbF4x7sHZXqlz4VrP4J5eptmUAp2FjqJL7+98ZB4WwtLlo3MNiqOW7AreqA4aERl
         v+hz/HXFjZDPPfatgIZSlswYK2WtV1YzEX6Y5Vrc/Tjr9Iyzh2aEztPTD/DQor2cBMWD
         xkcb7j8p/1v+fv9wHr+mlkw/G4uc0VKsRQ6bKRmn/KW7l1RAP9uTa1nF73yo5TnuoXqC
         IvjA==
X-Received: by 10.236.89.172 with SMTP id c32mr42603101yhf.180.1419971634367;
 Tue, 30 Dec 2014 12:33:54 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 30 Dec 2014 12:33:54 -0800 (PST)
In-Reply-To: <CAGZ79kYufUcj858HGjJPTDGJgmTRv-YVR30zOtAURpP00NWEeQ@mail.gmail.com>
X-Google-Sender-Auth: QUHmHsd7JzAQurg433myrasrmFU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261942>

On Tue, Dec 30, 2014 at 1:45 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Dec 30, 2014 at 12:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>>> No functional changes intended.
>>
>> Secondary information can be demoted to the end of the commit message.
>
> I think this would help in case there is a subtle bug introduced with
> such a commit.
> If you bisect it 2 years later and then ask yourself if that subtle
> behavior was
> intentional (can easily happen if the commit message is
> short/unclear). This would then
> tell you it's definitely a bug introduced. I believe to have seen such
> a comment
> somewhere in the history, but I cannot find it again. I'll drop it
> into the notes for now.

I think you misread or misunderstood my comment, which was that
secondary information should follow primary information in the commit
message. I did not suggest moving it below the "---" line.

"No functional changes intended" is meaningful and belongs in the
commit message, but it's not as important as the explanation and
justification of the change.

>>> +static void execute_commands_loop(struct command *commands,
>>> +                                 struct shallow_info *si)
>>
>> Style: Indent the wrapped line to align with the text following the
>> '(' in the first line.
>
> That's true. I have found this problem myself at another patch by
> Michael lately.
> If you apply the patch it is correctly aligned. If you view the patch
> however it is missaligned.
> Because of the leading plus sign the line in which the function
> signature starts is
> indented by one character. The other lines starting with a tab indent
> only to 8 character.

You're right. This one does align properly. Sorry for the noise.

(Of the two pointed out in patch 6/9, the first one also aligns
correctly; but the second does not.)
