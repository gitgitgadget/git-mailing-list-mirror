From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-instaweb: Fix custom apache log placement
Date: Fri, 23 Jul 2010 10:38:15 -0700
Message-ID: <7v7hkmf69k.fsf@alter.siamese.dyndns.org>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
 <AANLkTiknXtteX77h8Uy1JuWmGLWSSRkAGkS3INMOHBoJ@mail.gmail.com>
 <20100722234256.GA19581@dcvr.yhbt.net>
 <AANLkTimV0kGRMwxYxQu8jgWsiwTC_msU+2QWNAmYZuYe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:38:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcMCi-0006tf-MT
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab0GWRia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:38:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755508Ab0GWRi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:38:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79099C7B46;
	Fri, 23 Jul 2010 13:38:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ji1W5xmMtGyEKCf6KhUkhpUAtYo=; b=wV0Ipb
	djG88S6Esfn6tdIFrj7NlzhVfYfjBAf0k+sN1mscUYsinDy4SoGAg0+6MrguiQMO
	BG/baVV9CTAINt7xQG6ZDFYuWTBmcHRi/yrDZBeccJSjj+JQzXkCrFGFkkwNmKTB
	2VxqghVlGLtr3OlV1XA9un7UfH694rVMlj2Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZKL2Z5cUDbpCa+7wnQD8WY953LepOJV
	apL/hLpc+6+oueQCQT40gmCvmDYHxl4Pb34I9xw1cjHivrCK/sJS+/HK2K0ez0uL
	eK+zZoTCJtZT5kKGOmaj/eCZBhq6C0fDq86IuCgYHn7sotPsP30JvqRykPRm0dq+
	HgksYg7RpHE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A1AC7B42;
	Fri, 23 Jul 2010 13:38:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 785C8C7B40; Fri, 23 Jul
 2010 13:38:17 -0400 (EDT)
In-Reply-To: <AANLkTimV0kGRMwxYxQu8jgWsiwTC_msU+2QWNAmYZuYe@mail.gmail.com>
 (Dan McGee's message of "Fri\, 23 Jul 2010 08\:40\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 164170F8-9681-11DF-80FC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151557>

Dan McGee <dpmcgee@gmail.com> writes:

> On Thu, Jul 22, 2010 at 6:42 PM, Eric Wong <normalperson@yhbt.net> wrote:
> ...
>> Hi Dan, can you address Junio's concerns here?
>>
>> http://marc.info/?l=git&m=127791382102449&w=2
>
> I did already, and got no feedback...
> http://marc.info/?l=git&m=127791591706076&w=2

Thanks for a (half-) pointer [*1*]; I didn't see that message til now.

>> I think you are being overcautious. Even in this case, you can specify
>> the real name of the web server through git-config or command line
>> parameters to make sure it picks up the right settings. 

If there is an HTTP server "httpd" that does not understand Apache style
configuration file given via "-f" (use of which is a misconfiguration this
patch will start allowing users to make), we would need to add a new
codepath to the script to generate a configuration file to support that
server.  I do not think we have a mechanism to disambiguate different HTTP
server implementations that claim to be "httpd", so at that point we would
need to add something other than the command name for disambiguation.  But
for now I think your patch suffices.

As you pointed out, the last "case" statement in instaweb explicitly have
rejected servers we did not know about, so my worry was unfounded; nobody
could have been using a daemon whose name is "httpd", be it ArchLinux's
Apache or something incompatible.

Thanks.


[Footnote]

*1* Links to marc do not have an easy way other than re-typing to get to a
usable message-id to find the message to reply to, so while I wanted to
make this as a reply to your message from June 30th, I couldn't, and
instead I am sending this as a reply to the new message, and I had to copy
and paste the parts of the message I responded to.
