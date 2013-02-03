From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Honor configure's htmldir switch
Date: Sat, 02 Feb 2013 20:50:32 -0800
Message-ID: <7vpq0i9f1j.fsf@alter.siamese.dyndns.org>
References: <20130202212504.GA16412@gmail.com>
 <7v7gmqb30p.fsf@alter.siamese.dyndns.org>
 <CA+7ShCrB_1Q=aKw5sP5hLkM1o0v-P1WR5+1iL983X7WQCHP=oQ@mail.gmail.com>
 <7vtxpu9ipo.fsf@alter.siamese.dyndns.org>
 <CA+7ShCqxDKHw0dzC6ASH=qpjG_MP-QZxOyMxQmoTKhXc7ZYHuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Thompson <cjsthompson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 05:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1rbs-0002PG-KI
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 05:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab3BCEul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 23:50:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab3BCEuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 23:50:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 353E9B05A;
	Sat,  2 Feb 2013 23:50:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mzYd15o3zQkI8bpGBvMXp3pVwjI=; b=F4Flol
	uo29duSI1AjjxQAhltJ6agO54TacmsT1akRDz7OF5qo/aDA51J0j11Y7hfCSZNrN
	3p8/iEYGGXq9x5H317/7R2ErSej9KUx3xbmTEVTxapm/K1+RBVy54+CLozoXom1w
	BGrI0vG+Cu7YwwqPWV4ChQHMXD8D1PjS8WLSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jzF6Hx0Q/Zdi22NDfELt2LC3TIRc5Vgf
	gmg76v1YwKs8WuSRZX748yuWh+qSyAeJhAPePaI6HhvZgTusNdkBTPNSlYUT9dfP
	4ugKDzuonQ7t3PdNs+pjnvB0zS7qlNRfwgNP1Y0sMAoteLLskSqOoI02gfJxSoI8
	pHytUEyavhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AEBEB059;
	Sat,  2 Feb 2013 23:50:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B589AB056; Sat,  2 Feb 2013
 23:50:37 -0500 (EST)
In-Reply-To: <CA+7ShCqxDKHw0dzC6ASH=qpjG_MP-QZxOyMxQmoTKhXc7ZYHuA@mail.gmail.com>
 (Christoph Thompson's message of "Sun, 3 Feb 2013 04:43:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40C60E4A-6DBD-11E2-BC04-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215298>

Christoph Thompson <cjsthompson@gmail.com> writes:

[administrivia: why do you keep dropping git@vger from Cc???]

> I was under the impression that configure passed on the value of it's
> --htmldir switch by doing
> some substitution work like the following :
>
> sed 's|@htmldir@|$(htmldir)|g' config.mak.in > config.mak

The information flow goes more like this:

 * configure.ac is used to generate the configure script with
   autoconf;

 * configure script is driven by the user and finds the system
   characteristics and user's wish;

 * what configure found out is used to generate config.mak.autogen,
   using config.mak.in as a template; and then

 * the primary Makefile reads config.mak.autogen if exists and then
   config.mak if exists.

Note that use of ./configure is entirely optional for the build
system of Git.  You can give parameters to make on its command line
(without having config.mak or config.mak.autogen), or you can give
these parameters in handwritten config.mak and just say "make".

You can also use ./configure to write some reasonable values in
config.mak.autogen, but if ./configure guesses things incorrrectly,
you can still override them in your handwritten config.mak exactly
because it is read after config.mak.autogen is read by Makefile.
