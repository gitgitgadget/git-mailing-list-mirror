From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 19:06:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231903050.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info> <xmqqtx0n710m.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
 <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info> <xmqqmw6e499u.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
 <xmqqa92e47ap.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info> <xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:07:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3TrV-0007yd-HA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaLWSHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:07:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:60404 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbaLWSHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:07:05 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Lg0wl-1XWalN1trH-00pdWX;
 Tue, 23 Dec 2014 19:06:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:IKnu5u4O4F1E46w0xdgtvp/lQUDnwrWTrydDXKKeHBgSj88lNCM
 gE8vd0sfu7RYiXbp9PCWjbn8MVilqn5JsZE1g5Txp4q7fsBXJdusI+LUxHYbKfpezMZp3cv
 MxRnIMjU9tdIdQXiWKgXMBUz5HHfKyB2+PBVFofLNGV716VfUBF6FlWUrAZdE2+DMluCTtU
 Bwhryn6ocfaVgUcGlF22Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261752>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay, so just to clarify: you want me to
> >
> > - split the parser into
> >
> > 	- a parser that accepts only camelCased variable names when they
> > 	come from the config (for use in fsck and receive-pack), and
> 
> OK.
> 
> > 	- another parser that rejects camelCased variable names and only
> > 	  accepts lower-case-dashed, intended for command-line parsing
> > 	  in fsck, index-pack and unpack-objects, and
> >
> > - consequently have a converter from the camelCased variable names we
> >   receive from the config in receive-pack so we can pass lower-case-dashed
> >   settings to index-pack and unpack-objects.
> 
> I am not sure about the latter two.  This needs a design discussion
> what the command line options should be.
> 
> I think the command line should be like this:
> 
> 	git cmd --warn=missingTags,missingAuthor

Okay. This contradicts the convention where Git uses lower-case-dashed
command-line option values (e.g. on-demand, error-all, etc) and no
camelCased options were present so far. But your wish is my command.

Ciao,
Dscho
> 
> in the first place, i.e. "we may invent tokens to denote new kinds
> of errors as we improve fsck", not with "we may add options for new
> kinds of errors", i.e. the command line should not look like this:
> 
> 	git cmd --missing-tags=warn --missing-author=warn
> 
> And from that point of view, I see no reason to support the dashed
> variant anywhere in the code, neither in the config parser or in the
> command line parser.
> 
