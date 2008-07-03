From: Junio C Hamano <gitster@pobox.com>
Subject: Re: finding deleted file names
Date: Thu, 03 Jul 2008 12:41:43 -0700
Message-ID: <7vzloyzrew.fsf@gitster.siamese.dyndns.org>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
 <20080703103658.GA11571@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoff Russell <geoffrey.russell@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEUiM-0002A0-Pp
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 21:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbYGCTmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 15:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbYGCTmH
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:42:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbYGCTmG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 15:42:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 562F811432;
	Thu,  3 Jul 2008 15:42:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 847B311431; Thu,  3 Jul 2008 15:41:59 -0400 (EDT)
In-Reply-To: <20080703103658.GA11571@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Jul 2008 06:36:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D87925E-4938-11DD-905B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87309>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 03, 2008 at 09:31:55AM +0930, Geoff Russell wrote:
>
>> git diff --diff-filter=D --name-only HEAD@{'7 days ago'}
>> 
>> finds files deleted during the last 7 days, but if my repository is
>> only 6 days old I get a
>> fatal error.
>> 
>> fatal: bad object HEAD@{7 days ago}
>
> This should issue a warning, but use the oldest reflog entry. However,
> there is a slight problem with that. See below for details.

I think your patch is a sane thing to do.

Once reflog entries begin expiring, we won't have the null_sha1 on the
previous side of them, and after that we will keep returning the
oldest-known one, so nobody should be expecting to find out when a ref was
first created in this repository by checking with what timestamp that
syntax breaks in the existing interface.

Sorry for not being Shawn ;-)
