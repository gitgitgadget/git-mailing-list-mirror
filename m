From: "Piotr Findeisen" <piotr.findeisen@gmail.com>
Subject: Re: Documentation/user-manual.txt, asciidoc and "--" escapes
Date: Fri, 14 Nov 2008 14:02:59 +0100
Message-ID: <ddb82bf60811140502y60987761g55fc959a3e246afe@mail.gmail.com>
References: <ddb82bf60811061904t5defc492m80cd1b759674eb6@mail.gmail.com>
	 <ddb82bf60811061909m6f8a7b72o4b03ebcde8b9d188@mail.gmail.com>
	 <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com>
	 <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com>
	 <ddb82bf60811092338m3aad8041w20de23f18aa7d56e@mail.gmail.com>
	 <20081110100757.GA12868@diku.dk>
	 <ddb82bf60811100214j4246cf25yc1263c2ae8cd10fc@mail.gmail.com>
	 <20081112000445.GB17662@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0yLV-0000hQ-Nd
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbYKNNDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 08:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbYKNNDB
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 08:03:01 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:32545 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYKNNDA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 08:03:00 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1413884wfd.4
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 05:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rOlcnTvf6wENAh3pMInhYqoVcKJip79E90i8T+PGraQ=;
        b=Yvyu3huezU17Kf+cFAak5iCueqN/5p+Zl5SLmP36WsD1/wtWke3BhbKSq2c51x+lyy
         ztpiAAcMknilDcYTyVBiFV3kw7IpMGW/51FhcZbqteAnk5R/cWlrhLubjFDLowfgrWWG
         o4DYVkkN3dydEjuJTrz3dxzykIo+rhMhVcSp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nJG3OYdH8iSyWGdXx/dxI9B4rPXm2DT+nWu+nFLuJ3bS10+mCoUsVsvpV3UKssNEPG
         UyZMUqK7g9pYPhT/Lfx/ZhibDyhA4REqzXUrikb1dBxU8n1rgeYR0GxG9neu3ZsEmywf
         kfU6vj0Rkqnl9MvTArPDv9fg48Pc1jXs0ivzM=
Received: by 10.142.164.10 with SMTP id m10mr398622wfe.319.1226667779672;
        Fri, 14 Nov 2008 05:02:59 -0800 (PST)
Received: by 10.142.218.21 with HTTP; Fri, 14 Nov 2008 05:02:59 -0800 (PST)
In-Reply-To: <20081112000445.GB17662@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100969>

I've investigated it a little.
It seems that this newet version of asciidoc (I'm running 8.2.2) has
the global asciidoc.conf file (placed in /etc/asciidoc/asciidoc.conf
on my computer) containing the previously cited section:

    # -- Spaced and unspaced em dashes (entity reference &mdash;)
    # But disallow unspaced in man pages because double-dash option
name prefixes
    # are pervasive.
    ifndef::doctype-manpage[]
    (^|[^-\\])--($|[^-])=3D\1&#8212;\2
    endif::doctype-manpage[]
    ifdef::doctype-manpage[]
    (^|\s*[^\S\\])--($|\s+)=3D\1&#8212;\2
    endif::doctype-manpage[]
    \\--(?!-)=3D--

Those replacements are run *before* any replacements defined in
user-provided files are taken into consideration. You can disable them
only by disabling all replacements, I think.

So the only thing we can do about automatic conversion "--" to "=97" is=
 putting
    [replacements]
    &8212;=3D--
in Documentation/asciidoc.conf file or similar. (8212 =3D x2014,
"\u2014" =3D "=97"). This way the unwanted replacement is reverted.

However, this forbids literal "&8212;" in the source .txt files and
there is no way to enable it. This seems only little probable that
anyone would want to write "&8212;" until someone writes "writing
Documentation guide" where she would state that "&8212;" is
prohibited.

If this is good solution and we want to replace punctuation "--" with
unicode "=97", I will do this.
However, this seems a bit messy -- fighting against asciidoc instead
of using it as it's designed to be used. IMHO, it's better to
explicitly escape non-punctuation "--" with "\" and write punctuation
"--" with spaces on both sides. Please note, writing literal "=97" isn'=
t
so simple -- there is no such key on the keyboard :)

Best regards,
Piotr



On Wed, Nov 12, 2008 at 01:04, Jonas Fonseca <fonseca@diku.dk> wrote:
> Piotr Findeisen <piotr.findeisen@gmail.com> wrote Mon, Nov 10, 2008:
>> > This would also fix the usage of "--" in the manpages, e.g.
>> >
>> >        You've now initialized the working directory--you may notic=
e ...
>> >
>> > in gittutorial(7). On my setup, with "--" replaced with "=97", I g=
et the
>> > following nroff code:
>>
>> On my machine, make gittutorial.7 produces manpage that displays "--=
"
>> in this place :)
>
> At least you don't loose anything compared to the current behavior. ;=
)
>
>> >        You've now initialized the working directory\(emyou may not=
ice
>>
>> Anyway, this may be a good idea to use unambiguous "=97" (though peo=
ple
>> writing docs may be used to using "--" as a punctuation). I can run
>> through the Documentation replacing "\w--\w" with m-dash, if you wan=
t.
>
> I would like to see such a patch.
>
> --
> Jonas Fonseca
>
