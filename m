From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 04 Jun 2009 00:26:08 -0700
Message-ID: <7v63fczchb.fsf@alter.siamese.dyndns.org>
References: <200905122329.15379.jnareb@gmail.com>
	<200906031851.12160.jnareb@gmail.com>
	<20090603165613.GJ3355@spearce.org>
	<200906032220.00238.jnareb@gmail.com>
	<20090603202429.GO3355@spearce.org> <4A277507.2060409@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jun 04 09:26:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC7LA-0006iL-PM
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 09:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZFDH0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 03:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbZFDH0J
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 03:26:09 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62049 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbZFDH0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 03:26:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090604072610.BARN17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 4 Jun 2009 03:26:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id zjS91b0034aMwMQ03jS96p; Thu, 04 Jun 2009 03:26:09 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=1cH15jnNZHcA:10 a=8-WIN01VSTQA:10
 a=UImmgy8r03327txCHIAA:9 a=U-2HA7vqY_9B2WImVN4A:7
 a=2n9wWGUpFx5Xgyxzl6wrLEqG7kYA:4
X-CM-Score: 0.00
In-Reply-To: <4A277507.2060409@op5.se> (Andreas Ericsson's message of "Thu\, 04 Jun 2009 09\:17\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120684>

Andreas Ericsson <ae@op5.se> writes:

> How is "no tags present" signalled? Without such a signal, the client
> must always issue a subsequent request every time there are no tags
> embedded in the received pack, as it can't know if the server ignored
> the option silently or if there just aren't any new tags.

The fetcher first learns the set of tags and what objects they point at.
That's in the first part of the upload-pack protocol.

Of course, if there is no tag, you won't see them advertised, so you can
know.

After finishing the main part of the object transfer, if some of the
objects that are pointed at by tags are present (and reachable from refs),
but the tags that point at them do not exist yet, that is a sign that the
uploader didn't give you these tag objects.  Then you can turn around to
request those tags by initiating another exchange, and ask for them with
"want" lines.
