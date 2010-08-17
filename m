From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 2/3] compat/regex: hacks to get the gawk regex
 engine to compile within git
Date: Mon, 16 Aug 2010 22:35:11 -0500
Message-ID: <20100817033511.GA17840@burratino>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
 <1282015548-19074-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 05:37:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlCyy-0004Dh-OY
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 05:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab0HQDgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 23:36:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35768 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab0HQDgy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 23:36:54 -0400
Received: by gxk23 with SMTP id 23so2215878gxk.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 20:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=l3BeURbeHTdvrX00bBii20KTPChn8iR0+uLqZ/tqrG4=;
        b=x0X538uZGP+X07/lI6h3LdqPUDZaZOBiay8COxElTJixkmMFOLi2CASu95N08w+PZL
         aheWN6Ne3T6tzE9CtSsIYpHdZdtm9n9G7sWsX5Y5tjAmDzP1vFx5WO5T9xfgRDILl5Fs
         05Z40pJhYqeG/kHVQfT4SRP//MbQpQYKDR4Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UqHtnTn4foahz9ijyHeMgka5tLLv0SexNR3wSc9qOs5+/R9Y3jWYm4377G4XlJELQp
         Jbzbgpf+Cll0/5dpD2UjSP0cSvstbW7QuepWTN73bUWdlcV1nML+bOFphl2UwZCv75zQ
         BC0Ig5d1OK7B7CZiExt85AC9jlRYAguo9BRYM=
Received: by 10.100.225.8 with SMTP id x8mr6686725ang.203.1282016213448;
        Mon, 16 Aug 2010 20:36:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm11438040ann.27.2010.08.16.20.36.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 20:36:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282015548-19074-3-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153690>

Hi!

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +	# TODO: How do I compile just regex.o with this flag, not the
> +	# whole of Git?
> +	BASIC_CFLAGS +=3D -DGAWK

 gawk.o: EXTRA_CPPFLAGS =3D -DGAWK

See v1.7.1-rc0~60 and v1.7.0-rc0~90^2~2.

> --- a/compat/regex/regex.h
> +++ b/compat/regex/regex.h
> @@ -22,9 +22,12 @@
>  #ifndef _REGEX_H
>  #define _REGEX_H 1
> =20
> -#ifdef HAVE_STDDEF_H
> +#include <stdio.h>
> +/*
> +  Git: Was in `#ifdef HAVE_STDDEF_H` in gawk, adding -DHAVE_STDDEF_H=
 makes a
> +  *lot* of other things break
> +*/
>  #include <stddef.h>
> -#endif

Maybe

 #if 1
 #include "git-compat-util.h"
 #else
 ...

would be simpler.
