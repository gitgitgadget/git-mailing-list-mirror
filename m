From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 11:35:16 -0800
Message-ID: <7vsjhlsetn.fsf@alter.siamese.dyndns.org>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
 <jj5ih2$f0m$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
To: Jerome Yanga <jerome.yanga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:35:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S50AU-0002Lb-LH
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250Ab2CFTfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 14:35:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758586Ab2CFTfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 14:35:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36E856141;
	Tue,  6 Mar 2012 14:35:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BgbYiqEkhn9e97SE8awEy96Itek=; b=tVljOK
	0/8eHjiH7Q/qtEMPzWUc1YHI3rP1p+W8JYGnngq9HQkKbiAqWLIhOLPTZSRJEMYN
	Kjphid8hDYBC/caDoIGzqeKEvCKl37RDxw2Stx7iaIj6fS187GUSW5JjH4T6TpbB
	eT1c0qV44ASOvVD3tU+bKi2dldBvTtn0oQB88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fqb9NIYzdXy9khU8rZVRue6LWhU+S+0j
	zR/QmXASlXcCVEILIJP4vr9YuCyvtEvNB3LcjNurmTUFIkPb7URcjOj6OPFm+8df
	3q4IiLZYVDC9ZWaGzRXtpNS1P7c94HevqteFTJHK+iuPTVDL+cOe4t/CS3T3zYus
	O2oVca7NpaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1646140;
	Tue,  6 Mar 2012 14:35:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B66F2613F; Tue,  6 Mar 2012
 14:35:17 -0500 (EST)
In-Reply-To: <jj5ih2$f0m$1@dough.gmane.org> (Ben Tebulin's message of "Tue,
 06 Mar 2012 18:46:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80F41FEE-67C3-11E1-9242-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192379>

[jc: resurrected JY as recipient]

Ben Tebulin <nntp.20.jexpert@spamgourmet.com> writes:

> You can only push to "bare-only repositories". These do not contain a
> working tree but only a .git directory.

That's a bit too strong. You do not have to limit your "push" into
"bare repositories" (drop "-only", there is no such word), but it is
perfectly fine to use "push" as a way to emulate a "fetch" that you
would wish you could but you cannot in the opposite direction.

What "push" does not do is to touch the working tree, and this is
intuitively understandable once you realize that "push" is an
opposite of "fetch".

> My push seems to be successful too using the command below as I get
> the message "Everything up-to-date".
> 
> git push

It is somewhat strange that this _succeeded_.

When pushing into a repository with a working tree (i.e. "a non-bare
repository") and especially when trying to update its current branch
with such a push, "git push" would by default be refused, unless you
tweak a configuration variable or two on the receiving end.  That is
an expert feature and I do not think that is being in use in this
particular scenario, so perhaps the push did _not_ succeed to update
the branch Jerome thought it updated, but instead updated a branch
that is _not_ the one that is checked out in the repository on the
receiving end of this push.
