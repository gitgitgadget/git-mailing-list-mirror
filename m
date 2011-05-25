From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cross-compiling git (was: [PATCHv2] add Android support)
Date: Wed, 25 May 2011 16:20:00 +0200
Message-ID: <201105251620.01116.jnareb@gmail.com>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de> <m3k4dhzynr.fsf_-_@localhost.localdomain> <20110523143040.GB17743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Rafael Gieschke <rafael@gieschke.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 16:20:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEwY-0006hr-Jo
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861Ab1EYOUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:20:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846Ab1EYOUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:20:04 -0400
Received: by fxm17 with SMTP id 17so5404304fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=3NsfBG97Voij1VAsnktEfE+xprxyZ/HjMTYXrVhi/q0=;
        b=YUbzPGcVpl4zBjnahiFuT4UAuz7XGp1ex+0AFzd+QLh/ftOWIQ4Qh2G3LlTCHvEkSd
         WdSF3zGZDW1ohmFAdDINbiIcb3BUdJuqVm4d2Sw54pQof3wcKBpkkXII6kaQiEx4MDYV
         tfDL6lAuvmNW9H8xUZesm7LcTwi8FHJbP1RGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CjQxU1B+7RqGekj5o4vljFIkbiyp01OBg6+2hbAT4wzDe2YYBqBYFZbGkn8jnkUB28
         AcCjYVEdeDcva7EoWYlSv5MjzmcuUVsMN1OUBzxMoji0GMa3e5kZxt+gRW2VXI/x0NDa
         akVjRYT7o4ovF1KELkz1MLcdadJ6DW1LT+fEY=
Received: by 10.223.13.69 with SMTP id b5mr1515247faa.140.1306333202801;
        Wed, 25 May 2011 07:20:02 -0700 (PDT)
Received: from [192.168.1.13] (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id b22sm253247fak.27.2011.05.25.07.20.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:20:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110523143040.GB17743@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174404>

On Mon, 23 May 2011, Jeff King wrote:
> On Mon, May 23, 2011 at 12:04:44AM -0700, Jakub Narebski wrote:
> 
> > > So I think we are probably stuck either with the user setting an ANDROID
> > > meta-flag that sets the other flags appropriately, or leaving it up to
> > > the user to provide a sane config.mak.
> > 
> > By the way, how well Git supports cross-compiling (which from the
> > thread is necessity to generate binaries for Android)?  `uname -a`
> > trick works only when compiling on same machine.
> 
> It should work fine if you set the make variables appropriately for the
> target platform. But I've never tried it. Didn't msysgit people
> cross-compile for a while (or maybe still do)?

Well, the vague sketch of an idea is for Makefile to set uname_*
variables depending on the contents of `host` / `HOST` build variable,
so that detection is based on the target OS.

> > ./configure supports --host and --build options, but I don't know if
> > it pass them down to make somehow.  ANDROID=YesPlease seems wasteful:
> > what about setting HOST or MACHINE, or even uname_* variables, or just
> > using Autoconf's `host` (in the form of CPU-VENDOR-OS)?
> 
> I know very little about autoconf internals, but what would
> CPU-VENDOR-OS look like? Your CPU is probably some arm variant, though
> it will vary from device to device. Your kernel is Linux. The special
> steps in this case are about some weird userspace issues. So the
> equivalent would be more like finding a Linux distro that ships a crappy
> libc.  I guess that is what the "vendor" slot is for?

Well, http://www.gmplib.org/list-archives/gmp-bugs/2011-January/002156.html
says that it is

  $ ./configure --host=arm-linux-androideabi

(though I am not sure if it shouldn't be arm-androideabi-linux instead).
 
> But even if you somehow tell autoconf or the Makefile "yes, this is
> android", you are still going to need to manually specify the set of
> knobs that should be tweaked in that case.

See first paragraph of my reply.

> Whether you call it "ANDROID=YesPlease" or some other form.

I think it is better to solve more generic issue of cross-compiling
Git rather than solving narrow issue of cross-compiling Git on Android.

Of course we still need the part that sets variables appropriately
when we are compiling for Android (whether natively, or cross-compiling).
-- 
Jakub Narebski
Poland
