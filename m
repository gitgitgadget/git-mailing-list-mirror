From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Sun, 7 Jun 2009 19:21:13 +0800
Message-ID: <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com>
References: <20090602174229.GA14455@infidigm.net>
	 <m3vdnda9f7.fsf@localhost.localdomain>
	 <7vmy8p8947.fsf@alter.siamese.dyndns.org>
	 <20090603191050.GB29564@coredump.intra.peff.net>
	 <20090603191555.GL3355@spearce.org>
	 <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
	 <20090604160152.GA13984@sigill.intra.peff.net>
	 <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 07 13:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDGUI-0007zu-8r
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 13:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbZFGLVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 07:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbZFGLVM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 07:21:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:11150 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbZFGLVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 07:21:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1062304wfd.4
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T9CXVOCn3TamnpKyrwjnrutCBiBQeSFAuEUW+fl+MCM=;
        b=lbjJM/dx6yH2hqawWZscYHTBDLnzHb0p/VAsn1X8pfmdK97zebhpaHnLCDmkhjIY+i
         T7qsduVCIDdXGsqcj909qRLLUk4sorV1JLCKvbxXMQNgl21wp/3gp4EboDU+JIWunuPf
         Gtjwxagu+mmpv7UXuLCAhfm3Fw85c60Vn3+As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lMrK200y+J2r1HTm6X2Ja/2wuxo29MddpVlhKlFAqJ9xycQh2TS3Np2cvp6kV3OzJD
         6M6ygtLrR/eT9zugWcCV+/DYLRYXJ+tFFuKebeZwf4WovAkCmmmNNhpv80DRM9pSSYd3
         gFVxmHkJnZTUkb+39ioLPHSRLIpBoJF5b7h/U=
Received: by 10.142.185.21 with SMTP id i21mr1989589wff.311.1244373673822; 
	Sun, 07 Jun 2009 04:21:13 -0700 (PDT)
In-Reply-To: <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120964>

Hi,

On Sun, Jun 7, 2009 at 6:31 PM, Tay Ray Chuan<rctay89@gmail.com> wrote:
> On Fri, Jun 5, 2009 at 12:01 AM, Jeff King<peff@peff.net> wrote:
>>
>> =A0 =A0 =A0 =A0Fetching %s (got %d packs, %d loose): (%d/%d)
>>
> Hmm, just wondering, is this is the intended display for "-q" or "-v"=
?
> Or should I do isatty(), like builtin-pack-objects.c does for the
> "Writing objects" progress indicator?

by the way, I have updated http-progress-indicators based on your sugge=
stions.

What I have now is:

 Fetching %d objects (got %d of %d, %d alt)[, and %s]: 100%
(32077585/32077585), 30.59 MiB, done.

where

1. %d objects =3D number of concurrent objects being fetched, usually
around 4-5. Since objects are fetched alongside other files like packs
and pack indices, I separated this from (4).

2. got %d of %d =3D a count of loose objects. I haven't done counting o=
f
packs yet, but it shouldn't be very hard.

3. %d alt =3D number of alternate objects. The way I'm counting them no=
w
is very inaccurate; I may drop this if it's too complicated to do an
accurate count. I added this because some people use forked repos, and
they may wonder why after some time, the number of objects fetched
doesn't increase. (The time was spent on waiting for the server, only
for it to return a 404).

4. [, and %s] =3D an "optional" field that gets displayed when packs,
pack indices, etc. (everything except objects) are being fetched. The
byte counts are for this fetch, not the object fetch(es).

How about pack file verification? Some pack files are monstrous, and
can take some time to verify. Is it desirable to fit in pack file
verification into the same "Fetching..." line? Verification is a
per-file thing, so it should deserve the same treatment that "Getting
pack ..." lines got.

--=20
Cheers,
Ray Chuan
