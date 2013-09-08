From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Sun, 8 Sep 2013 00:01:11 -0500
Message-ID: <CAMP44s3PPrtr2ham2LWeeGu3tV+2qBd2Xhv1X5RCntbubUvFuw@mail.gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
	<CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
	<xmqqtxi1o6kf.fsf@gitster.dls.corp.google.com>
	<CAMP44s1Q6YjVnVz3OnT=cE+ozUddBxFzM1r_WT5QoR7sP6-9Sg@mail.gmail.com>
	<xmqq61ugo67v.fsf@gitster.dls.corp.google.com>
	<CAMP44s2PFVAKRUkEyN8BAH8C5UUMn21ou9hNkcOXaCsXscywHQ@mail.gmail.com>
	<20130908045606.GF14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 07:01:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIX7d-0003zf-Au
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 07:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab3IHFBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 01:01:13 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:63894 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab3IHFBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 01:01:12 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so3909927lab.40
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 22:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ilcOOF+fJlO4mAtnmgjFnMk1gD+r3fqpL7qhlG9m3D8=;
        b=IN7zwEuT2g5aSnU9gwZJ7zUWPjdAKFfGcIc9eiM4LK+kYg8Y8jVizyy7fr30Yl3z+P
         yN1f4juGX6Xiq2Yf+43a6Zf7D/FYnn13QdDGip0zBWfPLk0hRTCuWb9cGtAVspOKOGRl
         RF7tcIyAGdDTMjOoCkgWFPpTFNvqda6nkTb/NVuQh28FK2RrdoLv/1mEYqXtRyLGR/0G
         0q4tQxNno6cMlhyoelmOlclY4a5wMyjU3Gka7/QSXxmHrRdxsAuGOjRe2XAs24KJM547
         VempGG/aDkRrfA9DMJSG40/YB9/k5bei5v53PY8mMm1oAdviNTdEUKK42oJatT3+E/8/
         U7mw==
X-Received: by 10.112.51.166 with SMTP id l6mr10385860lbo.5.1378616471362;
 Sat, 07 Sep 2013 22:01:11 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 22:01:11 -0700 (PDT)
In-Reply-To: <20130908045606.GF14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234182>

On Sat, Sep 7, 2013 at 11:56 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 07, 2013 at 10:02:59PM -0500, Felipe Contreras wrote:
>
>> 'git checkout -' works perfectly fine, and it's the closest we have to
>> my suggested test_checkout() which I think would be ideal, but I'm not
>> going to work on.
>
> I do not think it works perfectly fine if the checkout itself fails. For
> example, after your patch, one of the tests reads:
>
>   test_when_finished "git checkout -" &&
>   git checkout HEAD^{} &&
>   test_must_fail git branch --set-upstream-to master
>
> The cleanup is undoing what happened on the second line. So if we fail
> on the third line, it does what we want. If we fail on the second line,
> then what branch are switching to?
>
> I think you would at least want to reverse the order as:
>
>   git checkout HEAD^{} &&
>   test_when_finished "git checkout -" &&
>   test_must_fail git branch --set-upstream-to master
>
> so that you know you are actually going to the pre-test state.

Yeah, that would be better and easily achievable.

-- 
Felipe Contreras
