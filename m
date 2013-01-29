From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-send-email: add ~/.authinfo parsing
Date: Tue, 29 Jan 2013 14:38:23 -0800
Message-ID: <7vehh3obs0.fsf@alter.siamese.dyndns.org>
References: <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <d58b0709cd86e0d336902b52d72e06dd9b52d70d.1359493459.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:38:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0JpK-0003sc-F3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 23:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab3A2Wia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 17:38:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab3A2Wi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 17:38:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2790C099;
	Tue, 29 Jan 2013 17:38:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XEaM8+D30Tb9eZrU3x+rx6ZWG0c=; b=MwjXTr
	jLcTTHUsYVtCkq7nY+0bb3brd5f50GI04sje1ahe4TOOy/18H2O3I2ghrwXbYpf7
	EXn/ihjL+4AyKeOyqq+KORmJ/J5YaLiXY2xuup3OFC4EcSpIDA4v6RkzBsmEZjcW
	ODJRNQgmBT85pWSXGopSldq464FUygZsclJeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PFXdwC65x8N4YeahtLuSrSBp9KRoXwZT
	+BmNGaGoNqnDAZLCotQXLHZKApLLu88MDlEqnE8R6mt9BDA9i61gNtOIISvt2UXU
	3I12Ja43Eylb0v6I52wLjkQcuiJsktRySFjTFWJervaktQtBF8cAglhInwsqp33d
	Y6YGXXV8GDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E779BC098;
	Tue, 29 Jan 2013 17:38:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52A15C097; Tue, 29 Jan 2013
 17:38:25 -0500 (EST)
In-Reply-To: <d58b0709cd86e0d336902b52d72e06dd9b52d70d.1359493459.git.mina86@mina86.com>
 (Michal Nazarewicz's message of "Tue, 29 Jan 2013 22:08:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97F8A83C-6A64-11E2-8024-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214978>

Michal Nazarewicz <mpn@google.com> writes:

>> It is rather strange to require a comma-separated-values parser to
>> read a file format this simple, isn't it?
>
> I was worried about spaces in password.  CVS should handle such case
> nicely, whereas simple split won't.  Nonetheless, I guess that in the
> end this is not likely enough to add the dependency.

But .netrc/.authinfo format separates its entries with SP, HT, or
LF.  An entry begins with "machine <remote-hostname>" token pair.

split(/\s+/) will not work for an entry that span multiple lines but
CSV will not help, either.

Is it bad to use Net::Netrc instead?  This looks like exactly the
use case that module was written for, no?

>> Perhaps you can convert at least some popular ones yourself?  After
>> all, the user may be using an _existing_ .authinfo/.netrc that she
>> has been using with other programs that do understand symbolic port
>> names.  Rather than forcing all such users to update their files,
>> the patch can work a bit harder for them and the world will be a
>> better place, no?
>
> Parsing /etc/services added.

Hmph.  I would have expected to see getservbyname.
