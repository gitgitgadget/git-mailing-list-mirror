Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5515C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D91820723
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V41Et7jC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgEVUum (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 16:50:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:58589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbgEVUum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 16:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590180640;
        bh=YvwzpPR4au6M6pS8vcZQ9Ud7gKABU1k7d9cKeYDCtDs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V41Et7jCksvItyHWfEKPr0JFxqiY8qZG8nrIR64C7Kn9CH+Cmcmnf3EwQ9z9rRUj5
         G7MgSVA9XmGE7x+Z1xMbvldCjwtKHgjUbLso0duJlkX7mucbjDhExtd3RZUy5xwQ0A
         EPbk/u+tHRkY2i1N5/8A8r3PQjH41AIKw1KwLHI8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.131]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1jpelK3SBl-00DYxi; Fri, 22
 May 2020 22:50:39 +0200
Date:   Fri, 22 May 2020 22:50:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 04/12] bisect--helper: reimplement `bisect_autostart`
 shell function in C
In-Reply-To: <nycvar.QRO.7.76.6.2005222058380.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2005222247500.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-5-mirucam@gmail.com> <nycvar.QRO.7.76.6.2005222058380.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZrMA2n1Uu2N+XCtdrEjLtxm4CDOUlwYwQcnV5+3VYzYEIUHkTGR
 cszzhjL3sAkwUg79MjV0J7KDSycIOgAShnrUIChrK/U5I+BW3O6pLNa04gwrKFqBc3KRQgZ
 uWP0wGXWJwHBQz7p70Hm5Fa22Wj44/wKrhHShfXSbUIUi8va3k+50fGfmMLNhtn0PWDds7f
 iowVaPzSzRa319PL1JOLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e3PiCGEaiX4=:UtMtWdDedmK6g1/vrCppPC
 UoB+oTUyYQWfWy+/KTQHhp2m/qWFnO4DeUhSR3pqWFexriF84TzgTGVAj+/d4FyM0tTLpe0O+
 z9TTJUqQ0Ii4VOvd7MMNoHN0Hf315W9tQmkntexVW/tVloF4xRCtcy3JzpVciNohz16YZC3CW
 deW+tVEZthK2GHnQWa8wwIKFFR7Srm+83kOzZQSRX7nx8sGu8srhyA30BK9VjVR8Jm9LGH6+t
 3MbuMHecwvnXOlKiGX73u/9AL6BCiXiaCFNOGZF5aRnHFk/15WDJnFkz0aQldojClR05LKsOB
 cg9JJNol79Kusqjg238m4z58wjbJbMzustUJqTI8GoqOyOfUey5bbdQjd6KVKDHdkkmBCrEDD
 cEhXa1Y8hYD/LMs6FhLaXxeu+lM3kIZGNLhYgBmIxkqHQuRtWkIbigwNSAM9w9CsnaDNAUd/Y
 IBa46lSs1sT/iS5hwLrnu3qtqYDEeODE3SEU55+LxkJcCeUfPAukE5tpl/lAacxy/Khhqm9AU
 jV/SibhgFtIQgsTEiVMZSOZ+nO3Dm+XRD62TGEmjDdyA0VCgpaaL1IwJVKlExtTewMAgf1bkA
 sLY0z5FEetAo6oMcs9Xz6/HXR5MbWea31vR1f/byqMC/3PbX32et7/nnt68hLOlPnPvYcDcfb
 zVEjle6odDHvboJQzmcsHCRb1ZI0IuBdg73ohgVhcWilSuwrlBGw2gvoCPiEO6T/O10J40LTJ
 isvC8tsMix5BlWmKC0BnVVZ9vcQqChvAX9C+n8rbm0YqK6py5hmTGTjRlbA3DadUpQh2zrE4I
 sPHUP0mCCqGCdXnCYxYE7U56TchrKw+GykynkggbG7fMMKe/ndzKHPzvy14Z77qQ27e6ZqCPK
 w+IOG86lOi4RRsholPPfF++0t57V0h9P74X3QbsrtFzVXsgHTbLzW00IruqNzHvo+CPm2WZ1B
 4nawwdJzibiyL+L5BL+4eias38/v6HOoBWrvchTYKGI8nrSSTDiuBSyy5JCu2f153xry4NCQv
 IJ//DFBQL1Oe3pq9bdugLqF/CKXRbwmE8kTbM39FTfEADZIj1D5/yw2gm489zdD15QckPRqxK
 jkRTVuZeDDBGiQF+PD0PjNuM+kI/o5CXVSyugpw7H7rekRJwKw4M3Tt+dMC8jH2qYkIJJn+8K
 XBtZ6HeTQPFqIG10xsxjvDVweBYzfHHdOmf9S0AJI4DBl8e7XLWyluhlbKYWUdwB/JdEgVSYc
 4Ys3wla3RxDKJLcty
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Fri, 22 May 2020, Johannes Schindelin wrote:

> On Thu, 23 Apr 2020, Miriam Rubio wrote:
>
> > +	/*
> > +	 * TRANSLATORS: Make sure to include [Y] and [n] in your
> > +	 * translation. The program will only accept English input
> > +	 * at this point.
> > +	 */
> > +	yesno =3D git_prompt(_("Do you want me to do it for you "
> > +			     "[Y/n]? "), PROMPT_ECHO);
>
> [...]
>
> I still think that we need to call `free(yesno);` or we leak memory.

Never mind. I got fooled by the fact that `git_prompt()` returns `char *`.
It actually returns the pointer `buf.buf` of a `static `strbuf buf`, so
there is nothing to `free()` here.

Sorry for the noise,
Dscho
