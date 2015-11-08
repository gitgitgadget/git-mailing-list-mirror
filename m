From: Jeff King <peff@peff.net>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sun, 8 Nov 2015 00:10:59 -0500
Message-ID: <20151108051059.GB19191@sigill.intra.peff.net>
References: <563DEA71.1080808@dinwoodie.org>
 <20151107184527.GA4483@sigill.intra.peff.net>
 <20151107192029.GW14466@dinwoodie.org>
 <1446930165.16957.9.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Sun Nov 08 06:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvIFw-0002b9-7C
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 06:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbbKHFLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 00:11:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:54667 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751051AbbKHFLC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 00:11:02 -0500
Received: (qmail 7711 invoked by uid 102); 8 Nov 2015 05:11:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Nov 2015 23:11:02 -0600
Received: (qmail 7788 invoked by uid 107); 8 Nov 2015 05:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Nov 2015 00:11:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Nov 2015 00:10:59 -0500
Content-Disposition: inline
In-Reply-To: <1446930165.16957.9.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281031>

On Sat, Nov 07, 2015 at 10:02:45PM +0100, Dennis Kaarsemaker wrote:

> Looks like lib-proto-disable.sh's fake SSH doesn't strip double leading
> /'es from the path. Try this patch:
> 
> diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable
> -ssh.sh
> index ad877d7..a954ead 100755
> --- a/t/t5813-proto-disable-ssh.sh
> +++ b/t/t5813-proto-disable-ssh.sh
> @@ -14,7 +14,7 @@ test_expect_success 'setup repository to clone' '
>  '
>  
>  test_proto "host:path" ssh "remote:repo.git"
> -test_proto "ssh://" ssh "ssh://remote/$PWD/remote/repo.git"
> -test_proto "git+ssh://" ssh "git+ssh://remote/$PWD/remote/repo.git"
> +test_proto "ssh://" ssh "ssh://remote$PWD/remote/repo.git"
> +test_proto "git+ssh://" ssh "git+ssh://remote$PWD/remote/repo.git"
>  
>  test_done

Good catch. It's a shame that the resulting URL becomes a little less
readable, but given that the damage is limited to this one test, I think
we can live with it. Working around it in the fake ssh script would
probably end up unnecessarily complex.

We may want to have git itself remove extra slashes from URLs, as Ramsay
suggested elsewhere, but I would worry about regressions. Let's solve
this test portability problem by itself, and we can consider the other
as a separate topic if anybody wants to pursue it.

Dennis, can you roll up a full patch with a commit message?

-Peff
