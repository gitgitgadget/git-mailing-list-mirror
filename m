From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 16:33:09 +0100
Message-ID: <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: szeder@ira.uka.de, git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 16:33:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZNv4-0005Bx-0W
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 16:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab2KPPdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 10:33:11 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58102 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2KPPdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 10:33:10 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2887451oag.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LCAMMswm7C1HHrvQMTV9rYsFTel5bBQQ9E62Y6o1Abw=;
        b=W1uzrBgWHaFmpxKQH65NRFEsZjZ7bzfbRHx3yyApH6Lzw73aWos3BVwN7AKmiv6Asz
         G9Or7cfSiOThJxtJK0hm0zaK/mwmbbTqtnPGkZTsMqWLmgbnlqFN7y4SE31LIrLxJHtz
         Tf4pp0LytIHo8U04p4CIDjeYvSkX2QdVpFehRp9vaQ4NjrUKyZ7sRWURZ7zVhtoHR8c/
         KUVsovsEZXRMVI3XXxZKAC7pfn4ac9taj1ifCN8ywS4hT4RvBcppjUnVVhkug6FJmLfp
         xgvMJlMER0//LEuoUm9IqDDLTl4CDRPi6t+PK4sYk2rrDD3vcVLKvCHP3zvR5dCS2bY0
         gQxQ==
Received: by 10.182.116.6 with SMTP id js6mr4051582obb.82.1353079989583; Fri,
 16 Nov 2012 07:33:09 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 07:33:09 -0800 (PST)
In-Reply-To: <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209880>

On Fri, Nov 16, 2012 at 3:39 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> On Thu, Nov 15, 2012 at 8:41 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Thu, Nov 15, 2012 at 12:51 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
>>> The current tcsh-completion support for Git, as can be found on the
>>> Internet, takes the approach of defining the possible completions
>>> explicitly.  This has the obvious draw-back to require constant
>>> updating as the Git code base evolves.
>>>
>>> The approach taken by this commit is to to re-use the advanced bash
>>> completion script and use its result for tcsh completion.  This is
>>> achieved by executing (versus sourcing) the bash script and
>>> outputting the completion result for tcsh consumption.
>>>
>>> Three solutions were looked at to implement this approach with (A)
>>> being retained:
>>>
>>>   A) Modifications:
>>>           git-completion.bash and new git-completion.tcsh
>>
>> As I said, I don't think this is needed. It can be done in a single
>> stand-alone script without modifications to git-completion.bash.
>>
>> This works:
>
> Thank you for taking the time to try things out.
>
> What you suggest below is an improvement on solution (C).
> I had chosen (A) instead because (C) creates a third script
> which gets generated each time a new shell is started.

We could generate the script only when it's not already present. The
disadvantage is that if this script is updated, the helper one would
not. One way to solve the problem would be to append the current
version of git, and figure a way to query it out. Another would be to
checksum it. But then again, maybe it's more expensive to check the
version or checksum than just write the file again.

Is it possible to just check if this is a login shell?

>> set called = ($_)
>
> I fought with this a lot before posting to the list.
> It seems that $_ is not set when a double sourcing
> happens.  Testing the solution as an actual user
> showed me that when I start a new shell it
> sources ~/.tcshrc, which then sources ~/.git-completion.tcsh
> and then $_ is empty for some reason.
>
> I couldn't find another way to figure out where the script
> is located, which is why I had to force the user to use
> ${HOME} for everything.

Ah :(

-- 
Felipe Contreras
