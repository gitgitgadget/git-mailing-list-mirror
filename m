From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t3404: restore specialized rebase-editor following commentchar test
Date: Sun, 11 Aug 2013 23:28:02 -0700
Message-ID: <7v4nav1kzx.fsf@alter.siamese.dyndns.org>
References: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
	<1376280459-55188-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 08:28:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8lbw-0004kg-Hh
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 08:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab3HLG2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 02:28:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48540 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755862Ab3HLG2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 02:28:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6511C33179;
	Mon, 12 Aug 2013 06:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nhiS55/slaVBKMXp3NlwNChE1LU=; b=XW/FIs
	MCkZCfERpjFdeYlNUfkwTIO1BSuA8TwGacCpxP6y/ga2HNzhmcTdNvzhzQV5R8dp
	OnmX+6sa1Gm3BGVe5yoYd4gAnMdq1XbANi2gwqhfXmwfBNLMFkOAYUW+nQF1pVqt
	trWvB/N1NWFdFEjwoVscFLUCa3g+XmJ661U7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a3KLcZArJBBavP662I5BU5XwfWJ0ITTf
	BFU288ARBhlVAsjYpfojw6TdhaAbCxB8mcR9rziFeeMwba/OLgAbmhYJko6z/TPx
	IoaEiEPraIYUMZEDFBgPLuMQunqtn6UkVvzQbttEYc7LuqfVAZoiWFX70Uwrog9F
	CXpsJLom6Ww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 577A833177;
	Mon, 12 Aug 2013 06:28:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2945F33174;
	Mon, 12 Aug 2013 06:28:04 +0000 (UTC)
In-Reply-To: <1376280459-55188-2-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Mon, 12 Aug 2013 00:07:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 580F193E-0318-11E3-9DB2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232158>

Eric Sunshine <sunshine@sunshineco.com> writes:

> At start of script, t3404 installs a specialized test-editor ($EDITOR)
> upon which many of the interactive rebase tests depend.  Late in t3404,
> test "rebase -i respects core.commentchar" installs its own custom
> editor but neglects to restore the specialized editor when finished.
> This oversight will cause later tests, which require the specialized
> editor, to fail. 

That is not oversight but was deliberately done knowing that it will
be the last test (and new tests can be added before it).

I think the patch is one way to give _known_ status to later tests
by declaring the editor installed by "set_fake_editor" the gold
standard, but isn't a better alternative to make sure that any newly
added tests after this point (or before the commentchar tests, for
that matter) set a fake editor it wants to use explicitly?

> (There are no such tests presently, but a subsequent
> patch will introduce one.)  Fix this problem.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t3404-rebase-interactive.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 49ccb38..af141be 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -949,6 +949,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
>  	mv "$1.tmp" "$1"
>  	EOF
> +	test_when_finished "set_fake_editor" &&
>  	test_set_editor "$(pwd)/remove-all-but-first.sh" &&
>  	git rebase -i B &&
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
