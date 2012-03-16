From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Edit a rerere conflict resolution
Date: Fri, 16 Mar 2012 09:01:44 -0700
Message-ID: <7vaa3gilg7.fsf@alter.siamese.dyndns.org>
References: <4F5E4B20.5080709@lyx.org>
 <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F636227.2060102@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:01:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ZbF-0001Tg-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 17:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032910Ab2CPQBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 12:01:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374Ab2CPQBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 12:01:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 492596B84;
	Fri, 16 Mar 2012 12:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g/mwcyULk+dev8lIHH4D9+D/1Qg=; b=XJyh2F
	87ZMIc20zDDLKnneOWF83mVw+xESCHmaV+toZfMpNhLrNvcSNc/RJD0Akac5fbnX
	J9HYZ51RQSZIe94f4IMAcuPZ4ych8u44OdU2ovRZIl0lCQAdu5fsuj/C+b/+4iLW
	gDfzn86pNFGhfpeTS/7C0PWYIkVII5XbFuZPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7W6G6elm/vsHcVw00xCRSGZ5ZWjERzB
	75QBvjlDOAGdkIyTaP0MM/nwjjcPaIqv+AGxzIqkg9Fiy9kFT0cavM0Ahm0bvVJG
	ZNNJJKphpDSYLdTvezPw/bGh5oFq5h1B8xA28P1kOIUjvM8TqN2UH1WikOEU1knO
	f/Z6vGoRAPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 404596B83;
	Fri, 16 Mar 2012 12:01:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C07A56B82; Fri, 16 Mar 2012
 12:01:45 -0400 (EDT)
In-Reply-To: <4F636227.2060102@lyx.org> (Vincent van Ravesteijn's message of
 "Fri, 16 Mar 2012 16:54:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 548FA4DA-6F81-11E1-A3F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193272>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Op 12-3-2012 21:01, Junio C Hamano schreef:
> ...
>> I haven't find it necessary in practice, as the re-fix for me
>> typically would go like this:
>>
>>      $ git merge other-branch
>>      ... rerere kicks in; eyeball the results
>>      ... ah, my earlier resolution is no longer correct
>>      $ edit $the_path
>>      ... test the result of manual edit in the context of the merged whole
>>      ... and be satisified
>>      $ git rerere forget $the_path
>>      $ git add $the_path
>>      $ git commit
>>      ... rerere records the updated resolution
>>
> This doesn't really work for me:
>
>      $ git merge other-branch
>      Auto-merging <path>
>      CONFLICT (content): Merge conflicts in <path>
>      Resolved '<path>' using previous resolution.
>      Automatic merge failed; fix conflicts and then commit the result.
>
>      $ git rerere status
>      $ git rerere forget <path>
>      error: no remembered resolution for <path>
>
>      $ edit <path>
>      $ git commit -a -m "fix"
>      ... no sign of rerere doing something.
>
> Why is this different from what you describe above, and how can I
> modify the recorded resolution ?

Do you have rerere.autoupdate set by any chance?  If so, don't.  At least
when you are trying to purge the broken rerere entry.
