From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: portability fix for string printing
Date: Fri, 8 May 2015 14:55:17 -0400
Message-ID: <CAPig+cQVpYseCs7V_zHbUhEbWitdNZx1UJgHSdd2svowBOxsYg@mail.gmail.com>
References: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
	<1431046619-2340-1-git-send-email-danny0838@gmail.com>
	<xmqqy4kzklhp.fsf@gitster.dls.corp.google.com>
	<CAPig+cQQSrQiSzp7Jat8LYH+RqYdpJ2XCXweAtrYE_QoLzSznQ@mail.gmail.com>
	<xmqqpp6alxiw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Danny Lin <danny0838@gmail.com>, git develop <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:55:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnQi-0002d5-HG
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbbEHSzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 14:55:20 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38592 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbbEHSzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:55:18 -0400
Received: by igbhj9 with SMTP id hj9so29167730igb.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pWKLf5Ax6I0yuv8hO/7LPMa8O1rS5Tcv+9gBGlb2qZc=;
        b=G4fHaR9Jq4OEAD5PvTKgyqn15HLbYZL0U8GQnmd7dt8grYlzAYZCN+Xp1+mJ9ZSEAz
         N7mUV/NLEwYW3ZvG2lAQu550zMu8xEtp+3IbbgkLuE/0PUkIKZT7tFQXiKLCO7VsIjr9
         polMhrAEksgz4RHAFkosk7RkKO1bHO83VboXsrvrqYnO40iH8YchOXCXKenAEDccJqyu
         mkzo7o0Pt5owfkDDM4qrX+WhTJCrWC3CKWuLcO26gPAMXL8U7Fk2oWjUf4x+a8oTGdrV
         VkRJz6kvBHHBGurl0u3REcVJOd2GuSQbraV34sUdNeHJd8ux+MejVFdmn9QK1H6gDKRI
         fGjw==
X-Received: by 10.42.250.70 with SMTP id mn6mr5917149icb.78.1431111317887;
 Fri, 08 May 2015 11:55:17 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 11:55:17 -0700 (PDT)
In-Reply-To: <xmqqpp6alxiw.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: hVw-05nFwblj1B2oVOoAet5hVmI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268645>

On Fri, May 8, 2015 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Fri, May 8, 2015 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Thanks, this looks good.  Will apply with a little bit of tweak in
>>> the log message.
>>
>> Hmm, I would say that the changes to debug() and say() should either
>> be dropped or moved to a separate patch (along with the first
>> paragraph of the commit message). With the introduction of the
>> progress() abstraction, there is no longer any need for changes to
>> say(), and the "better portability" rationale for changing say() and
>> debug() is never properly explained, and is thus nebulous at best.
>
> I justified them in this way.
>
>     contrib/subtree: portability fix for string printing
>
>     'echo -n' is not portable, but this script used it as a way to give
>     a string followed by a carriage return for progress messages.
>     Introduce a new helper shell function "progress" and use printf as a
>     more portable way to do this.  As a side effect, this makes it
>     unnecessary to have a raw CR in our source, which can be munged in
>     some shells.  For example, MsysGit trims CR before executing a shell
>     script file in order to make it work right on Windows even if it
>     uses CRLF as linefeeds.

Very nicely explained.

>     While at it, replace "echo" using printf in debug() and say() to
>     avoid tempting people introducing the same bug.

Okay, this works as reasonable justification for including those
changes in the same patch.

It might read a bit more fluidly if rephrased something like this:

    While at it, replace 'echo' with 'printf' in debug() and say() to
    eliminate the temptation of reintroducing the same bug.
