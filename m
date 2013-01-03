From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Thu, 03 Jan 2013 07:22:59 -0800
Message-ID: <7vip7expd8.fsf@alter.siamese.dyndns.org>
References: <20130101172645.GA5506@thyrsus.com>
 <CAEUsAPYwinmbDkSVu71WJRgUjLfBeNdKDFt6O1f8-Ti9evn6Hw@mail.gmail.com>
 <7vmwwqyc8w.fsf@alter.siamese.dyndns.org>
 <CALWbr2xx0beca_LUHO45pGMZ4Y0jZ9-iMWq8WBO6PmW==Ysw=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, Eric Raymond <esr@thyrsus.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 16:23:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqmdg-0000TW-N9
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 16:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab3ACPXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 10:23:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab3ACPXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 10:23:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58167B88D;
	Thu,  3 Jan 2013 10:23:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n110s4WwGkfn3wQt1DgSwErb4nM=; b=S0dbfd
	9pfhuZ8tpn8bxoTvBbF2Elyt3QVgeL4M9Mio0vdHFNgV5e6GwHgwDwskYk3VMHzx
	unBmZ1M86doY6BavsmY7IR6sdi6diwkPk47J2OPBNQysv1vhU3L/9SmYB3yy/Z57
	L6OIjF0ufVsncYPiqW8WnZIRhIJynHv8s4TPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nUEoFsU7WQPrn3yTdZ5gyoygFWVswOmY
	bwFPUxA7zJc+HO31/5+Azemj2Wzj2BaqGLNHnMvhAiZOPlfo7LwSEOEkoifYuGRD
	IrcfFZv0l5VlVoq270daNqc8SuNHgks3acfMBoGzD88vNMslbQNYK/BAphCu8OVB
	eXkPPOjQCkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1590CB88C;
	Thu,  3 Jan 2013 10:23:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86F50B88B; Thu,  3 Jan 2013
 10:23:01 -0500 (EST)
In-Reply-To: <CALWbr2xx0beca_LUHO45pGMZ4Y0jZ9-iMWq8WBO6PmW==Ysw=A@mail.gmail.com> (Antoine
 Pelisse's message of "Thu, 3 Jan 2013 08:47:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 763DFB8A-55B9-11E2-8A4E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212589>

Antoine Pelisse <apelisse@gmail.com> writes:

>> Doesn't Python come with a standard subprocess module that lets you
>> spawn external programs safely, similar to the way Perl's list form
>> open(), e.g. "open($fh, "-|", 'git', @args)", works?

... and of course a more boring "system('git', $subcmd, @args)", as well.

> You mean something like this:
>
>   p1 = subprocess.Popen([backend.command()], stdout=subprocess.PIPE)
>   subprocess.Popen(["git", "fast-import", "--quiet"] + gitopts,
> cwd=outdir, stdin=p1.stdout)
>
> Assuming gitopts is a list rather than a string. (care must be taken
> with backend.command() also)

Yes.

I vaguely recall that the subprocess module once used to be one
portability issue but that was between Python 2.3 and 2.4 or some
ancient history, and it should no longer be relevant.
