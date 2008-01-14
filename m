From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit.c: remove useless check added by faulty cut and paste
Date: Mon, 14 Jan 2008 13:54:11 -0800
Message-ID: <7vsl10hy4c.fsf@gitster.siamese.dyndns.org>
References: <7v8x2uqabt.fsf_-_@gitster.siamese.dyndns.org>
	<200801142128.m0ELSBoE030025@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:55:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEXGs-0003oM-FP
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 22:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbYANVyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2008 16:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbYANVyZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 16:54:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788AbYANVyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2008 16:54:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BF94B21C4;
	Mon, 14 Jan 2008 16:54:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DA191F32;
	Mon, 14 Jan 2008 16:54:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70483>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> You are calling overlay_tree_on_cache() which does use CE_UPDATE flag=
 to mark
> duplicate entries.  And that is the same algorithm as used when git-l=
s-files
> is called with its --with-tree option.  I think this if statement is =
not
> mindless but is the right thing to have the same logic as you have in
> git-ls-files.

You are right and I was stupid.

Because the pathname ce->name is given to path_list_insert()
which does not allow duplicates, there is no breakage either way
from the correctness point of view in this codepath, unlike the
one in ls-files.  But avoiding unnecessary processing with a
single bit check is certainly better.

Will revert, but I first have to go find a brown paper bag.
