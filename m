Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593E9C433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 06:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3006960F70
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 06:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbhJQG6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 02:58:08 -0400
Received: from mout.web.de ([212.227.17.12]:54933 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhJQG6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 02:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634453741;
        bh=+TVBQQDVaofCMGof+C1vPKZeKLz41ly4z/Fv+cim6Mg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Wwge5VFbv7TwVtj5W/xIKf47YypTIlwVFaIdZFFbg0Sg3NAz05cZ2p8b/3h1tdSMy
         flRHMsPNABZcJyMtBCfeeLCfOf3e832UF1EMn3tCQuTXcFo/+WXj8u6ssSwB9hJwHj
         WD1wvuJd9dPmdx9GyihPLIHt8JFI1AevYT5ATiio=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lhvpu-1n6AEJ37yc-00n6Aq; Sun, 17 Oct 2021 08:55:41 +0200
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <xmqq4k9i5a4n.fsf@gitster.g> <eddcbe66-b172-90b7-309e-e9ce5b5b44a4@web.de>
 <87zgr8dg8j.fsf@evledraar.gmail.com>
 <fc7eb9fc-9521-5484-b05f-9c20086fd485@web.de> <xmqq1r4k197p.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0ea73e7a-6d43-e223-ab2e-24c684102856@web.de>
Date:   Sun, 17 Oct 2021 08:55:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq1r4k197p.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pJO3TdROXcuVQEP046Xq3Sdv0SU/+OGHR5U0mQeR9xrrkIGbThe
 y6u4V9IBjQF56UznApTweO540M6MhaOrKYPW70o/M4JeplLJqOV3H9X3LXupDKBYISG7qtv
 J6/rsYK/2XHZR4gh2CUqL0/GV/4CUFppQvjzZRigrijwE5x6OyOUvE8WHuvJOEHRw9LWOZ4
 zxuAFpW6NqK7Q/flazHCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qO7jxFQ7TJM=:0M1YqSvtq4rC4Z5IccirOz
 m06udW/RS9r7Rgg4OvQydBbF+cYUJfAtnCkKSZq6r77uEniR6IAUVDDa6SOYxvRvImRtGS9dk
 PdeDWVw3VEMHx+vSutkzSinZSpY/boeBZxFqRDNvKxZg8+2bn2/XimQtInD2h0cGWAz9RlvKt
 WqbLeI52m8JBmK0qeY6/QhasEFaypoHRxVl2DsgPVGKeCsxHJtLYlW3PRbbnyPyGwEvSGGBTm
 +Rm1suFvUxqVBeer8uPmwcL8c1HxpszeQaPNvJxhMjSUP6hZ1+Bo1+oVqlYO9RF8PI+9tBw7T
 REBD7xwrJ/t2AXrBBGjl9goEN0sowKftQuNWRiVnzJvrvwDMXG7q2g192Fwp/mD62ct4zchlj
 Q94cp10Ce65Vjt8PfsNEaNspd8ufuIjPL2+fz9xq+bprh2PhTQNa5hPN5++mz6H7Kz9pZFIel
 4cENOI6I+TcM+jpdO8aWmS2HRBLUKj7LWHs12AM+rJSTdozvJziCHuvwM7vAVjl/OJQkVAlXZ
 OIwh8Tw/Kb0uRbJCGug6BlIQApyZkUMtHxaWhBKw9RdkaadvoSPWjVGdWa8fNugMgipVdS+Rz
 YsEAAMkvlbIRco/jgDcRlBzY01BptaG3WVqqNy0kOy1vfKvmQdGAfycpGkJI+Ehl4v1aPwfFw
 /vuqQo3SZU0VG0BSfNb8qyEySphvenT2GkolAcqME5Rbvm/MtxA/D9iYj3ionhYrwtNpK1oF0
 8GGWU2xIR5ErDiOJzJDdPe8TcyZIi0jSMMIejY4F/vIGoa8mfERH1hYHOqtTKidzbYN4xP+Pw
 UJiW1CQx+3TcbsoO32ErqdvVUK8X1u+0eGAhqOD06jRtJJyiXV/rrAiopjn9IEh91cWl8LTtI
 kKk9FBIS8tVzD/imUAKCZ2laC6+MbZrC2xx1WCaENw4h6vLDwSy3RszxK/rGXJkzafK73IkrI
 VBTmWpzFRCPsVqcBpQtSkXj2JUDtbk49+etMB1E5OSO2nPmdllUXY1PKg44ophtYqJwdYMh8Y
 FXxRv1wivPxu6qibpMBy0++ULrWpH04LlfdvCWf0nbs7J0bY8e92z9P0PFNaNpL/tZ84pG6lI
 bnTg45otj/7WUM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.21 um 08:00 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>> Literal patterns are those that don't use any wildcards or case-foldi=
ng.
>>>> If the text is encoded in UTF-8 then we enable PCRE2_UTF either if th=
e
>>>> pattern only consists of ASCII characters, or if the pattern is encod=
ed
>>>> in UTF-8 and is not just a literal pattern.
>>>>
>>>> Hmm.  Why enable PCRE2_UTF for literal patterns that consist of only
>>>> ASCII chars?
>>>> ...
>>>     echo 'Ren=C3=A9 Scharfe' >f &&
>>>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?Ren.=
 S' f; echo $?
>>>     1
>>>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?R[e=
=C3=A9]n. S' f; echo $?
>>>     f:Ren=C3=A9 Scharfe
>>>     0
>>>
>>> So it's a choose-your-own adventure where you can pick if you're
>>> right. I.e. do you want the "." metacharacter to match your "=C3=A9" o=
r not?
>>
>> Yes, I do, and it's what Hamza's patch is fixing.
>
> That may be correct but is this discussion still about "Why enable
> ... for literal patterns that consist of only ASCII"?  Calling "." a
> "metacharacter" and wanting it to match anything other than a single
> dot would mean the pattern we are discussing is no longer "literal",
> isn't it?  I am puzzled.

Right, =C3=86var's comment is not about my question, but highlights an
inconsistency in master that is fixed by Hamza's patch.

I'll repeat and extend my question: Hamza's patch enables PCRE2_UTF for
non-ASCII patterns even if they are literal or our locale is not UTF-8.
The following change would fix the edge case mentioned in its commit
message without these side-effects.  Am I correct?

diff --git a/grep.c b/grep.c
index fe847a0111..5badb6d851 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -382,7 +382,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, =
const struct grep_opt *opt
 		}
 		options |=3D PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern)=
 &&
+	if (!opt->ignore_locale && is_utf8_locale() &&
 	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

