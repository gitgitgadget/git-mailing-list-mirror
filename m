From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Prevent switching branches when local modifications exist
Date: Wed, 13 Jun 2012 16:35:46 -0700
Message-ID: <7vfw9yg4z1.fsf@alter.siamese.dyndns.org>
References: <h5ina9-g9n.ln1@homer.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Bartoschek <ponto@pontohonk.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 01:36:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sex6v-0000Ju-Ld
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 01:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab2FMXfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 19:35:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab2FMXft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 19:35:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C33E19FAB;
	Wed, 13 Jun 2012 19:35:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LDUyF1HZhVDFZyS36r+71HCx05g=; b=UUR+/t
	HqOyhzIYNMq3JmDnyUjCoD5SxswnrB1LqAPeWSI2km35dGiYkWROhacE/udT3Y4h
	nNt6P/kdVUKf+7AhnXt5Vtg+3E3CgJBsk7QkSPl00kAejsd+2XsFJ0n69kPMYcS3
	0uXfSNsYWnQ2N9E3wL5/ved6WEP2evNuiOE0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dLLpwrh5c30rHKD8wPswAieFS9Uv/Rql
	KUPIi0P52xcUj5VWkcpY7IhNI5ShL+XDp3Z/mEc9Z1fQfjhAE2RLjWwQAsr33Fuw
	8g2Cna/wYm7UKOrt8BkiAQcHRYpFTPSt765GZckNUOAz4NSWpaGp6y74erErDZY6
	XquPShQbAQY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BACC89FAA;
	Wed, 13 Jun 2012 19:35:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 232B29FA8; Wed, 13 Jun 2012
 19:35:48 -0400 (EDT)
In-Reply-To: <h5ina9-g9n.ln1@homer.bruehl.pontohonk.de> (Christoph
 Bartoschek's message of "Thu, 14 Jun 2012 00:52:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8108E6AA-B5B0-11E1-8C76-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199958>

Christoph Bartoschek <ponto@pontohonk.de> writes:

> Hi,
>
> how can I prevent that git allows me to switch branches when there are 
> uncommited local modifications?
>
> [14.1 (steiner_topo)]$ git checkout -b ergo
> Switched to a new branch 'ergo'
> [14.1 (ergo)]$ echo blub >> src/invtree.C
> [14.1 (ergo)]$ git checkout steiner_topo
> M       src/invtree.C
> Switched to branch 'steiner_topo'
> [14.1 (steiner_topo)]$ 
>
> How can the last checkout be prevented?

The question sounds similar to asking "How can I prevent 'rm -r'
from removing anything when I type it in my home directory."  It is
useful for 'rm -r' to remove everything recursively, but sometimes
you would want to prevent you from running it by mistake in a wrong
place. In general, there is no good direct solution for that.

A few usual ways people deal with this kind of issue are (1) to make
it easier to notice that they are "in a wrong place" (e.g. by having
the current directory in their prompt to avoid 'rm -r' in $HOME) and
training themselves to be careful, (2) to make it possible to
recover if that happens by mistake (e.g. by having .snapshot on the
filer).

For "checkout", an approach that corresponds to (1) is to have
branches and status in the prompt (available from git-completion).
Fortunately for (2) there isn't anything special necessary, as
checking out a different branch with "git checkout" does not lose
information, after creating and checking out the steiner_topo
branch, you can use checkout again to come back to ergo branch.
