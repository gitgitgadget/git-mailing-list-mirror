From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sat, 8 Aug 2015 12:33:03 +0530
Message-ID: <CAOLa=ZT+hCgM+mL2vQknwUjaxG9Mr4C2Qir=aa==Fv9CebYwLg@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
 <1438800854-19901-1-git-send-email-Karthik.188@gmail.com> <CAPig+cTOzZ0RFd2eu43rYQDnsXmfswbRx3=vN41BJf_BHON7tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 09:03:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNyAc-0004Y8-2r
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 09:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbbHHHDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 03:03:34 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33623 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbHHHDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 03:03:33 -0400
Received: by obdeg2 with SMTP id eg2so93815687obd.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0Y6fCALnTKEpuf9FpwcnyNh/dM7yfysnjcV0WUYWu6k=;
        b=xlN+3fRFdiAdlLjKneM0HTA5PaVPObweajppoazVJRKLDym03DUXf6n5ssMApgL0OP
         jlYkk1i1xxvi/zO/fVTWtMPon7dyyPiDiYeKiRCUyHZpsvgQiGi3JWY1Xpuhy4LNwMAh
         V3UIGScPcbCTG0uhoLpdZ9QqdoGN2NFoSkcWe6akwYWZ6YVx+zKZ+pqqJngiVkkw4vaQ
         tWJjRKG0uC2eVZk6elFxXcJiQ2N01JooMXluwvfy5w3YiphylT7mHFKkUhYCf5OBNXKp
         D2kGQg5MB9WYNO8sNB7ZnWiwq3VP9OS4Stg9RZHeTqU8AfUM/uf3J5aD03Q3fk5VJq4i
         s19Q==
X-Received: by 10.182.60.130 with SMTP id h2mr10357537obr.42.1439017412506;
 Sat, 08 Aug 2015 00:03:32 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 8 Aug 2015 00:03:03 -0700 (PDT)
In-Reply-To: <CAPig+cTOzZ0RFd2eu43rYQDnsXmfswbRx3=vN41BJf_BHON7tA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275509>

On Fri, Aug 7, 2015 at 9:34 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement an `align` atom which will act as a modifier atom and align
>> any string with or without an %(atom) appearing before a %(end) atom
>> to the right, left or middle.
>>
>> It is followed by `:<type>,<paddinglength>`, where the `<type>` is
>> either left, right or middle and `<paddinglength>` is the total length
>> of the padding to be performed. If the atom length is more than the
>> padding length then no padding is performed. e.g. to pad a succeeding
>> atom to the middle with a total padding size of 40 we can do a
>> --format="%(align:middle,40).."
>>
>> Add documentation and tests for the same.
>
> I forgot to mention in my earlier review of this patch that you should
> explain in the commit message, and probably the documentation, this
> this implementation (assuming I'm understanding the code) does not
> correctly support nested %(foo)...%(end) constructs, where %(foo)
> might be %(if:), %(truncate:), %(cut:), or even a nested %(align:), or
> some as yet unimagined modifier. Supporting nesting of these
> constructs will require pushing the formatting states onto a stack (or
> invoking the parser recursively).
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

Good point, I have been working on this parallely and it works for now,
I'll send that with the %(if) and %(end) feature. But for now, it should be
documented and added in the commit message.

Using a linked list of sorts where whenever a new modifier atom is encountered
a new state is created, and once %(end) is encountered we can pop that state
into the previous state.

-- 
Regards,
Karthik Nayak
