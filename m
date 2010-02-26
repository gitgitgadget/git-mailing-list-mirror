From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] Disable OpenSSL SHA1 implementation by default
Date: Thu, 25 Feb 2010 23:11:59 -0500
Message-ID: <ca433831002252011r3d3459a2xca7535300cd6630f@mail.gmail.com>
References: <20100222110814.GA3247@progeny.tock> <20100222112326.GA21929@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Robert Shearman <robertshearman@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 05:12:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkrYw-0002TI-K5
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 05:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759474Ab0BZEMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 23:12:21 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37326 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230Ab0BZEMV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 23:12:21 -0500
Received: by gyh20 with SMTP id 20so1638988gyh.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 20:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QFnC9DpNSafH5iN070MbgF2C1Z50YlhngXhxBc3PIp8=;
        b=sCx2sicJ13795g1FTqBzC5q4Xy26tRQkpWjtMxrRNeHUmEHPvG+jJTiuYkOezebYMO
         fpSZY1O3eIIzkYNj0K/SpBGpqUalVRRXX6ZBhyQgTe54iQW3JZEDi6U6bbmsPX2VAD5s
         FLTBoksiIDZazxwikmPGjSVxkZVq/8Xmy31DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=usgV8mbcTTzRxC0Ll6G0gLmycTEA60tQXL4A+gNYI0KBM8PpXfz+AeYY25CW8OuU2m
         UDiHyyVm4yPueEwrX9wPnxGf9zzaTMy9LGscJPyaeHJdK9/M/mTfcY4tLm3soONra/6x
         ULAKo+00LuG1XcFhb54jt8JEvSTxaZSbRdyow=
Received: by 10.91.163.2 with SMTP id q2mr799906ago.33.1267157539156; Thu, 25 
	Feb 2010 20:12:19 -0800 (PST)
In-Reply-To: <20100222112326.GA21929@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141102>

On Mon, Feb 22, 2010 at 6:23 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 22, 2010 at 05:08:14AM -0600, Jonathan Nieder wrote:
>
>> The OpenSSL SHA-1 routine is about as fast as block-sha1, but linkin=
g
>> to libcrypto slows down the startup of git commands by an appreciabl=
e
>> amount. =C2=A0Use the BLK_SHA1 implementation by default instead.
>
> What is your definition of "about as fast"? I benchmarked up to a 20%
> slow-down a while back:

=46or what it's worth, here are my numbers from running git-fsck on my
x86-64 machine.  It appears that BLK-SHA1 is slightly faster.  If you
know a better benchmark to run, let me know.  Perhaps it would be good
to write some sort of suite to test this, and let people post their
results to some website.

make git-fsck
=2E/git-fsck  66.75s user 0.28s system 99% cpu 1:07.17 total
=2E/git-fsck  66.70s user 1.28s system 99% cpu 1:08.06 total
=2E/git-fsck  66.77s user 0.63s system 99% cpu 1:07.42 total

make BLK_SHA1=3D1 git-fsck
=2E/git-fsck  65.60s user 0.65s system 99% cpu 1:06.26 total
=2E/git-fsck  65.39s user 0.65s system 99% cpu 1:06.06 total
=2E/git-fsck  65.24s user 1.36s system 100% cpu 1:06.60 total

Core 2 Duo E6300 1.86 GHz (2MB L2 cache), 2GB memory
Ubuntu 9.10 x86-64, gcc 4.4.1, git v1.7.0-90-g251a495
