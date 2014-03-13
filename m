From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Microproject idea: new OPT_* macros for PARSE_OPT_NONEG
Date: Thu, 13 Mar 2014 12:00:24 -0700
Message-ID: <xmqqfvmlj54n.fsf@gitster.dls.corp.google.com>
References: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
	<531977AF.4060907@alum.mit.edu>
	<CACsJy8AUhHE8=Yaj6_G46V6w5ZbA3z403GkBfsbZL7MxgeA3RQ@mail.gmail.com>
	<xmqqzjl1u87n.fsf@gitster.dls.corp.google.com>
	<CACsJy8Dw=43m_4KzAxwCqLsFq2E23rT=bT3zmGUue6RYTnrOYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 20:00:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOArw-0002fQ-Ny
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 20:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbaCMTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 15:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbaCMTA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 15:00:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6C82739B8;
	Thu, 13 Mar 2014 15:00:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hD1Kz14Vmi34JNnQ8IJBQHgRbrk=; b=GxXuZL
	mU75ef4AuZKhT3QKQqb+PxNgCDieEobgmAxnMcW3HS4yPdm36UAXJaqdpMPQPxug
	giduNzr9knkPVypZL4CrwMmigwNfvQSMUPvud6mrsRstoAPqHkQ0R7xB5pzBU+NM
	EdZreiYyup4DWUQwa02mu+4nkIIRrEcWpP9n0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sq1l8U1COFwiqaecIF6u39h0Ju9y3inO
	8IcoWwMU5nDnGF2ACgCKj+9vvrlGzAULBzSSacp11fh+0nB619FxiMcbT9T3yhu/
	BHH8iPQS4iBohN52DxAmX00qQ3Q5Ad6GO2kd1TyEDREJkZ51J+rUN85GTKmU/zO9
	Egv0U0uCgjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92BE1739B6;
	Thu, 13 Mar 2014 15:00:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC4A8739B4;
	Thu, 13 Mar 2014 15:00:25 -0400 (EDT)
In-Reply-To: <CACsJy8Dw=43m_4KzAxwCqLsFq2E23rT=bT3zmGUue6RYTnrOYg@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 13 Mar 2014 06:37:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC8F4EC6-AAE1-11E3-BC4B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244045>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 8, 2014 at 2:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Looking at "git grep -B3 OPT_NONEG" output, it seems that NONEG is
>> associated mostly with OPTION_CALLBACK and OPTION_SET_INT in the
>> existing code.
>>
>> Perhaps OPT_SET_INT should default to not just OPT_NOARG but also
>> OPT_NONEG?
>
> There are OPT_SET_INT() that should not have NONEG in current code. So
> there are two sets of SET_INT anyway. Either we convert them all to a
> new macro that takes an extra flag, or we add OPT_SET_INT_NONEG() that
> covers one set and leave the other set alone.

Are you forgetting the third alternative, of swapping the default,
if the ones that do not want NONEG are in the minority, to reduce
the number of spelled-out instances?
