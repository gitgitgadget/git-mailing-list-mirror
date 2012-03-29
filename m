From: Junio C Hamano <gitster@pobox.com>
Subject: Re: better way to find Git.pm officially?
Date: Wed, 28 Mar 2012 23:45:53 -0700
Message-ID: <7vwr63rjku.fsf@alter.siamese.dyndns.org>
References: <86r4wc9f6j.fsf@red.stonehenge.com>
 <20120329061336.GE27604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 08:46:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD97X-0006WK-LO
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 08:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab2C2GqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 02:46:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554Ab2C2Gp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 02:45:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 062CE6CE4;
	Thu, 29 Mar 2012 02:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KVNXYKnPfej52kUOA4D65PLvU8o=; b=j4CCGb
	zoeBQj2M8LgD5XfFm/fZZo2B3nRHB/bEVF4g+SefPO6YhwmXLtywWhdjelcApk7v
	7r/fVyeXNbEZhLScHOlvv/JxWNvgKIMkpQJdKKFtzXS5PGhJ0qpNDSL+QIW0DgVR
	sdY7QpD0zQamHZe+GZAhgWsmByzVVMySaW8yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kqM+dVFF7SFZOBYHjgZQ2NQcp5ppXXrD
	V4TWjjsWxW+t+3cQ4JR/q80GE9fXV3UMO8CeLB6cIyTUBTr/US+HvhY/VpzvyLIf
	ztDp79anbtLaqoVoDx54XQBu1sPsh8PkxyN1IzoYodjmxuXiAtu2Klgru94S+FoF
	UocqxTZkw5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F15346CE3;
	Thu, 29 Mar 2012 02:45:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70FA76CE2; Thu, 29 Mar 2012
 02:45:55 -0400 (EDT)
In-Reply-To: <20120329061336.GE27604@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 29 Mar 2012 02:13:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5969FBE-796A-11E1-B082-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194235>

Jeff King <peff@peff.net> writes:

> I always assumed that it was the responsibility of the user or the
> packager to put Git.pm into a sane place that is found by perl's normal
> lookup (possibly via the user's PERL5LIB if it is a per-user
> installation).

Unfortunately, not really.

See what this target does in our Makefile:

	$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl

Our scripts know where INSTLIBDIR is, so that we can redirect INSTLIBDIR
to whatever directory that the packager or the user wants to, which may be
outside the usual PERL5LIB.

Especially with NO_PERL_MAKEMAKER installation, perl/Makefile points at
$(prefix)/lib with INSTLIBDIR, and $(prefix) is by default $(HOME), so...
