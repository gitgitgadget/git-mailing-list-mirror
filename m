From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Sat, 18 Sep 2010 09:51:13 +0200
Message-ID: <AANLkTimN+rGCS7pokwSDVT75_LsU4aAsaHmw7Xi_HVm+@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201009171806.49774.jnareb@gmail.com> <AANLkTikjLNva7Jgh0xYeah1maFusfOiaLwY7+eixx8so@mail.gmail.com>
 <201009171917.44979.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 09:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwsDA-0005dW-VP
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 09:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab0IRHvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 03:51:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60466 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab0IRHve convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 03:51:34 -0400
Received: by iwn5 with SMTP id 5so2599353iwn.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8E2IoLtavnzFxTnHafHWhsDWf8r06Aw1lVTfBX2L+N0=;
        b=BetqRvs2G40ok0H9w8Ugm0xzzfaBPbFBr1dK0kgRvT7+l1SHLIpkNQ1P9L9nAmrqun
         cIZ4oUdGQ0taIm05JBLRUqg27lmwPXTg8IUbl2Z0p+xsMohTWKGcCaM3z9Gs14ThLX7l
         PLfQ0dr03cw0VG9x2/oTfgnUzrNzWBp+5oO/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J93s95Fdug0FycvKQObFB64Yjo+ci4GWrUiTA/SS8ZzySwhD3AOVNMUhWKd7zP+njS
         ocnv4ozcoITrm3/x3p3dadhPmhGO8GzSPuUrX4jTiO4152jpjIi9X9VxjuJv08FuO1rK
         eLzmYKd+svLnZ7DCjqnOvLFb0HcVchrItRH9o=
Received: by 10.231.148.20 with SMTP id n20mr6360024ibv.196.1284796293445;
 Sat, 18 Sep 2010 00:51:33 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Sat, 18 Sep 2010 00:51:13 -0700 (PDT)
In-Reply-To: <201009171917.44979.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156435>

On Fri, Sep 17, 2010 at 7:17 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Fri, 17 Sep 2010, Giuseppe Bilotta wrote:
>> On Fri, Sep 17, 2010 at 6:06 PM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>> Giuseppe Bilotta wrote:
>>>> On Fri, Sep 17, 2010 at 3:24 AM, Jakub Narebski <jnareb@gmail.com>=
 wrote:
>>>>>
>>>>> ... but I think that having separate subroutines for opening and
>>>>> closing tags is a bad design / bad API (except in some rare cases=
).
>>>>> It is begging for unbalanced HTML.
>>>>>
>>>>> It would be better if it was a single subroutine wrapping 'div' a=
round
>>>>> contents given either as a string, or via callback (subroutine re=
ference),
>>>>> in my opinion.
>>>>
>>>> I'm not sure that in this case the string or callback approach wou=
ld
>>>> be any cleaner. I'll see if perl supports closures or something li=
ke
>>>> that.
>>>
>>> Perl supports closures (thanks to anonymous subroutines 'sub { ... =
}'
>>> and lexical variables 'my $var'), see perlsub and "Function Templat=
es"
>>> in perlref.
>>>
>>> I also recommend free ebook "Higher-Order Perl" http://hop.perl.plo=
ver.com/
>>
>> Thanks for the suggestion. I'm still not convinced that such an
>> implementation would be better though. Aside from the general
>> aesthetical suckiness of passing closures around (and the experience
>> is not any more pleasurable in Perl), there's also the matter of the
>> calling convention to use. I can think of two options:
>>
>> (1) we make the function callable as git_do_group($class, $id, sub {
>> <closure that prints the content> }, <paramters that go to
>> git_print_header_div>), which is somewhat illogical since we're
>> specifying the content before the header,
>
> Why not
>
> =A0git_do_group($class, $id, <print_header_div parameters>, sub { ...=
 })
>
> or even use subroutine prototypes? =A0We can use 'pop @_' to get last
> argument of a subroutine.

Ah, I hadn't thought about pop to get the last parameter. I think it
makes sense. Ok, I'll give this syntax a try,

> [...]
>> Overall, I still get the impression that the current API is
>> considerably cleaner, even with the small counterweight of the risk =
of
>> leaving groups open (which is not something so dramatic anyway, IMO)=
=2E
>
> Might be.
>
> But as currently git_*group() is used in only one place, isn't it
> premature generalization ;-) ?

I noticed the same comment to patch 7/7, still writing the reply for
that patch. I believe the feature is useful enough to deem the
refactoring, and since it's written already why go back? ;-) (it also
makes the code cleaner IMO).


--=20
Giuseppe "Oblomov" Bilotta
