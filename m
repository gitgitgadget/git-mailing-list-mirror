From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 09 Mar 2016 19:01:19 -0500
Organization: Twitter
Message-ID: <1457568079.13557.7.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-5-git-send-email-dturner@twopensource.com>
	 <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
	 <xmqqpov3fdb6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:01:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ado2z-0001Sx-QE
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbcCJABZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 19:01:25 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35605 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934532AbcCJABV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:01:21 -0500
Received: by mail-qk0-f172.google.com with SMTP id o6so27833905qkc.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9O9VgAJ5dkCOOPUKVFGXRXaat1Zb62zDo8A5mLgy54s=;
        b=uuz4KfXqP4pfdwSOa9TkyoMpiAmOReuArEsdytiWnZ0MvDwm+1CYCAKy7QCkG8dTb1
         bp9AGcLSOWk4I4a+zVMEKKdAygop3io51UaqiwKyw9GXI47nAkyujps2UVVuOYa23khF
         LB+kVWW8vg/BUjmYPaceF/UFuKzqAnXpk9Px0YE70ZDiUMih3vweFn4ixd8tLgiJQGZx
         rl7ZfyVltytQ4qkjSvOCtkyGBUGtg0kHVgOQqYlJp/zT7Gv3Swbv7Y94i9eOTWoJ7BaZ
         ovFpXt1AcfgnIA+zDu8lEsylx6OXaUjA/+SO+vC/k0aUCicvqz4ae45GSHcS2hj0iKKd
         ZRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9O9VgAJ5dkCOOPUKVFGXRXaat1Zb62zDo8A5mLgy54s=;
        b=llRxZJsUOsPh8V70P2kSeOIHDIBJ9jXPT7JvUJp1qjA3k2otNM3tnuR5WVCevdITHw
         C7p7krKFoO+ezGxbCM0G79nvRq9wJM9z5Sj8ZBCduycjQ0/LtZAfFcqZB2nqairDwOi8
         92VG0AY2ZWKop9tvPTx3l4i0YwQAxhhk+J0k1SIKYwggnS2joSQRtykcP/VPvDXVrVUf
         FBJDTGs/uj9rSHVGK+61WcHNMse8RW7LCdf65/2WaPZE3ciNohXg5bcvcTu1rfedF2/L
         uXx/X0vHHL7qrOWIWmErl87AoWN+XgqUzjPdYnezKVmkiLU2b/1p1eLi49xab3tweTfv
         S2Rw==
X-Gm-Message-State: AD7BkJJWaq9Y6IkwqftMRz8+syyMYqwSiEMvCprJncHWFCc5X9JQIj39O/K+vtWCBabCoA==
X-Received: by 10.55.25.141 with SMTP id 13mr510300qkz.69.1457568080495;
        Wed, 09 Mar 2016 16:01:20 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id d73sm533095qhc.23.2016.03.09.16.01.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 16:01:19 -0800 (PST)
In-Reply-To: <xmqqpov3fdb6.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288585>

On Wed, 2016-03-09 at 15:21 -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > David Turner <dturner@twopensource.com> writes:
> >=20
> > > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
> > >=20
> > > Instead of reading the index from disk and worrying about disk
> > > corruption, the index is cached in memory (memory bit-flips
> > > happen
> > > too, but hopefully less often). The result is faster read. Read
> > > time
> > > is reduced by 70%.
> > >=20
> > > The biggest gain is not having to verify the trailing SHA-1,
> > > which
> > > takes lots of time especially on large index files.
>=20
> Come to think of it, wouldn't it be far less intrusive change to
> just put the index on a ramdisk and skip the trailing SHA-1
> verification, to obtain a similar result with the same trade off
> (i.e. blindly trusting memory instead of being paranoid)?
>=20

1. If the index were stored on a ramdisk, we would *also* have to write
it to durable storage to avoid losing the user's work when they power
off.  That's more complicated. =20

2. Duy notes that it is easier to add further optimizations to this --
for instance, we could share a pre-parsed version of the index.  It
would be harder to add these optimizations to the disk format, because
(a) they would take up more space, and (b) they would probably be
harder to write in a single pass, which is presently how index writing
works.

3. If we wanted to just skip SHA-1 verification, we would not need a
ramdisk; it's almost certain that the index would be in the disk cache
most of the time, so regular storage should be very nearly as fast as a
ramdisk. I think mlock might help ensure that the data remains in the
cache, although I'm not sure what the permissions story is on that.
