From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Fix interactive rebase when the editor saves with CR/LF
Date: Mon, 26 Oct 2015 12:13:23 -0700
Message-ID: <xmqqsi4xh298.fsf@gitster.mtv.corp.google.com>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
	<cover.1445782122.git.johannes.schindelin@gmx.de>
	<xmqqpp02kbif.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510261133030.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 20:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqnDM-0002bO-0t
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 20:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbbJZTNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 15:13:47 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751741AbbJZTN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 15:13:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5E60251C5;
	Mon, 26 Oct 2015 15:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Xg8seiH6v24h9ytr+89xxiMwF9k=; b=IIRLjLhu4wjgyjHXj8Z1
	TyTl5/BkjwEDLFYXWQGsxeklciuEKHdXC9nlVwSmxeeIOS2zEz3vePl/Kw0rLynh
	7bClCrGAT4uMoCC3/QgEXwW+kkZE61QEX8dTuiLxp97PMCO7onoaPbphDn7QpU1x
	W1AoBHeJvVumRxpOGERjntY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KnvuNhXyZ07uuXAilV9FOS3Hf4sZIhPk2ngY0+JcbIf1lV
	8CmbBPXUVAVzS9lNDWLcQqz4LNGShhuji+F+ae/G1+IPDeGZ+6ocyHALEfwWJ2Rj
	pHvdYSXAAoe/vVCCYOISFwiDIIne6B5daiR0FAktdTGrCt03VcLseju/mPNmA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD6B0251C3;
	Mon, 26 Oct 2015 15:13:24 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 31B10251C2;
	Mon, 26 Oct 2015 15:13:24 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A10D05A6-7C15-11E5-A04A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280208>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A simple test with CR/LF line endings in a script reveals that it is
> pretty solid:
>
> 	x=a
> 	case "$x" in a) echo b;; esac
>
> prints out 'b', as expected.

I do not see what this has to do with anything.

The shell language parser when parsing a script may do the right
thing, but the bug I was alluding to was that your 'read' does not
seem to be removing the terminating <newline> (which is CRLF on your
platform) after reading a line before splitting the contents on the
line at IFS boundaries.

> Again. If CR has no place in IFS, why does LF have a place in IFS? It
> makes *no* sense to argue for one and against the other.

See my message to Matthieu.
