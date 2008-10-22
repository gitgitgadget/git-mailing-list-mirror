From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according to
 git-log rules.
Date: Wed, 22 Oct 2008 12:07:48 -0700
Message-ID: <7vd4hsv46z.fsf@gitster.siamese.dyndns.org>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com>
 <20081022082016.GA18473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:09:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksj58-00065s-63
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 21:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbYJVTIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 15:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYJVTIH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 15:08:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYJVTIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 15:08:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A0D572032;
	Wed, 22 Oct 2008 15:08:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 21E357202F; Wed, 22 Oct 2008 15:07:56 -0400 (EDT)
In-Reply-To: <20081022082016.GA18473@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 22 Oct 2008 04:20:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C06B5BD2-A06C-11DD-9765-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98889>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 22, 2008 at 12:55:57AM +0400, Alexander Gavrilov wrote:
>
>> +test_expect_success \
>> +	'blame respects i18n.commitencoding' '
>> +	git blame --incremental file | \
>> +		grep "^\(author\|summary\) " > actual &&
>> +	test_cmp actual expected
>
> Even though it is POSIX, using backslashed grouping in 'grep' isn't
> portable. It fails at least on Solaris 8, and you have to do:
>
>   egrep "^(author|summary) "
>
> instead. Of course, I can't get your test to pass even with that change,
> but I think that is just a broken iconv on Solaris.

Yuck.  Solaris 8 /usr/bin/grep does not even grok "-e", so we cannot do a
more obvious:

	grep -e "^author " -e "^summary "

Do people build with NO_EXTERNAL_GREP on older Solaris?

git-submodule.sh uses grep "-e" to look for two patterns and I suspect
older Solaris would have the same issue.
