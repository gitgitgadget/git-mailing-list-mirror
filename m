From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Get rid of refreshing cache after "git commit"?
Date: Sun, 17 Jan 2010 00:27:28 -0800
Message-ID: <7vljfx87bj.fsf@alter.siamese.dyndns.org>
References: <fcaeb9bf1001170016q5e285201r36f6030579cfa605@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 09:27:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWQUC-0001PK-32
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 09:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0AQI1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 03:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216Ab0AQI1h
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 03:27:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab0AQI1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 03:27:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C537491EC2;
	Sun, 17 Jan 2010 03:27:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ojmHPAynOv0y7DE4gcpNgrJecXY=; b=Bb3L5z
	xpCP0a6Qfijw7CW36zBPFN1XmFsS5jqErYdKRSEUO2G575hZd5edtkPiQChEewqG
	HZeSC7/1VBvIenC9STXx+UuOnv1ZC5VZRS6gNoIy9oIwfBImh5MvrPq/Ccfchnz5
	fUIG57Ney3ko/Jy3yBFPkgcLxUeNLbGP7bqiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Njqp4ICY2A5EDh951F3iwzQGXpR7ArfT
	o21jQSiZDY5ot2hMn2aXVWAgJTiNhPxgJbsrZhkA1vKwzIwEPmz4Y+pc8NRpUZ20
	BO3JgxqVVwBLZdfFHMjEhgx6UwprSfoHUDYfCEGvOU1NqS69yg/W6Gp5XlWxrUOr
	npVtJ6n+s5g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E11F91EC1;
	Sun, 17 Jan 2010 03:27:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDFCC91EC0; Sun, 17 Jan
 2010 03:27:29 -0500 (EST)
In-Reply-To: <fcaeb9bf1001170016q5e285201r36f6030579cfa605@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sun\, 17 Jan 2010 15\:16\:46 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 286FE9BC-0342-11DF-AC0E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137278>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Nowadays almost (all?) porcelain commands silently refresh index
> before doing anything relating to worktree, I wonder if this tradition
> is still necessary.

Inside "commit", various checks to see if/how worktree files are changed
are attempted by the libified diff-files/diff-index and they must be used
after you refresh the cache entries.

"git commit" (without paths) does not necessarily have to when you can
prove that the user never looks at .git/COMMIT_EDITMSG (e.g. "-F file" is
given without "-e"), but otherwise you need to refresh the index to show
the correct status in the message buffer.

"git commit paths..."  must refresh the named paths (not necessarily the
whole index), but again you would need the whole index to show the status
correctly.
