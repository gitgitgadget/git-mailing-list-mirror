From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] fix hunk editing with 'commit -p -m'
Date: Thu, 06 Mar 2014 13:15:02 -0800
Message-ID: <xmqqvbvrvxk8.fsf@gitster.dls.corp.google.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfdL-0004mh-Fk
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbaCFVPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:15:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaCFVPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:15:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CEEF7074B;
	Thu,  6 Mar 2014 16:15:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sRsnIK3LoXRKkZcADot/HwUDajg=; b=WSu4Tz
	x5RYHYR0jLOPK4Ncp5Hp2uKXV9KDmbccnUUKPlli0wMK49z9acQqJdiqamJAGMoq
	tgVcnmmkzOwMEEasBlUezdazalJ4PPwfsLOH6jc+J8LOC7G4Ple7McHaY9QI7Q6J
	AEHoZJEmkV+n+wFRwKwrTaZ1RJZ0VDS4hd1FI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SiXV+kgBUP9lMT9+ILM7/+uHacLvCdk6
	WA5k6LRBdBsvlke55Tzdprh6xCfno1CS8wzW/Kx0/oeE3DAqcS8Yml1VzzH39TWG
	MqO7fe0gHGz+QluiHX3ZvUFoXMKEsurYeV4pproQB8j7Fwu8WMf2KbuXXlIMMYYw
	fA+IPjt52ok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68BC97074A;
	Thu,  6 Mar 2014 16:15:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73BC270746;
	Thu,  6 Mar 2014 16:15:05 -0500 (EST)
In-Reply-To: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Thu, 6 Mar 2014 15:50:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6377FA4E-A574-11E3-AC95-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243552>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> This patch fixes the fact that hunk editing with 'commit -p -m' does not work:
> GIT_EDITOR is set to ':' to indicate to hooks that no editor will be launched,
> which result in the 'hunk edit' option not launching the editor (and selecting
> the whole hunk).
>
> The fix consists in deferring the GIT_EDITOR override to the hook subprocess,
> like it's already done for GIT_INDEX_FILE:
> - modify 'run_hook' so the first parameter is the environment to set
> - add a 'run_hook_v' variant that take a va_list
> - add a new 'run_commit_hook' helper (to set both GIT_EDITOR and GIT_INDEX_FILE)

I sense that this is in line with one of the "leftover bits" items I
keep in http://git-blame.blogspot.com/p/leftover-bits.html,
especially http://thread.gmane.org/gmane.comp.version-control.git/192669/focus=192806
;-)
