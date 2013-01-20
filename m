From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Sun, 20 Jan 2013 10:53:09 -0800
Message-ID: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
 <vpq622s9jk1.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	git@vger.kernel.org, Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:53:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx01Q-0004RD-ET
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3ATSxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:53:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab3ATSxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:53:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62B47A3D7;
	Sun, 20 Jan 2013 13:53:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZhwEv4tVF4J38VdcBdTvkCcKPI=; b=bpLjlk
	M7DlTLuQ35xWByApe/MXJAmlM6BajBYra10pP5paZDFKFJmJaHv4f7ffkS1/Qq5+
	PblvmkRiS1C12eVg8mMmJPgGYmP1vh/Lwkj99wS3M3bc9wn+Dr//h2gIYNuKRCqC
	sAWNSfHEyzdVU9NAAEKOyqdO+5OxtdVs4J2QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QzwZxdsOCoiXLsaQpf5TRb3SSy2m6+r3
	2qpPTQPeGYeU4xfIOb9mq0+ISgcQ+QzPy8Uk2QZ5T4xq2eXaWOvHDNwYzc74dlZ/
	RxoTdxz+ga2R+be8sYUiYqNvacSHdTPjlsW6kkwN8C36ErpawW7qFKofm1RDxmoh
	JiAYmu2y/Es=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 581B0A3D6;
	Sun, 20 Jan 2013 13:53:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E135FA3D5; Sun, 20 Jan 2013
 13:53:10 -0500 (EST)
In-Reply-To: <vpq622s9jk1.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Sun, 20 Jan 2013 12:32:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A308BBD8-6332-11E2-AD45-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214030>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Implementing "git rm -u" as a tree-wide command would create a
> discrepancy with "git add -u". Implementing it as a "current directory"
> command would make the migration harder if we eventually try to change
> "git add -u". Perhaps "git rm -u" should be forbidden from a
> subdirectory (with an error message pointing to "git rm -u :/" and "git
> rm -u ."), waiting for a possible "git add -u" change.

Yeah, that sounds sensible.  Start with a "'git rm -u' is forbidden
without arguments", give advise to use either "." or ":/".  And stop
there.

The first step of "git add -u" migration plan would be to warn when
no argument is given and update all the existing index entries, and
give the same advise to use either "." or ":/".  Keep this for three
cycles: 3 * (8 to 10 weeks per cycle) = 27 weeks ~ 1/2 year.

The second step would be to forbid "git add -u", and keep the
advise.  That will make it in-line with "git rm -u".
