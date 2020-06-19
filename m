Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790FC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F0F21527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbgFSQLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:11:12 -0400
Received: from elephants.elehost.com ([216.66.27.132]:28753 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391369AbgFSPGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 11:06:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05JF5wnV092667
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jun 2020 11:05:58 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <015c01d63ddd$97d65080$c782f180$@nexbridge.com> <20200615215937.GA636737@coredump.intra.peff.net> <002801d64365$b6fdc2d0$24f94870$@nexbridge.com> <20200616080200.GA650578@coredump.intra.peff.net>
In-Reply-To: <20200616080200.GA650578@coredump.intra.peff.net>
Subject: RE: [Possible Bug] Use of write on size-limited platforms
Date:   Fri, 19 Jun 2020 11:05:52 -0400
Message-ID: <028c01d6464b$235346c0$69f9d440$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIiTx0sS4gALBW8notSiC9T8n4M5QKWXqXkAgWN3LQBdiEpcKgXZ2vw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 16, 2020 4:02 AM, Peff wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: git@vger.kernel.org
> Subject: Re: [Possible Bug] Use of write on size-limited platforms
> 
> On Mon, Jun 15, 2020 at 06:38:34PM -0400, Randall S. Becker wrote:
> 
> > > So I think this really ought to be using write_in_full(). There's
> > > only one caller, and I think it would be improved by the switch. Do
> > > you want to write a patch?
> > >
> > > You could make an argument that the fwrite() version ought to also
> > > loop, since it's possible to get a partial write there, too. But we
> > > don't do that in general. I suspect in practice most stdio
> > > implementations will keep writing until they see an error, and most
> > > callers don't bother checking stdio errors at all, or use ferror().
> >
> > I'll give the patch a go. It is very simple. Would you suggest
> > removing the strbuf_write_fd() as part of this patch since it only
> > impacts bugreport.c?
> 
> I could go either way on that. IMHO it isn't offering much over a bare
> write_in_full() call. The "don't call write() if there are 0 bytes"
> logic is part of write_in_full() already.

Patch delivered.

Regards,
Randall

