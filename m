From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] die_with_status: use "printf '%s\n'", not "echo"
Date: Wed, 7 Aug 2013 10:58:24 +0200
Message-ID: <871u65yj0v.fsf@linux-k42r.v.cablecom.net>
References: <7vwqnyg10v.fsf@alter.siamese.dyndns.org>
	<1375813604-10565-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 07 10:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6zZe-0007Pn-Su
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 10:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151Ab3HGI60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 04:58:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:4660 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757220Ab3HGI6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 04:58:25 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 7 Aug
 2013 10:58:22 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 7 Aug 2013 10:58:24 +0200
In-Reply-To: <1375813604-10565-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 6 Aug 2013 20:26:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231812>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> At least GNU echo interprets backslashes in its arguments.
>
> This triggered at least one bug: the error message of "rebase -i" was
> turning \t in commit messages into actual tabulations. There may be
> others.
>
> Using "printf '%s\n'" instead avoids this bad behavior, and is the form
> used by the "say" function.
>
> Noticed-by: David Kastrup <dak@gnu.org>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
[...]
> +test_expect_success 'rebase -i error on commits with \ in message' '
> +	current_head=$(git rev-parse HEAD)
> +	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
> +	test_commit TO-REMOVE will-conflict old-content &&
> +	test_commit "\temp" will-conflict new-content dummy &&
> +	(
> +	EDITOR=true &&
> +	export EDITOR &&
> +	test_must_fail git rebase -i HEAD^ --onto HEAD^^ 2>error
> +	) &&
> +	grep -v "	" error

Umm, doesn't that only test that _some_ line in the error does not
contain a tab?

Whereas you need to test that _no_ line contains <TAB>emp, or some
such.  Perhaps as

  ! grep -v "	emp" error

> +'
> +
>  test_done

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
