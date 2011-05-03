From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Tue, 03 May 2011 12:00:30 -0700
Message-ID: <7v7ha7ip81.fsf@alter.siamese.dyndns.org>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <FB837238-9953-4FD8-BC52-5C0AB061C291@gmail.com>
 <4DBFA1A2.6050409@drmicha.warpmail.net>
 <86404CD9-6040-4083-912F-23F4C11F4ED2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHKq3-0003gz-Pp
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 21:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab1ECTAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 15:00:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab1ECTAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 15:00:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 317253ECB;
	Tue,  3 May 2011 15:02:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfF6f+PP8wNfa2ykExFQPx30Lsg=; b=KTHhGg
	TsBCkKOXMa24tXaZKhC1CwmdhnjjEWM8j4EdlLCrD9XjAhzNySTi2+Gi98qBTYSP
	l7wsftt2VWTvNnu9Nm9UK4+GcBI77xpYW78EQjkXX2mYQLeN0Z9XGXV11VuBBL4T
	k016THpU3RRKQPCFoGZislKeyqgqTj/1wKU8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykFkFuo67vN6N9wgmK/A4dr3o8fKLbc0
	iMsMZjl1wFk/b3efVG7yuzXpQrsX58Z1aNig2keXwF3Uf8i9FXDrmGPAJlmTrwml
	vUZdi2fMON1u2VsGkSFSPitdaxSP0L2mazxCvPG3VUvYAyA+fjtIeV/aC259PGtN
	ADm2NnW1MPY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2A3F3EC8;
	Tue,  3 May 2011 15:02:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9EEED3EBF; Tue,  3 May 2011
 15:02:35 -0400 (EDT)
In-Reply-To: <86404CD9-6040-4083-912F-23F4C11F4ED2@gmail.com> (Joshua Juran's
 message of "Tue, 3 May 2011 01:17:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAC06A26-75B7-11E0-9277-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172684>

Joshua Juran <jjuran@gmail.com> writes:

> My recollection is that Metrowerks C will statically allocate read-
> write storage (duplicating the read-only copy of the string) and copy
> the string into it at runtime.  It only copies the string once, which
> is ensured by checking an internally generated flag (also statically
> allocated) every time the scope containing the declaration is
> executed.  This is the pessimization I speak of.

That's a stupid compiler, isn't it?  Doesn't it pay attention to the fact
that the static char string in the function scope also says "const"?

A sane compiler would store { 'H' 'E' 'A' 'D' '\0' } five bytes in a data
segment (preferrably ro), give it a label and turn its assignment to and
comparison with "next" and "this" to a reference to that label address,
and all can be resolved by the linker.  Your suggestion will give a
compiler an excuse to allocate an extra pointer variable to hold that
address in addition to that, espcially if you do not say const twice.

Of course the extra pointer could be optimized away if you follow the data
and if the compiler does so we would get the same code.
