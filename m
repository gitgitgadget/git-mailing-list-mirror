From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] git-rebase--interactive.sh: look up subject in
 add_pick_line
Date: Sun, 22 Jul 2012 13:51:31 -0700
Message-ID: <7v4nozr030.fsf@alter.siamese.dyndns.org>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
 <5009135C.208@viscovery.net>
 <CAOeW2eHeySzEzj_8BByuz4jrc_CreLtZpTshcYsTxqBrtxyg0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Git <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 22:51:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St37t-0002U9-Dc
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 22:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab2GVUvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 16:51:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab2GVUvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 16:51:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FC6087AB;
	Sun, 22 Jul 2012 16:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DOv9rJWPtuAQVWYPl9snbsezgoQ=; b=ERYenj
	iUBhLp9BgNICBIisvgnzKtUPOzgAwaNLvU8a5EvF3GVsTLuKGbYUpVHUdZBOn2Sd
	QF3s+sskQfJQPePuNmNqaIuivKpxCx75B1AD9SM5FecvUC0rMMRA7UkqqDsYlvA+
	44CwW/Uj1hIz3+oYomeMwydI99NH9L6QT2l+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fFDonutFHxG8yJwV5/EWd26aPQ/KTKGA
	hWYOe7tE/OholgGYgE2oRGQk8kjdmHd23yuIGsEzDlMtoFgSIK1N2e2TvzFMC3yE
	ZGWDoatM0x3w/fm9W8O2dBE//FSOO19Bs46e0uBEvRHo7v5Lk3o/CoM2COs07FCz
	UZzXm+O4v8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D66C87A9;
	Sun, 22 Jul 2012 16:51:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14CEA87A8; Sun, 22 Jul 2012
 16:51:33 -0400 (EDT)
In-Reply-To: <CAOeW2eHeySzEzj_8BByuz4jrc_CreLtZpTshcYsTxqBrtxyg0g@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 20 Jul 2012 08:47:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05AAD2CC-D43F-11E1-8B31-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201861>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> After patch 7/7, cherry is used instead of rev-list. Ideally, I would
> have liked to teach "git rev-list --cherry-pick" to somehow use a
> <limit> just like cherry does, but I couldn't think of a generic way
> of doing that (in this case, we want to say something like "range
> a..b, but drop commits that are equivalent to any in b..c"). I
> actually don't remember if I gave up because I couldn't think of a
> sensible way of specifying ranges like that, or if I just ran out of
> time (not familiar with the revision-walking code).

Why not use patch-id output instead, then?  Grab patch-id for
commits b..c to make a mapping from patch-id to commits, do the same
for a..b and use the mapping to filter?
