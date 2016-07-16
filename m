Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F8A203BD
	for <e@80x24.org>; Sat, 16 Jul 2016 08:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbcGPIee (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 04:34:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:51090 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbcGPIeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 04:34:31 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MDR21-1ba7hW0MWb-00GmwS; Sat, 16 Jul 2016 10:34:19
 +0200
Date:	Sat, 16 Jul 2016 10:34:17 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] Verify that --cherry-pick avoids looking at full
 diffs
In-Reply-To: <xmqqwpkmn83r.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607161033370.6426@virtualbox>
References: <alpine.DEB.2.20.1607151749540.6426@virtualbox> <xmqqwpkmn83r.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8lENQtdBboiGxOtkpSuRpbtDQZ5pYgvq5jvWEqTXMlOHB0fo2On
 gYfV6VAowuSyoFjmFDn+Ee4Uq489P1NbaCeYnjhMsC0Px3DLD3O9dMKMwsHuQpoyzVYzdmC
 6y7yD5m2XlnlLixxd47AXxu8iTaWMeTxuTM9ha/AQthl4DCWmhc9T/UUqp4ZgEaa4vj52EC
 GA16AV+WFgarzrp42T9pw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:vTDUp2afg0I=:OlY47YnhnvYSIqMh+Qqke3
 Sw1u+dnijBY3a7+Zj3Sih1Wy5Wl5Du7LhQpT7mP68adZ4DZJ5M0jBGbHZDlkY3Qxg79510b08
 OV+VGZhfwwp9rbluz5ZOGmqT7YIdoajhtXMkdZ6cMKmiakDJ7mt6sPzIUrMFuxFZz5NMeuvLT
 PU8/VkP4GE/Wdn02pa8+TzLA4ZdGiq0SJIznf6yqpI4SRsj+u+vMA7T/uYHQGBoTee6SXHegm
 WCjviRcI4JM0kyenFtXOquzRY5MZ30b6vdfBNQOg5sS7QtxohOOMsMCTghTnBDFgBWp5A52ya
 C8QHWyN8GGxQh7GmUcQVpjF+5jP4CnyCi7Qxy8IWUuCNh09BcY6uTXFCO6qBjPzzd/i/2lwLv
 ZDUHTJs60tGHD0I7W9FvzPUDirogOxo190OR8dacqiBm/jgPeaCLE7xL+OICJt2+4/vuYTwq9
 XfK5ovQ/F57ImHpqPkMCFj7Tq+6LDhLFI7UrX4yuYh2Oz0smEibK4sPKaUWAwnLmfdNYdt/VU
 pw9AgS+lq/7ZlPYLr0fdh+ohswuaon4wdREtJLo8/qQwzwmaz4Eaxm3WjP45+dNZp370E59mw
 uTlaVQ60vflV5qCTrjgIRzIaGcK9wLQxOJpfh3VVM/GAjh8V1y8OJZwsu/jXaMcvjZunOV8ez
 HVNpy2gvgGhK2ZXpqnt7kyiyzvyj/ADhz0OpER5wpqDMSyFeGwwNKGJMS0C+Tn7entJdYN1SC
 oMMH0OiDnlP6ryvBWQvC68OOajDK4XKixZhWn4F5+BXwXVL79wA6L+fm20l5oOCDHSGkqqpRv
 VouKwhH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 15 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The entire point of the previous patch was to make sure that we look at
> > abbreviated patch IDs (using the diff *headers* only, but avoiding
> > to load the blobs into memory and diff them) first, and only look at
> > full patch IDs when the abbreviated patch IDs were not for the
> > --cherry-pick test.
> >
> > Let's make sure that we actually avoid looking at the full patch ID,
> > simply by corrupting an object that is needed for the full patch ID, and
> > then seeing that --cherry-pick still works.
> 
> I think "Avoid looking at" merely is the means to an end, and not
> the goal by itself.  By not looking at them, you hopefully run
> faster.
> 
> So I'd think a more useful addition under t/ would be to t/perf
> somewhere, not "now you can rev-list --cherry-pick even inside a
> corrupt repository, as long as corruption happens to be with blobs
> and not the containing trees".

I agree that we need a perf test.

But we *also* need this test that ensures that we avoid loading blobs into
memory, because that is the solution we do not want to see regress in the
future.

Ciao,
Dscho
