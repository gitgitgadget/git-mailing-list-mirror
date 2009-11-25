From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 11:32:44 -0800
Message-ID: <7vr5rmwgbn.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:33:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDNbx-0003Tm-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 20:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759586AbZKYTcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 14:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759583AbZKYTcp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 14:32:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759577AbZKYTco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 14:32:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 536EEA1142;
	Wed, 25 Nov 2009 14:32:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Ztuxs9zQ7QlJYSRrfDTogK0+Jxo=; b=BsVZq9JmDMBGI15yiXF2YrL
	LnOoFrv9pAJrVPukVoHYozy+bS83fY6GCsfneMTf7S1Kq8jIW0D8jh4TzWPXphjZ
	OW9LhYrT+bBPlAMh2H7Ky4idZEOg+VLbNTAUVYCiiyphVYtb9ywFbAtM3e/puPp5
	l7aGBJtqNv4A1TIkkHJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=e6d9SdgyQktJXEzEoMY0IDYhOWkku1fMw6917v6WSSxsihIo7
	pcnUL5vsa//tE2A9GJkp9I5l4fXLNWe5vOauBRVeQRd9ahEKhBKSq/7wVCffgBrx
	1SGgJprQXEPRZwSWlUZW9R0yEZKGyXhivtrtteST3xTgXT82CvfOTNf3VA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FB53A1141;
	Wed, 25 Nov 2009 14:32:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2C998A113D; Wed, 25 Nov 2009
 14:32:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50B0AD3E-D9F9-11DE-A77D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133662>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I almost always want only results from "app/soc", so when I run git
> grep I do so from within "app/soc" to make sure I don't get false
> positives from the many external sources we have.

The standard answer given by others has been "you can always say '.' at
the end; having to remember/count number of ../ necessary is much much
more inconvenient".

> PS: I don't mind having to set a config variable to keep the current
> behavior though.

I've thought about it for five seconds before sending my patch, but
discarded it, because I do not see it as a good transition plan.

If it were something like "git-push", that is a purely Porcelain for
causing _effect_ to outside world, the customizable behaviour of the
command depending on which repository it is run is excusable and may even
be beneficial.

But if a command like "grep" that "does one small thing and do it well"
changes its behaviour drastically depending on a config variable or an
environment variable, it won't be a command that you can rely upon any
more in your scripts and hooks.  It's the same insanity as GREP_OPTIONS
environment variable.

So this change, if we were to do it, unfortunately has to be "we do it
once and for everybody" a flag day event, I think.  That is what I am not
enthused about this patch.
