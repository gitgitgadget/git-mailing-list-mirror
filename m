From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in
 fill_project_list_info
Date: Fri, 10 Feb 2012 13:44:02 -0800
Message-ID: <7vobt6nz31.fsf@alter.siamese.dyndns.org>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
 <201202101917.52908.jnareb@gmail.com>
 <7vsjiipiyu.fsf@alter.siamese.dyndns.org>
 <201202102230.13193.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:44:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvyGU-0004uy-KL
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759137Ab2BJVoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 16:44:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab2BJVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:44:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D932627B;
	Fri, 10 Feb 2012 16:44:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ffQesl6sguXPKxJ+3Ec/IA7jiek=; b=PHDADc
	vnlI6WdmDcSxGy+88WEq6WPpXDuqdSmNI5Fn5XKonA5P1jqK4exzpCFxxyc5wF5t
	zJsgjYdOjDjdW3xRRDek1bxLAQnbB0Yk5UvUec9cLRVSUOQxO6Y6VsSlXcFr85Ll
	8XOF0wGdj3/Z5QFy3a/Wvi2t4Dn4bqcaK7NVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OEVkZHkkZZJJM9eDXNeP87/T3Zrv8+fX
	7VsRQKJRAcnyj4c0fgWFDDyr2Ua0ACNWdRPH7XTdxY7Anon6Az1cFXWiqtDcRQBt
	Ndi1VHmyilyZVQCwHxQ+2BUnwUnsOya2yyYJgpfy/A91efsrGmJfPBrSh7hFnS9Q
	J0HLhGPBpj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74FE46279;
	Fri, 10 Feb 2012 16:44:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 074F86277; Fri, 10 Feb 2012
 16:44:03 -0500 (EST)
In-Reply-To: <201202102230.13193.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 10 Feb 2012 22:30:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59D9515A-5430-11E1-B36E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190463>

Jakub Narebski <jnareb@gmail.com> writes:

>> Exactly.  Why do you need @fill_only at all?  If you are interested in
>> ctags and you want to make sure ctags is available, the question you want
>> to ask the helper function is "Does the project structure already have
>> ctags field?".  Why does the helper function needs to know anything else?
>
> It is to support incremental filling of project info.  The code is to
> go like this:
>
>   create
>   filter
>   fill part
>   filter
>   fill rest
>
> We need @fill_only for the "fill part".

Again, why?

> As filling project info is
> potentially expensive (especially the 'age' field),

So you wouldn't say "I am interested in 'age' field" but show interest in,
and fill, cheaper fields in the earlier "fill" calls, and then...

> doing it on narrowed
> (filtered) list of project is a performance win.

... you drop uninteresting projects by using the partially filled
information, and show interest in more expensive 'age' in the later round
for surviving projects.

It still does not explain why you need @fill_only.
Hrm...
