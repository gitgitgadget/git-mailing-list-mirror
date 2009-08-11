From: skillzero@gmail.com
Subject: Re: [RFC PATCH v3 7/8] Support sparse checkout in unpack_trees() and 
	read-tree
Date: Tue, 11 Aug 2009 15:03:10 -0700
Message-ID: <2729632a0908111503i7f035c1aw4e84151eab821006@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-7-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-8-git-send-email-pclouds@gmail.com>
	 <2729632a0908111418m57e03d8as9c122cbb52efc21a@mail.gmail.com>
	 <m3ab26owub.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MazRB-0008Qa-SI
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 00:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbZHKWDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbZHKWDL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 18:03:11 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:63224 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbZHKWDK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 18:03:10 -0400
Received: by qyk34 with SMTP id 34so3517916qyk.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W8ZO75V3dYiw813NWkg8Pg7bALUMKAuzfKTzw9TDhNU=;
        b=yEM6YZ1htD1HSq/+31DjkRwdfb/VAg/e8prk1tmm8pZ8ht7CYlLYubqpEAE4aVjKub
         spXLe9RL0TmNYH+2rq/AhASnmPz29AqfN77+8qjOvx0KV5JdDxa96EbOjuXoJWNinfKt
         nwI5bMagBkQjEuTvdXL64waCkBFF80rmjMEPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ahwltxr+8fgbZ0VM/4ZiX8SAjFn8XHLX4yNUNqKuBpWwfBfC20G3IujsrwPoMtgG0R
         0O4ZF5M7Zeh9mduOBTVWIpk8N/14/LClcNDvmPyE7f+pkzauZqf/ZQFxcsYCdYzYrAv9
         5IjmEFM7DqnpIBmAMsgAtzLuwJbc3BHrzATCw=
Received: by 10.224.54.129 with SMTP id q1mr4434149qag.299.1250028190865; Tue, 
	11 Aug 2009 15:03:10 -0700 (PDT)
In-Reply-To: <m3ab26owub.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125608>

On Tue, Aug 11, 2009 at 2:38 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> skillzero@gmail.com writes:
>> 2009/8/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>
>> > [1] .git/info/sparse has the same syntax as .git/info/exclude. Fil=
es
>> > that match the patterns will be set as CE_VALID.
>>
>> Does this mean it will only support excluding paths you don't want
>> rather than letting you only include paths you do want?
>
> Errr... what I read is that paths set by .git/info/sparse would be
> excluded from checkout (marked as assume-unchanged / CE_VALID).
>
> But if it is the same mechanism as gitignore, then you can use !
> prefix to set files (patterns) to include, e.g.
>
> =C2=A0!Documentation/
> =C2=A0*
>
> (I think rules are processed top-down, first matching wins).

I wasn't sure because the .gitignore negation stuff mentions negating
a previously ignored pattern. But for sparse patterns, there likely
wouldn't be a previous pattern. Include patterns are a little
different in that if there are no include patterns (but maybe some
exclude patterns), I think the expectation is that everything will be
included (minus excludes), but if you have some include patterns then
only those paths will be included (minus any excludes).

It's great if it already supports includes as well as excludes
(although it's a little confusing to say !Documentation to mean
"include it"), but I wasn't sure from the comment so I was just
asking.
