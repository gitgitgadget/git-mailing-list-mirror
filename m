From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] grep: correct help string for --exclude-standard
Date: Wed, 4 Mar 2015 18:46:57 +0700
Message-ID: <CACsJy8DVG7MZoJcSxkZX5kdE8tLT7HnNqDEins3a2aLThZbWPg@mail.gmail.com>
References: <1425045718-30696-1-git-send-email-pclouds@gmail.com>
 <20150304101606.GB15788@peff.net> <CACsJy8AW4=tsFLDcJb=is5UUdVyyFPD+AHi1v-xX=qCXLL_N2g@mail.gmail.com>
 <20150304112603.GA26545@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:47:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT7m1-0005hA-70
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 12:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759653AbbCDLr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 06:47:29 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40395 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759652AbbCDLr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 06:47:28 -0500
Received: by iebtr6 with SMTP id tr6so66308370ieb.7
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 03:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gpxPrdYpqGOodfo/2/XXRedfouIO6pTekTRY3bELK2g=;
        b=c+JbvR/bV0cpaDeZGVGK2hBFNu0TarxA561EO3Sf67kNEO9ixMVqf6Ghu3VXzIckjO
         6T/akt+jhqDa0MaWTLNk3GiDz7lmW7bwgjFkuBzWXxhQW+Am780D44g8Pp0X518s+CMh
         yVEnMJB+kVNSdXacU10SPY3A1Gk4CSTPD/i/cQYToEJyra0nqENpg/bVzl8lXBfLDojc
         EVdrU+XJfZce2TCrQ8FUpMo70O7SKUjF5JwMS74hoakR21aVZCpsMMlKpi9Tgn7oIEBa
         T9XHEe+KbW2Cn24gq9aghxVvli4ccnTyF0mIh+7VWVAy7/KDgmzi2FpLk+TLWq0hkQ6b
         3ssw==
X-Received: by 10.50.61.34 with SMTP id m2mr10382836igr.20.1425469647508; Wed,
 04 Mar 2015 03:47:27 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 4 Mar 2015 03:46:57 -0800 (PST)
In-Reply-To: <20150304112603.GA26545@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264756>

On Wed, Mar 4, 2015 at 6:26 PM, Jeff King <peff@peff.net> wrote:
>> > It might be nice if parseopt had a PARSE_OPT_NEGHELP option or something
>> > to show the "--no-" form.
>>
>> Regardless, yes it would be nice to have something like this. I think
>> there are places that can make use of this.
>
> Grepping around, it looks like the best form would be an OPT_NEGBOOL
> that acts like a boolean but negates the truth value, and advertises the
> negative form. We have a lot of:
>
>   OPT_BOOL('n', "no-checkout", &option_no_checkout,
>            N_("don't create a checkout"))
>
> where countermanding an earlier "--no-checkout" has to be spelled as
> "--no-no-checkout", rather than "--checkout". If we could write:
>
>   OPT_NEGBOOL('n', "checkout", ...)
>
> that would be nicer. But the short option is a bit weird. We'd want:
>
>   -n: option_no_checkout=true
>   --checkout: option_no_checkout=false
>   --no-checkout: option_no_checkout=true
>
> That is, we flip the sense of the long option, but the short option
> still yields "true". I think that would be useful, but it sure is weird
> to explain.

Yeah it looks confusing.. How about leaving that first arg as the
short option "checkout" and move 'n' elsewhere? Something like this

OPT_NEGBOOL(0, "checkout", 'n', ....)
-- 
Duy
