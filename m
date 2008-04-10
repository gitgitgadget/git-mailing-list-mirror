From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] Fix tests breaking when checkout path contains	shell
 metacharacters
Date: Thu, 10 Apr 2008 00:24:29 -0700
Message-ID: <7vwsn6xjde.fsf@gitster.siamese.dyndns.org>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-6-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-7-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-8-git-send-email-bdonlan@fushizen.net>
 <47FC69B8.40809@viscovery.net> <20080410063028.GA12562@shion.is.fushizen.net>
 <47FDB85F.9070503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Donlan <bdonlan@fushizen.net>,
	Git Mailing List <git@vger.kernel.org>,
	Adam Roben <aroben@apple.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 09:25:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjrA3-0004hz-VP
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbYDJHYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbYDJHYq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:24:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYDJHYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 03:24:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7158E2319;
	Thu, 10 Apr 2008 03:24:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8980C2318; Thu, 10 Apr 2008 03:24:37 -0400 (EDT)
In-Reply-To: <47FDB85F.9070503@viscovery.net> (Johannes Sixt's message of
 "Thu, 10 Apr 2008 08:49:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79185>

Johannes Sixt <j.sixt@viscovery.net> writes:

>>>>  test_expect_success  ".rev_db auto-converted to .rev_map.UUID" "
>>>>  	git-svn fetch -i trunk &&
>>>> +	test -z \"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_db.* 2>/dev/null)\" &&
>>>> +	expect=\"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_map.*)\" &&
>>>>  	test -n \"\$expect\" &&
>>>> +	rev_db=\"\$(echo \$expect | sed -e 's,_map,_db,')\" &&
>>>> +	convert_to_rev_db \"\$expect\" \"\$rev_db\" &&
>>>> +	rm -f \"\$expect\" &&
>>>> +	test -f \"\$rev_db\" &&
>>>>  	git-svn fetch -i trunk &&
>>>> +	test -z \"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_db.* 2>/dev/null)\" &&
>>>> +	test ! -e \"\$GIT_DIR\"/svn/trunk/.rev_db &&
>>>> +	test -f \"\$expect\"
>>>>  	"
>>> While looking at this test: Wouldn't it be easier to just place the whole
>>> thing (and probably similar cases, too) in single-quotes?
>> 
>> To be honest, I fixed all the git-svn tests with a suitably clever vim s///
>> expression, so at the time this way was actually easier :)

Yeah, last night I ran out of energy reviewing things.  The above is
simply too ugly to be acceptable, with or without automated s///
expression.
