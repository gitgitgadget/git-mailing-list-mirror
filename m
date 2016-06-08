From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 8 Jun 2016 14:12:06 -0400
Message-ID: <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org> <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:24:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhxj-0007SS-6Z
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbcFHSMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:12:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34345 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161092AbcFHSMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:12:08 -0400
Received: by mail-io0-f195.google.com with SMTP id l9so2259792ioe.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lwMCs11rayh7NEHjudinJgrrBa7AUxkq4QXMWzaCJ/0=;
        b=KLJxo7b/FYwANCpPamw2FWVZtcvT7gfBzjB2yCaTAApXgZ4gI0eHk8rh+v3vA4E/ex
         UlgHMIiTzz1fbobia/U6IDMX4MZn3eVPAiep2rZaVVMvZbQEDe6BbmS9nptJrLQzQ4Br
         uqKNl5iHcqftEqc8D8Cvnvo3MPcKEEWZ2yrHu+vBe+C/4QhuDzbZPH2+g6J2q2qBl/4B
         H1kW+GSpEuJduK6WRYU2fyFZigE7oLQH3QOZ//1vEteHw5cXc17NLny+CiGvoAUKxAS9
         OglpzcDTfyBdO+hxdAc4yLsUAviII6kX32M1z8kFWRaneNf56PGIzU16ToT3dBcmusgz
         K6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lwMCs11rayh7NEHjudinJgrrBa7AUxkq4QXMWzaCJ/0=;
        b=YqAY8LExsW87N3wEQdX9sqjWsC/1uY3dO06QvDFwu9LFpxRV0yhuy7qsAI4776/NUU
         0s+I12c9ddAbe+gHiTYjiwFAX6eG0OPiA+Q1r7GuQysrYc22cO/O9DanaVzN9WrxQCdF
         8LGt8xjOo1/M1uE3g2yK+69xeBNneiOnAf4Pa7SPlSkrI0+XkExauteAZbomFPbxHlt3
         tRe7Ka+9XJ0DqMctmtKwVAu/2NI/4R5kGQvWFb82C6uzRsabKRt/YiyGNgdpZpB1qLaL
         Dx/4koneX1gvgXONs7qTR0Lyz/VDraAcr8uYFoYGge/gcGcONyLFCTeBM4gfmmMCca/Y
         rjQw==
X-Gm-Message-State: ALyK8tL4wogjSeiSN43wKrphNmZ7QE0yr20Z7pdAKZby0cJH0vbQcavBKPZ8ptcPpKEuG/IU5b4/uHo/1LjF6Q==
X-Received: by 10.107.25.13 with SMTP id 13mr10573773ioz.104.1465409527040;
 Wed, 08 Jun 2016 11:12:07 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 11:12:06 -0700 (PDT)
In-Reply-To: <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: Uy6pvl-GGSfRc_Ilwn2N6GWTKtI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296827>

On Wed, Jun 8, 2016 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>> +sub parse_email {
>> +     my %mail = ();
>> +     my $fh = shift;
>> +     my $last_header;
>
>> +     # Unfold and parse multiline header fields
>> +     while (<$fh>) {
>> +             last if /^\s*$/;
>
> You stop at the end of fields before the message body starts.
>
>> +             s/\r\n|\n|\r//;
>
> The pattern is not anchored at the right end of the string;
> intended?  Is it worth worrying about a lone '\r'?

Thanks, I think you covered pretty much everything I was going to say.
I'd just add that if the matching is going to be kept loose like this
(rather than anchoring it), then s/[\r\n]+//g might be easier to read,
but it's a minor point.

>> +             if (/^([^\s:]+):[\s]+(.*)$/) {
>> +                     $last_header = lc($1);
>> +                     @{$mail{$last_header}} = ()
>> +                             unless defined $mail{$last_header};
>> +                     push @{$mail{$last_header}}, $2;
>
>> +             } elsif (/^\s+\S/ and defined $last_header) {
>> +                     s/^\s+/ /;
>> +                     push @{$mail{$last_header}}, $_;
>
> Even though the comment said "unfold", you do not really do the
> unfolding here and the caller can (if it wants to) figure out where
> one logical header was folded in the original into multiple physical
> lines, because you are returning an arrayref.

Also, the comment about folding lines should be moved down the part of
the code which is actually (supposed to be) doing the folding rather
than having the comment at the top of the loop.

> However, that means the caller still cannot tell what the original
> was if you are given:
>
>         X-header: a b
>             c
>         X-header: d
>
> as you would return { 'X-header' => ["a b", "c", "d")] }
>
> In that sense, it may be better to do a real unfolding here, so that
> it would return { 'X-header' => ["a b c", "d"] } from here instead?
>
> I.e. instead of "push @{...}, $_", append $_ to the last element of
> that array?

Right.

>> +     # Separate body from header
>> +     $mail{"body"} = [(<$fh>)];
>> +
>> +     return \%mail;
>
> The name of the local thing is not observable from the caller, but
> because this is "parse-email-header" and returns "header fields"
> without reading the "mail", perhaps call it %header instead?

If there is (for some reason) a mail header named 'body', then this
assignment of the body portion of the message will overwrite it.
Perhaps this function should instead return multiple values: the
header hash, and the message body.
