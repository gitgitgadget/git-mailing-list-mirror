From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Improvate portability: Display pid_t's always as
 long
Date: Wed, 27 Aug 2008 12:03:46 -0700
Message-ID: <7vsksqp9f1.fsf@gitster.siamese.dyndns.org>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net>
 <1219858743-4476-2-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQKF-00051N-SK
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYH0TD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYH0TD4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:03:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYH0TD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:03:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BF1163327;
	Wed, 27 Aug 2008 15:03:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C03AF63326; Wed, 27 Aug 2008 15:03:49 -0400 (EDT)
In-Reply-To: <1219858743-4476-2-git-send-email-sn_@gmx.net> (David Soria
 Parra's message of "Wed, 27 Aug 2008 19:39:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E433A9EE-746A-11DD-878A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93924>

David Soria Parra <sn_@gmx.net> writes:

> Some systems (like e.g. OpenSolaris) define pid_t as long,
> therefore all our sprintf that use %i cause a compiler warning
> beacuse if the implicit long->int cast. So to make sure that
> we fit the limits we display pids as longs and cast them explicitly.

This patch just makes one wonder what needs to happen when the next random
platform has pid_t as long long or int32_t or whatever signed integral
type that was picked arbitrarily by the platform.

I think these *printf()s are mostly for informational purposes and if you
favor minimum change, you might be better off casting it to "int" without
changing the format specifiers.

On the other hand, if you are shooting for maximum compatibility perhaps
you may want to cast it to "intmax_t" and format as such.

Casting to "long" does not make much sense from either perspective, does
it?
