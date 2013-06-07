From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch doc: escape asterisk in --tags paragraph
Date: Fri, 07 Jun 2013 08:09:51 -0700
Message-ID: <7vk3m6ufcw.fsf@alter.siamese.dyndns.org>
References: <1370604694-2438-1-git-send-email-artagnon@gmail.com>
	<7vppvyugeg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:10:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkyIj-0006YM-ET
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab3FGPJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 11:09:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab3FGPJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 11:09:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B6E23EB7;
	Fri,  7 Jun 2013 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tgJESCHETDG/gu8NhaMPajekbpE=; b=MdRaWK
	nB3ySif63oBoopBNG5zrLARp6ArsBTfPRvDb8GHAhT6AdEDA96lInsrBPv5f4F2e
	kHn0vNWOkvTiZIPOyC5ycxoVVZh42yBMlV3MKFs+GuHeRcZ3ezuwLJ5Gc6pum4je
	XNuSrVtxreXp+mkLO4pE+SeEOA3VgiQp05K0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l7CilfkEJOZ3acapc8vDgu5F4FKty4X7
	Lm69D6pnJDP83c6NNVnOGwit7KAky+I7APou4b3jfWb6W2BAvQIg5vlObq4wM4e7
	gboyaiSfKEpPNGyvb5pS1koEfnfBX0kom9hfVoRdmIiojX5ogOhNozZm0vVrRvOZ
	Gs6KSxcq8+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 792E823EB6;
	Fri,  7 Jun 2013 15:09:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D516D23EB5;
	Fri,  7 Jun 2013 15:09:55 +0000 (UTC)
In-Reply-To: <7vppvyugeg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Jun 2013 07:47:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FF7D4BA-CF84-11E2-A20F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226635>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Currently, the paragraph corresponding to the --tags option in
>> git-fetch(1) looks like:
>>
>>   -t, --tags
>>       This is a short-hand for giving "refs/tags/:refs/tags/" refspec
>>                                                  ^^^^^^^^^^^
>> 						 this is in bold
>>
>> This happens because the corresponding text in fetch-options.txt is
>> "refs/tags/*:refs/tags/*"; asciidoc renders the text between the two
>> asterisks in bold.  Escape the first asterisk, correcting the text.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Candidate for maint?
>
> The issue certainly is real and needs a fix for maint.  Your
> solution I am not sure about.
>
>   $ git grep '\\\*' -- Documentation/\*.txt
>
> shows only two meaningful hits (git-rm.txt and git-svn.txt);
> everybody else uses
>
> $ git grep '{asterisk}' -- Documentation/\*.txt
>
> and the one you spotted in fetch-options.txt is very similar to the
> one appears in git-pull.txt, I think.

How about this?

-- >8 --
Subject: fetch-options.txt: prevent wildcard refspec from getting misformatted 

When explaining the "--tags" option as an equivalent to giving an
explicit "refs/tags/*:refs/tags/*" refspec, the two asterisks were
misinterpreted by AsciiDoc as a request to typeset the string
segment between them in bold.

We could fix it in two ways.  We can replace them with {asterisk}s
while keeping the string as body text, or we can mark it as a
literal string by using the backquotes around it.

Let's do the latter, as it is teaching the user an "exactly as
typed" alternative.

Noticed-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/fetch-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 6e98bdf..c87bf39 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -57,7 +57,7 @@ endif::git-pull[]
 ifndef::git-pull[]
 -t::
 --tags::
-	This is a short-hand for giving "refs/tags/*:refs/tags/*"
+	This is a short-hand for giving `refs/tags/*:refs/tags/*`
 	refspec from the command line, to ask all tags to be fetched
 	and stored locally.  Because this acts as an explicit
 	refspec, the default refspecs (configured with the
