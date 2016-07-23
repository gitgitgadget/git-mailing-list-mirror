Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F71203E3
	for <e@80x24.org>; Sat, 23 Jul 2016 07:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbcGWH1X (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 03:27:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44802 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbcGWH1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 03:27:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F28E203E1;
	Sat, 23 Jul 2016 07:27:21 +0000 (UTC)
Date:	Sat, 23 Jul 2016 07:27:21 +0000
From:	Eric Wong <e@80x24.org>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, peff@peff.net,
	tboegi@web.de
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
Message-ID: <20160723072721.GA20875@starla>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <5792B622.5040306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5792B622.5040306@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> wrote:
> W dniu 2016-07-22 o 17:49, larsxschneider@gmail.com pisze:
> > +use strict;
> > +use warnings;
> > +use autodie;
> 
> autodie?

"set -e" for Perl (man autodie)

It's been a part of Perl for ages, but I've never used it
myself, either; I suppose it's fine for tests...

> > +$| = 1; # autoflush STDOUT
> 
> Perhaps *STDOUT->autoflush(1), if I remember my Perl correctly?
> Should this matter? Why it is needed?

It's better to always disable automatic output buffering when
writing to pipes or sockets for IPC.  Otherwise output may be
buffered indefinitely because the buffering mechanism doesn't
know a reader is stalled.

Same problem with using stdio.h functions for IPC in C.
