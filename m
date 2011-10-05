From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 15:56:38 -0700
Message-ID: <7vaa9f59p5.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 00:56:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBaON-0006w5-EV
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 00:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935513Ab1JEW4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 18:56:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934900Ab1JEW4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 18:56:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71435415;
	Wed,  5 Oct 2011 18:56:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oqZmkAILAvOVCNlt9ZD9diJeF4s=; b=dNlsIt
	DTxSP2WB2L09yBwHV6VKzIitAfyN3Mkp1uEDBqzICeuOWP4xahqQHzET9AA4LV5l
	f2swDUSz+X8hCElDO+fio93Iy0j/W36xkVCMP8HVVZHzriSGllhZY4GsaEsoDW/Y
	HaAEBEx2Jci+0ZXVKqog9ZefjQlirqJQ6+1hA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J6ytmxPri3Ia2GngSSRF3EfFeDGOuxlh
	KhRuUFLXsmeCC+awyxXfQGRmiSQLL4WvoL5wLYdRZaUmWs05+mP67cLaX8UXyuTG
	/bFhECwQRd5mppBZU7L8QHN1GSJoC6ejc/GK1CxZArCcDy9NWp+4kZaSHVWib3m6
	g6acuWHGsnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E00C5413;
	Wed,  5 Oct 2011 18:56:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3252F540B; Wed,  5 Oct 2011
 18:56:40 -0400 (EDT)
In-Reply-To: <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 6 Oct 2011 09:47:11 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49755A7E-EFA5-11E0-BEAF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182900>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 6, 2011 at 5:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I do not necessarily think that it is a good approach to forbid the same
>> branch to be checked out in two different places, by the way. One reason
>> people would want to keep multiple workdirs is so that while they are
>> still working on a branch and are not yet at a good "stop point" to even
>> make a temporary commit to get interrupted, they find it sometimes
>> necessary to be able to build the tip of that same branch and even make a
>> small in-working-tree fixes (which later will be carried back to the
>> primary branch). The problem arises only when one of the repositories try
>> to update or delete the branch while it is checked out in another working
>> tree.
>
> I think of two options:
>
>  - detach from the already locked branch (pretty much like what we do
> with tags now)
>
>  - refuse normally but let "checkout -f" do it anyway. However the
> checkout lock will remain at the original worktree. If you want to
> update branch from the second checkout, do "commit -f" and take
> responsibility for your action.

Sorry, what problem are you trying to solve? Does that "checkout -f" meant
to nuke the local changes that are not yet at a good "stop point"?
