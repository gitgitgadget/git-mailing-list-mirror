From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Sun, 07 Jul 2013 03:01:44 -0700
Message-ID: <7vfvvq6647.fsf@alter.siamese.dyndns.org>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-3-git-send-email-artagnon@gmail.com>
	<20130705124536.GU862789@vauxhall.crustytoothpaste.net>
	<7vobag7wl0.fsf@alter.siamese.dyndns.org>
	<20130705202948.GW862789@vauxhall.crustytoothpaste.net>
	<20130707055438.GA1730@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 12:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvlmy-0001XS-LD
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 12:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3GGKBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 06:01:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab3GGKBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 06:01:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA73D28A9F;
	Sun,  7 Jul 2013 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=93Wc64MPaZNKNvfVSqC1Pddb9EQ=; b=ZD8ZfN
	s0usiia5oplPeGzaZsOV6O72rlCSApCswmbiOj+k0w/2BfB1vJWS8FtmvNdb6Cwu
	qrEUBoq1a+Dxcjl6taDh07/iCQeTYVClKzCoKBXdNljlHr4NetvSfqeqG6HyHxuA
	WwOEEY4LIr0YLrxn9wqdDkR+jB3JTlpXXCLUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uMCxMLpCfvnz6I14fb9VCdRQnyl8/1Qa
	Rg3dMxoAFf0AXlpav0HmOygppn/ouCtbQpKTWqAfcTVoO3JZDhO4a2qH5yR+xcz+
	RPLYRl9VznJ0qDJfv7MWXs1v39a4rD8Wx/QbCNo40+e491KwnWT5FUXMvUYsYFhb
	fzijF4Xi2no=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC36328A9E;
	Sun,  7 Jul 2013 10:01:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C80B28A9C;
	Sun,  7 Jul 2013 10:01:46 +0000 (UTC)
In-Reply-To: <20130707055438.GA1730@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 7 Jul 2013 01:54:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BD8C276-E6EC-11E2-9B96-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229762>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 05, 2013 at 08:29:48PM +0000, brian m. carlson wrote:
>
>> On Fri, Jul 05, 2013 at 10:20:11AM -0700, Junio C Hamano wrote:
>> > +# Helper to come up with SSL/TLS certification validation params
>> > +# and warn when doing no verification
>> > +sub ssl_verify_params {
>> > +	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
>> 
>> You might as well put this at the top of the file, because all use
>> statements happen at compile time anyway, regardless of their location.
>> If you want to lazy-load this, you need to do:
>> 
>> require IO::Socket::SSL;
>> IO::Socket::SSL->import(qw(SSL_VERIFY_PEER SSL_VERIFY_NONE));
>> 
>> which is equivalent to "use" except that it happens at runtime.
>
> I think we _must_ lazy load this, or else we are breaking git-send-email
> users on platforms that do not have IO::Socket::SSL (and do not plan on
> using SSL themselves).
>
> The same goes for the "use" in patch 1/2.

A very good point.  Thanks.

Also it appears that people seem to be seeing different behaviours
depending on the versions of IO::Socket::SSL they have; we may need
to conditionalize what our code does depending on $PACKAGE::Version
after we do that lazy loading.
