Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C7D1F981
	for <e@80x24.org>; Wed, 29 May 2019 16:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfE2QsA (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 12:48:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63204 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Qr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 12:47:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97D9314CE64;
        Wed, 29 May 2019 12:47:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=i+y/uhUft1fFU
        ymkaSqKUfQSEok=; b=J08Soo0t31Nb74S1BvTTZTeOMhZjM9zNULFq0OqbLEo4J
        w9vggHOc4JeZBhOPi+YAmCcrdqlNK+XoEa+r3R+ro4QRdbNNNhCslZGe6m4m+QUG
        DGQf2BsAtrEMmgBV4SqVYshCc1AOXqyd32kMdK8IaETaEFSgu606SA5bhZ/9k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=yNnRdWG
        62FaS1RX8R1RBvtBcFzMRDMqXm51cud1w98RSpF2hocJNGvBYC1gbZUd/vufM0J4
        2D+98NhPiRcq+0b+i8W8G5WdtSr4M/K0QkSpkL/19FxyUQ06AzVMBvrDy/rZgUwC
        3aoFqMdVDYse+GoHQiFLhQflN72iXPN5Im2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9046514CE63;
        Wed, 29 May 2019 12:47:57 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0CC0314CE62;
        Wed, 29 May 2019 12:47:57 -0400 (EDT)
Date:   Wed, 29 May 2019 12:47:55 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/3] diff-parseopt: correct variable types that are
 used by parseopt
Message-ID: <20190529164755.GE3654@pobox.com>
References: <20190524092442.701-1-pclouds@gmail.com>
 <20190529091116.21898-1-pclouds@gmail.com>
 <20190529091116.21898-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529091116.21898-2-pclouds@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 82D08952-8231-11E9-8D1C-72EEE64BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Most number-related OPT_ macros store the value in an 'int'
> variable. Many of the variables in 'struct diff_options' have a
> different type, but during the conversion to using parse_options() I
> failed to notice and correct.
>=20
> The problem was reported on s360x which is a big-endian
> architechture. The variable to store '-w' option in this case is
> xdl_opts, 'long' type, 8 bytes. But since parse_options() assumes
> 'int' (4 bytes), it will store bits in the wrong part of xdl_opts. The
> problem was found on little-endian platforms because parse_options()
> will accidentally store at the right part of xdl_opts.
>=20
> There aren't much to say about the type change (except that 'int' for
> xdl_opts should still be big enough, since Windows' long is the same
> size as 'int' and nobody has complained so far). Some safety checks may
> be implemented in the future to prevent class of bugs.
>=20
> Reported-by: Todd Zullinger <tmz@pobox.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  diff.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/diff.h b/diff.h
> index b20cbcc091..d5e44baa96 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -169,7 +169,7 @@ struct diff_options {
>  	const char *prefix;
>  	int prefix_length;
>  	const char *stat_sep;
> -	long xdl_opts;
> +	int xdl_opts;
> =20
>  	/* see Documentation/diff-options.txt */
>  	char **anchors;

FWIW, I ran this versions of the series through the fedora
buildsystem and noticed no issues on s390x or any other
architectures.

Thanks,

--=20
Todd
