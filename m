From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Thu, 24 Jan 2013 10:22:04 -0800
Message-ID: <7v1udacugj.fsf@alter.siamese.dyndns.org>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com>
 <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
 <7v1udcn84w.fsf@alter.siamese.dyndns.org>
 <CACsJy8DiVy7tcG_t2JENKoPSFWV24Tneh4q=upPPJML4VESMag@mail.gmail.com>
 <7vwqv3dw2n.fsf@alter.siamese.dyndns.org>
 <CACsJy8CtV-ngy4iGm3Vn3bu9XwpSrZ_AeWpPxTC2TY_qXv=Cxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyRRW-0002oR-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 19:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab3AXSWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 13:22:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64849 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab3AXSWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 13:22:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 256A4B751;
	Thu, 24 Jan 2013 13:22:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8QFTn+re/A6ufBOajiUIYYpiBrY=; b=m61va5
	tuYoLhbFZfsJvY86eFsSwhtnDHlNYTfi+fCUwLE5Y5w3D03Lar4mEPqiIEm2FjUE
	lBh2Ry5XpMMdo4wWWbc0bsmHrluF1mKDCmseS+g8BArKWa95c9GxfbfgEywiPkzM
	5uJHdkme0emtpvFCplFwGSfxjhKryAddqUJxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e3WjqFW6h0Y+9apHumWTTotNOq0qbHdB
	YoMLdVgshdh/5WIEVmZPh+yoSHfLELmgSMwW0ft2ska87kO1DHiJdLE52dm1iG4d
	D3UfJavivtX4+OYfJyXADI3LhyYNl4vgwjw5pSuv0rMLn6/+B6p+2FWwi2XXk0kb
	hwcEqQLtxEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1371DB74F;
	Thu, 24 Jan 2013 13:22:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67EC0B74E; Thu, 24 Jan 2013
 13:22:06 -0500 (EST)
In-Reply-To: <CACsJy8CtV-ngy4iGm3Vn3bu9XwpSrZ_AeWpPxTC2TY_qXv=Cxw@mail.gmail.com> (Duy
 Nguyen's message of "Thu, 24 Jan 2013 12:51:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F55C403A-6652-11E2-85FF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214437>

Duy Nguyen <pclouds@gmail.com> writes:

> I don't think we need to support two different sets of wildcards in
> the long run. I'm thinking of adding ":(glob)" with WM_PATHNAME.
> Pathspec without :(glob) still uses the current wildcards (i.e. no
> FNM_PATHNAME). At some point, like 2.0, we either switch the behavior
> of patterns-without-:(glob) to WM_PATHNAME, or just disable wildcards
> when :(glob) is not present.

Yeah, I think that is sensible.

I am meaning to merge your retire-fnmatch topic to 'master'.  What
should the Release Notes say for the upcoming release?  

    You can build with USE_WILDMATCH=YesPlease to use a replacement
    implementation of pattern matching logic used for pathname-like
    things, e.g.  refnames and paths in the repository.  The new
    implementation is not expected change the existing behaviour of
    Git at all, except for "git for-each-ref" where you can now say
    "refs/**/master" and match with both refs/heads/master and
    refs/remotes/origin/master.  In future versions of Git, we plan
    to use this new implementation in wider places (e.g. "git log
    '**/t*.sh'" may find commits that touch a shell script whose
    name begins with "t" at any level), but we are not there yet.
    By building with USE_WILDMATCH, using the resulting Git daily
    and reporting when you find breakages, you can help us get
    closer to that goal.
