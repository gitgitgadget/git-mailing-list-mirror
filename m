From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 04 Jan 2012 10:58:01 -0800
Message-ID: <7vmxa3pa6e.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de>
 <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
 <7vboqks8la.fsf@alter.siamese.dyndns.org> <4F038EC8.505@tu-clausthal.de>
 <7v39bws4xi.fsf@alter.siamese.dyndns.org> <4F0405D4.9090102@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Jan 04 19:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiW2N-00038n-KT
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 19:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab2ADS6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 13:58:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60636 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843Ab2ADS6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 13:58:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF7D16B8A;
	Wed,  4 Jan 2012 13:58:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h/IRznmDg8J8F3w5uRNZu7KU25Y=; b=asTnJ2
	S3JrFaPedQgu7TzAFB4FzgLwJkvVIaLaDPyMXl240VfCpQwxgGK55Vid1F1uB0Sm
	k18sUV5OVhBhhTajfg+C7GGmDZRNbyUt9qGPdtygszXHgVIs3vPGL/px1v6sV6V5
	xtUgx6IyqDTTkSnNQpCdsYKtb1Z+2p0SFe+r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EGUVQpS1qbLhNrB6oEyY+xUZSbNfFVUt
	fYmcMxMdxOHKmi4LP6g7KoSEQBKufYIHaR1Aui+HyyeuvAW9NR7SoFzRw63+dY00
	NsIYdBlTqyTB8PAoXXRswR15rEAdW5EGwvs7+jng6xmp1pkyfrEGs7xj8H4+PpAd
	/jk2FqBHshM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B126B89;
	Wed,  4 Jan 2012 13:58:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 474696B88; Wed,  4 Jan 2012
 13:58:03 -0500 (EST)
In-Reply-To: <4F0405D4.9090102@tu-clausthal.de> (Sven Strickroth's message of
 "Wed, 04 Jan 2012 08:55:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0780B4D0-3706-11E1-9ADB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187938>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Some perl versions, like the one from msys, crash sometimes
> if reading from STDIN wasn't successful and chomp is applied
> to the variable into which was read.

Depending on how widespread such implementations of Perl are, a patch to
fix other uses of chomps might deserve to be on the maintenance track
independent from this patch series. I seem to find many hits to:

    $ git grep -e 'chomp *([^)@]*='

already in our codebase.
