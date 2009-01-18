From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending
 objects to server
Date: Sat, 17 Jan 2009 16:48:57 -0800
Message-ID: <7viqod5thi.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ray Chuan" <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 01:50:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLrz-0007Pn-OG
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbZARAtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbZARAtE
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:49:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbZARAtC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:49:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 17EA991260;
	Sat, 17 Jan 2009 19:49:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 432F59125D; Sat,
 17 Jan 2009 19:48:59 -0500 (EST)
In-Reply-To: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
 (Ray Chuan's message of "Sat, 17 Jan 2009 20:24:47 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC8E4C7C-E4F9-11DD-A5B8-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106119>

"Ray Chuan" <rctay89@gmail.com> writes:

> Currently, git PUTs to
>
>  /repo.git/objects/1a/1a2b...9z_opaquelocktoken:1234-....
>
> then MOVEs to
>
>  /repo.git/objects/1a/1a2b...9z
>
> This is needless. In fact, the only time MOVE requests are sent is for
> this sole purpose (ie. of renaming an object).
>
> A concern raised was repository corruption in the event of failure
> during PUT. "put && move" won't afford any more protection than using
> simply "put", since info/refs is not updated if a PUT fails, so there
> is no cause for concern.

That's a completely bogus reasoning.  Normal operation inside the
repository that was pushed into won't look at info/refs at all.

The true reason you want to avoid put-then-move is...?
