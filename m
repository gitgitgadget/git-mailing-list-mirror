From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Fri, 22 Mar 2013 16:08:08 -0700
Message-ID: <7vzjxv3uef.fsf@alter.siamese.dyndns.org>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <20130319181042.GA14295@sigill.intra.peff.net>
 <20130322222438.GA13207@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 00:08:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJB4h-0005tc-SQ
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 00:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423456Ab3CVXIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 19:08:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422648Ab3CVXIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 19:08:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8487AB9F;
	Fri, 22 Mar 2013 19:08:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TQAGf5w9I0yuuhmG+dt4xjmjvv8=; b=Q9RHn0
	qC06owQ9BtHsxOw+C9VnRRv9cdN6wtHa+rBgS6YQp/V0PH6+TZ4obRLG3lSi/jSR
	7SVMu0yKUxYcncTPZBd9XAUjpW+12DlYFaVjnfhaot9oMDNsNB8WlLicvMh6doha
	P5x7oX25Ll9iUp3WS3/ozlQSWbceslMMEKE+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaInUPGQ1pg6JVsD2lncVC48vuyXLpeI
	PMqH6JYMeHf9Td45VJTNpUIuztsXhLU8GQa54QO7Z20iGoeYtScLyb3/r1W465JH
	mrEWw+g1jpCBX2sU+WeTdPx0v2FWjmxSXiFbyyUbM3OunpmVG1Hy/hc8PaPAfgEY
	YGrqI+sSLlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA9A4AB9E;
	Fri, 22 Mar 2013 19:08:10 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C745AB9D; Fri, 22 Mar 2013
 19:08:10 -0400 (EDT)
In-Reply-To: <20130322222438.GA13207@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Mar 2013 18:24:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D4D3E28-9345-11E2-9441-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218866>

Jeff King <peff@peff.net> writes:

>   if (pathlen && pathname[pathlen-1] == '/')
>           pathlen--;
>
> would work. But it seems that match_basename, despite taking the length
> of all of the strings we pass it, will happily use NUL-terminated
> functions like strcmp or fnmatch. Converting the former to check lengths
> should be pretty straightforward. But there is no version of fnmatch
> that does what we want. I wonder if we using wildmatch can get around
> this limitation.

Or save away pathname[pathlen], temporarily NUL terminate and call
these functions?
