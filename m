From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] Provide a build time default-editor setting
Date: Sat, 31 Oct 2009 21:29:56 -0700
Message-ID: <7vhbte3m0r.fsf@alter.siamese.dyndns.org>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock> <20091031014441.GH5160@progeny.tock>
 <7vfx90co1e.fsf@alter.siamese.dyndns.org>
 <20091031032647.GA5583@progeny.tock>
 <7vzl775ol5.fsf@alter.siamese.dyndns.org>
 <20091031212144.GA5022@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 05:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4S53-00053I-Cd
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 05:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbZKAEaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 00:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbZKAEaG
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 00:30:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZKAEaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 00:30:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F29158DA67;
	Sun,  1 Nov 2009 00:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UN7cOQl48dd8ns/bLOW6VgQK+EE=; b=qcyUwvQJUwVpbevDRm/pLTr
	iPrjuBARFMQGR1kLxTM2ziyS2fBRnhUjgirEa3n5+UqrwUindJUpQkiV5i0SvEDk
	WiwkhkhCM6IanfmYU8c7kGGm3FF3GJFOn3LpdjfW6TpTZirrIpFU0gTpwsqF3uzj
	pt/HsA7WOceF6TEVJt0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sobkKIwaGkkn4agzr6ucj9yBREpSUuNtt/P05lDibT7HgVJ6+
	eZGYP2jOad3uPm5L9mnS9iJq5rcxDvzyTTi49F5u6Q/pQ5se8WRGOkoFyOIcNS5B
	3GvtbtyII+guaJTdeB3rjCFR8RP6y16amnh0U4/OxMiEi9kNc9uh5fw4x8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A28188DA62;
	Sun,  1 Nov 2009 00:30:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7FFF8DA61; Sun,  1 Nov 2009
 00:29:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A2E82EC-C69F-11DE-B325-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131866>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +unset EDITOR VISUAL GIT_EDITOR
> +
> +test_expect_success 'determine default editor' '
> +
> +	vi=$(TERM=vt100 git var GIT_EDITOR) &&
> +	test -n "$vi"
> +
> +'
> +
> +if ! expr "$vi" : '^[a-z]*$' >/dev/null
> +then
> +	vi=
> +fi
> +
> +for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
> ...
> -for i in vi EDITOR VISUAL core_editor GIT_EDITOR
> +for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>  do
>  	echo "Edited by $i" >expect
>  	unset EDITOR VISUAL GIT_EDITOR
> @@ -78,7 +91,7 @@ done
>  
>  unset EDITOR VISUAL GIT_EDITOR
>  git config --unset-all core.editor
> -for i in vi EDITOR VISUAL core_editor GIT_EDITOR
> +for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>  do

Beautiful ;-)
