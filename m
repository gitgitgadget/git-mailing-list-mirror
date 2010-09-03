From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Fix compat/regex ANSIfication on MinGW
Date: Fri, 3 Sep 2010 22:21:36 +0000
Message-ID: <AANLkTikqWap4nUamS=bx6oJ7mhUTEkFWpf7Hf=Mv1Ek=@mail.gmail.com>
References: <4C761EA2.2060904@viscovery.net>
	<OFF09696E1.DC0D98D7-ONC1257793.0070A82E-C1257793.00758522@DCON.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	johannes.schindelin@gmx.de
To: karsten.blees@dcon.de
X-From: git-owner@vger.kernel.org Sat Sep 04 00:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oredk-0006im-R3
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 00:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab0ICWVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 18:21:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60796 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab0ICWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 18:21:37 -0400
Received: by iwn5 with SMTP id 5so1896979iwn.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=6P/Pt+R2dCqKuYbxVpXrJ1fuDc2dnwR3lA0LiejGuWw=;
        b=s44idsh8vMu3lOJWkg0xRBiOrMTIjZb3gGp6PhnU426mb+1vTT1P8+56W/sdlg79S7
         4kHXO/wxd/k9wVLABxwfPXOqE1XlXHau9yxZoYwgqQ8ypHFnC9m+CXcFb0k+pjFuU1A2
         eVszzVPT2aIUpR9qZBRF1CrAVbi3dN/zzxzhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=d1g2Ec+t+RwCTYw8JdjQxG3LjHuCK/SEYt73Ozc/BP3EfLgMmb1UkjFbLHuCBwob4p
         3KeJfZmsvrpLP52LmuOqEYfJdNyFAAP0wxBVgEp+oGszBf+lvPoirs06RBNECw3WrcJB
         hCB1eFlf/qOBp4fOK/cwXFvjGXGF391in2T6Q=
Received: by 10.231.151.135 with SMTP id c7mr1481727ibw.184.1283552496546;
 Fri, 03 Sep 2010 15:21:36 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 3 Sep 2010 15:21:36 -0700 (PDT)
In-Reply-To: <OFF09696E1.DC0D98D7-ONC1257793.0070A82E-C1257793.00758522@DCON.DE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155280>

On Fri, Sep 3, 2010 at 21:23,  <karsten.blees@dcon.de> wrote:
>
> Johannes Sixt <j.sixt@viscovery.net> wrote on 26.08.2010 09:58:26:
>> Am 8/25/2010 20:24, schrieb Karsten Blees:
>> > this doesn't compile if internal_function is #defined non-empty (e.g. on
>> > mingw/msysgit). The old-style definitions work.
>> >
>> > In file included from compat/regex/regex.c:78:
>> > compat/regex/regexec.c:357: error: conflicting types for
>> > 're_search_2_stub'
>> > compat/regex/regexec.c:44: note: previous declaration of
>> 're_search_2_stub' was
>> > here
>>
>> Here's a fix.
>>
>
> Sorry, I realize I should've cross-posted this to the msysgit list (adding
> cc).
>
> In the meantime, Dscho has fixed the function definitions in the msysgit
> fork like so:
> static int internal_function
> re_search_2_stub (struct re_pattern_buffer *bufp,...
>
> Your patch removes internal_function from the declaration, so now it doesn't
> compile again...
>
> There're basically three solutions:
> 1. revert the whole ANSIfication stuff (stay in sync with glibc upstream)
> 2. add internal_function before function definition (like everywhere else in
> regexec.c - efe33c61 in git://repo.or.cz/git/mingw/4msysgit.git)
> 3. remove internal_function from declaration (ce518bbd)
>
> As I don't think you plan active development on this (or push changes
> upstream?), I'd opt for (1).

Yeah, wasn't the only reason they were ANSI-fied because Junio had
some script in the todo branch that explicitly used -Werror in
conjunction with a warning for k&r declerations/

I've forgotten what all these fixes to compat/regex were about, but if
that's the case 1) looks simplest.
