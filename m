From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Submodules: Use "ignore" settings from .gitmodules
 too for diff and status
Date: Wed, 28 Jul 2010 14:35:01 -0700
Message-ID: <7vhbjjware.fsf@alter.siamese.dyndns.org>
References: <4C4DD33F.4020104@web.de> <4C4DD3CF.9070906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 28 23:35:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeEHX-0003ay-B2
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 23:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab0G1VfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 17:35:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0G1VfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 17:35:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A35D1C8FBC;
	Wed, 28 Jul 2010 17:35:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oPdcY1P9ZaljdtiNewjyPoTsvyQ=; b=wAwEt5
	+E1zcL3iTiuhp4OSUlYJPD9nKoq6nWZ0lG8JSwqTx2Mq9bQjK7Fg7JLutG5OddVw
	s/vqDoPehE+miwBn2Ma2OIsXhhFwINAdA87qHsP0tlOyQybzhNkQTXLyx5Q9Ynwj
	pd8bxHKS+KD/dHhgHQr2tt1LfWpQX/UkHWnmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cbEhKm1gED+CgoIdtOmmebVGIYkaFnaU
	xIbNOdJ0w5iSvTGJ+X1QgjnuEQLvmVKojw7IQhoyytLIdloKDb0H+pCe6UxjvLZw
	SX55NvblLyKSy5Hvg+1ZdFLeTS/zC5cEsBrFysUjKWqWeG7+IflQ8drjLAFD3gac
	BgLAxmYKso4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 716C7C8FB9;
	Wed, 28 Jul 2010 17:35:06 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7B20C8FB7; Wed, 28 Jul
 2010 17:35:02 -0400 (EDT)
In-Reply-To: <4C4DD3CF.9070906@web.de> (Jens Lehmann's message of "Mon\, 26
 Jul 2010 20\:28\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD421D92-9A8F-11DF-88F1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152121>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> The .gitmodules file is parsed for "submodule.<name>.ignore" entries
> before looking for them in .git/config. Thus settings found in .git/config
> will override those from .gitmodules,...

Hmph.

The value of "submodule.<name>.path" does not have to be "<name>".  There
seems to be a bit of confusion here.

I thought that [PATCH 1/2] used the path to the submodule, not its name,
as the key.  Even though the patch to Documentation/config.txt talks about
"submodule.<submodulename>.ignore", what the code actually seems to do in
set-from-submodule-config is to use path.  

But this patch seems to key off of <name>.

I suspect that it would make more sense to use <name> so that once the
user configures ignore in .git/config, it will persist across moving of
the submodule in the superproject tree.

In either case, we would want to be consistent between the two, no?
