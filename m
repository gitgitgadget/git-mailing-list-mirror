From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 13:39:43 -0700
Message-ID: <7vabry43cg.fsf@gitster.siamese.dyndns.org>
References: <1189115308.30308.9.camel@koto.keithp.com>
	<7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
	<1189133898.30308.58.camel@koto.keithp.com>
	<7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
	<46E145BF.4070403@eudaptics.com> <20070907124253.GB27754@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkcP-00038u-3M
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758379AbXIGUjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758345AbXIGUjv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:39:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbXIGUju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:39:50 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A186312FEE9;
	Fri,  7 Sep 2007 16:40:07 -0400 (EDT)
In-Reply-To: <20070907124253.GB27754@artemis.corp> (Pierre Habouzit's message
	of "Fri, 07 Sep 2007 14:42:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58069>

Pierre Habouzit <madcoder@debian.org> writes:

> I'd have added though that maybe update-ref should print a warning for
> the references that do not match the restriction Junio added. This could
> be done using the function Junio proposed un update_ref() in refs.c

I would even suggest making it into an error, even if we do not
error out on the reading side (being liberal when reading but
more strict when creating, that is).

That confused_ref() needs to be tightened further, by the way.
It is called only when we are considering to tack the user
string immediately below $GIT_DIR/ so the only valid cases are
(1) the string begins with "refs/", or (2) the string is all
uppercase (or underscore), especially without slash.  The one in
the proposed patch is not strict enough and does not enforce the
former.
