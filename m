From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not
 make sense
Date: Thu, 05 Apr 2012 13:01:58 -0700
Message-ID: <7vhawy54nd.fsf@alter.siamese.dyndns.org>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
 <20120405124706.GA3921@sigill.intra.peff.net>
 <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
 <20120405184345.GA6448@burratino> <7vlima5591.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFssh-0004x0-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 22:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab2DEUCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 16:02:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab2DEUCA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 16:02:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07C766AF8;
	Thu,  5 Apr 2012 16:02:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mqrKBlWJzTblX6beHy48DhX77Bk=; b=Opr77B
	oT/IbsaasdfxkwU38jDd7ZfKsaheufKkkmSxi1/CmpUExe9IPmQismBMm8EU8cxI
	7ruGF8ozg04RZ57WZvaCNS4uEiWAeiuHB/E083fWzl1zObPAES9k/B5bq8WalGAd
	ob4LOmRYdFd8/MHp3j0pl5WE/Aw7/+k51GiBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PNJzgN76/qoecRgD9D5rGSMuH270xlpW
	0hcJJ+PghXdx/0A/F2nlRflbMVitzm/ZK+GiQOXI69jMMNNjzSyUZ2XkFO4K9YK6
	l2tiyFnFdtwhotO3X42rR0wZiuEx7u+dhkSSjnHnzIT7I3UW/LZCA0ThZ1/HPgLS
	aHx2OKwLvoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F312B6AF7;
	Thu,  5 Apr 2012 16:01:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 871CA6AEA; Thu,  5 Apr 2012
 16:01:59 -0400 (EDT)
In-Reply-To: <7vlima5591.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 05 Apr 2012 12:48:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3418BFFA-7F5A-11E1-AF9E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194803>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I worry that a beginner seeing this message would think it means that
>> when "master" is set up to track origin/master that there is no way to
>> push that branch to any other repository.
>>
>> Maybe something like
>>
>> 		die(_(
>> "You are pushing to remote '%s', which is not the upstream of your\n"
>> "current branch '%s', without specifying a refspec.\n"),
>> 		    remote->name, branch->name);
>>
>> would be harder to misunderstand.
>
> Perhaps.  Do we need to rephrase it without using the word 'refspec'
> (e.g. "without telling me what to push"), or there is no point avoiding
> jargon because other jargons (i.e. 'remote' and 'upstream') already appear
> in the sentence?

How about phrasing it this way?

Note that the short-looking first line (in the context) and the second
line (updated) of the message are very much on purpose, to give '%s'
enough room to expand without overflowing the usual terminal width.

 builtin/push.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 765b19c..7a20036 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -99,7 +99,9 @@ static void setup_push_upstream(struct remote *remote)
 		    "refusing to push."), branch->name);
 	if (strcmp(branch->remote_name, remote->name))
 		die(_("You are pushing to remote '%s', which is not the "
-		      "upstream of your\ncurrent branch '%s'.\n"),
+		      "upstream of your\ncurrent branch '%s',\n"
+		      "without telling me to push which local branch to\n"
+		      " update which remote branch with."),
 		    remote->name, branch->name);
 
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
