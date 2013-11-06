From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Wed, 06 Nov 2013 11:01:31 -0800
Message-ID: <xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 06 20:01:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve8MH-00080H-H9
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 20:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab3KFTBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 14:01:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172Ab3KFTBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 14:01:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27DF54D266;
	Wed,  6 Nov 2013 14:01:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWvMbPtUtdp1Kq3363skC67OenM=; b=mChbis
	fdYVXV/euALQ4rlFcJMrrdleiKv79rQp3k4q/UOn0CRqVLHl3l3686CM2nbxhTWU
	82QnW28rioaST6VMVYqcQvyjaQM3KJjKsECk9dxs8XMVAMn3Qxbw1AXThZDV6Hh8
	iiaoIytEDi0JsPmbRpq8gmVWeuVphQlT36HD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qQ4TWlFIN+wK0zJA2udTGo6/qjHaels3
	ym9BVbi8yBOAdi4BuAdcXFj+467D3Y4KUjuTI7WJg0J+MjZcn52gCWF/RUdoSqYY
	GU/fy6bwvIA/mEAzPKfE38TGY0qlpsnImmb29g/iwCaQ330uJTXQ1x0Jss0G+Eng
	80lDO8B1eEg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 185674D264;
	Wed,  6 Nov 2013 14:01:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57C3D4D263;
	Wed,  6 Nov 2013 14:01:35 -0500 (EST)
In-Reply-To: <1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	(Matthieu Moy's message of "Tue, 5 Nov 2013 11:16:59 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB7F29B2-4715-11E3-9451-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237362>

Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:

> I don't remember all the discussions on the patch which introduced
> the warning, but I don't think it's relevant to digg them before applying the patch:

If we apply the patch then it is too late to dig them ;-)

> * The assumption was that users would read the docs, but as I already mentioned:
>   "Judging by the question asked on stackoverflow
>   ( http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0 )
>   and its popularity, telling the users to read the docs did not work very
>   well."

That is true, but does it justify giving a misleading information in
the advice message?

Specifically:

>> +   "When push.default is set to 'matching', git will push all local branches\n"
>> +   "to the remote branches with the same (matching) name.

invites those who do not read documentation to mistake it with using
an explicit "refs/heads/*:refs/heads/*" refspec.

And this one

>> +   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
>> +   "branch to the same remote branch used by git pull.   A push will\n"
>> +   "only succeed if the remote and local branches have the same name.\n"

while you can see that it is not telling a lie if you read it twice,
"will only succeed if" feels somewhat roundabout.

	... push only the current branch back to the branch of the
	same name, but only if 'git pull' is set to pull from that
	branch. Otherwise the push will fail.

might be an improvement, but I dunno.

> * The warning has been there for a while now. Advanced users have
> already set push.default.  We shouldn't be worried about eating a
> bit of screen real estate for users who didn't yet.

This part I can agree with.
