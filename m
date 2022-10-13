Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F9C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJMQCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJMQCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 12:02:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DBB104D0E
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 09:02:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E04EA1BCA17;
        Thu, 13 Oct 2022 12:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AIU1q8xTcWnc
        +AIAPiuRRIEjb53uaMOKKqgp78bV/V4=; b=xSa5OlmW+gjqd7q0SI5QYLVLcvJ6
        ZK1y7CPENXEYAUbmw7jkJXwWscFSdlJhwcqnLAJfMPeZAw+aEsmAKUBkpItjWf93
        KSl+nqf4nNfXho72E3ziK6V/fKgKDXk+9stCIRqkhGMDHuHmRDQALw5p1xnpD6zi
        V9Juqws+MKBW2KA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D94251BCA16;
        Thu, 13 Oct 2022 12:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14E231BCA15;
        Thu, 13 Oct 2022 12:02:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
        <xmqq7d14k9uh.fsf@gitster.g>
        <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Oct 2022 09:02:26 -0700
In-Reply-To: <221013.86o7uflvcv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Oct 2022 15:11:49 +0200")
Message-ID: <xmqq35briuel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6EEE28E4-4B10-11ED-B3A3-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In apply.c's parse_fragment() we seem to only care that we find a
> "\"-line that's at least the length of "\ No newline...".

If I recall correctly, this was done very much on purpose back in
2005 on top of what I and Linus did originally (which was specific
to "No newline" written in C locale).  Because the input from "git
apply" may not necessarily be the output from "git diff", and in the
older days, "git diff" spawned platform "diff" to show diff, it would
have been subject to l10n.

With GNU diff, I can do

    $ echo -n one >/var/tmp/1; echo -n two >/var/tmp/2
    $ LC_ALL=3Dja_JP.utf8 diff -u /var/tmp/[12]
    --- /var/tmp/1  2022-10-13 08:40:55.393209930 -0700
    +++ /var/tmp/2  2022-10-13 08:40:59.269538397 -0700
    @@ -1 +1 @@
    -one
    \ =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AB=E5=B0=BE=E3=81=AB=E6=94=
=B9=E8=A1=8C=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93
    +two
    \ =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AB=E5=B0=BE=E3=81=AB=E6=94=
=B9=E8=A1=8C=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93

As it does not consider a file that ends with an incomplete line a
text file [*], I do not think POSIX says anything about lines that
begin with "\" in the "diff" output, but I would be surprised if GNU
patch (or anybody else's, for that matter) did not ignore text on
the line, because all of them must be able to parse the above
output.

> I wonder what (if any) compatibility issues we'd have if we emitted
> e.g.:
>
> 	\ The filename pointed to by the symlink does not end in a newline

While I do not think it would break anybody, I doubt it would give
us much value.  One line above that output is a line that any user,
who is vaguely familiar with the contents being compared, can
recognize as giving a pathname, the contents of the symbolic link.


[References]

https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap03.html#=
tag_21_03_00_83
