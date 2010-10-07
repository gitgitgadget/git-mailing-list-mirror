From: Jeff King <peff@peff.net>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 14:33:42 -0400
Message-ID: <20101007183342.GA20289@sigill.intra.peff.net>
References: <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net>
 <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
 <20101007172939.GA12130@sigill.intra.peff.net>
 <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
 <vpqaamp3n6d.fsf@bauges.imag.fr>
 <20101007175358.GD12130@sigill.intra.peff.net>
 <AANLkTinu6fhd9DwfJpjiaxOUu_MrTym_RepR9f44=vrv@mail.gmail.com>
 <20101007181349.GD18518@sigill.intra.peff.net>
 <AANLkTikkZaCQKFTnQ=k2Ajp_6mVRd6mrP1P7bEASEGgd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:33:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vHb-0003ll-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0JGSda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 14:33:30 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48553 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab0JGSd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 14:33:29 -0400
Received: (qmail 20355 invoked by uid 111); 7 Oct 2010 18:33:29 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 18:33:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 14:33:42 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikkZaCQKFTnQ=k2Ajp_6mVRd6mrP1P7bEASEGgd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158427>

On Thu, Oct 07, 2010 at 08:19:01PM +0200, Erik Faye-Lund wrote:

> Yeah. When I read K&R a bit closer, I find this:
> 
> "A number specifying a minimum field width. The converted argument
> will be printed in a field _at least this wide_, and wider if
> necessary. If the converted argument has fewer characters than the
> field width _it will be padded_ on the left (or right, if left
> adjustment has been requested) to make up the field width."

You are confusing field width (%*s) with precision (%.*s) here.

C89 is pretty clear that the behavior I am seeing is mandated:

  7.19.6.1, paragraph 4:

     An optional precision that gives ... the maximum number of bytes to
     be written for s conversions.

  7.19.6.1, paragraph 8, item "s":

    ... Characters from the array are written up to (but not including)
    the terminating null character. If the precision is specified, no
    more than that many bytes are written. If the precision is not
    specified or is greater than the size of the array, the array shall
    contain a null character.

so it is always about giving a maximum to print an unterminated string,
or to print a partial string. But printf always stops at a NUL.

-Peff
