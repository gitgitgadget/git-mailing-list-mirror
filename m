From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v6 5/6] fast-import: add option command
Date: Thu, 3 Sep 2009 06:55:38 +0200
Message-ID: <fabb9a1e0909022155r254c41c6s9ed962313c241e9@mail.gmail.com>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com> 
	<1251914223-31435-2-git-send-email-srabbelier@gmail.com> <1251914223-31435-3-git-send-email-srabbelier@gmail.com> 
	<1251914223-31435-4-git-send-email-srabbelier@gmail.com> <1251914223-31435-5-git-send-email-srabbelier@gmail.com> 
	<1251914223-31435-6-git-send-email-srabbelier@gmail.com> <7vskf4px6j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 06:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj4Mh-0007bV-Pa
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 06:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbZICEz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2009 00:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbZICEz5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 00:55:57 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:41756 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZICEz5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2009 00:55:57 -0400
Received: by ewy2 with SMTP id 2so1488415ewy.17
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 21:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q0gdVGMvejf6j4y6sKp9Rzs6y3u975DTH91UheTVRx0=;
        b=qvEvl5GwF1hkL7HZgaEZHggdhYqZdghFCKZI0auqfzD3nvC0VVfFezyPJooeWA+n6k
         OhOyjs0cz74CcTaCtB7b/wMHpSDIjPln8GNBVtc/iANGtsE3dlT22k22A0GDDc/3MZi5
         jVq9ag4u0AhpHBCI99/uHrIyeBORES63i1VfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T90DPq/FWCIZSfiemlYrWza9aQukaT3bWNeKr2E5Ks9qhk3FAtqFNwvktrmizB9DCv
         Pxg469GNL3qM3/ViU5KgUsKsR/ujRoJN+mNocWdt5ti42/uUk3aF4WKh3hxCtqbh2Hoy
         73ycrvRo5vF/0dyp9K1Ik0L0CvO4wYdNnVJD0=
Received: by 10.216.87.201 with SMTP id y51mr398800wee.80.1251953758108; Wed, 
	02 Sep 2009 21:55:58 -0700 (PDT)
In-Reply-To: <7vskf4px6j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127639>

Heya,

On Thu, Sep 3, 2009 at 04:41, Junio C Hamano<gitster@pobox.com> wrote:
> If "option git something-unknown" is given, it is clear that the tool=
 that
> generated the stream assumed that such an option exists in the import=
er;
> it might appear prudent to abort the operation.
>
> But what about "option hg something"?

I think we should assume that if we see 'option not-us foo' without a
preceeding 'feature not-us-option', the frontend does not require us
to understand the option (perhaps because they also specify 'option
git foo'.

> If that is the sensible thing to do, then we obviously should ignore
> "option hg anything", but at the same time we should ignore "option g=
it
> we-do-not-know-what-it-does".

Perhaps, frontends could then use 'feature git-quiet-option' if it
wants to make sure it is supported.

> I think at least the function should be made conditional to die() if =
it
> was called from parse_argv() but simply ignore unknown if it was call=
ed
> from the input stream.

Makes sense, what do the fast-import devs think?

>> +static void parse_option(void)
>> +{
>> + =A0 =A0 char* option =3D command_buf.buf + 11;
>
> ERROR: "foo* bar" should be "foo *bar"

Ah, I thought I had fixed all of those, apologies.

> ERROR: do not use C99 // comments
> ERROR: do not use C99 // comments

Will fix in the next version (after we decide on what to do with
unknown git options).

--=20
Cheers,

Sverre Rabbelier
