Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659CC0015E
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 01:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHJBli (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjHJBlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 21:41:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B081999
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 18:41:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f25d045cso319413b3a.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691631696; x=1692236496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo6Fi1XEFO86fzS0O2JvbC7Aa+oOnKNRUZODeDCqqAk=;
        b=kcJUy5lJQojkYCbxEKAWEUGf6SPqx2OKf7OHU3aULz5c7aL/ZZYFSOIRgBbwY0SF5t
         Z3RdeICgJvWpILmmqCyr00/sggvksTBxuPxT5L4lXQ8LeBgcTibPHlr6fW7bOq30HIIM
         pNWKvBkzD5mceqwNueg9ImnSazDIQbPrMOcxTRjClHK10Xhce6RivjSOEgZ3Tho+u4SC
         +KTbRxR9sdePboJxZp6TsoLLBYss6F57/HD901A0eijMJEKWcA+dOjibloVrBmzh2F38
         QdSu62ZHjg2Rnw48r+jPL85nncQTGN+SSyXM4ctFNBTRP1FKrO/NdJmb78XHuPyGwMmP
         diag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691631696; x=1692236496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo6Fi1XEFO86fzS0O2JvbC7Aa+oOnKNRUZODeDCqqAk=;
        b=VbpymqDrvylbgzk9+QY+VDzaizrzRt57SVsa2S52/B2MQT+a4Rhjbp88iJMuMPy6Bw
         ee4hqNd+s+CVcLvVOeJKJErb4ryd6s0lili2HNZ1YZOqQJapUSIrq/R12maAj3W32XgC
         b/l/L+qlyc7FozeRanhDXYgKfzmw/Dn4R2RvP45KqDsNzt6GVJSJ4T/ePBd+YbbHdNWu
         SqogwAF/jcIaXnRcc7VG1tIcnP1A+A4hEWuEcVqdhlfqP00BE7+ZNkON2PM6pIq/fad2
         OEFUq7srQcLYWDh5Zc/IitCk1DcOU/NQA8TOIFseMKsT+J7TS4Lp3IP3vUbHTgamWvop
         zFeg==
X-Gm-Message-State: AOJu0YwrHhL4loW6lkgRy6qV57QC2FcQQGdiOvg3BNCSFs6FzxQ1Zf0u
        oVoNsTu+qg5Usfd1Yg6mjw0b0+H2cwg=
X-Google-Smtp-Source: AGHT+IHCDBiztKeq79iS0pdsT1QNwDH+CLVwbaKuyvxXpOm3SCQkt2lTkg0fNyCr5yyMk9jGo6w6Rw==
X-Received: by 2002:a05:6a20:324d:b0:131:dd92:4805 with SMTP id hm13-20020a056a20324d00b00131dd924805mr936629pzc.57.1691631696047;
        Wed, 09 Aug 2023 18:41:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001b7f9963febsm213866plg.175.2023.08.09.18.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 18:41:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 03ADC80F7F18; Thu, 10 Aug 2023 08:41:11 +0700 (WIB)
Date:   Thu, 10 Aug 2023 08:41:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>, git@vger.kernel.org
Subject: Re: [PATCH] Fix grammar in git push man page
Message-ID: <ZNRANBdZG9kAnjxq@debian.me>
References: <20230810004044.1420385-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y9tvvTU032ADgONK"
Content-Disposition: inline
In-Reply-To: <20230810004044.1420385-1-wesleys@opperschaap.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Y9tvvTU032ADgONK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 08:40:25PM -0400, Wesley Schwengle wrote:
> -When neither the command-line nor the configuration specify what to
> +When neither the command line nor the configuration specifies what to

IMO either command-line or command line is correct...

--=20
An old man doll... just what I always wanted! - Clara

--Y9tvvTU032ADgONK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZNRAJwAKCRB7tWyQc2rT
CODGAP92g9Vd1xv6WtUPXIuIeUFhG3dvq3VMbItl0960gtwj4AD/dVAr2qgPnuSQ
WfcnF5LQ+1xszaMvUlB/A2BSC3kSWAM=
=jkeI
-----END PGP SIGNATURE-----

--Y9tvvTU032ADgONK--
