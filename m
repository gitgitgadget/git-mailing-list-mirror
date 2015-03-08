From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is
 empty
Date: Sun, 08 Mar 2015 15:45:16 +0530
Message-ID: <54FC2134.3030806@gmail.com>
References: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>	<CAPig+cTkC1Y1sWJLpG0iUHju3GOMnvOT-nsAU51GykeV2QB+vA@mail.gmail.com>	<54FAD7D7.4030008@gmail.com>	<CAPig+cRDkoH-zmYhk9ag+Yiwg1h452hOpS2fx2H5xmu5KUNqiQ@mail.gmail.com> <xmqqvbict0y9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 11:15:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYF7-0004kF-Pf
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbbCHKPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 06:15:25 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44697 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbbCHKPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:15:20 -0400
Received: by padet14 with SMTP id et14so40748470pad.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vZXGMzzZv7guaDxFZE8WEPWI8NBH1KHK3/escxvjfWU=;
        b=hIf9tzmTPaX0t1yDEpoDZPEaftESiuoOz/uezenqKEruy5sIt31pingjVR7PErjYt3
         WLJCbKvk9eBXoJT55nsas+8gCRoTGVNf/E9IJXDeAkuKA6FCLmn/VYdvGKmA4KoVN/Q+
         O5wm6kt89FHbPVfAe8HNuKab/nTMYcC/IqpkMIj9v5Jcvapwr7MF+pEv2BNY4j/L7p3y
         vquj/Xgwz00l6+f/HwARlqysooVpAfhx2S+6prSRF7Lykc6j8zyhNlWO5bqZBrkaDD+r
         jx+iDaDg+Sqc4m/F4B680FMouxNN2HenWgNixrUqu99xbjLX4/LBZXKTqzOARBzK+cUG
         LgRA==
X-Received: by 10.68.101.130 with SMTP id fg2mr41719574pbb.118.1425809720090;
        Sun, 08 Mar 2015 03:15:20 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ki2sm14427745pdb.33.2015.03.08.03.15.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:15:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqvbict0y9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265079>



On 03/08/2015 12:44 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Sat, Mar 7, 2015 at 5:49 AM, karthik nayak <karthik.188@gmail.com> wrote:
>>
>>> Also "*(*argv)[1]" seems more readable to me, maybe more of a perspective?
>>
>> I also had considered suggesting (*argv)[1][0] as more readable, but
>> it is primarily personal taste, and I didn't want to bike-shed the
>> issue.
>
> I didn't mention that in earlier review rounds for the same reason,
> but I saw Andreas Schwab also independently made the same comment,
> so that makes three of us.
>
> That does not change the fact that this is merely a matter of
> preference; I wouldn't even call this one a "taste" (use of which
> implies that there are judgement involved, as in "good taste" and
> "bad taste").
>
> But because it is "preference", the only time we can discuss is when
> a new code is submitted and is under review.  Once it is in the
> tree, it is not really worth extra patch noise to go and change.
>
> As everybody knows, POINTER[0] and *POINTER are equivalent.  We have
> quite a few places where we say "let's treat passing an empty string
> the same as not passing an argument at all" with
>
> 	if (!POINTER || !*POINTER)
>          	; /* no-op */
> 	else {
>          	/* do something with POINTER */
>                  fn(POINTER);
> 	}
>
> and we could say !POINTER[0] instead of !*POINTER, interchangeably.
>
> We tend to prefer (again, I do not think this is particularly a
> "taste" thing) *POINTER over POINTER[0] when POINTER is just a
> single variable in the above pattern we often see in our code.
>
> But when POINTER is an expression like (*argv)[1], where you unwrap
> the operators according to their precedences, it often is easier to
> read if you do not have to flip your eyes left and right too often.
>
> You first look at "argv", then notice the prefix "*" (you have to
> move your eyes to the left here) and know argv points at a location
> that holds a pointer.  Then you notice the suffix [1] (now to the
> right) and know that pointer points at an array and the expression
> is talking about in its second element.
>
> Now, you want to say that second element is actually a pointer to a
> string and want to talk about the beginning of that string.  If you
> express it as "*(*argv)[1]", it forces the reader to go back to the
> left end once more.  If you write it as "(*argv)[1][0]", the reader
> can keep going to the right, starting from the last thing the reader
> read and understood (which is the "[1]" at the right end).
>
> At least, that is how I analyze _my_ preference---the latter feels
> easier on my eyes.
>
> But as I said this is a mere preference thing.
>

The way you put it, it makes a lot of sense that most would prefer 
"(*argv)[1][0]" rather than "*(*argv)[1]".

Thanks for clearing that out.
Regards
-Karthik
