From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 08/19] reset.c: share call to die_if_unmerged_cache()
Date: Thu, 10 Jan 2013 00:51:59 -0800
Message-ID: <CANiSa6jeD6=fuXoQD5UWX1ZX18OFAVYTPLEuVi5vp6R0ivLLzQ@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
	<1357719376-16406-9-git-send-email-martinvonz@gmail.com>
	<7vlic25e9d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 09:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtDs6-0000zQ-6w
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 09:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab3AJIwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 03:52:00 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34158 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab3AJIwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 03:52:00 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so389098ieb.3
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 00:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ih1CQ7EQ2KaS5oiey8YLI26u5maz9c10wkHqfsjrYrs=;
        b=YBnE60rwDh5Wv3CFT4HtxBhgDCLtgIuA6X0kiTyUB/O1blp0k3zNzM7N2gk7sr1nxB
         8u/QC3IttYs4xTQJgLfsdUNLmVSKYWBmhiWhjek1lwvBCn0w2S/8ubG6Vc1oy14zrgeE
         jYWLuwp17L8WwEYQ0O5NihG1q/LYfoBhiISCB42PP9fTYO3/jaXv/Ve1Y3WnwDWV3plu
         2hZcTUJuFZeTkb5cgjracBzR2ehmvYsQLFSLjgvbFKmmBvpk2QmXm3CTy3DP4uDfhlbw
         IvsFditdyK3dm05HkOX5mCZpzQFcxtGp9eUFacyYwo/4b53B7k3S1Zd6oiiv0bYSkUsK
         OPCA==
Received: by 10.50.33.233 with SMTP id u9mr4901155igi.39.1357807919829; Thu,
 10 Jan 2013 00:51:59 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Thu, 10 Jan 2013 00:51:59 -0800 (PST)
In-Reply-To: <7vlic25e9d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213130>

On Wed, Jan 9, 2013 at 11:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> Use a single condition to guard the call to die_if_unmerged_cache for
>> both --soft and --keep. This avoids the small distraction of the
>> precondition check from the logic following it.
>>
>> Also change an instance of
>>
>>   if (e)
>>     err = err || f();
>>
>> to the almost as short, but clearer
>>
>>   if (e && !err)
>>     err = f();
>>
>> (which is equivalent since we only care whether exit code is 0)
>
> It is not just equivalent, but should give us identical result, even
> if we cared the actual value.

If err is initially 0, and f() evaluates to 2, err would be 1 in the
first case, but 2 in the second case, right?

I think the two might be identical in e.g. JavaScript and Python, but
I don't use either much.
