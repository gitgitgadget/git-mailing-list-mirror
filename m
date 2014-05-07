From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: move out of contrib
Date: Wed, 07 May 2014 10:37:21 -0700
Message-ID: <xmqqppjpbicu.fsf@gitster.dls.corp.google.com>
References: <1399077403-19678-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq38gmctzn.fsf@gitster.dls.corp.google.com>
	<536989d764672_250b14ed2ec66@nysa.notmuch>
	<536a067b3b1ca_5e8fbfd30879@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 19:37:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi5mc-0007iC-2q
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 19:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbaEGRh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 13:37:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55021 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbaEGRhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 13:37:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80BA4147A9;
	Wed,  7 May 2014 13:37:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vUllwhU1R/h4CW57r+OoA/SXvUM=; b=ege8pd
	QWL4GzdOUEdi/wY6mcK8eRSpKSFy+MUv+C85yroOXJ3m7Wk+QvZu6ZSUPA7W1vAh
	vLPmeZIhhpy/Rf0xu5h3B3nWDNr88cHlmpc4L9GIbLQ315yYSSSZ8Yq4S4sq0/eB
	KA3Kns1hNkN5NeVDGWVrStASHOHBKz2JtDAOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b9pmgwE+vrEa5PEcgzGZ/42EaGcaheNk
	cD/XHfFmn4B0P3kNWHnk/Scj3/5woOHSrwIxsN59BYAB2rU58pBDZ75jGfr+Y+rp
	DJtsst5U/rFgn5Ysz6tr7U5MJe5bAV16sCzk+h5SHfgKAaClCT6lyB7ZIFzwRWV4
	CrvRCNneZdE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77991147A8;
	Wed,  7 May 2014 13:37:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DEBC8147A7;
	Wed,  7 May 2014 13:37:22 -0400 (EDT)
In-Reply-To: <536a067b3b1ca_5e8fbfd30879@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 07 May 2014 05:10:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F2FE21C-D60E-11E3-95CB-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248334>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> As an example of all the hacks needed by a real distribution package,
> here's the stuff ArchLinux packagers have to do:
>
>   # bash completion
>   mkdir -p "$pkgdir"/usr/share/bash-completion/completions/
>   install -m644 ./contrib/completion/git-completion.bash "$pkgdir"/usr/share/bash-completion/completions/git
>...
>
> And here's what debian packagers have to do:
>
>   # bash completion
>   install -d -m0755 '$(GIT)'/etc/bash_completion.d
>   install -m0644 contrib/completion/git-completion.bash \
>     '$(GIT)'/etc/bash_completion.d/git
>...
>
> If our build system was sane, they wouldn't need so many hacks.

I do not see how the above two examples lead to that conclusion.
How would it help to blindly install to $(sharedir), or suggestion
to use pkg-info when major distros do not even use one?

I would understand if the saneness you seek were for distros to
agree on where things should go, or at least agree on how to find
out where things should go.

The situation for completion scripts unfortunately has to be even
worse than others (like gitweb) in that distros, in order to serve
users (not upstream projects) better, want to package various pieces
of completion scripts from different projects into a location their
bash-completion package wants to see.  I applaud their effort and I
wish that projects they pull various completion scriptlets from can
do more to help them, but I do not think a single makefile target to
unconditionally install to $(sharedir) is it, and honestly speaking,
the distro completion packagers could do more to help us projects to
help them by at least agreeing on how to find out where they want to
see our completion scripts installed.

I do not think we are there yet.
