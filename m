From: Junio C Hamano <gitster@pobox.com>
Subject: Re: $GIT_CONFIG should either apply to all commands, or none at all
Date: Thu, 02 Oct 2014 10:51:05 -0700
Message-ID: <xmqqppeanywm.fsf@gitster.dls.corp.google.com>
References: <20141002001034.24160.11848.reportbug@fabul.fbriere.net>
	<20141002011546.GR1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 19:52:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZkY3-0001U4-Rl
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 19:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbaJBRwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 13:52:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55295 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbaJBRwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 13:52:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A3583E228;
	Thu,  2 Oct 2014 13:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EHFyVa1SdLdnOa8UKmb3LfvQpM4=; b=NcR9vQ
	kPymi5CzlIqlVtVI27FwWRNSDIlekpVmLH6U7miD4s4ryS5kXsOfbWOxbG2Mwxbj
	3yqtYipILoL7V+UmqHB4AWsG2NVuEHZk+3UD95TQ2x+w4/+DQqlPm9WRN14Xl9ox
	cKH1OjK1wUEg4bVNxxRl46ORNTaSGw8FV6FLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SeKmyXzLiLxaBxHl2D5cR0UB9QZhp9lr
	dCwyGpet7v8t+oFRXElt8+yv/4c5TZM5+IufoLvBAwIFA7lDzXr8BquaODpqxrj2
	cc2KDRHhmogoiv7DuGa0MQs9St25zV8045TBWeO4cjW8QBPv+vKgTypAsVd96rsd
	ifgLIwC87Ms=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2115F3E227;
	Thu,  2 Oct 2014 13:52:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 398213E1F8;
	Thu,  2 Oct 2014 13:51:08 -0400 (EDT)
In-Reply-To: <20141002011546.GR1175@google.com> (Jonathan Nieder's message of
	"Wed, 1 Oct 2014 18:15:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0414C58-4A5C-11E4-8F40-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257815>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yep.  One possibility would be to do something like the following (A):
>
>  1) advertise in the git-config(1) manpage that the GIT_CONFIG
>     environment variable only affects the behavior of the 'git config'
>     command
>
>  2) introduce an environment variable GIT_I_AM_PORCELAIN.  (If doing
>     this, we could come up with a better name, but this is just an
>     illustration.)  Set and export that envvar in git-sh-setup.sh.
>     When that environment variable is set, make git-config stop paying
>     attention to GIT_CONFIG.
>
>     That way, git commands that happen to be scripts would not be
>     affected by the GIT_CONFIG setting any more.

At the places you plan to update porcelains to set and export
GIT_I_AM_PORCELAIN, you could unset GIT_CONFIG if set.  Would that
achieve the same goal?

And you can stop there without doing 3 or 4, no?
