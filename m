From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/18] gitweb: Change file handles (in caching) to
 lexical variables as opposed to globs
Date: Thu, 09 Dec 2010 16:32:39 -0800
Message-ID: <7vwrnieac8.fsf@alter.siamese.dyndns.org>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
 <1291931844-28454-13-git-send-email-warthog9@eaglescrag.net>
 <m3d3pa1o0j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:32:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqut-0003CH-PG
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab0LJAcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:32:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0LJAcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:32:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1537C31AE;
	Thu,  9 Dec 2010 19:33:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M1lY72Xr5xRkK0AAqIv9zFEOC7c=; b=G2sXqu
	Xvt/31IFLqu57Bsy/euGQth0KvICG27t/ytiAM387NBNg6RvkqGxKqSOl+tE4bUA
	Xfq504mtPKqY8Mn7D9136hu+G71q/1/KbotTNegb4IOJYc6PPI0my0tf+/2wgV/3
	JHIiUoCZXzM5SzBCROJOIM1slMOqTh8amhGgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJo/URe8KCqdxPVwoP+1uUhAQnM2rFjz
	uVbglx0ABbRxNSKcTZFwWQfsklL5ooiHmwa+jE3phmFuXCVcL4/wQBg3ZCkxAMcI
	g7fEA/4TgRDuZ+OlU6voW3DBOjEE6KD5Vnsui84S6YZpyNbdE4rR/mrJCdfJq4oY
	3GLwFhtmA7g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D93EF31AD;
	Thu,  9 Dec 2010 19:33:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3B6C31AA; Thu,  9 Dec 2010
 19:33:06 -0500 (EST)
In-Reply-To: <m3d3pa1o0j.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 09 Dec 2010 16\:16\:20 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1104C310-03F5-11E0-A142-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163367>

Jakub Narebski <jnareb@gmail.com> writes:

>> +# Global declarations
>> +our $cacheFile;
>> +our $cacheFileBG;
>> +our $cacheFileBinWT;
>> +our $cacheFileBin;
>
> You are trading globs for global (well, package) variables.  They are
> not lexical filehandles... though I'm not sure if it would be possible
> without restructuring code; note that if variable holding filehandle
> falls out of scope, then file would be automatically closed.

Hmm. why is it a bad idea, when you need to access these from practically
everywhere, to use global variables to begin with?  To a certain degree,
it sounds like an unnecessary burden without much gain to me.
