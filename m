From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff bug?
Date: Thu, 06 Jun 2013 15:17:02 -0700
Message-ID: <7v4ndayjdt.fsf@alter.siamese.dyndns.org>
References: <CANd8icJ_1mqT9m-n3wPPdjzG1oNjwxfQeUA6YL6KVxbq0iEa1g@mail.gmail.com>
	<51B10236.2030009@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sarma Tangirala <vtangira@buffalo.edu>, git <git@vger.kernel.org>
To: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 00:17:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkiUg-00078F-7O
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 00:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab3FFWRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 18:17:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab3FFWRG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 18:17:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2030A26495;
	Thu,  6 Jun 2013 22:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Kju2Ox94ENBG
	8zaE09ZTVooMWfo=; b=LX5g9dVocH+Nn5KY+6ypLpZ0uu0OS1M4/JHwVAgxyuw1
	h404JkQnNEJroP0J5Wy9Mc/Ky+EUeitZ5GTtfmN/q1tDDZzLlz4cPZtpRfqm4oJS
	u0prnASbqGLdD2FF/KjRCYLuHWhkMdcpkSc2ASL93Q9tffbKBHZQUMXe3FxDm74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S6u5Sh
	PUIhPmjmogFP3TypzPahMKXqlbfBlEurBm5uWhd11yAlssM8Zh3lmri19VcCC0Np
	A5VUG0Jm9bZvST8x3JSVpRksfr7auoOFXSpgwbx2MwBi4E7Wkqe13vXyfC9XmtCl
	gDo2wHeTgHLc9uaRRAJp+EmT2D/sZUdlSBwg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1323F26494;
	Thu,  6 Jun 2013 22:17:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7069D26492;
	Thu,  6 Jun 2013 22:17:04 +0000 (UTC)
In-Reply-To: <51B10236.2030009@ensimag.fr> (=?utf-8?Q?=22C=C3=A9lestin?=
 Matte"'s message of
	"Thu, 06 Jun 2013 23:42:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1622692-CEF6-11E2-8E5F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226567>

C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:

> Le 06/06/2013 23:26, Sarma Tangirala a =C3=A9crit :
>> Hello All,
>>=20
>> If I did 'git diff HEAD^..HEAD -- file' should git not report some
>> kind of warning if it could not match the file? For example, if 'fil=
e'
>> were infact 'dir/file' and 'file' were unique, would it not be a goo=
d
>> idea to report that in the present working directory 'file' were not
>> found but 'dir/file' were a match?
>
> I don't know any program doing such a thing, and I don't think it is =
the
> role of the program to predict which file the user actually wanted to
> provide in the command line.
> That would imply looking for files with the same name or a close name=
 in
> the current directory and its subdirectories - and maybe even in the
> superdirectory? It is hard to decide when you have to stop looking fo=
r
> the file.

The parameters after "--" are pathspecs, which is a set of patterns
the paths discovered by the operation (in this case "diff" that
finds paths in HEAD^ and HEAD) are matched against.  They are used
to filter out uninteresting paths.

If HEAD^ and HEAD does not have anything that match the given
pattern (in this case, literal four-letter string "file"), the set
of interesting paths may become empty and that is perfectly normal.

So this is working as designed.

Having said that, we do detect typo by noticing when a pathspec did
not find _any_ path that matched it in some front-end Porcelain
commands, e.g.

	$ git add 'foo*'
        fatal: pathspec 'foo*' did not match any files

It is unreasonable to do the same in "git log old..new -- path" and
error out when the pathspec does not match, because it is normal for
some revisions to have path while some other revisions to lack it.

But for a two-endpoint diff Porcelain (not the plumbing diff-files,
diff-index and diff-tree), I do not think it is particularly a bad
idea to add such a "typo-detection" feature.
