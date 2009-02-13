From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 13:32:59 -0800
Message-ID: <7vprhm81kk.fsf@gitster.siamese.dyndns.org>
References: <1234529920-9694-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY5gg-0001E9-LQ
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 22:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759537AbZBMVdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 16:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbZBMVdO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 16:33:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928AbZBMVdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 16:33:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3508C99953;
	Fri, 13 Feb 2009 16:33:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CABB199952; Fri,
 13 Feb 2009 16:33:03 -0500 (EST)
In-Reply-To: <1234529920-9694-1-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Fri, 13 Feb 2009 13:58:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7D7F43E-FA15-11DD-BF6D-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109775>

Thomas Rast <trast@student.ethz.ch> writes:

> 'git log --abbrev-commit' adds an ellipsis to all commit names that
> were abbreviated.  This is annoying if you want to cut&paste the sha1
> from the terminal, since selecting by word will pick up '...' too.
> (And this cannot be fixed by making '.' a non-word character; in other
> instances, such as the '123457..abcdef0' from git-fetch, it's part of
> the expression.)

I actually think that it is a bug that --abbrev-commit uses ellipses.

It has been there since "diff --abbrev" was first introduced by commit
47dd0d5 (diff: --abbrev option, 2005-12-13).  It did make sense to align
columns in abbreviated raw diff output with ellipses, but it did not make
much sense to do that for commit object names.

Some scripts might be relying on the presense of ellipses but depending on
the object distribution, the length of the ellipses can range from zero to
three; if they are expecting to always see three dots, such scripts are
already broken.

For this reason, I do not think it is necessarily a bad idea to make this
change even unconditionally to both plumbing and Porcelain.
