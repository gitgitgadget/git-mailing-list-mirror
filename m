From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash pop not reapplying deletions
Date: Mon, 15 Feb 2010 18:17:44 -0800
Message-ID: <7v7hqdrkjb.fsf@alter.siamese.dyndns.org>
References: <loom.20100214T200110-615@post.gmane.org>
 <201002142308.01704.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve Folly <steve@spfweb.co.uk>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhD0i-00037i-Sq
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 03:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511Ab0BPCRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 21:17:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502Ab0BPCRy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 21:17:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8266C9A2A2;
	Mon, 15 Feb 2010 21:17:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DFoGT2Kz8Oay0HuRp7dFsfKC1vI=; b=bog3RK
	ykymBcs4JRI5hWUWDzcoiVU4jnYK2aMensN8cSTip6QxrE/nAIyrSm4eDTUuWxbM
	7vD6vuE/XJySMvSAmT59jTu+rmNg62cHV46c4887v9xRUM/iUu8gyLQ7cLu+YLWR
	8ZFtGMK6A91qTDB1IMOZqicm0YUj9IqV8u3zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/E0zMHpUKgDAhvW40DJ7W4ZOu5zO3AV
	Zf+OuN/D0zTCGulew2rUxrCwTdsmvXEXQMdVF9uRSOWaca9+h1qoVlLNPVQ/iz0F
	HQuyT+Gtd0Iw6MdFbXjC9r8fIun47SCMpNR0m9/zCprzgszMYdaqKh1YtsBFyiZQ
	SyogNBUl5bI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 48BA89A2A0;
	Mon, 15 Feb 2010 21:17:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64B769A29E; Mon, 15 Feb
 2010 21:17:46 -0500 (EST)
In-Reply-To: <201002142308.01704.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun\, 14 Feb 2010 23\:08\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B271B96-1AA1-11DF-BAED-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140059>

Thomas Rast <trast@student.ethz.ch> writes:

> The problem is that you aren't using --index, but still expecting it
> to restore your index.  If you change it to 'git stash pop --index',
> everything will work as expected.
>
> Yes, it does stage new files, but that is only to help you: otherwise
> you could forget them before committing.

I think the reason _new_ files are added is simply because ack then there
was no other way to make it tracked.

A sane thing to do these days might be to add a newly created file with
the "intent to add" option, to mimic the way other files in the work tree
with changes are unstashed.  They get the full change in the work tree,
without restoring what their corresponding index entry used to have when
the stash was made, if you unstash without the --index option.
