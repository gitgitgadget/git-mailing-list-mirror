From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH] Add a remote helper to interact with mediawiki, pull &
 clone handled
Date: Mon, 6 Jun 2011 19:48:17 +0000
Message-ID: <BANLkTi=nOa2B_KNfv-XkYFVr8Ngdd2msFA@mail.gmail.com>
References: <1307355635-5580-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?Q?Sylvain_Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfmw-0008OK-5k
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1FFTsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 15:48:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65477 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab1FFTsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 15:48:32 -0400
Received: by qwk3 with SMTP id 3so1819337qwk.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=z0oRDUMgcmpm1qxsjvQ/+cL/F8syeDTgvB5FCQIu9pY=;
        b=potZ3oXs9pkhjmypwXU1Ocn4/mHn7e0mqd35x1JvX2F56dlTpC3wWbGNbUg1Ohyb4f
         CaT5uItrANKbfbymSS7lxNBl6Bus980CIeW+//2Lph7YZnOnM6esMAUdBfm89+56z3UA
         HH5Ht0OkO84m1OAHKjqUL0jCxI+SqKelyT/nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=sP25zz6givflvLn9DvZbTENfvnK/l1LT1l6W3fCkqfzAjRXGVUlRIpqBF9NhNs5NAm
         5Zl5YUPTIei7aQNpQNr5Urz8emyMhYw/VC+7HdRZ/ziWpMbBkBULOjtQhIq/N4l8HrZz
         4Aq/Snj3B81qH/+d2n0mLg3I39D1Vdlbf4RuI=
Received: by 10.229.37.144 with SMTP id x16mr3917752qcd.22.1307389712144; Mon,
 06 Jun 2011 12:48:32 -0700 (PDT)
Received: by 10.229.189.12 with HTTP; Mon, 6 Jun 2011 12:48:17 -0700 (PDT)
In-Reply-To: <1307355635-5580-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
X-Google-Sender-Auth: dRUi-ngzpcbUmZvU-uOmNeBJz2k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175153>

Hi,

On 6 June 2011 10:20, Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr> wrote:

I've got some points of my own for consideration.

> @@ -0,0 +1,306 @@
> +#! /usr/bin/perl
> +
> +use strict;

use warnings; ?

> +use Switch;

Ugh -- no.  This is terrible.  Look at this:

[~]% corelist Switch
Switch was first released with perl v5.7.3 and removed from v5.13.1

Since you do not specify a minimum perl version you might be alright,
but for those people on 5.14 -- they won't have this module, for good
reason.  You can, if you wanted use "given/when" as alternate
constructs to this.

> +use MediaWiki::API;
> +use Storable qw(freeze thaw);

This might have problems transcending storable formats made on a 32bit
machine, and then trying to unpack them again on 64bit.  Do you really
need the need for these storable items to be encoded as binary?

[...]

-- Thomas Adam
