Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F227C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 06:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F579221E9
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 06:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bmLqnQ88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgDQGp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:45:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52319 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDQGp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 02:45:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4F5248898;
        Fri, 17 Apr 2020 02:45:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YJ42kn3WcbtQ
        gNwUeVHWplXea4A=; b=bmLqnQ880Xzzpi2V7f2O11nlmnkigIDKChmk0Cccslrz
        U93itRMV3fdG88h8Fd2moUi+iI7H+rfCeh9xgZudy9Ad0WOi3Ik3fox0SRgVqUEm
        6GWKfKOt89MUxw4yEvxmyjJ1yEiZ0sghsOQBGcRkyO7glnBGqGbSHFq0MV9+yI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JsiPLo
        T7AyDOiST7sRWf4/NDVIJcTb8gC7oJJ0YZuvjMtFdyIlsD3q9DA+PNfycgxUU8V0
        R18STxi8f57s6+MyKWlWZPbpIbEvd2MHSRV4XTGvIsnoqIvvGs2CGWSVoFYRnd0+
        MzBN3d+KGOtZVzzNov/oX1Q5nU8AyHdRsJG0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE28E48895;
        Fri, 17 Apr 2020 02:45:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42BB848894;
        Fri, 17 Apr 2020 02:45:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     asheiduk@gmail.com, git@vger.kernel.org, greg@hurrell.net,
        l.s.r@web.de
Subject: Re: [PATCH] grep: follow conventions for printing paths w/ unusual chars
References: <xmqq1ronyz1s.fsf@gitster.c.googlers.com>
        <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
Date:   Thu, 16 Apr 2020 23:45:54 -0700
In-Reply-To: <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Fri, 17 Apr 2020 03:04:03 -0300")
Message-ID: <xmqq8siuwqxp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 165D6796-8077-11EA-835E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> +	if (opt->relative && opt->prefix_length)
> +		quote_path_relative(filename + tree_name_len, opt->prefix, out);
> +	else
> +		quote_c_style(filename + tree_name_len, out, NULL, 0);

Yup.  This solves the discrepancy reported correctly (i.e. both
sides should do the quoting, the original only quoted when relative,
and the new code corrects the other side).

> +	if (tree_name_len)
> +		strbuf_insert(out, 0, filename, tree_name_len);

I am not quite sure about this part, though. =20

Earlier we inserted the latter part of filename (after offset
tree_name_len) to strbuf "out" after quoting, and then we are
prefixing the earlier part of the filename without quoting to that
same "out".  Wouldn't a path ABCDEF (I do not literally mean that
these ascii alphabets need quoting---just imagine each of these
stands for a different letter and some causes the path to be quoted)
with tree_name_len pointing somewhere in the middle be added as (an
analog of) ABC"DEF", i.e. literal prefix with remainder quoted?  I
would (perhaps n=C3=A4ively) expect that the whole thing would be placed
inside a dq pair in such a case, even if the prefix part alone would
not require quoting.

Thanks.


