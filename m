Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3F01F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbcH3RHz (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:07:55 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:60611 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758496AbcH3RHy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 13:07:54 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E9B046AB66;
        Tue, 30 Aug 2016 17:07:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lead71_7ebcd24cfcb37
X-Filterd-Recvd-Size: 3002
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 17:07:50 +0000 (UTC)
Message-ID: <1472576869.5512.98.camel@perches.com>
Subject: Re: git am and duplicate signatures
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Aug 2016 10:07:49 -0700
In-Reply-To: <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
References: <1472573556.5512.93.camel@perches.com>
         <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(adding lkml)

On Tue, 2016-08-30 at 09:54 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > git-am -s will avoid duplicating the last signature
> > in a patch.
> > 
> > But given a developer creates a patch, send it around for
> > acks/other signoffs, collects signatures and then does
> > a git am -s on a different branch, this sort of sign-off
> > chain is possible:
> > 
> > 	Signed-off-by: Original Developer <od@domain.com>
> > 	Acked-by: Random Developer <rd@domain.com>
> > 	Signed-off-by: Original Developer <od@domain.com>
> Both correct and allowing the earlier one duplicated as long as
> there is somebody/something else in between is deliberate.

linux-kernel has a script (scripts/checkpatch.pl) that
looks for duplicate signatures (<foo>-by: [name] <address>)

Should the last Signed-off-by: in the commit log be
excluded from this check?

> > Should there be an option to avoid duplicate signatures
> > in a sequence where an author can git-am the same patch?
> I dunno.  The way "Signed-off-by" is handled is designed
> specifically to support the meaning of that footer, namely to record
> where it originated and whose hands it passed, used in the kernel
> and Git land.  Other projects certainly may have need for footers
> that denote different things that want different semantics (e.g. Who
> authored it and who cheered on it), but that is outside the scope of
> the "Signed-off-by" supported by "am -s" and "commit -s".
> 
> Support for more generic footers was supposed to come when the
> "interpret-trailers" topic started, but the author of the topic
> seems to have lost interest before the mechanism has become ready to
> be integrated in the workflow commands like "am", "commit", "rebase"
> etc., which is unfortunate.
> 
> > 
> > sequencer.c:append_signoff() has a flag for APPEND_SIGNOFF_DEDUP
> Yes, I think this is one of the warts we talked about getting rid of
> but haven't got around to it.  It is there because "format-patch -s"
> was incorrectly written to dedup Signed-off-by: from anywhere in its
> early implementation and to keep the same behaviour.  We should drop
> that flag from append_signoff() function.
