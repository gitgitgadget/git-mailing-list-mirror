Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058EB1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 14:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbfJNOQm (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 10:16:42 -0400
Received: from mout.web.de ([212.227.17.12]:49477 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbfJNOQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 10:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571062596;
        bh=iIUpREuVYIIqXb59HiznsdW6Kyf7Qp0VHSNXGRcM8y0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Qbkv8jGx0pWAP4mRkPqvDqqkdjWBkXywacvkhlgitFUj2lLAMLk8M3ixnOYFm7t0Z
         ImdGlYJmd0LI3TOVcfyDhXnXJm552Muy7Tt0Ex/QwnwZvDUGoCrRnFMKtBOBew4Gf2
         nQuoefnJznD89KViI3mv41zN6rA5fLxk2BPaTdic=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGign-1iFwYf2hdZ-00DUtT; Mon, 14
 Oct 2019 16:16:36 +0200
Subject: Re: [PATCH] column: use utf8_strnwidth() to strip out ANSI color
 escapes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <9b3f6960-ea75-c3a7-3a24-0554320bb359@web.de>
 <nycvar.QRO.7.76.6.1910141312010.46@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a165b244-b18d-0434-42c5-bfe28b8bab51@web.de>
Date:   Mon, 14 Oct 2019 16:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910141312010.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c+ad/eLgm0mNlitPwUphQlmciI6jfZ7GRgRy8FokaBEMsIhT0U9
 gnG1WFOG9NNhKEiITDUlOBL+pv7CnNUgSuBQA92Xfd8ubkGJ+o5rF32MezJqi3t5dBY0VCY
 hIBJ7yBG6+S63io4AyapZnf88/fJZHytUxDBFbNP5iRxMWJu8720V/mk7ARvqgVmP10vKNH
 3s9vG3y33m1n/En5calMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5TqYAFB73Cw=:QVPC6rTf6ZOG/n9xNiHsQn
 R4Lni9pFk522Pa7c3HalJa5qMpj5SIrZczK2V5CHOG777Cvmi9FmX0iDOVgu6pes8/bYjXzpA
 pJpHRnXBch2dYUoZcBmcPmk24CvYGbUuwA5yi3pkb24pw33/JlmUlMmP5K+q/5InSIy0nFyJQ
 lwiiaREoRSjSSJw9giliU+h+E+dzOP6aBcLX9ukEQNxPPRxDwKLuJ8bZgb+T2yW5dTkgcaWBA
 Au8543yX9XQW1wn7Rs+8aqFCzJ/BJgarqR5RdNWrCSIthrbEV4IVO31pnKLGsyQxWUr96iqcq
 D85moTBijS5yPVLtnUi3qzDxdtPvxpWc9QGnH1EXqzBWlHj9ijSQI7q9FbJxOzKn3PfLAwBFI
 dI6MrWEFwY7UA3pbp7sNEAStUG+aKbNaqaOpS9gNKalGa6m7yMQ6PV23MJlqWhCzqUCsRvndd
 5fwgT9NHuwdnrE21qOXBP0JnrZNA/vLdglSEGhbB7coQh3v1dP4desqgFpndqUhtrC9D2xDhs
 Hqx4s9l/lnToa/A4ZvwjD98q8W6e8MEwF4wbKSXFp9CyaoeO0i8YgHHuL+NeWf8QfMYw8HLG5
 YF2afnyH96hlx+9Tk9xKllUZxpOi+4eHJlmHez/mjH+XTv6pe9kNc3FhiWHuSZmafj5NWjdWF
 gj3DrA6u6POuhRaO1iUce0sJwXj5pea1xiBIW/AQ+nHk1j44OWydGfiyYjJ7lG7Evx8O8SNlw
 20Q7IgHtyvCGsS7gF65SRSOWV8lbzmTyY9CPTKR+V/mBRcbMGysp7wA7F+D2fsbJGknnOCwez
 7kiyVxGEaP7gkyiR+yC4KF+MG+sg6scXTREiKN3my7erPh45yTyNXp4ujbam1hb0hgXy18Khx
 pNjB1guqkeiMApgPtCzeaDBMmbd/erLkoOVhKGSIqf2saBLKFDodVMUzGe9CdpSDU8KkFIwEP
 OYb/9K8ntaEtG88OIWqwNyOBZ4NKI3YyHFS+D8iE4EggmnCHsKuiNjpCZPeiebi0TnViTNaJC
 42a0lO3cm9L1QOWGVFuAvWCgrZkrlaKAk4X+M0ncbkc1dlSCn+p8lDURjtsiB1RlgASwaKNmQ
 OLeOdf611rZYJJxiKbNup2ow1SQSM/GMTigrnrlBbuAAMqlIAoTUmHphn5URYjuZp78a2cgCp
 W9M6oE8F/UgZ+XzoTQ5YaVoILoR40o+uArfmomrme/yXP62c6+8Lp+mcfq+CNE1sYBNXxR/28
 48WCsxKiYhyljGCdE2u9p8RBDChvpNujsETKDyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.19 um 13:13 schrieb Johannes Schindelin:
> Hi Ren=C3=A9,
>
> On Sun, 13 Oct 2019, Ren=C3=A9 Scharfe wrote:
>
>> This changes the behavior, though: The old code skips all kinds of
>> Control Sequence Introducer sequences, while utf8_strnwidth() only skip=
s
>> the Select Graphic Rendition kind, i.e. those ending with "m".  They ar=
e
>> used for specifying color and font attributes like boldness.  The only
>> other kind of escape sequence we print in Git is Erase in Line, ending
>> with "K".  That's not used for columnar output, so this difference
>> actually doesn't matter here.
>
> Arguably, the "Erase in Line" thing should re-set the width to 0, no?
> But as you say, this is not needed for this patch.

It doesn't move the cursor, just clears the characters to the right, to
the left or both sides, depending on its parameter.  So ignoring it for
width calculation like	the old code did would be appropriate -- if we'd
encounter such an escape sequence in text to be shown in columns.

Ren=C3=A9
