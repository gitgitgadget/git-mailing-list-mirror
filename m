From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 04 Jan 2012 11:08:01 -0800
Message-ID: <7vipkrp9pq.fsf@alter.siamese.dyndns.org>
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
 <4F040E46.5030001@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Jan 04 20:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiWC2-0007wi-9K
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 20:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab2ADTIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 14:08:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756765Ab2ADTID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 14:08:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B4796E3E;
	Wed,  4 Jan 2012 14:08:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3URx9PBinZkU7zqOzP05Vz5mhNw=; b=q2Y1da
	6jlYjulJqJZXofdISb+IGmoptrzdRapmQdbMPydZdaWBaKz+KzpoaK2gKWImeUZq
	oK2EjkBRVSozf5m0wVeXPmGXBTP9hj0T2VSaLdvn+qxWsCmMcf0p9jGIWGQbQaJI
	h2aMIz8u6PFu2NYqn4LXsazp9+V5UcNYbA1WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FVEE6EfQ4ml07MFrh6xCPJM9OEscibce
	Atd0o7VH+2oiOPIxUzcsH4nEBmLnLcDeQSG9GkTmkpA1+bkz6oGWbSouI/JoH361
	vuSay5UqZ5GtcglQ0z3scJw7lf6TMhTTEmIV4NaFRpQtCThn/g6bI2M//ZPv/PVJ
	bGQHXcbF+F0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 422F16E3D;
	Wed,  4 Jan 2012 14:08:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E6966E3B; Wed,  4 Jan 2012
 14:08:02 -0500 (EST)
In-Reply-To: <4F040E46.5030001@tu-clausthal.de> (Sven Strickroth's message of
 "Wed, 04 Jan 2012 09:31:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CB56D5E-3707-11E1-8354-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187939>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 04.01.2012 08:55 schrieb Sven Strickroth:
>> The Git.pm part is easy, but I also tried to update prompt.c (untested).
>
> I said "easy" and then I mailed the wrong/outdated patch :(
> I'm sorry for the noise.
>
> From: Sven Strickroth <email@cs-ware.de>
> Date: Wed, 4 Jan 2012 08:44:48 +0100
> Subject: [PATCH] Git.pm, prompt: try reading from interactive terminal
>  before using SSH_ASKPASS
>
> SVN tries to read reading from interactive terminal before using
> SSH_ASKPASS helper. This change adjust git to behave the same way.

It might be an accurate description of what Subversion does ("tries to" is
the key phrase).  I however do not know if it is equivalent to what your
patch does.

When GIT_ASKPASS is not set, the $prompt is given to the standard error
stream unconditionally and then the "require Term::ReadKey" codepath is
used. When the terminal is unavailable, you might get undef in $ret and be
able to fall back on SSH_ASKPASS part, but you cannot take back the noise
you have given to the standard error stream.

Is there a way to ask Term::ReadKey (or possibly some other module) if we
will be able to interact with the terminal _before_ we give that prompt?

The simplest would be to do this, I would think, but I didn't test it.

	if (!defined $ret && -t) {
		print STDERR $prompt;
		if ($isPassword) {
                	...
	}
        if (!defined $ret) {
		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
	}
