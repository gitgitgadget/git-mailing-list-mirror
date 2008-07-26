From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sat, 26 Jul 2008 10:31:18 -0700
Message-ID: <7vod4kft7d.fsf@gitster.siamese.dyndns.org>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de>
 <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 19:32:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMndD-0005xY-Gg
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 19:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYGZRbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 13:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYGZRbe
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 13:31:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYGZRbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 13:31:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7DA0D41D4C;
	Sat, 26 Jul 2008 13:31:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9249141D4B; Sat, 26 Jul 2008 13:31:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness> (Johannes
 Schindelin's message of "Sat, 26 Jul 2008 16:14:33 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B04B8E76-5B38-11DD-BB9E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90264>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When the program 'git' is in the PATH, the argv[0] is set to the basename.

While it may be true, I do not think it matters that we cannot get the
full path _UNLESS_ we are doing the relative "../" business.  

> However, argv0_path needs the full path, so add a function to discover the
> program by traversing the PATH manually.

I think unconditionally requiring argv0_path to be set is the root cause
of the bug.  Unless we do not fix _that_, we will have to make a needless
call to lookup_program_in_path() even when nobody needs that information,
which is unacceptable.
