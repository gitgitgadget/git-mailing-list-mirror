From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 02:17:42 -0400
Message-ID: <20150428061741.GL24580@peff.net>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 08:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymyq5-00028b-VH
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 08:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbbD1GRq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 02:17:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:50992 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750970AbbD1GRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 02:17:44 -0400
Received: (qmail 20266 invoked by uid 102); 28 Apr 2015 06:17:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:17:44 -0500
Received: (qmail 11965 invoked by uid 107); 28 Apr 2015 06:18:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 02:18:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 02:17:42 -0400
Content-Disposition: inline
In-Reply-To: <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267901>

On Sun, Apr 26, 2015 at 08:49:41AM +0200, Erik Elfstr=C3=B6m wrote:

> -extern const char *read_gitfile(const char *path);
> +
> +#define READ_GITFILE_ERR_STAT_FAILED 1
> +#define READ_GITFILE_ERR_NOT_A_FILE 2
> +#define READ_GITFILE_ERR_OPEN_FAILED 3
> +#define READ_GITFILE_ERR_READ_FAILED 4
> +#define READ_GITFILE_ERR_INVALID_FORMAT 5
> +#define READ_GITFILE_ERR_NO_PATH 6
> +#define READ_GITFILE_ERR_NOT_A_REPO 7
> +extern const char *read_gitfile_gently(const char *path, int *return=
_error_code);

There was a discussion not too long ago on strategies for returning
errors, and one of the suggestions was to return an "error strbuf"
rather than a code[1]. That's less flexible, as the caller can't react
differently based on the type of error. But for cases like this, where
the only fate for the code is to get converted back into a message,
it can reduce the boilerplate.

What you have here is OK to me, and I don't want to hold up your patch
series in a flamewar about error-reporting techniques. But I think it's
an interesting case study.

-Peff

[1] The original thread was here:

      http://thread.gmane.org/gmane.comp.version-control.git/259695/foc=
us=3D260722

    I'm still a little wary of the allocation boilerplate introduced by
    the strbuf approach. But in this case it would not be too bad, I
    think.
