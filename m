From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reflog --date
Date: Tue, 21 Oct 2014 10:24:34 -0700
Message-ID: <xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
References: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 19:24:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgdAu-0001oa-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 19:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933111AbaJURYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 13:24:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932849AbaJURYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 13:24:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21B691665D;
	Tue, 21 Oct 2014 13:24:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yV2dO8VVH2wRDFdKhc4bejIixFM=; b=g/wwdT
	GLBjsO7H1gPMuE7A/jdv25RwHNTHwnkI3mjy5xGrCVfIwCB8obRlOvbl9Ot4kTIX
	3vWIDke7t7EsRUzeoYngP4SuURDDlwG/eeg6HC2oKJOdj+TO0Apdq854Kcm1TVcx
	c9eQciPm3enJy6w6/tXcloW4VUBgp9RKHuFV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lVVO0U2dx6PdW5Ch3XGsfXUiZVrH5n+g
	wc0MMBBTlKfrpSiKabTlaetxMnY27tEheXCML7veadVuENxsRPIiLsxM+hq+zNg4
	nVNriqqJmnPiLoAkqjBwmngL8J4GmkIMZHxIIfoQY973bgXDcs8OYvBfM3jMlcZ2
	fsfdIi6QfSs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1707D1665C;
	Tue, 21 Oct 2014 13:24:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11D2516658;
	Tue, 21 Oct 2014 13:24:39 -0400 (EDT)
In-Reply-To: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
	(John Tapsell's message of "Tue, 21 Oct 2014 09:11:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 237BDA6E-5947-11E4-ACD5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Tapsell <johnflux@gmail.com> writes:

> Hi all,
>
>   Could we add a default to "--date" so that:
>
> git reflog --date
>
> just works?  (Currently you need to do:   git reflog --date=iso)  It
> should probably obey the default in log.date?

Hmph.  "--date=<style>" is not the way to choose between timed and
counted output in the first place, though.

In a similar way that "git log -g @{now}" and "git log -g @{0}"
switch between two, "git reflog @{now}" and "git reflog @{0}" have
been the primary way to choose between them.  Only because it is
clear that you want the timed format when you specify any date style
e.g. "git reflog --date=relative", we give timed output without
@{<time>/<number>} but that is just icing on the cake.

That at least is why things are the way they are.  And once you
understand the above, you would understand why "--date=<style>" is
not singled out as a useful option in the documentation, because
that is not a primary way to choose between timed and counted
output, but because it is merely a way to influence how times are
shown once you chose timed output.

Having said all that, I have a few comments:

 - Perhaps use of @{<time>} vs @{<count>} as _the_ way to choose
   between timed and counted output is not documented clearly enough
   to lead to such a misunderstanding?

 - Perhaps use of @{<time>} vs @{<count>} is a less intuitive than
   ideal way to choose between them in the first place?

 - Perhaps adding --date with no date-style specification as another
   way to trigger "You said 'date' so you must mean you want timed
   output" heuristics just like existing "--date=<style>" does may
   let us get away without answering the above two questions,
   sidestepping the issues?

I dunno.
