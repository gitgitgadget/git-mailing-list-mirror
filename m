From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Mon, 25 Mar 2013 07:54:51 -0700
Message-ID: <7v620f34xw.fsf@alter.siamese.dyndns.org>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
 <20130324123620.GA2286@serenity.lan>
 <CAJDDKr7Uz44TQ8y2jpjhNadWUCD5Mo=GLdaLLh99eENARQSwcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 15:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK8o3-00038J-4X
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 15:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555Ab3CYOy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 10:54:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758522Ab3CYOyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 10:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45BCFB15B;
	Mon, 25 Mar 2013 10:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=busW3A+QX/phvCffkEyU1eG4hg0=; b=Hwhd8j
	K3VCByW68Qhh+ZblTaB4Aku6m7TR3oZyuc/+UVmo0m470P7AXJ1YdiYBHoI3salm
	bXgalmF7bNl/URCS1rWmw6XHyLJQ5iE1fd4hcfkKYV4Wz1YaEglvucUcevMxXhB8
	1bLAMpes7XCqnxx9q+3BApR0FmNKqFrSIX8rI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jxf6PkIJpikpVRlh8uRfU1bX+Hq1L/Uh
	sRRZM9uxSlY+jaUzsojZZtWD9FjTJAYxqeT6VeATmrCyANGBfuZq7DaKab93H5Sr
	nREd9psfityey96mAKg4TeGKVUQ9nhg6Jgr2S6/NNUPLlqOONS0JSJQJ+2Ilc98m
	MQMnCJENPa0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38B2FB15A;
	Mon, 25 Mar 2013 10:54:54 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFA0AB159; Mon, 25 Mar 2013
 10:54:53 -0400 (EDT)
In-Reply-To: <CAJDDKr7Uz44TQ8y2jpjhNadWUCD5Mo=GLdaLLh99eENARQSwcw@mail.gmail.com> (David
 Aguilar's message of "Sun, 24 Mar 2013 14:29:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3ACD56E-955B-11E2-AFE0-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219033>

David Aguilar <davvid@gmail.com> writes:

> This makes me wonder whether the modifiable mode should be made
> more explicit, either in the documentation or via a flag.
>
> Imagine if --dir-diff also honored --edit and --no-edit flags.
>
> Right now --edit is the default.  If we had foreseen these various
> edge cases and unintended copy-backs then we may have initially
> chosen --no-edit as the default, but that's not really my point.
>
> What I'm thinking is that it might be good for the tool to
> learn --edit/--no-edit so that the symlink/copy-back heuristic
> can be documented alongside that option.  Users can then know
> what to expect when using this mode.  --no-edit would also be
> faster since it can avoid all these extra steps.
>
> It could also learn "difftool.dirDiffEditable" to control the
> default, which would eliminate the pain in needing to supply
> the flag on every invocation.
>
> What do you think about officially supporting a read-only mode?

Yeah, actually that was what I've been assuming the default (not
suggesting to change the default behaviour here).
