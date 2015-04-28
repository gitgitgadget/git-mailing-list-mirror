From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/5] setup: sanity check file size in
 read_gitfile_gently
Date: Tue, 28 Apr 2015 02:02:22 -0400
Message-ID: <20150428060222.GK24580@peff.net>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 08:02:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmybY-0005ar-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 08:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbbD1GC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 02:02:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:50984 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750970AbbD1GCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 02:02:25 -0400
Received: (qmail 19606 invoked by uid 102); 28 Apr 2015 06:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:02:25 -0500
Received: (qmail 11866 invoked by uid 107); 28 Apr 2015 06:02:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 02:02:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 02:02:22 -0400
Content-Disposition: inline
In-Reply-To: <1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267900>

On Sun, Apr 26, 2015 at 08:49:42AM +0200, Erik Elfstr=C3=B6m wrote:

> read_gitfile_gently will allocate a buffer to fit the entire file tha=
t
> should be read. Add a sanity check of the file size before opening to
> avoid allocating a potentially huge amount of memory if we come acros=
s
> a large file that someone happened to name ".git". The limit is set t=
o
> a sufficiently unreasonable size that should never be exceeded by a
> genuine .git file.
>
> [...]
> +	if (st.st_size > PATH_MAX * 4) {
> +		error_code =3D READ_GITFILE_ERR_TOO_LARGE;
> +		goto cleanup_return;
> +	}

My understanding is that PATH_MAX is set absurdly low on Windows
systems (and doesn't actually represent the real limit of a path!).
Since the value is picked arbitrarily anyway, could use something more
independent (like 100K or something, which is large enough to be beyond
absurd and small enough that a malloc isn't a big deal)?

-Peff
