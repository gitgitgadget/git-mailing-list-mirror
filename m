From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sun, 18 Mar 2012 22:26:25 +0100
Message-ID: <CACBZZX6_m6b3Abf=NhWvL_g5aHEG9xZEBFfc3K35aSRrUBeWOQ@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
 <4F6461D7.40303@pileofstuff.org> <7vipi1d9r7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Sayers <andrew-git@pileofstuff.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Ncq-0000y0-74
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 22:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab2CRV0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 17:26:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42658 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2CRV0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 17:26:46 -0400
Received: by eaaq12 with SMTP id q12so2536386eaa.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4gINc/XYgsqVou7v36eGrnzuOlgeIOTQocu4bqilyIc=;
        b=uNDguMl4vvAEVdPNFGmDBx5nNG5Yv0deB1OWg3DEzcWR87nVG0OnL/b4UEK7ugTbjz
         DNoY6K5UpAnQqMHz+nO74DIAI+VQ0sDekIjqkcodxA5J4B9WBPlZ17p5mzHVg7eI5roU
         2a+A1r2hvO/3cg4M/uC+Udxp8djaoeVzfW24q3HE0vh47CpLKV2jMYfodFalPb4eqBBr
         qUH20v+QZ5Qe7BYPxdRSpKrHt3WNj4e6lQD7FL1JrtOFyaI90Y3OspHazQLCXfFMIEjp
         MTS8NpwskpAxTLDmlA5VBVAg2m/Jyd3OsaeQjDoWQl9npJrZm9XsgvizwwDFEFf0ZvWm
         u4Rg==
Received: by 10.14.99.76 with SMTP id w52mr1268187eef.3.1332106005420; Sun, 18
 Mar 2012 14:26:45 -0700 (PDT)
Received: by 10.213.19.83 with HTTP; Sun, 18 Mar 2012 14:26:25 -0700 (PDT)
In-Reply-To: <7vipi1d9r7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193391>

On Sun, Mar 18, 2012 at 19:50, Junio C Hamano <gitster@pobox.com> wrote:

> But again, that is not something we have direct control over [...]
> ---whoever is doing the locking-out is taking responsibility for
> these users who are out of our reach.

Firstly I'm all for this change, but I agree with Andrew Sayers that
step the deprecation plan is somewhat questionable.

I contribute to the perl core and a few years ago we moved to make
yearly releases, at the same time we introduced a deprecation cycle
saying that if we warn that something will be removed in $YEAR it's
kosher to remove it in $YEAR+2.

The problem with that approach is that as Andrew points out OS release
cycles aren't yearly, so someone might upgrade from $YEAR-2 to YEAR+3
and find that his programs don't compile anymore.

Git is similar to Perl in that most of our users don't get Git from us
with any regular interval, they just use whatever's packaged by their
OS, and in practice:

 * Most of your users use your program through their OS vendor

 * OS vendors will upgrade their OS whenever they feel like it.

 * OS vendors are in all likelyhood not going to backport some
   deprecation patch or eject it from their build in a manner that
   makes sense with regard to their release schedule.

That sucks, but given that this is how things work I wonder who we're
really helping by implementing deprecation warnings from the
standpoint of our release cycle, probably not the majority of our
users.

Most of our users are either never going to see this warning because
their OS will skip the whole of steps 2-6, or worse yet their OS
might upgrade Git between steps 2-5 and they'll be stuck watching the
warning it for 1-6 years, or however long their upstream vendor takes
up upgrade.

I think a better strategy would be to just announce that we're going
to change it, and then just change it without any intermediate
steps. That's what this is going to look like anyway to most of our
users, and without the danger that our users will be stuck on releases
that'll spew warnings about some upcoming change which in reality
happened in upstream years ago.

We could even use the only way of communicating to everyone involved
that something major changed: bump the major version number.
