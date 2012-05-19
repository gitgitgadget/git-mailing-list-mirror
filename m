From: Carsten Mattner <carstenmattner@googlemail.com>
Subject: Re: git-completion with bash alias
Date: Sat, 19 May 2012 09:50:59 +0200
Message-ID: <CACY+HvryQvZedBhYjeG3O2GvvrqipvZFm3kW5mcm70mdrFjVLg@mail.gmail.com>
References: <CACY+Hvqd6L7gWgDBvjPmLPsfA2o1CVKuqkDZ_j7XYf=WjuwvKQ@mail.gmail.com>
	<20120519004147.GE765@sigill.intra.peff.net>
	<CAMP44s3DzJFoXTbUKEKUKcSs1TRWGW+2Ze+zMA1ch2eVgtu9bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 09:51:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVeRP-0000dn-14
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 09:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758585Ab2ESHvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 03:51:01 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57731 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489Ab2ESHvA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 03:51:00 -0400
Received: by obbtb18 with SMTP id tb18so5049183obb.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QEtYHrRgw4v1lCr+hHY3d7THKlGLKQ+u7JAVNr8BpIo=;
        b=yWHegeZLwhG7rmauS6DFZRhU5WmaOj8gYbOkVE27ODsnP+w2cxWjFv7CEp91UliakR
         6kR1WUX1sNrc6kbytPQKbZ9qpKyvneHRKQ15Xfv3IOosTVaSQOUCU9U4Nt9mZw5EfK7I
         SGeOe0e+UD/IFunxp+qflqwrBw3FTU29L/7dmt5PfM7xkL3tdfNYT0DrDCU2PRwaLQHB
         9nm8Hw89TvfccKSbW7wFNc+fUIcEVNr7po6HkASml8XUpszEr3su8zTo4WN+1sR6lNGW
         equYI3qSZ+/PI7Nn0D7TsKHED0BkCXvSfAAjSk8sKkmqm6srxRQIRMTZQPFnyVD/K83A
         TWUA==
Received: by 10.50.213.71 with SMTP id nq7mr2673937igc.12.1337413859998; Sat,
 19 May 2012 00:50:59 -0700 (PDT)
Received: by 10.50.6.231 with HTTP; Sat, 19 May 2012 00:50:59 -0700 (PDT)
In-Reply-To: <CAMP44s3DzJFoXTbUKEKUKcSs1TRWGW+2Ze+zMA1ch2eVgtu9bA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198024>

On Sat, May 19, 2012 at 4:28 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, May 19, 2012 at 2:41 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, May 18, 2012 at 01:35:24PM +0200, Carsten Mattner wrote:
>>
>>> Completion works when used as "git checkout foo" but fails with
>>> "bash: [: 1: unary operator expected" when trying to complete
>>> via a single character shell alias like "alias g=3Dgit" as in
>>> "g checkout foo".
>>>
>>> git version 1.7.10.2.548.g9de9681
>>
>> Hmm. Are you invoking the completion like:
>>
>> =A0complete -F _git g
>
> s/_git/__git_wrap_git/
>
>> ? That used to work, but was broken by the recent 6b179ad (completio=
n:
>> add new __git_complete helper, 2012-05-14).
>>
>> The "new" way seems to be:
>>
>> =A0__git_complete g _git
>>
>> but that function is explicitly labeled as "not public". It looks li=
ke
>> there was a follow-on patch that was discussed to make a public vers=
ion,
>> but it got dropped.
>
> Well, _git was probably not public either.
>
>> I'm not sure if this regression is intentional, or if the "old" way =
even
>> worked reliably (I seem to recall people running into issues with
>> _get_comp_words_by_ref not being called properly sometimes, but I do=
n't
>> remember the details). So it's not clear to me if the right way forw=
ard
>> is fixing "complete -F _git" to work again, or if that way is just
>> broken, and a public version of __git_complete is the right path.
>>
>> Felipe, can you comment?
>
> The problem is with certain functions (e.g. _git_fetch), which are
> broken not only for aliases: try 'git --git-dir=3D$PWD fetch <tab>'.
>
> Should be easy to provide backward compatibility though.
>
> I'll send a patch soon.

Any advice what I should put after alias g=3Dgit to enable
completion for g? Temporarily using "__git_complete g _git".
