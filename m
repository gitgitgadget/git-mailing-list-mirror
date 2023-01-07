Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856AC54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 21:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjAGV3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 16:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjAGV3o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 16:29:44 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780F18B24
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 13:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673126969; bh=0CxZ8DeWLGgC36ebrHmnIGgrek9EZ37qgMKMHhSaGiE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
        b=fri7snlTuJmQM44bg4j/CSP9CySKfsMLn1rNT7P3Z8wb1OqcNlLxWIKro9YJ/D/TK
         +6+F2pw5t+dCvJtMqxgq8GkSlJYqY8O9hzdFwSM9Yzgj0XcBmNspHrTGxo3xNGkTtK
         /9f7iYCpabAB4HN4GSlS2YzeVtXTXp4JLCgqA6b5nnd6xJx7dlwbKNmUNFtqHssz6O
         9CvM+8/7rlZLYq3JVAqvEK86RoELTOZOFjbeCtAMCAnbSIHEniGhei6zlkyMvaEiZY
         ARe7ijQRsDnv2EG5rPx3eyCD57YVJBDxnHUhxH97e1WR/cAkh/Yu6bdtYpcUVFYlNj
         X1YOw9GtxPGWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1oYMQD2Q12-00gDtL; Sat, 07
 Jan 2023 22:29:29 +0100
Message-ID: <e525342d-5900-1870-f176-da4eef083143@web.de>
Date:   Sat, 7 Jan 2023 22:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] convert trivial uses of strncmp() to skip_prefix()
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
 <Y7lzFG9gyDrOE4Xt@coredump.intra.peff.net>
 <Y7l0mq6khtlgxGca@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
In-Reply-To: <Y7l0mq6khtlgxGca@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LHr7DvTVCM/XyfZMJ/33W1NIroYI55Q2JU5si3dkRYLT8bQnmKA
 oXjKWVw90DI4HFvBXFMMbAFA9TvJ1cafognKRgAnqbtf/M3ClUodWBja9+2nHOls18YHVx6
 b3K+/0cA3HRcRDjvwIhLAjPS5UCmjdSkCnQ37CNNb9W/JPa0So0XtfU/WAFgC6VmxxzMe41
 i33kDfJODBfD2gAbTi2mQ==
UI-OutboundReport: notjunk:1;M01:P0:P3uL78RBHbw=;OxsleIFvB9NDrJbqZm6UmRPSfor
 pAAdrIk1Q0AOajCnErpAIpTKaNOK7WUkfad3RU7JCf/iiXr4pN15701yMHyrx1H8VGUbPxEgW
 /kT4Z4JFtSkpb3BBkw/bP6L0ap4X6xKNMQwHIVvjUS8u8vtBfD9qLp/HImHkMNvusCyTNkt27
 i2uR+xPhop8IEN+Qyk7aNOc/qdpMIIuQ/fVLoaBqPyLvrAEBwCfv4L0CpGcUYmoLYP2jn9V/7
 B6Yy5OlsPv9Kz6IH759O14nUdrPWcAQou6xLRo7O8ph+rTJwaCYby3MTuB3NUD+dzZATYBVk7
 LRBqNtgKbzjTJPdSLU8vfhESCPfUvwTtso7JTcOIKRrz0+jWhX49kZZHgG69iwce4rdbU7A1r
 QmfpKoUMCE13WavtYJ9viPFz6IGaGjwHWqCAySoAAIhvQQUhGdptImA3th683D9UfrHYgr1eA
 dQ7AHrSWguCSCMVJIno/99EgEu/lxPjQRJPGFSLJIuaBPoQwBKBzJO+YQxgniMiuEAX/cOQxv
 Wk+faGhwXgx9wp5c/p2Db8VQPlF27Y1EuPPYJtodY+7FfgLpLjw9hcyYnWGJOGDMEpdaO7WIt
 cKKsdlzQNcXPip/8f7ri6X1MlzR7X3IbbwkqZKcEYsPvedc++ZeKxjsHx0/x+xHN8NWtkf90F
 nJCpSxi3bPcby7MlLpY2NNjnfE/bjPaFudkMCMMd6G5YOsSiEW1LTjy6V9JjoX8clJXyswZJw
 gnfU4kh0Ul09GrCllfMxtarisTZ8IxvkJ5jPwJezarYWY2EqG60fUvH/9N55df2GfpgtHYFYq
 VHOOlGwH+mvnBIIwq6JwxCz8zyUOOhHmHozjxaXl1guLoxYcSvfFoaPhaEp17+2GyvbdWHi59
 Hg/+llJUn9sK0IpK/+tcQ0eNQ41WY3fAAAcLdHmN66Q/nf+iDrjPxFzX9Ws/ObAF7TJPuNle7
 rnahWQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.23 um 14:33 schrieb Jeff King:
> On Sat, Jan 07, 2023 at 08:26:45AM -0500, Jeff King wrote:
>
>> Note in the case in ws.c that to get rid of the magic number "9"
>> completely, we also switch out "len" for recomputing the pointer
>> difference. These are equivalent because "len" is always "ep - string".
>
> By the way, one thing I noticed about this parse_whitespace_rule()
> function is that it's very loose about its matching. It does:
>
>         for (i =3D 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
>                 if (strncmp(whitespace_rule_names[i].rule_name,
>                             string, len))
>                         continue;
> 		...we matched...
> 		break;
> 	}
>
> So it will prefix-match any of the options, even if there are
> ambiguities. E.g.:
>
>   git -c core.whitespace=3D-t show
>
> will turn off "trailing-space", even though it would also match
> "tab-in-indent". It would be easy enough to fix it to require the whole
> name, but I wasn't sure if this prefix-matching was supposed to be a
> feature (it doesn't seem to be documented anywhere, though).

Abbreviations are being used:

   $ git grep whitespace=3D .gitattributes
   .gitattributes:* whitespace=3D!indent,trail,space
   .gitattributes:*.[ch] whitespace=3Dindent,trail,space diff=3Dcpp
   .gitattributes:*.sh whitespace=3Dindent,trail,space eol=3Dlf

(Full names: trailing-space, space-before-tab, indent-with-non-tab.)

a9cc857ada (War on whitespace: first, a bit of retreat., 2007-11-02)
added this function.  Its commit message says:

   "You can specify the desired types of errors to be detected by
    listing their names (unique abbreviations are accepted)
    separated by comma."

And the part about abbreviations needing to be unique was true at that
time, because the names of the only two types back then started with
different characters.  aeb84b05ae (core.whitespace: split trailing-space
into blank-at-{eol,eof}, 2009-09-05) broke that property first.

The current behavior of picking the first match from a list with a
basically random order is not ideal, but at least stable.  Can we still
change it?  The intent seems to have been to ignore ambiguous prefix
matches.

Ren=C3=A9

