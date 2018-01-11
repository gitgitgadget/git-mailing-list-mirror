Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14DAF1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 13:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934340AbeAKNkS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 11 Jan 2018 08:40:18 -0500
Received: from elephants.elehost.com ([216.66.27.132]:25982 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934336AbeAKNkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 08:40:16 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0BDe7X5049018
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Jan 2018 08:40:08 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'git mailing list'" <git@vger.kernel.org>
References: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com> <20180111062048.GA31213@sigill.intra.peff.net>
In-Reply-To: <20180111062048.GA31213@sigill.intra.peff.net>
Subject: RE: [PATCH] Replaced read with xread in transport-helper.c to fix SSIZE_MAX overun in t5509
Date:   Thu, 11 Jan 2018 08:40:01 -0500
Message-ID: <002101d38ae1$b1bacb40$153061c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJsSMotxvL6FxEkVCXZaKOUGVaNvALAkTFeoicqhJA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 11, 2018 1:21 AM , Jeff King wrote:
> On Thu, Jan 11, 2018 at 12:40:05AM -0500, Randall S. Becker wrote:
> > This fix was needed on HPE NonStop NSE where SSIZE_MAX is less than
> > BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
> > was the only place outside of wrapper.c.
> 
> For my own curiosity, what is SSIZE_MAX on your platform? BUFFERSIZE is
> only 64k. Do you really have 16-bit size_t?
> 
> I wondered if you would also need to set MAX_IO_SIZE, but it looks like we
> default it to SSIZE_MAX.

size_t is 32 or 64 depending on the memory model of how a program is compiled. SSIZE_MAX in limits.h is 53284, which is a message system limit. There was a previous fix associated with this size limit came from our team (commit a983e6ac58094a3b2466ad3be13049ce213f9fc3).

Cheers,
Randall

