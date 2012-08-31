From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 2/4] merge-base: "--is-ancestor A B"
Date: Fri, 31 Aug 2012 11:03:28 -0700
Message-ID: <CANiSa6i5tY_V_dhK0wSaKzy0xwvN9uTqRJUJ7ZvgqCG7Ta5rsQ@mail.gmail.com>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
	<1346368388-23576-3-git-send-email-gitster@pobox.com>
	<CANiSa6iy60Ts5Rdss6EwGN5Vp9KCqn35BzMC+Aacm+zqWjp4-w@mail.gmail.com>
	<7vtxvjnfcu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 20:03:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7VZ9-0006Dj-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 20:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab2HaSD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 14:03:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54434 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab2HaSD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 14:03:28 -0400
Received: by iahk25 with SMTP id k25so1620549iah.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RMo9OkSFNZdP8ef1Ea50TK+VIbDVlTYPsR0VaThtgOM=;
        b=F7w836kdLVinkcIgiyZ0OCQU4IX2AkbSAWiIEMUKSPGcA1PvF8J0TPlWVq7uIzbJk5
         eWyATXvIc/Q2LC/GfyXXvQBIH5i3GY0fqWw4CwEByo8uEZIxoNaxyH4vWzREacgV3CYC
         ORpn8KDltBRigDLkorQpeeWRyyxhawy+u8tdB8lnImunsDlBlFRklvqH6949tsf7u7iH
         +/t5vJTBbFQup7hVFznQuq7HOfzQO0kMtTOSKb6BFXrCCSsPGfAdsUW6Bsh3NuP750by
         ZtaP9qh3zMaJl4zGGuZO7GaQjW7DrP4Jo4kkE0+Cv+/mW99sFxTvZG6fEukY5p1ecl2t
         /pZw==
Received: by 10.50.207.106 with SMTP id lv10mr4007624igc.0.1346436208084; Fri,
 31 Aug 2012 11:03:28 -0700 (PDT)
Received: by 10.64.36.138 with HTTP; Fri, 31 Aug 2012 11:03:28 -0700 (PDT)
In-Reply-To: <7vtxvjnfcu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204600>

On Fri, Aug 31, 2012 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>>> +       if (argc != 2)
>>> +               die("--is-ancestor takes exactly two commits");
>>
>> I think git merge-base shows the usage message regardless if argc < 2,
>> so this only happens when more than two arguments are given.
>
> Yes, but it is a good discipline not to depend too much on what
> other parts of the code may have done, when you do not have to.

Yes, I definitely agree. It was more that when I saw this line and
then tried it out, I was a little surprised that it didn't tell med
"--is-ancestor takes exactly two commits" when I gave it only one. But
since few users read the code before running the command, it will
probably not be too surprising :-)

>> Maybe
>> include --is-ancestor in the usage message?
>
> I think "merge-base -h" will get this for free thanks to parseopt.

It seems not, or maybe I'm using the wrong terminology; I meant to
include it in the first part of the below.

usage: git merge-base [-a|--all] <commit> <commit>...
   or: git merge-base [-a|--all] --octopus <commit>...
   or: git merge-base --independent <commit>...

    -a, --all             output all common ancestors
    --octopus             find ancestors for a single n-way merge
    --independent         list revs not reachable from others
    --is-ancestor         is the first one ancestor of the other?


>  'git merge-base' [-a|--all] --octopus <commit>...
> +'git merge-base' --is-ancestor <commit> <commit>
>  'git merge-base' --independent <commit>...

Ah, I guess this is what I was looking for. The remainder of the patch
looks good too. Thanks.
