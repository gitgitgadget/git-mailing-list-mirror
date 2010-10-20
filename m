From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] test-lib: extend test_decode_color to handle more
 color codes
Date: Wed, 20 Oct 2010 16:40:30 -0700
Message-ID: <7v39s0v3f5.fsf@alter.siamese.dyndns.org>
References: <7v4ocgx2we.fsf@alter.siamese.dyndns.org>
 <1287613046-61804-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nazri Ramliy <ayiehere@gmail.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 01:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8iGz-0005D0-Vl
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 01:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab0JTXkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 19:40:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0JTXkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 19:40:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F86DE0DD4;
	Wed, 20 Oct 2010 19:40:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eLxQUmn9ssJtOvp+M8LCZUqISDI=; b=OIvNYx
	cmd5CZl4khWCF0eA3bOQtMb8GEBUva1KOmpEdewQSnFWt6+ky8A4TBp3Jg4AdH1t
	gIJ92aQvutNmPplcY9lPnosarC01+yjUPOyhHmi364ULGkpkK5doN+O/T9ew2ImT
	yxCRWXMOWjkKSElAHX+yKMXqivOHnaSX5sd+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qo1QXVVQYpnkPDNQXbIhEwezuWu/Q1Ky
	SuhjLd+qNysDnDejBeBMyW6MfFIUSKpxbZsucxylplru9PKr6mDajbr1cXUJywex
	qrjIkgQIS87PIzQdMnzW/4zczQlqTyckrzEYOjwz+6j6pUZXp6Q5cM68oSuWd+zS
	WY/n1xqkyB0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0FEEE0DCF;
	Wed, 20 Oct 2010 19:40:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33C9DE0DCE; Wed, 20 Oct
 2010 19:40:32 -0400 (EDT)
In-Reply-To: <1287613046-61804-1-git-send-email-kevin@sb.org> (Kevin
 Ballard's message of "Wed\, 20 Oct 2010 15\:17\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FE68F0E-DCA3-11DF-853F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159451>

Kevin Ballard <kevin@sb.org> writes:

> Enhance the test_decode_color function to handle all common color codes,
> including background colors and escapes that contain multiple codes.
> This change necessitates changing <WHITE> to <BOLD>, so update t4034
> as well.
>
> This change is necessary for the next commit in order to test
> background colors properly.
>
> Signed-off-by: Kevin Ballard <kevin@sb.org>
> ---
> I turned sed into awk. Looks like awk is already used elsehwere in git,
> so I'm assuming this is safe, but please let me know if it's not.

I think calling BOLD BOLD is the right thing to do (who came up with the
bogus WHITE in the first place anyway---my terminal is black letters on
white background, thank you).

Even though some scripts seem to already use awk, they are all used for
very small and trivial processing without exercising anything remotely
fancy e.g. hexadecimal \xXX quoting or match() function, so I wouldn't be
surprised if we see breakage reports from minority platforms.

But I do not think of a trivial way to express combination of attributes
by extending the existing sed script (we can write loops and do the same
computation as your awk script does, but it does not reduce the complexity
nor risk of portability issues), so let's see what happens.  We already
use Perl everywhere, which we might end up using for this if there are
platforms that have issues with your awk script.

Thanks.
