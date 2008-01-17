From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 21:15:43 -0800
Message-ID: <7vejchkp6o.fsf@gitster.siamese.dyndns.org>
References: <478E1FED.5010801@web.de>
	<76718490801162043w3884435ex435f38b9de837540@mail.gmail.com>
	<76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jay Soffian" <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 06:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFN7E-000570-Qc
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 06:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbYAQFQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 00:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbYAQFQH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 00:16:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbYAQFQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 00:16:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 943AD23BC;
	Thu, 17 Jan 2008 00:16:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1874423B2;
	Thu, 17 Jan 2008 00:15:57 -0500 (EST)
In-Reply-To: <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> (Jay
	Soffian's message of "Wed, 16 Jan 2008 23:59:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70828>

"Jay Soffian" <jaysoffian+git@gmail.com> writes:

> So here's what I can see as being useful additions to git:
> ...
> Thoughts (besides "patches welcomed")?

I think we already discussed a plan to store normalization
mapping in the index extension section and use it to avoid
getting confused by readdir(3) that lies to us.  Is there any
more thing that need to be discussed?

I would presume that we would still add _new_ paths using the
pathname we receive from the user (there is no need for us to be
similarly insane as broken "normalizing" filesystems), but when
deciding if a path is new or we already have it in the index
would be done by seeing if an entry already exists in the index
whose "normalized" form is the same as the "normalized" form of
the given path --- that way we would not add two paths to the
index that would "normalize" to the same string.
