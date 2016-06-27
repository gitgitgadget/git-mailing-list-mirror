Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7F32018A
	for <e@80x24.org>; Mon, 27 Jun 2016 17:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbcF0Rxr (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 13:53:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbcF0Rxq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 13:53:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9011226E35;
	Mon, 27 Jun 2016 13:53:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Y1mQyFLxfujL
	MPI0NZ8J9J2G3YU=; b=JHPkG9YWCdlXFddY9hgqfCsnIB6jAI+mGdey8wc1I2Ex
	O0d8F77m/XBzRYYParkIe3KiiCTxWKiI/p01IAlpQY8QANd2jjH9yWwJVTaXoIlG
	+QRIw2Tzj1BmdkXSW1yffqWWDkGB25url058VJ1tYIrITDEfyb0UHi9Bdv+JlHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yPNrKo
	inx3JuxI0doz7U1KYD3HvlV4RfAWD0Q25b3CYUQnJLDnBWvzwzFhvjNMRpIlgSU9
	LmFKy7rnh+Qi9TDTzyASTAA20bni+2Bep1QnygV1CVCMolG7zk9BSlB8pDJrVwn+
	QBJyRipofLnomRUUkuqWG2VeeIA/c1trTXQRY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87CD426E34;
	Mon, 27 Jun 2016 13:53:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 022D526E32;
	Mon, 27 Jun 2016 13:53:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/2] Support for $FILENAMES in tool definitions
References: <20160627132137.GC4194@pflmari> <57716227.1030104@gmail.com>
Date:	Mon, 27 Jun 2016 10:53:24 -0700
In-Reply-To: <57716227.1030104@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Mon,
	27 Jun 2016 19:28:07 +0200")
Message-ID: <xmqq7fdabjsb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0CDE0AC4-3C90-11E6-823E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> On 2016-06-27, Alex Riesen wrote:
>
>> This adds a FILENAMES environment variable, which contains the repository
>> pathnames of all selected files the list.
>> The variable contains the names separated by spaces.
>
> Why not separate filenames with end-of-line character (LF)? It would still
> be broken for some filenames, but only for unportable ones.  Filenames with
> internal space (common on MS Windows) would work then.
>
>   http://www.dwheeler.com/essays/filenames-in-shell.html
>  
> If Tcl allows it, you could separate filenames in FILENAMES environment
> variable with NUL ("\0") character...

Tcl may or may not handle a string with an embedded NUL, but I think
it is hard to have an embedded NUL in an environment variable.

Use of LF is a good suggestion regardless.

