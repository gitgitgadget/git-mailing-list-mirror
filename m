From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repository modified after migration
Date: Tue, 12 Jan 2016 10:07:29 -0800
Message-ID: <xmqq8u3uvfha.fsf@gitster.mtv.corp.google.com>
References: <CAFwKRnQ_EZ73DBfrb0HNks3dt3=YJbLRoHvB0mfsD9FA-ey6hA@mail.gmail.com>
	<5693C48A.7060801@drmicha.warpmail.net>
	<xmqq4mekx9ld.fsf@gitster.mtv.corp.google.com>
	<5694A4E6.6020508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yang Yu <yang.yu.list@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:07:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3M2-0002Dp-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbcALSHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:07:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752575AbcALSHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:07:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 811E339412;
	Tue, 12 Jan 2016 13:07:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xp695UN3NstYjDycWRZc/SN2UDI=; b=ihe40Z
	q8aYxHwIJteonJ1/A+hIvUYPW9DUSmgtywkWAtAj9fxTY7IGxC/7YL15+f27TGXf
	aLVgetf2I+3G34LLy52hSL6odUtmn+LH/BAUYfRBmGivfwrDQcEuElIH0aGaKi7c
	FMVtFxcWkeYVRPdVl7fNktHAyfMViajb27o/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AjOx3cEn9rSY/FlNM3s5bdAXqH39m5Jl
	jQjLCftMtEpoSWDAehNXlhhocmspb+wRHfRGRMUJyjhZZEwB5e7m77g+2uSxQHvl
	APiFJZj/67Q5OiBKVmkwdF4XIZAiDrmR73RNFaWcBkrODQpEIySJmyX7d77/4luM
	G6yjKJ3t/AY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77F4C39411;
	Tue, 12 Jan 2016 13:07:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EAAA53940E;
	Tue, 12 Jan 2016 13:07:30 -0500 (EST)
In-Reply-To: <5694A4E6.6020508@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 12 Jan 2016 08:01:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58EAAF2E-B957-11E5-843F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283828>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 11.01.2016 19:19:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> This happens whenever the "stat" information changes, e.g. due to
>>> changed device numbering and such. "git reset --hard" would have been
>>> the quickiest way to reset the stat cache/index - after git diff, of
>>> course ;)
>> 
>> That does not quite explain why 'git status' reported modified files
>> in the first place.  It would have refreshed the cached stat info in
>> the index as the first thing to do.  "git status" I think is the
>> recommended way these days ("update-index --refresh" for us old
>> timers) to nondestructively correct the cached stat information
>> discrepancy caused by "cp -R".
>> 
>> If you need to resort to "reset --hard", then there is something
>> else going on.
>
> Back than when I had the same problem with git repos on removable file
> systems (if I remember correctly) git status did not correct that
> information. It may be different now.

I do not recall we did anything specific to help removable devices,
so if the report is coming from a filesystem on a removable device
we may be seeing the same symptom.

I somehow doubt that is the case, though.

A not-entirely-inplausible theory is that the index in the original
repository somehow marks modified entries as clean, fooling "status"
that is run in the original repository into reporting that nothing
changed.  Because "cp -R" into a different location forces the
content-level checking, "status" run in the copy notices that they
are indeed different and tells the true story.  If that is the case,
it would be interesting to see how the index got into that state.
