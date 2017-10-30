Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F7F2055E
	for <e@80x24.org>; Mon, 30 Oct 2017 10:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbdJ3KeO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Oct 2017 06:34:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52422
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751777AbdJ3KeN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2017 06:34:13 -0400
X-IronPort-AV: E=Sophos;i="5.44,319,1505772000"; 
   d="scan'208";a="242809226"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 30 Oct 2017 11:34:12 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] remote-mediawiki: limit filenames to legal
References: <20171029163714.4818-1-anarcat@debian.org>
        <20171029181034.27707-1-anarcat@debian.org>
Date:   Mon, 30 Oct 2017 11:34:11 +0100
In-Reply-To: <20171029181034.27707-1-anarcat@debian.org> ("Antoine
 \=\?utf-8\?Q\?Beaupr\=C3\=A9\=22's\?\=
        message of "Sun, 29 Oct 2017 14:10:34 -0400")
Message-ID: <q7h9fua0zzz0.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupré <anarcat@debian.org> writes:

> @@ -52,7 +53,7 @@ sub smudge_filename {
>  	$filename =~ s/ /_/g;
>  	# Decode forbidden characters encoded in clean_filename
>  	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf('%c', hex($1))/ge;
> -	return $filename;
> +	return substr($filename, 0, NAME_MAX-3);

There's a request to allow a configurable extension (.mediawiki would
help importing in some wikis, see
https://github.com/Git-Mediawiki/Git-Mediawiki/issues/42). You should at
least make this stg like length(".mw") so that the next search&replace
for ".mw" finds this.

Also, note that your solution works for using Git-Mediawiki in a
read-only way, but if you start modifying and pushing such files, you'll
get into trouble. It probably makes sense to issue a warnign in such
case.

Regards,

-- 
Matthieu Moy
https://matthieu-moy.fr/
