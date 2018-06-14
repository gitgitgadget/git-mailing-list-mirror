Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584C11F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754758AbeFNSGw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:06:52 -0400
Received: from mail179-28.suw41.mandrillapp.com ([198.2.179.28]:5926 "EHLO
        mail179-28.suw41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754635AbeFNSGv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jun 2018 14:06:51 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 14:06:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=4YPUv7rJXvgRa+y/y/BdYlq0764v8FJ/N2iTFPcu/kA=;
 b=HISWAgY0IzADPOoqHBYOfwJzl/HMeXm4o0/zrtg/NEEuedEkjtVeDcO8sTDE5bOAYfBOM2OQ2x0s
   jcrjZTNquXVFOu8APdUafJlsn5UbSdDulzZdvRmebt2QaKt4oEqfj+s7eeWjpLqvWLtul0POBn/f
   69SXKPGsMU/+oP84vvU=
Received: from pmta04.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail179-28.suw41.mandrillapp.com id h4anbm22s283 for <git@vger.kernel.org>; Thu, 14 Jun 2018 17:51:51 +0000 (envelope-from <bounce-md_31050260.5b22ab37.v1-e8f5ef7819ef44de88e7935616010f8a@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528998711; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=4YPUv7rJXvgRa+y/y/BdYlq0764v8FJ/N2iTFPcu/kA=; 
 b=Qs6p7IQbd949IJi7xFMt3rLon21lH6MdjSn/dCc02ZqYs3YU8ItX8Tat7EqL8iJ2Ul+wI7
 4WovSNpioeJPxkq6abwLrosmlzx6f32fx3VGcknUDknvmSuWxm+yd4i6qUvNCheoKcBzJZEZ
 7QkyTXEy4dAtOVw6B7c85pqWWeR54=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
Received: from [87.98.221.171] by mandrillapp.com id e8f5ef7819ef44de88e7935616010f8a; Thu, 14 Jun 2018 17:51:51 +0000
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Message-Id: <20180614175147.GB27147@deco.navytux.spb.ru>
References: <20180612185413.GA21856@deco.navytux.spb.ru> <20180613111840.1427-1-kirr@nexedi.com> <xmqqbmce7fcm.fsf@gitster-ct.c.googlers.com> <20180613184301.GB22854@deco.navytux.spb.ru> <20180613210509.GA15574@sigill.intra.peff.net> <20180613231147.GA21025@sigill.intra.peff.net> <20180614052455.GA2861@deco.navytux.spb.ru> <xmqqzhzx4aip.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhzx4aip.fsf@gitster-ct.c.googlers.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.e8f5ef7819ef44de88e7935616010f8a
X-Mandrill-User: md_31050260
Date:   Thu, 14 Jun 2018 17:51:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 09:07:26AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > Jeff, thanks for corrections. I originally tried to look into invoking
> > "git tag" two times, but since git tag always creates a reference it
> > would not be semantically the same as having one referenced tag object
> > pointing to another tag object which does not have anything in refs/
> > pointing to it directly.
> 
> Well, then you could remove it after you are done, no?  I.e.
> 
> 	git tag -a -m "tag to commit" tag-to-commit HEAD
> 	git tag -a -m "tag to commit (1)" temp-tag HEAD~1
> 	git tag -a -m "tag to tag" tag-to-tag temp-tag
> 	git tag -d temp-tag
> 
> would make the temp-tag object reachable only via refs/tags/tag-to-tag
> I think.

Yes, I could remove, and I though about it originally, but to me it is
less clean compared to just creating new tag object without any
reference to it in the first place.

Kirill
