From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v3 3/3] Add documentation for virtual repositories
Date: Thu, 26 May 2011 11:28:33 -0700
Message-ID: <BANLkTimQO3AFeSmmFZOBLLGwEDgQk33Euw@mail.gmail.com>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
 <1306284392-12034-3-git-send-email-jamey@minilop.net> <20110525160708.GE8795@sigill.intra.peff.net>
 <BANLkTikwxiBTVdqnQtdvr-VTCm2hSOcRjw@mail.gmail.com> <20110525171021.GA24038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 20:29:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPfIq-0007eA-5r
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 20:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630Ab1EZS2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 14:28:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49322 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1EZS2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 14:28:54 -0400
Received: by vws1 with SMTP id 1so764099vws.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 11:28:53 -0700 (PDT)
Received: by 10.52.65.106 with SMTP id w10mr1268655vds.137.1306434533073; Thu,
 26 May 2011 11:28:53 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Thu, 26 May 2011 11:28:33 -0700 (PDT)
In-Reply-To: <20110525171021.GA24038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174556>

On Wed, May 25, 2011 at 10:10, Jeff King <peff@peff.net> wrote:
> Like chroots, there is a sticky point with symbolic links. What shoul=
d
> "refs/virtual/repo1/HEAD" have in it? Either:
>
> =A0ref: refs/virtual/repo1/refs/heads/master
=2E..
> If the former, then we will have to make sure the ref is inside our
> prefix, and strip it out.

Yes. And if its outside of our chroot space, we have to hide the
symbolic reference as though it is broken. This is fairly simple since
symbolic references are supposed to be "absolute", we can do a quick
prefix test and either strip the prefix on read (or add it on write),
or pretend like the reference is broken and hide it if its outside the
prefix.

> If the latter, then you will get different
> results for:
>
> =A0git show refs/virtual/repo1/HEAD
>
> versus
>
> =A0GIT_REF_PREFIX=3Drefs/virtual/repo1 git show HEAD
>
> which I think is a bad thing.

Yes, I agree, this would be bad. Hence we should store the real path
in the symbolic reference, but strip/add the prefix when
GIT_REF_PREFIX is set.

--=20
Shawn.
