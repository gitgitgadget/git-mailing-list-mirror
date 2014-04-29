From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/4] replace: add option to edit a Git object
Date: Tue, 29 Apr 2014 14:43:54 -0700
Message-ID: <xmqqvbtrizfp.fsf@gitster.dls.corp.google.com>
References: <20140426194404.21546.82305.chriscool@tuxfamily.org>
	<20140429023629.GB11730@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfFoo-0006e9-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbaD2Vn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:43:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932885AbaD2Vn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:43:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CADA7FE8B;
	Tue, 29 Apr 2014 17:43:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LF6hsoRuYE/pCTth1JpJ6XOTLvs=; b=wA5qGJ
	4OLQhAPC81iNuX0TwlFmnEWoacZgJUUxwwF8HCoZYyvgNfP7+tfyDonVka0OliMh
	tBT292gCuWawIWTPHpo9DtQbdylKQ5xZjJvrf5GDPTunVjvGxaWTOEfzQyrAcmv3
	cARL+ZhXvP/Fq8Y4lKIWuTJs/vWx0BkpQEhXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=js9xE61HrjRJVSGq6tPN/lnJF3H0XMM3
	1mwwOWSLi0QNW5XbBiz8RP2itH/TYELXya8r6eJXNq3nXSp4RSmPc8oJCbn3VgTp
	0eWcW65BiFxCVGtxr8yTzOb/KFS6RUSaHVZzjfkiNWLrpG5zE61FRZ7vPJhAtQ06
	jBneUNdfWbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0D4F7FE89;
	Tue, 29 Apr 2014 17:43:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEFCA7FE87;
	Tue, 29 Apr 2014 17:43:55 -0400 (EDT)
In-Reply-To: <20140429023629.GB11730@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Apr 2014 22:36:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5D24FA5A-CFE7-11E3-835A-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247612>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 26, 2014 at 10:00:53PM +0200, Christian Couder wrote:
>
>> This patch series comes from what Peff sent in the following thread:
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/243361/focus=243528
>
> Thanks. As I recall, these were in pretty good shape, and I just read
> over them again and didn't see anything wrong.
>
>> I added the following fixes:
>> 
>> - add "strbuf_release(&result);" in import_object(); this was suggested
>>   by Eric Sunshine
>> - use MODE_LIST instead of MODE_DELETE if no arguments are passed; this
>>   makes the test suite pass
>> - add "--no-replace-objects" when calling "git cat-file" in export_object();
>>   so that we edit the original object if an object is already replaced
>
> All sensible, I think.
>
>> I am not happy with the fact that if the user doesn't modify the object when
>> editing it, then a replace ref can still be created that points to the
>> original object. I think something should be done to avoid that.
>
> Yeah, it should be easy to just hashcmp the sha1s after calling
> import_object. In fact, I think we can just erase any existing replace
> ref in that case (the user might have started with a replace ref and
> converted it _back_ to the original object, for example).
>
>> Once that is fixed, I plan to add some tests and documentation, but I wanted
>> first to let you know that I am looking at this.
>
> Great. Thanks for working on this.
>
> -Peff

Thanks.  In the meantime, I'll queue these as-is and push the result
out.
