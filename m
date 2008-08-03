From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More on git over HTTP POST
Date: Sat, 02 Aug 2008 20:27:47 -0700
Message-ID: <7v63qiydzg.fsf@gitster.siamese.dyndns.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org>
 <20080803025602.GB27465@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 05:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPUHV-0005jH-Em
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 05:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbYHCD1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 23:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbYHCD1z
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 23:27:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYHCD1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 23:27:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9A7C42798;
	Sat,  2 Aug 2008 23:27:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 22CF742797; Sat,  2 Aug 2008 23:27:50 -0400 (EDT)
In-Reply-To: <20080803025602.GB27465@spearce.org> (Shawn O. Pearce's message
 of "Sat, 2 Aug 2008 19:56:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 286E9F28-610C-11DD-9C01-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91198>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Show Refs
> ---------
>
> Obtains the available refs from the remote repository.  The response
> is a sequence of git "packet lines", one per ref, and a final flush
> packet line to indicate the end of stream.

As the initial protocol exchange request, I suspect that you would regret
if you do not leave room for some "capability advertisement" in this
exchange.

With the git native protocol, we luckily found space to do so after the
ref payload (because pkt-line is "length + payload" format but the code
that reads payload happened to ignore anything after NUL).  You would want
to define how these are given by the server to the client over HTTP
channel.  For example, putting them on extra HTTP headers is probably Ok.
