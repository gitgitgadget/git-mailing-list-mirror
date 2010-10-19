From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fetch and bundle don't work in (semi-)broken repo
Date: Tue, 19 Oct 2010 13:39:25 -0500
Message-ID: <20101019183925.GF25139@burratino>
References: <20101019160957.GK11713@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 19 20:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8H9Z-0003cS-FU
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 20:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab0JSSnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 14:43:06 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39526 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0JSSnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 14:43:05 -0400
Received: by pxi16 with SMTP id 16so709372pxi.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EsDF5CvJsbjRZlp+U9I3HEvHjF/iHRCnfTN3YMMYSCk=;
        b=dAjJhu24YwvlynWkjWlbp6Hv2zDgNM0JXpAgFU8L8zFVBibxy4c7sndWQUz7mx8KdP
         k52vf/5/zzHAujikIZIdvfNyGjGp4EgKbt48S7Oz8lxLbn2XcVCHc2Y7peahY/nFiUkJ
         Mb4lyV9jslWLQEj7Nbia+bfammMNWcEnaEMT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=o6wBKiRWqn1NeQ3zFKEQYOQa04sfuY7Fr7IZNC966kLIEFq5GipwuzjYO8orvf/K9+
         Q3twIOLfp12O0OOFTv/t84LR9TNIdsGMpZzZ7K5BPrw7uH3hxN2spqHoG2xnXfltSjek
         okjA26QZqB4jHo291f/cnTwfdzgMHdGSgMJ94=
Received: by 10.142.209.10 with SMTP id h10mr5059101wfg.256.1287513784793;
        Tue, 19 Oct 2010 11:43:04 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y21sm2538259vbx.6.2010.10.19.11.43.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 11:43:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019160957.GK11713@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159350>

Hi,

Uwe Kleine-K=C3=B6nig wrote:

> 	ukl@hostname:~/path1/linux-2.6$ git fetch ~/path2/linux-2.6 sectionm=
ismatches
> 	remote: Counting objects: 118, done.
> 	remote: error: unable to find 40aaeb204dc04d3cf15c060133f65538b43b13=
b0
> 	remote: Compressing objects: 100% (83/83), done.
> 	remote: fatal: unable to read 40aaeb204dc04d3cf15c060133f65538b43b13=
b0
> 	error: git upload-pack: git-pack-objects died with error.
> 	fatal: git upload-pack: aborting due to possible repository corrupti=
on on the remote side.

Sounds like alternates or workdir allowed gc to be overzealous, indeed.

Could you:

 1. Make a copy of the corrupted repo, just in case.
 2. Explode all backs with "git unpack-objects"
 3. Identify the missing object, as explained in
    Documentation/howto/recover-corrupted-blob-object.txt?

With that information, it would be easier to examine whether and how
pack-objects could be smarter about fetching the non-missing objects.

> I don't know what 40aaeb204dc04d3cf15c060133f65538b43b13b0 is, but I
> think it's not necessary for the sectionmismatches branch:
>=20
> 	ukl@hostname:~/path2/linux-2.6$ git format-patch linus/master..secti=
onmismatches
> 	0001-wip-enable-DEBUG_SECTION_MISMATCH.patch
[...]
> and linus/master is contained in ~/path1/linux-2.6, too.

Cc-ing Nico, pack-objects wizard.

Thanks for reporting.
Jonathan
