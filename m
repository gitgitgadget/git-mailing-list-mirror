From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 13:43:34 -0700
Message-ID: <7v8weu6idl.fsf@alter.siamese.dyndns.org>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock> <20091029075021.GC15403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 21:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3bqb-0002Ow-36
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 21:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbZJ2Unn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 16:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbZJ2Unn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 16:43:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbZJ2Unm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 16:43:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B34306C5F4;
	Thu, 29 Oct 2009 16:43:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=qtsOmMrRL+Apu+79FZ7L+i124
	Pw=; b=vNwKKIHUO3JHmibvi2/BfZ2V6yZgrky8/ATwbN/8neETqmIVEKG7U6glo
	aMLhSZuHJUanLRkh3kB3CjOevfW8txsuQPVqEZPzdt6FJ3fILxrvcSiCMbYvq5Gv
	835iVV8b1Cc/9+8uvvjzV0lcRDBc5Z6Wmxk4gVV8EF6SnFOjBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=FhVFH/7CKqXuZPz1hop
	4jW4NVzVwWB5F+IqB5NzCaCBZckcezUDL4NwETGsP8ptfJ5FCdPpXYgEyt1Agqd3
	WhhkrHTtr8+tZrrEs3vjE/ApDm9nVx+qhoe6F5r5iqDStOlbWPyo2Ed1fchakuMU
	GVrVVZkzmTdBD2Gh8YM5pNMU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 849EF6C5F3;
	Thu, 29 Oct 2009 16:43:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9FF96C5EE; Thu, 29 Oct
 2009 16:43:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCF32438-C4CB-11DE-A616-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131650>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Provide a DEFAULT_EDITOR knob to allow the fallback editor (to
> use instead of vi if VISUAL, EDITOR, and GIT_EDITOR are unset) to
> be set at build time according to a system=E2=80=99s policy.  For
> example, on Debian systems, the default editor should be the
> 'editor' command.

I think we allow things like

    GIT_EDITOR=3D'"/c/my program/vi" --i-like-color --config=3D$HOME/.m=
yvicfg'

and the eval construct in git-sh-setup.sh is about supporting that kind=
 of
insanity^Wflexibility.

My "how about" patch on DEFAULT_PAGER might be minimally safe with

    make DEFAULT_PAGER=3D"/c/my program/less"

but if you are going to do this for real, you would need to use proper
quoting in the Makefile (look for _SQ for hints).

Also I do not think it allows this at all:

    make DEFAULT_PAGER=3D'"/c/my program/less" --i-like-color'

It probably is Ok to force the "default" one to be just the path to the
command (i.e. not part of command line), but I thought this would be wo=
rth
pointing out.

> This change makes t7005-editor into a mess.  Any ideas for fixing
> this?

I think the introduction of DEFAULT_EDITOR makes it unfixable; your
DEFAULT_EDITOR may be set to '/usr/bin/vi' not 'vi'.

Just detect DEFAULT_EDITOR being not the default 'vi' and abort/skip th=
e
entire test, perhaps?
