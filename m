Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057101F462
	for <e@80x24.org>; Tue, 18 Jun 2019 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfFRImV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 04:42:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:52487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfFRImV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 04:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560847318;
        bh=rWoLNu3CO6uiILvx6uhSCidt7TzFcAWZmtyLPGCVx1Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Nve1vl24VogOe76YXdJEuuaclSGc5CJadM1FeYymFMHkkAW0fULOnMA4GtSaBMDAb
         /bdO5SgxqZVxUQG1fs8xnnta0ExXJq70VKdnIhVI82xozHiJujsDKU0Tq95M3W8sEM
         vrZmWM/LHOyNn33SuczXlg7AyURKfoBRdJ6ZeSCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1iQm7X37e1-00o0w6; Tue, 18
 Jun 2019 10:41:58 +0200
Date:   Tue, 18 Jun 2019 10:42:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matthew DeVore <matvore@google.com>
cc:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com,
        matvore@comcast.net, Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/10] list-objects-filter: implement composite
 filters
In-Reply-To: <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com>
Message-ID: <nycvar.QRO.7.76.6.1906181040490.44@tvgsbejvaqbjf.bet>
References: <20190601003603.90794-1-matvore@google.com> <cover.1560558910.git.matvore@google.com> <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gVlXXlDWn/zjg+DIa9j/HKlyOySPoi6QQnrB9ACruxO53fLrSQK
 dzANDzTeZdpyrsjofNHlbni8We8iDfcsf3sOJDMMILX9FoYpVtO4MKx2CyUY/0npunNHACa
 SQFnlSXv01QlBMsWbo/F8t+0OaX0ur9Ibnc9Web2u//rmaEgN7AxtTsxHgnsSr+RRIN7QXo
 oDHxdB3D1e4OE2s7+3Mxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0X2sieLDzE=:y2a+0t4qKxBKHwcoX5k9MQ
 3XmdfhgtaYUg3dCvP8JfTh9XRamRF0llk/nSf4lDmUI5wVDJMQpjUnAc4YG3HroXkSYYPBcJN
 9tbsny8O94iRQKKYRh7yAcvi3X42U3RCv0G962NMhKjCYtG62twck/awE3l+z4bZ4PhiwZX5d
 48Du3kZys9LDjRveSDpMYiuWQZeD64YKK9s0SwqIwwz3zIn04qH5cwO4rQjkpOBynrxz7lQFW
 1qmDSCKhjYHMHVhBd/ICM+6W9HNnO+6v0AFHzPcQRSwa/oG4JjXkh/zpafYatxJgcDDCXEMXm
 ZlcK7CbP64jRFeTRsUv4Rc6hB5qzZGqC6M3wYXq20H9Soi56bGSFsUC2gBCUlkYfYGAcxWrP8
 6GGxoWhkILfKHx8ZkAFw8U+1YXIIJcNhEc5hCDHtVY8s87okbZ005EQTlbMI515UOWYPBl8UW
 j8ynKJmangWZvc1u7DBiuItfxfKS8+fVzQSnkFNtpmFM3yhTtJUx16wWI8NjHdmBokFn8MTYm
 R6FbnTVyrFHMA/iK4S8ehlezzd1RGX50Pj/G9VQqTMJtpxU/ARTUD41ho+j0wUpN5BcwN6Yq/
 WlwaauilXqsGPcbMAzQc0Z9/CPko7AYXGN4gnR2MTjpgRWtYoxodmw3Ai4XJV8TXo2xI0wpbe
 r6MSKhTrP9sLIlWePP6WZJM4bDuJHnal+jpK/eAOHLy2R/U7gfBxM5EzOJ9WGOZBHf/d/paVu
 yyw6BZM9sxFw7CA3xWaJZ4vfsjy1lfrZeF3R+EgGn63BkYWYXcrcmlsDNbCmsV3j14oNh5z3b
 4S4NCcxRsTl2dyjsY5ZYzBUGbLIiADuxePAIJqy8pkG3jL2KZmAO9tWk6jQJqZgrtLYfiKaWg
 4WH5wxGTQqFZ1Ga5KTCLoCDJFomykloHdpPQP9AKUS6KYijEM0+Jbl7KJJZwreNQOM1oz7h6q
 Dhhexg9DCAyfP0r4BAY/dX336ybcfAWamvLOfQzOknKoIdQ2Em2Yn
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On Fri, 14 Jun 2019, Matthew DeVore wrote:

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options=
.c
> index 8e7b4f96fa..1c402c6059 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> [...]
> +
> +static int parse_combine_filter(
> +	struct list_objects_filter_options *filter_options,
> +	const char *arg,
> +	struct strbuf *errbuf)
> +{
> +	struct strbuf **subspecs =3D strbuf_split_str(arg, '+', 0);
> +	size_t sub;
> +	int result =3D 0;
> +
> +	if (!subspecs[0]) {
> +		strbuf_addf(errbuf,
> +			    _("expected something after combine:"));

Please squash this in, to pacify Coccinelle:

=2D- snipsnap --
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5e5e30bc6a17..483ab512e24c 100644
=2D-- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -150,7 +150,7 @@ static int parse_combine_filter(
 	int result =3D 0;

 	if (!subspecs[0]) {
-		strbuf_addf(errbuf,
+		strbuf_addstr(errbuf,
 			    _("expected something after combine:"));
 		result =3D 1;
 		goto cleanup;

