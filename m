From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Fri, 24 May 2013 11:01:15 -0700
Message-ID: <7vehcw9s0k.fsf@alter.siamese.dyndns.org>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
	<1369321970-7759-8-git-send-email-artagnon@gmail.com>
	<CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
	<CALkWK0=XufbcwObBq7_MWX3jL63Nv3YeSvTUpOfXD+XoKkvMag@mail.gmail.com>
	<CACsJy8AHX0181uON5Aa7oJzX8j3qAA26Ymh5G3YEGidD4O5zvA@mail.gmail.com>
	<CALkWK0=LXNRaWz0vN_FwmJKbXT+W11mHABqzSJnbm_izQ0Ttrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 20:01:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfwIt-0007Vl-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 20:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348Ab3EXSBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 14:01:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab3EXSBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 14:01:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1037620F6A;
	Fri, 24 May 2013 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2FTUGXM2JKUX2qnzFsFIJpvqBP0=; b=k7TUzM
	EgTLyr4Rn3NGvBwdpGp/ifS0yV8VGonPsL/mClUI+JGYTKRGSqiBVcLbMlmVXD9d
	VQ2ikq9ek94vha/RKkyRN8/3y+dr3yJJ4rL+pbi5dPeD/PySU/m9ZwRaRdH92PmM
	/Z2zAOe66VcNz9Nu3y99nR9JqW4DO9O/2fwHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SPEUExOUTPno3fu7rEY+CsrQ3ZtM1EdS
	1kvm7gQz2eHXF/EUUo4JAKS8E8lamszE1j1W+hsSLjm2NI9rX8+p5s/gDTVle+1W
	Kny/ujZa1qftxq1Y2LvWzgV0GTDZ1maDPPqBGFUIM5p5NnxB43i0VwuOrjOVO+Va
	3RnVVlcpsLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0665720F69;
	Fri, 24 May 2013 18:01:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63BF120F66;
	Fri, 24 May 2013 18:01:17 +0000 (UTC)
In-Reply-To: <CALkWK0=LXNRaWz0vN_FwmJKbXT+W11mHABqzSJnbm_izQ0Ttrw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 24 May 2013 21:59:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE754346-C49B-11E2-8651-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225390>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Duy Nguyen wrote:
>> Then "show @{p}" should show the tip commit of rr/master, not the ref
>> name.
>
> Yes, that is correct.
>
>> rev-parse (with an option, maybe) may be a better place for
>> this.
>
> Er, no.  I actually want things like diff @{p}..HEAD.  I want it to be
> a first-class revision, just like @{u}.

I think Duy's suggestion makes perfect sense; rev-parse already has
a mechanism to expand @{u} to the full name, so if you are hooking
into the same codepath as @{u} to implement the "I publish there"
information, which I think you should, you already should have it
for free.
