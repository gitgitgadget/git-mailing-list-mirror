From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: make the ssh connection quiet
Date: Wed, 27 Oct 2010 15:35:41 -0700
Message-ID: <7v1v7bclhe.fsf@alter.siamese.dyndns.org>
References: <1288189628-4883-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?utf-8?B?U3TEmXBpZcWE?= <jstepien@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:35:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEb4-0005Ko-JZ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab0J0Wfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 18:35:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0J0Wft convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 18:35:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E05521137;
	Wed, 27 Oct 2010 18:35:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=uzfrr+cwmIxDiNE4FE915X6lg
	H8=; b=ykenYDXEoqJHGJ2eSamATld9ntlp05UlrWYQoYYChwlhmZYCSDIzyhTHH
	YAWhLy4UCdMLxK1jNmBafnURUjP/ox+UB0JppC/9fTUYbBajgT54GYRgmJoAALlD
	gu+tpmP+cgFlb46Wng+Y/F/ix6Pfel/8m+J2NAdyAq85aoZBMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=N4UpysvEBkcM+0NqzVR
	glLmikWWWem5tv3cSKR3DBilEA97KjNX5F7kKZBFyTn5ss9o26nqySClTMUccUBj
	jFz9Yb6KQGqiBL3pBkm0ZRUUkO+0fymbIB4AS0h3A4tuH7av0H/OlnDt0Nlr4yov
	PgFK6XLnSDLWOuZ13tHLPCyI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC9711122;
	Wed, 27 Oct 2010 18:35:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D78E111B; Wed, 27 Oct
 2010 18:35:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A0B965A-E21A-11DF-926B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160129>

Jan St=C4=99pie=C5=84  <jstepien@users.sourceforge.net> writes:

> The --quiet option passed to fetch-pack did not affect the ssh child
> process. When an ssh server sent a motd it was displayed because the =
ssh
> client wasn't launched with the -q option.

This is curious for a couple of reasons:

1. "-q" option to "ssh" is not meant to supress "motd"; it is about
   warning and diagnostics.  From man ssh(1):

     -q Quiet mode.  Causes most warning and diagnostic messages to be
        suppressed.  Only fatal errors are displayed.  If a second -q i=
s
        given then even fatal errors are suppressed, except for those
        produced due solely to bad argu=E2=80=90 ments.

2. "PrintMotd" defaults to "yes" but it is to specify whether the daemo=
n
   should print /etc/motd when a user logs in interactively.  I didn't
   think fetch-pack logged in interactively, so why should this matter?
