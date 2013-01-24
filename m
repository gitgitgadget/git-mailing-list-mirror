From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9902: Instruct git-completion.bash about a test mode
Date: Thu, 24 Jan 2013 14:29:33 -0800
Message-ID: <7vlibi8baq.fsf@alter.siamese.dyndns.org>
References: <201301242220.09067.jn.avila@free.fr>
 <7vtxq68day.fsf@alter.siamese.dyndns.org>
 <201301242304.16078.jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Thu Jan 24 23:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyVJ1-0005KQ-E1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 23:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686Ab3AXW3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 17:29:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab3AXW3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 17:29:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C18BEC867;
	Thu, 24 Jan 2013 17:29:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F0C9coqDcLHb
	2tG+SIBmG/fsnug=; b=db5C1bt+HryTZBOdku/XktMfbZVUM/eU0iIhwxRGA1VR
	UArAiVMaYepThLZ8zjRmQdPuZj0AoSLzsur5iLmowLsyoR7lmuh0ykjALA5GoOKT
	eXWq5jlYRG4CEzeOzDcFGU3abxX6rhqEOqZbRQcT+TOxqyuifqrXZGCrwxzRSnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EFBh9G
	D72GqDmP5pezI9LEn7etdJWjRzEN2w9gRVBRtpp+Rzrv0YCQTWL8mxRFOOIGHzMo
	83x1IxpR/P2gdRVABRH51nQ1UGoHTa0XW2TtAbf6YoXmL9y9WH2uYY969Fhqu4MV
	MsMZTSqtc+2gX0qWWvV6IK9v3D1m7Sf6NrQWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B100BC866;
	Thu, 24 Jan 2013 17:29:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14A95C85F; Thu, 24 Jan 2013
 17:29:34 -0500 (EST)
In-Reply-To: <201301242304.16078.jn.avila@free.fr> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Thu, 24 Jan 2013 23:04:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87D9C488-6675-11E2-AB84-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214466>

"Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:

> My rational was to be sure to put the environment variable out of the=
=20
> way once the script has been sourced. I can make two alternative=20
> definitions of __git_list_all_commands () depending on the presence o=
f=20
> $AUTHORIZED_CMD_LIST if you are worried about performance.

Actually, it does not matter, as once __git_list_all_commands is
run, its result is kept in a variable.

So Peff's

  if test -z "$FAKE_COMMAND_LIST"; then
          __git_cmdlist() {
                  git help -a | egrep '^  [a-zA-Z0-9]'
          }
  else
          __git_cmdlist() {
                  printf '%s' "$FAKE_COMMAND_LIST"
          }
  fi

would be just as simple if not simpler, does the same thing, and is
sufficient, I think.

The t9902 test is only interested in making sure that the completion
works, and we do not want "git help -a" that omits a subcommand from
its output that is not built in your particular environment to get
in the way, which will not be an issue with this approach.
