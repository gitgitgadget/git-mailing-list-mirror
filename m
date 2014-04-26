From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Sat, 26 Apr 2014 03:13:58 -0400
Message-ID: <20140426071358.GA7558@sigill.intra.peff.net>
References: <20140421204622.GA9532@logfs.org>
 <20140425182928.GA29904@logfs.org>
 <vpqoazpdz1r.fsf@anie.imag.fr>
 <20140425201048.GB29904@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 09:14:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdwoM-0006it-83
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 09:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbaDZHOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 03:14:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:38885 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751391AbaDZHOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 03:14:00 -0400
Received: (qmail 28303 invoked by uid 102); 26 Apr 2014 07:14:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Apr 2014 02:14:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2014 03:13:58 -0400
Content-Disposition: inline
In-Reply-To: <20140425201048.GB29904@logfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247147>

[+cc Duy, whose patch this is]

On Fri, Apr 25, 2014 at 04:10:49PM -0400, J=C3=B6rn Engel wrote:

> A second option is to add a --pager (or rather --no-pager) option to
> the command line and allow the user to specify
>     GIT_PAGER=3D"git --no-pager -p column --mode=3D'dense color'" git=
 -p branch

I think we have "--no-pager" already. But the "-p" is turning _on_ the
pager, so you could also just omit it. IOW, I really don't understand
why the original command was not simply:

  GIT_PAGER=3D"git column --mode=3D'dense color'" git -p branch

The whole infinite loop that the original commit solved is caused by
specifying the "-p". So it sounds like the right solution is "don't do
that". Am I missing something useful that the "-p" does?

I wonder if perhaps the intent was that the user might have set
"pager.column", in which case the use of the pager is implied. I still
think that the right solution is to use "--no-pager" explicitly then. I=
f
the user is invoking git inside GIT_PAGER, it is up to them to save
themselves from infinite recursion.

-Peff
