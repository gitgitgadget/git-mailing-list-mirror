Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125E420A27
	for <e@80x24.org>; Sun, 17 Sep 2017 00:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdIQAgc (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 20:36:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50740 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751198AbdIQAgb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 20:36:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2574597FFD;
        Sat, 16 Sep 2017 20:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pByvnxaJKlzx
        42xOnaimHsmN/WM=; b=eWniQGWXapSwH2E2fceKmfxoKCvbByM9T8XGUgaYy0aX
        Q18zT+xx/V1yipwoWQL5/+SlyrjYcNq2ehqFObkFXCP4ZliCAO5EQdYxBc+8MMQK
        6zGq/4ejKuWQTjWqNW/IToEertuUF1N5yksbkYj26r1XbOTp/PPNDBHS3hKPqMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eDHP7Q
        emKKoSrP61GErLHvhj7ui5cYy3Yw6GGQYVYfPLRIW4qEHaqsiu2gpU3C8sGqmww1
        JHvEWxE1EyFsPR1dcr5Cgx40WE0Erm5uzkpFo84cxFtW+wkbo5IU/arLKmKyy2y7
        kFBgEcKXspGmQGS8Kr1cx5cqyVC/Ls7uRKjkQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C3B797FFC;
        Sat, 16 Sep 2017 20:36:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AB4897FFB;
        Sat, 16 Sep 2017 20:36:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        git@vger.kernel.org, musl@lists.openwall.com
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
References: <59BB3E40.7020804@adelielinux.org>
        <20170915063740.GB21499@alpha.vpn.ikke.info>
        <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
        <59BCAF81.3090206@adelielinux.org>
Date:   Sun, 17 Sep 2017 09:36:26 +0900
In-Reply-To: <59BCAF81.3090206@adelielinux.org> (A. Wilcox's message of "Fri,
        15 Sep 2017 23:58:41 -0500")
Message-ID: <xmqqpoaqupo5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3DCE0796-9B40-11E7-98EA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"A. Wilcox" <awilfox@adelielinux.org> writes:

> While musl's reading is correct from an English grammar point of view,
> it does not seem to be how any other implementation has read the standa=
rd.
>
> However!  It gets better.
>
> The ISO C standard, committee draft version April 12, 2011, states[4]:
>
>> c    Matches a sequence of characters of exactly the number specified
>> by the field width (1 if no field width is present in the directive).
> ...
> Since Git is specifically attempting to read in a host name, there may
> be a solution: while 'c' guarantees that any byte will be read, and 's'
> will skip whitespace, RFCs 952 and 1123 =C2=A72.1[5] specify that a net=
work
> host name must never contain whitespace.  IDNA2008 =C2=A72.3.2.1[6] (an=
d
> IDNA2003 before it) specifically removes ASCII whitespace characters
> from the valid set of Unicode codepoints for an IDNA host name[7].
> Additionally, the buffer `locking_host` is already defined as an array
> of char of size HOST_NAME_MAX + 1, and the width specifier in fscanf is
> specified as HOST_NAME_MAX.  Therefore, it should be safe to change git
> to use the 's' type character.  Additionally, I can confirm that this
> change (patch attached) allows the Git test suite to pass on musl.

I did a quick scan for substring "scanf" and read through the
output, and it seems that this is the only one that wants to do the
this many characters, e.g. "%42c", conversion.

I am a bit worried about the correctness of your conclusion, though.

As long as we are reading from the file written by us, because the
string we write as the hostname part comes from what we prepare in
my_host[HOST_NAME_MAX+1] using xgethostname(), we may know it would
fit in locking_host[HOST_NAME_MAX+1].  But because HOST_NAME_MAX on
my platform may be shorter than what your platform uses, I'll run
over the end of my buffer if I am reading the lockfile you write to
notice that the repository is in use from your host.  After all, the
reason why we write hostname in the file is because we expect the
filesystem is shared across different hosts, so relying on HOST_NAME_MAX
to be the same across platforms would not be a good way to go.

So it seems to me that a real fix has to read the file ourselves and
parse up to our HOST_NAME_MAX+1 to see if the hostname refers to us,
and fscanf that cannot take "slurp up to this many bytes" is not
useful tool to implementing that parsing.

The current scan_fmt variable comes from da25bdb7 ("use
HOST_NAME_MAX to size buffers for gethostname(2)", 2017-04-18), and
before that, we used to use "%"SCNuMAX" %127c", which was already
problematic.  The "%127c" part came from the very original of this
codepath in 64a99eb4 ("gc: reject if another gc is running, unless
--force is given", 2013-08-08), whose first appearance in released
versions was in v1.8.5, it seems.  IOW, nobody tried to run Git with
musl C in the past 4 years and you are the first one to notice?

Thanks.
