From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: possible Improving diff algoritm
Date: Fri, 14 Dec 2012 13:20:29 +0100
Message-ID: <CALZVap=r0toqWT7aJxiKtezmR8s4QDd0x92JX-eBLWhKaJsmOw@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org> <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org> <CANv4PNnC1J54TSpHuBOpY=rbuU_naysYkmoyi=utNF0vWK1CnA@mail.gmail.com>
 <B1564B28-9BB9-48A2-B59E-7D7C0B0DDECF@adacore.com> <7vzk1izcv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Bosch <bosch@adacore.com>,
	Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 13:21:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjUGK-0000KO-8d
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 13:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab2LNMUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 07:20:51 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64464 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210Ab2LNMUu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 07:20:50 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so3779234vcd.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 04:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EouxIDwNe8M9/hZlvgQcwAQUq4+u1IN73ZxlHbRvC3I=;
        b=A1lDPz75xcMipaYPOatZDgQqrynJmq12zb65Lc5pIgHO3WEpBgOr1dq+ZNUDf+L//c
         BPBmN1byQ3Vj8R23/bFOjjkpT2Wpu9mRnA2gL0rlAZ2on9y6eyR5uFSGer/Dm/9LPbJI
         2UW/onqV16zKZi9uLg+m2GZeAipISd1h3WdJPdhtC3LBH+f2BB8HF/Q0Jz13WMO5+U0O
         Ylqx4lyfveSUta2OdOuxK5Pru2R5RPwVZ5xxU46OKBZu+2VWilEuhpsYoYSiMm3Ujxpy
         l5clRnOs6azqB6VTzOYPaIjEl2wHm79IsXEFgmeObBicgY87nVeCf3kmSrStlgJjqn+9
         xwBg==
Received: by 10.52.35.20 with SMTP id d20mr7611068vdj.50.1355487649510; Fri,
 14 Dec 2012 04:20:49 -0800 (PST)
Received: by 10.58.33.200 with HTTP; Fri, 14 Dec 2012 04:20:29 -0800 (PST)
In-Reply-To: <7vzk1izcv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211490>

I think the idea of being preferable to have a blank line at the end
of the added/deleted block is key in this case.

Javier Domingo


2012/12/13 Junio C Hamano <gitster@pobox.com>:
> Geert Bosch <bosch@adacore.com> writes:
>
>> It would seem that just looking at the line length (stripped) of
>> the last line, might be sufficient for cost function to minimize.
>> Here the some would be 3 vs 0. In case of ties, use the last
>> possibility with minimum cost.
>
> -- 8< --
> #ifdef A
>
> some stuff
> about A
>
> #endif
> #ifdef Z
>
> some more stuff
> about Z
>
> #endif
> -- >8 --
>
> If you insert a block for M following the existing formatting
> convention in the middle, your heuristics will pick the blank line
> after "about A" as having minimum cost, no?
>
> You inherently have to know the nature of the payload, as your eyes
> that judge the result use that knowledge when doing so, I am afraid.
> I think your "define a function that gives a good score to lines
> that are likely to be good breaking points" idea has merit, but I
> think that should be tied to the content type, most likely via the
> attribute mechanism.
>
> In any case, I consider this as a low-impact (as Michael Haggerty
> noted, it is impossible to introduce a bug that subtly break the
> output; your result is either totally borked or is correct) and
> low-hanging fruit (it can be done as a postprocessing phase after
> the xdiff machinery has done the heavy-lifting of computing LCA), if
> somebody wants to experiment and implement one.  As long as the new
> heuristics is hidden behind an explicit command line option to avoid
> other "consequences", I wouldn't discourage interested parties from
> working on it.  It is not just my itch, though.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
