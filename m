From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases with
 symlinks
Date: Sun, 19 Sep 2010 11:17:28 -0700
Message-ID: <7vd3s9y4w7.fsf@alter.siamese.dyndns.org>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <vpqhbhmx6tg.fsf@bauges.imag.fr> <7vpqwa254i.fsf@alter.siamese.dyndns.org>
 <vpq8w2yt8hc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 19 20:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxOSg-0005wS-Hh
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 20:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab0ISSRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 14:17:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab0ISSRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 14:17:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94C81D7697;
	Sun, 19 Sep 2010 14:17:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d0yu/c4stL0iqSyCHepG/JeiJsM=; b=tHyOlw
	B0162v6Q9aEqvBd7lsu3A19sW7n4mtyPeftPKMRcB51joWH0VDKfpcAwZKyKfUK7
	FL4nbU/NaZWZlUpblEWkDlw0js4N0QZX0Z7qOU1MgWdglA1wkHfvhOzZUGJDNNsn
	oDxCEuq8AUpXhvSxOPQPdQKn4a2RE5hRxC/I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoVdbqCS9w8kPENb5IcR/zP8eSqEDysE
	LnlqbpJCe1qyrCNskPalcdGnk9Ze8yh58p8ZiMoPnvvPLGlI3ftnihO0FJLIh1lO
	0P16Gk8o3/xcHgtW6Vrs50+1q0j6aN45evBEb0P7lW+sU24LR/kaVA9gP7EDATR2
	9MFtdeGtUxM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 197C3D768B;
	Sun, 19 Sep 2010 14:17:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D704D767C; Sun, 19 Sep
 2010 14:17:30 -0400 (EDT)
In-Reply-To: <vpq8w2yt8hc.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 19 Sep 2010 10\:58\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2EF9F8F6-C41A-11DF-BB4D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156505>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> That said, if you changed a symlink from pointing at A to pointing at B,
>> it does run the textual diff between the string we get from readlink(3).
>
> Yes, and my question was to make sure we don't run the textconv filter
> on these strings.
>
> I've just checked, and from my little tests, git diff doesn't try to
> textconv the pathnames, it runs the textual diff without textconv,
> which is the expected behavior.

Ok, then I think it makes sense to make sure we don't run the textconv
filter on them.
