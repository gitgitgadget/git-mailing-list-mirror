From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: set temp variables using 'env' in test function instead of subshell
Date: Wed, 19 Mar 2014 10:28:46 -0700
Message-ID: <xmqqzjkm3xo1.fsf@gitster.dls.corp.google.com>
References: <244284@gmane.comp.version-control.git>
	<1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
	<xmqqd2hj6y5o.fsf@gitster.dls.corp.google.com>
	<20140318214536.GA10076@sigill.intra.peff.net>
	<xmqqy5075f0k.fsf@gitster.dls.corp.google.com>
	<20140318230658.GA10679@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:29:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKIR-0004MR-F2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759405AbaCSR2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 13:28:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759349AbaCSR2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:28:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 531A374731;
	Wed, 19 Mar 2014 13:28:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y+QkY6kLugP8wx4TmVAWg4r3ofQ=; b=DMaNc+
	i/W2rNZJSO0JgMHJfxqFMVFZfcf//kSsgLxSKqQOyfrC/ox4qLzUlqwSZbUXjQ8I
	FelT5byjHIUj5xs+uV5/AZzCNYuW3ghvSnBI9dkvANWEHzUtTa9mEuwhhO+N0RWU
	dKZtu8CPNrcJfvyQTe9oh+lQn+zGUPSpW8SNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWajfWfCk3Wvk0RPvgRkAj2/vnkM++e6
	rQ9yvh87hirj3MZ+/U6DhupBGaLKQEJq2dTz4KEKypONIqSrQyLbKLwU630Xkmcm
	goEjCcT2qfzhnyfPwRtp3j/oAHDhftDvOjpY7BOCKyQySl2/6FB07I5We02/BJqH
	yTB5sT5nYDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 407EE74730;
	Wed, 19 Mar 2014 13:28:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8834F7472F;
	Wed, 19 Mar 2014 13:28:48 -0400 (EDT)
In-Reply-To: <20140318230658.GA10679@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Mar 2014 19:06:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE5D64C0-AF8B-11E3-BDF9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244466>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 18, 2014 at 03:16:27PM -0700, Junio C Hamano wrote:
>
>> > Isn't GIT_CONFIG here another way of saying:
>> >
>> >   test_must_fail git config -f doesnotexist --list
>> >
>> > Perhaps that is shorter and more readable still (and there are a few
>> > similar cases in this patch.
>> 
>> Surely, but are we assuming that "git config" correctly honors the
>> equivalence between GIT_CONFIG=file and -f file, or is that also
>> something we are testing in these tests?
>
> I think we can assume that they are equivalent, and it is not worth
> testing (and they are equivalent in code since 270a344 (config: stop
> using config_exclusive_filename, 2012-02-16).
>
> My recollection is that GIT_CONFIG mostly exists as a historical
> footnote. Recall that at one time it affected all commands, but that had
> many problems and was done away with in dc87183 (Only use GIT_CONFIG in
> "git config", not other programs, 2008-06-30). I think we left it in
> place for git-config mostly for backward compatibility,...

Thanks.  Then I think it makes sense to do such a conversion but it
probably should be done on top of this patch (we could do it before
this patch), not as a part of this patch.
