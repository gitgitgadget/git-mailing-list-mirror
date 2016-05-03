From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 3 May 2016 10:55:09 -0700
Message-ID: <CA+P7+xp=8hTgLkmsUFW2d6VF82hEdYxGa48N5HLY-gj1H3WJzQ@mail.gmail.com>
References: <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
 <20160420041827.GA7627@sigill.intra.peff.net> <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
 <xmqqwpngukin.fsf@gitster.mtv.corp.google.com> <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
 <1461969582.731.1.camel@intel.com> <CAGZ79kYx22oYobPxMkC03fGk-E9zaZZd2f+qafESkhcmFog7-w@mail.gmail.com>
 <1461970113.731.3.camel@intel.com> <xmqqfuu0uzn7.fsf@gitster.mtv.corp.google.com>
 <20160502180231.GA8812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"sbeller@google.com" <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 19:55:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axeXr-0006z8-5Y
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 19:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934561AbcECRze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 13:55:34 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36774 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbcECRza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 13:55:30 -0400
Received: by mail-oi0-f48.google.com with SMTP id x201so36060279oif.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/I+MkvZQOA6V+hZX2lolcJjnjSvMdastBWiBZf0cp1o=;
        b=nL7skYTmjGOV8pOwcX6XyZCFaJc2g3OdkrMgRzTzVc9JBjk83Bd/56JbkTUHh/EL62
         WoOK90UpMz6B8pg4Hqwu1qwRGfTMSR1T8Y2abiGieCyw1tDs+a6Q1L78wdzWTDYK3Y1h
         XkWVH4TWs3DYIKlO9F0V8iynwvthElh3cS/0HjUIeFUBaej2mcuZMakyC7mcuHUPUwty
         Z9KR/AWDZHIiz9wapkaM5ZWWjDT50hCVx+sFq51mTPF8PLJu9WJCDXZkCQ4D+Y1v7k7s
         0XuwHuECZ5Rzf3IuLYa11BF6mI2h1CgBVtLUaAL7eWH38eUtvI4RK9Ioap1/xJ3uVqrA
         iWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/I+MkvZQOA6V+hZX2lolcJjnjSvMdastBWiBZf0cp1o=;
        b=jIQX/quj8dgIlA+yDb/NZ4CGPxQvX1selyu3vI4p7y3VL7KGf60BtQ5U4ujsV3HwmD
         I4cng5M0E8hV2tSiW7rTEpHb8pYHT/Jc+WSGyELgFNhxCv740Oii935HwXPv1BWyYdNg
         KtbEI35QJl6u4r9vtkqGlJ2oD4EuqyMgNqC3eLG3Qio62zjXGTrdRyzI9QVaxVxI0dwb
         6oa8Yt9tU5eAL+2H4o9ONPvPNGAEF5/lG1uPWxGo9rHN1Q2Xjn1f15PJiH1NqOu9YYEg
         flZbgb/z8UbIAL6C3qstqINbUa8DWnlkFnBivJixJNciKJCvafTMmzUN6uhqnRK70PSQ
         pAqw==
X-Gm-Message-State: AOPr4FXbzaXag0bi/S97SbwOlFuJWhJDpy67XYPB5j2Lvr+A+DNr9jgHV04zKRRab2LwQ8U3/PjvxCjL7mPH4Q==
X-Received: by 10.202.60.194 with SMTP id j185mr2141516oia.196.1462298129614;
 Tue, 03 May 2016 10:55:29 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Tue, 3 May 2016 10:55:09 -0700 (PDT)
In-Reply-To: <20160502180231.GA8812@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293423>

On Mon, May 2, 2016 at 11:02 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 02, 2016 at 10:40:28AM -0700, Junio C Hamano wrote:
>
>> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
>>
>> > True. I think the chances that it needs such a thing are quite minor,
>> > and if an undocumented knob gets exposed it would have to become
>> > documented and maintained, so I'd prefer to avoid it. Given that the
>> > risk is pretty small I think that's ok.
>>
>> OK, then let's do only the "documentation" part.
>>
>> -- >8 --
>> Subject: [PATCH] diff: undocument the compaction heuristic knobs for experimentation
>>
>> It seems that people around here are all happy with the updated
>> heuristics used to decide where the hunks are separated.  Let's keep
>> that as the default.  Even though we do not expect too much trouble
>> from the difference between the old and the new algorithms, just in
>> case let's leave the implementation of the knobs to turn it off for
>> emergencies.  There is no longer need for documenting them, though.
>
> I agree with this reasoning. Thanks.
>
> -Peff

I think I agree too.

Thanks,
Jake
