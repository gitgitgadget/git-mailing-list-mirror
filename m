From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Fri, 17 Sep 2010 18:41:06 +0200
Message-ID: <AANLkTikjLNva7Jgh0xYeah1maFusfOiaLwY7+eixx8so@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201009170324.25801.jnareb@gmail.com> <AANLkTikk7vUFMr31Azdcpe+PK0-yA2sp2EcnHjdfw0Zn@mail.gmail.com>
 <201009171806.49774.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:41:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owe0D-0001CK-2N
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab0IQQl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 12:41:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63386 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0IQQl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 12:41:27 -0400
Received: by iwn5 with SMTP id 5so2115397iwn.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=1OheDU2uPVDbOTImvWviMrJzd3DYZtczXpkQuNBb4rU=;
        b=IDy1otOHlchmhePvmfi41XX1WNx5rU7qUAxpHCSMkM64Xm5M/S9j2LyFDVX6kv3IG5
         nEQcUlj5mznJuvwH7MKeI5AteFSZCDNiheogOjcrxsy6+FoJJlFghtCbzXbC9k9QbN8z
         WRgVAM1F/36CGuihp5Q924uHtkzkU142BufIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fytv4ab5F+bZS02EZZ8lr2l2b6Kwj6XQR0nwcDPwPoxT/LQlaQAlb4Gl3eoPcZxdA2
         ju4T0vL5UZv0l6EHekLUg2rkmmjLtf+DmN/WPg4RVPjShhYgNXJZweGyMXQaKNI1s7v7
         OD6KsBXki3H+l2trqhY2YsdwmnK1Y6DPUoVVA=
Received: by 10.231.34.139 with SMTP id l11mr5411283ibd.141.1284741686254;
 Fri, 17 Sep 2010 09:41:26 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Fri, 17 Sep 2010 09:41:06 -0700 (PDT)
In-Reply-To: <201009171806.49774.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156397>

On Fri, Sep 17, 2010 at 6:06 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>> On Fri, Sep 17, 2010 at 3:24 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> >
>> > ... but I think that having separate subroutines for opening and
>> > closing tags is a bad design / bad API (except in some rare cases).
>> > It is begging for unbalanced HTML.
>> >
>> > It would be better if it was a single subroutine wrapping 'div' around
>> > contents given either as a string, or via callback (subroutine reference),
>> > in my opinion.
>>
>> I'm not sure that in this case the string or callback approach would
>> be any cleaner. I'll see if perl supports closures or something like
>> that.
>
> Perl supports closures (thanks to anonymous subroutines 'sub { ... }'
> and lexical variables 'my $var'), see perlsub and "Function Templates"
> in perlref.
>
> I also recommend free ebook "Higher-Order Perl" http://hop.perl.plover.com/

Thanks for the suggestion. I'm still not convinced that such an
implementation would be better though. Aside from the general
aesthetical suckiness of passing closures around (and the experience
is not any more pleasurable in Perl), there's also the matter of the
calling convention to use. I can think of two options:

(1) we make the function callable as git_do_group($class, $id, sub {
<closure that prints the content> }, <paramters that go to
git_print_header_div>), which is somewhat illogical since we're
specifying the content before the header, or

(2) we make it like git_do_group($class, $id, sub { <closure that
prints header div> }, sub {<closure that prints the content>}), which
is even more horrible since the header div is just a
git_print_header_div

Overall, I still get the impression that the current API is
considerably cleaner, even with the small counterweight of the risk of
leaving groups open (which is not something so dramatic anyway, IMO).

-- 
Giuseppe "Oblomov" Bilotta
