From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Sun, 16 Nov 2014 10:49:35 -0800
Message-ID: <xmqqvbmfyo8w.fsf@gitster.dls.corp.google.com>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
	<1416036379-4994-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 16 19:49:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq4tV-0004KD-IW
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 19:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbaKPStn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 13:49:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751632AbaKPStm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 13:49:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CEBF1A661;
	Sun, 16 Nov 2014 13:49:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OAPVEvrMnTk0NeEsTU5ApeikI9g=; b=esOwDD
	3BvB2MgefIDOi0y1RRLm1GunUiEYs3Wq/UQtksq6hHhldDR+IxOhSP4Aht/V2ODQ
	68VCIds93RUSO234GGLb4974p7hZic554gytc9cqAnV6V7oLPj+lJP83SI2/CZHr
	VY+eizgMz9Z1RU3rSXCNLwvA9qYrBkMdgFgdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9ev5G3JRFbtfwqPa4x+wV8yzUGegA1r
	JGEtCGj99KB+hz9jvMuYKN1ffoAjJks5iI8B8HGfmdOxbnVkoBzBkSUExPC+ejcy
	riLO6pv/VEJfMViLFPu2WRLZFWwcSWdT7QmOm2jHIo3DoJjxyHc2Jl4YMbOvpUsx
	XbKCFhvr+ow=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 237201A65E;
	Sun, 16 Nov 2014 13:49:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6D2D1A640;
	Sun, 16 Nov 2014 13:49:38 -0500 (EST)
In-Reply-To: <1416036379-4994-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sat, 15 Nov 2014 08:26:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5145FE32-6DC1-11E4-997B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There is no reason for $GIT_DIR/config to be executable, plus this
> change will help clean up repositories affected by the bug that was
> fixed by the previous commit.

I do not think we want to do this.

It is a welcome bugfix to create $GIT_DIR/config without executable
bit when and only when we create it.  It is very much in line with
"There is no reason for $GIT_DIR/config to be executable"---we do
not need to make it executable ourselves, so we shouldn't, but we
did which was a bug we want to fix in patch 1/2 you posted.

But with the "preserve existing permissions" fix we did earlier, the
end users are now allowed to flip the executable bit on for their
own purpose, and dropping it without knowing why they are doing so
is simply rude.  And honestly, Git do *not* even want to know why
the users want to flip the bit.

So I would suggest not to spend any cycle or any code complexity to
"repair" existing repositories.  Having that bit on does not hurt
anybody.  Those who found it curious can flip that bit off and then
Git with "preserve existing permissions" fix will keep that bit off
from then on.
