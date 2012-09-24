From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 07:36:10 -0700
Message-ID: <7vipb31o9x.fsf@alter.siamese.dyndns.org>
References: <5060097F.9050203@drmicha.warpmail.net>
 <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG9ny-0002eu-0d
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab2IXOgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:36:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519Ab2IXOgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:36:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C666D91C5;
	Mon, 24 Sep 2012 10:36:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wo+ijgbMYU97hmw6AOjv/FbyYF8=; b=paSnhx
	nRPCIkcXVi9sYAYdxSqVR7udSYuRykE0RIRjk1vIJDdFfx05UVTLUL6don2NbYik
	B8LsbQXGNtbVuqNerJOpPXuGO3Tk6G8araSItBKxq8+C3rfnmI96ptdG0a2NhokK
	JVSekH1TWBiRaMI65uSrw0r+dE32gibH+iP2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=taBUZRT5oFrDgb+sY+4bkEPUujkA8mFZ
	9GKWjO0PKq2BNR+UK/hh833hbkfvEzzj7sIZUNNg/OR43/J8WgbdgTA8Y5uPeAAB
	DMrK4a4/Bz0W1MpABojBrYp7KP0XlNlRlsYxuLAq/7OyCwWmDmFOQ4WdC/k3Qa5U
	qSFzXFDDq2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B32DE91C3;
	Mon, 24 Sep 2012 10:36:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3405D91C2; Mon, 24 Sep 2012
 10:36:12 -0400 (EDT)
In-Reply-To: <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 24 Sep 2012 14:41:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3005C4BC-0655-11E2-9E57-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206276>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> "~" is a shell feature. Know your shell. If we make an exception for
> --git-dir, we might have to support --blahblah=~/somewhere.

Correct but not entirely true.

When we know --git-dir=<path> must name a path, we should be able to
do better.  See OPT_FILENAME in >parse-optios.h>, for inspiration.

MJG's patch later in this thread is conceptually OK but I do not
think it should introduce a "expand and then setenv" helper that
won't be useful unless the variable is GIT_DIR.  That pattern does
not appear that often, and smells like a bad API design taste.
