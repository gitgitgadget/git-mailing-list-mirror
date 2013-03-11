From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH
 compatibility
Date: Mon, 11 Mar 2013 11:09:17 -0700
Message-ID: <7vwqtd95bm.fsf@alter.siamese.dyndns.org>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v38w1c3ms.fsf@alter.siamese.dyndns.org> <513E0FB4.40607@gmail.com>
 <7v8v5talzu.fsf@alter.siamese.dyndns.org> <vpqppz5u8te.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Manlio Perillo <manlio.perillo@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 19:09:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF7AR-0002kn-R8
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 19:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab3CKSJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 14:09:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247Ab3CKSJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 14:09:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B0DA66C;
	Mon, 11 Mar 2013 14:09:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Au19irVpQ1YvSVpnVCofk9vkD5I=; b=N86TRj
	U3aKUvoZo42NMQ3wNpspR82yUWa2DwjFEAbKwzSa/dsDvyUxsjqtyeIVZhtgRIyO
	oMj7ihVdCbE3WMQEjMRLxbMtg5j5r5E/YJwtXjyLCrVgEOMn5Ud4Uv8IJ7mZs2Ru
	DmCGSsdcqFE7iUMzvJlmBJa0N3rKWCM2U+Yu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I+0TT7zNPvXa2Ix/N9tV+ZcoImlEI+pz
	DBnxlkPvavrGO+9V308FPVRg91bs6RzCkJrG0iJugdxcep0bL7VtJfs2ZUZ0V0tf
	cyb70T4GH4BeOUFFzbWgTvm35drnjPvrzB9bKvabHxwLaFg8DpFsArkv8pHh2Yx/
	1X8h1AR9sdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 476C3A66B;
	Mon, 11 Mar 2013 14:09:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1B89A669; Mon, 11 Mar 2013
 14:09:18 -0400 (EDT)
In-Reply-To: <vpqppz5u8te.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 11 Mar 2013 18:48:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAC7359E-8A76-11E2-9959-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217897>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ahh, thanks for reminding me of this.  You are right; these two
>> functions are broken when the user has CDPATH set, I think.
>>
>> Here is a reroll.
>
> Thanks. Even nicer that the previous since the CDPATH implied the
> subshell anyway.

Actually, "cd", not CDPATH, is what implies that the caller must be
calling us in a subshell, e.g.

	result=$(__git_ls_files_helper dir/ args...)

Otherwise the user's shell would have been taken to an unexpected
place, with or without CDPATH.

So strictly speaking there is no reason for an extra subshell here,
but writing this in the way the patch does makes our intention
crystal clear, I think.

In any case, let's queue this fix for the 1.8.2 final.  The CDPATH
thing will affect not just zsh but bash users.
