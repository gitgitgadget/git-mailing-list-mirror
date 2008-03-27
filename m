From: Jeff King <peff@peff.net>
Subject: Re: git add -i doesn't update permissions
Date: Thu, 27 Mar 2008 01:57:46 -0400
Message-ID: <20080327055746.GA8469@coredump.intra.peff.net>
References: <20080326102332.GA26842@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Mar 27 06:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jel8K-0004Ji-6l
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 06:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYC0F5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2008 01:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbYC0F5t
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 01:57:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1441 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbYC0F5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 01:57:49 -0400
Received: (qmail 9810 invoked by uid 111); 27 Mar 2008 05:57:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 01:57:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 01:57:46 -0400
Content-Disposition: inline
In-Reply-To: <20080326102332.GA26842@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78335>

On Wed, Mar 26, 2008 at 11:23:32AM +0100, J=C3=B6rg Sommer wrote:

> +test_expect_success 'update file permissions' '
> +       git reset --hard &&
> +       chmod +x file &&
> +       printf "p\n1\n" | git add -i
> +'

I'm not sure this is really a bug (but rather a feature request, which =
I
will explain below). add--interactive has two modes for moving changes
to files into the index:

  1. 'u' will 'update' the file in the index, adding the new content an=
d
     any mode changes

  2. 'p' will show you each patch hunk from the file, which can then
     either be added or not.

You are using 'p' and expecting it to work with the file mode, when it
is purely about picking content hunks.

So I think the test _should_ be

  printf "u\n1\n" | git add -i

in which case it works fine.

Now, if you are interested in adding the mode change of a file but _not=
_
its content, I think that is a reasonable thing to ask for. And it's
something that is not possible with "add -i" right now, I don't think.
You seemed to expect that 'p' would present the mode change and say "do
you want to stage this?" which I think is a reasonable interface. Thoug=
h
in that case "[p]atch" should perhaps be "[p]artial update".

-Peff
