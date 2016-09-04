Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75431F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbcIDUkm (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:40:42 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:53907 "EHLO
        homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754019AbcIDUkm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 16:40:42 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id 1C1EC2B206A;
        Sun,  4 Sep 2016 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=ozbAp
        yeCCPYeYzJG2NDmbRM5qE8=; b=qn2S2QhKXFTrNCz0ZM4lbwtne0PeJWTdEBANh
        XI0miBi9VG0zFPlrmvs3aqX0tcaYBpHkAs8S1YDS+P19rcVP3g8fBaBMAyyTZK8Q
        ds8ptmL+zgLXBhnaI8KrV+RCpTzRIMAiNC8m9rY3p0qRn6tYDPRItXJ9AD5s2rz1
        UDV4pk=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 3D1DC2B2065;
        Sun,  4 Sep 2016 13:40:40 -0700 (PDT)
Message-ID: <1473021637.6035.27.camel@frank>
Subject: Re: [PATCH v2 05/38] refs: create a base class "ref_store" for
 files_ref_store
From:   David Turner <novalis@novalis.org>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, git@vger.kernel.org
Date:   Sun, 04 Sep 2016 16:40:37 -0400
In-Reply-To: <39277c75122a374b360057d6e1f6d889a90f6fb4.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
         <39277c75122a374b360057d6e1f6d889a90f6fb4.1473003902.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-09-04 at 18:08 +0200, Michael Haggerty wrote:

> +/* A linked list of ref_stores for submodules: */
> +static struct ref_store *submodule_ref_stores;

I don't like the per-submodule stores being in a linked list, which
requires a linear search.  Stefan has, I think, been doing a bunch of
work to scale git to support on the order of thousands of submodules,
which this potentially breaks.  What about a hashmap?


