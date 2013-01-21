From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 11:12:44 -0800
Message-ID: <7vwqv6fiz7.fsf@alter.siamese.dyndns.org>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
 <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMnt-0001ac-Gt
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab3AUTMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:12:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326Ab3AUTMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:12:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E897FACCB;
	Mon, 21 Jan 2013 14:12:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RGbMK7JOJnCb7QsVsA18GUEnpMg=; b=yQAO9J
	Ipk5jlpUsqAF8548BZ1VUpUzkSFNmF1YK+bC6loaDz1Ta4vQTgiKRfa2PSiEod+U
	f15v8xegdCOMN/p+iguU8fWidFZs2K+31cjYEFoDikyr8YgfAYXx0YlnQrNazCyA
	azTP/dNu7nKiXYNH4G3dFCaHbo5SXYVnrdjP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LTIwivqL6EtwU3Vfnl/UlQrCwhydvFDQ
	uu2R+s+b8VMk9T+ZpiPW8zRlbAheBxqLUS9tQFqSJ9jUJM2VZ6P92zjRhAD0vK1J
	/wgpPXMF06C8+a8qv0owh7xDPz6GrTA4wZdoOGcQ514HrNSguqYzsGwo7Oat9fny
	ElGDWqo91Ps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC161ACCA;
	Mon, 21 Jan 2013 14:12:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67E5BACC8; Mon, 21 Jan 2013
 14:12:46 -0500 (EST)
In-Reply-To: <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 21 Jan 2013 13:00:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A1E771C-63FE-11E2-84F8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214145>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Most git commands that can be used with our without a filepattern are
> tree-wide by default, the filepattern being used to restrict their scope.
> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.
>
> The inconsistancy of 'git add -u' and 'git add -A' are particularly
> problematic since other 'git add' subcommands (namely 'git add -p' and
> 'git add -e') are tree-wide by default.
>
> Flipping the default now is unacceptable, so this patch starts training
> users to type explicitely 'git add -u|-A :/' or 'git add -u|-A .', to prepare
> for the next steps:
>
> * forbid 'git add -u|-A' without filepattern (like 'git add' without
>   option)
>
> * much later, maybe, re-allow 'git add -u|-A' without filepattern, with a
>   tree-wide scope.
>
> A nice side effect of this patch is that it makes the :/ special
> filepattern easier to discover for users.

Nicely explained.

> The first step should look like this patch. The message remains vague
> about the next steps ("change in a future Git version", no mention of
> the exact change nor of the exact version in which it will happen),
> but I'm fine with refining it (perhaps this could be a 2.0 change,
> like the change to push.default?).

I think rolling big changes line these to a single version bump
would make sense, if we were to do it.

I have to wonder if "git add -p" and "git add -e" are the ones that
are broken, and the migration suggested here is going in the wrong
direction, though.  After all "add -p" and "add -e" are interactive
by their nature, so it is a _lot_ easier to change their default
behaviour in the name of "usability fix", "consistency fix", or
whatever.  Wouldn't we achieve the same consistency across modes of
"add" if we made them relative to the current directory?
