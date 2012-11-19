From: Junio C Hamano <gitster@pobox.com>
Subject: Re: verifying git file contents without checking out history?
Date: Sun, 18 Nov 2012 20:55:18 -0800
Message-ID: <7vtxsmxkcp.fsf@alter.siamese.dyndns.org>
References: <1353287836-sup-270@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 19 05:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaJOS-0004hS-UW
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 05:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831Ab2KSEzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 23:55:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab2KSEzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 23:55:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB9F6A923;
	Sun, 18 Nov 2012 23:55:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eCB4N00r7G7e95+lkvZ2+z38M9g=; b=Qkr2Oq
	5t3nQZ9R6I6315ztFVqF6J+5p8YeNvTxGahTIoD1Qnq6fFlX6QuoRLl1LQ+7w7XW
	2g7zD6D82RLZAD6UiSdY9SxVvoTQkBxlHWT2ADx3/e0F/AiFUT8LAwKzytXiJRNN
	I8xbMGSIHleM6g0NihG04GgSmzpXKXLxeHeXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Exeyli7Yfq2JGqPxyBQmERVPUmPSL3sy
	HDe85mlj6ldVHb+efs1RvESaJD/uS5wcNTjorBgXss3ix27uJPR/bbd1H+pqwECV
	6M+MfV8n0lyXbX1MmS+xMMM0kMUaQquPlPz+egt2pglRIeta5zxCmoI/4ED0KJQs
	LSjUW/Misno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7C60A922;
	Sun, 18 Nov 2012 23:55:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36841A920; Sun, 18 Nov 2012
 23:55:20 -0500 (EST)
In-Reply-To: <1353287836-sup-270@nixos> (Marc Weber's message of "Mon, 19 Nov
 2012 02:50:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51C02A62-3205-11E2-8904-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210040>

Marc Weber <marco-oweber@gmx.de> writes:

> git clone --depth=20 $url; git checkout $hash
>
> How to verify that I have the contents I think I have - given that I
> trust my local git executable?

Define what you mean by "contents".  Do you care only about the tree
state recorded in that $hash, and you also trust that $hash is the
correct one?

  $ git cat-object commit $hash | git hash-object --stdin -t commit

would be a way to verify that you do have the commit object
everybody else calls $hash, and you can verify the objects contained
within the commit whose name is $hash (i.e. its tree and its
parents) in a similar way.  Use "git ls-tree $tree" to find out the
objects your top-level tree recorded in the commit $hash, and you
can verify the contents recorded in the tree object recursively.
