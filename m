From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Fri, 17 Sep 2010 19:17:44 +0200
Message-ID: <201009171917.44979.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <201009171806.49774.jnareb@gmail.com> <AANLkTikjLNva7Jgh0xYeah1maFusfOiaLwY7+eixx8so@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 19:17:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OweZM-00009r-8H
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 19:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab0IQRRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 13:17:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44225 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0IQRRq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 13:17:46 -0400
Received: by bwz11 with SMTP id 11so2831234bwz.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Q7Omu8AsC7HK6iOxmaRDmCoMjIfl7g6Wj2t8uCDxRLg=;
        b=BoNnh6sWlsOrGLGqM91RPxfhYmqnQqgiTMS8QjKhHEcQ/iSbfEa4f8c9cPocOi6Fd5
         81EQT7cSN8okio6YLJ8t1s3KrqsqQt5qlNfUZDb8LxoVcPu4+6TCU9s3by0U/MANy/Hv
         jKYvXKwr0tEMuSLT9i4xSDUA8A95vl/foUm/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=x9buiHUbYSo7sNFq8omlbKkozXwEhF7wklyqqUMKu4TQimPK2rV3IdCmh45978Bysp
         2qNihYnBxbVEML65G3Eenyt58ARy62j2KUyU5Uq2JgOnffSzA7FQ9nMblIawZGoNZgBc
         rVU0MT6/kpKjlV+WfH5ou8SpYTewxJR4Sz/YA=
Received: by 10.204.50.204 with SMTP id a12mr4038315bkg.117.1284743865263;
        Fri, 17 Sep 2010 10:17:45 -0700 (PDT)
Received: from [192.168.1.13] (abvo68.neoplus.adsl.tpnet.pl [83.8.212.68])
        by mx.google.com with ESMTPS id x13sm3823561bki.0.2010.09.17.10.17.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 10:17:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikjLNva7Jgh0xYeah1maFusfOiaLwY7+eixx8so@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156401>

On Fri, 17 Sep 2010, Giuseppe Bilotta wrote:
> On Fri, Sep 17, 2010 at 6:06 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Giuseppe Bilotta wrote:
>>> On Fri, Sep 17, 2010 at 3:24 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>>
>>>> ... but I think that having separate subroutines for opening and
>>>> closing tags is a bad design / bad API (except in some rare cases).
>>>> It is begging for unbalanced HTML.
>>>>
>>>> It would be better if it was a single subroutine wrapping 'div' around
>>>> contents given either as a string, or via callback (subroutine reference),
>>>> in my opinion.
>>>
>>> I'm not sure that in this case the string or callback approach would
>>> be any cleaner. I'll see if perl supports closures or something like
>>> that.
>>
>> Perl supports closures (thanks to anonymous subroutines 'sub { ... }'
>> and lexical variables 'my $var'), see perlsub and "Function Templates"
>> in perlref.
>>
>> I also recommend free ebook "Higher-Order Perl" http://hop.perl.plover.com/
> 
> Thanks for the suggestion. I'm still not convinced that such an
> implementation would be better though. Aside from the general
> aesthetical suckiness of passing closures around (and the experience
> is not any more pleasurable in Perl), there's also the matter of the
> calling convention to use. I can think of two options:
> 
> (1) we make the function callable as git_do_group($class, $id, sub {
> <closure that prints the content> }, <paramters that go to
> git_print_header_div>), which is somewhat illogical since we're
> specifying the content before the header, 

Why not

  git_do_group($class, $id, <print_header_div parameters>, sub { ... })

or even use subroutine prototypes?  We can use 'pop @_' to get last
argument of a subroutine.

[...]
> Overall, I still get the impression that the current API is
> considerably cleaner, even with the small counterweight of the risk of
> leaving groups open (which is not something so dramatic anyway, IMO).

Might be.

But as currently git_*group() is used in only one place, isn't it
premature generalization ;-) ?
-- 
Jakub Narebski
Poland
