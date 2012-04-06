From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad Man Page URLs
Date: Fri, 06 Apr 2012 00:15:07 -0700
Message-ID: <7vzkap1gck.fsf@alter.siamese.dyndns.org>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 09:19:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG3SI-0002Eq-3O
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 09:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab2DFHPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 03:15:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51902 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab2DFHPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 03:15:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 713497558;
	Fri,  6 Apr 2012 03:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uC06/qkI/KT/dLxyGoXxYdC9MFg=; b=UbM7mG
	vNjQtr++Ht7ISezzNj7HuerV8GpEgo+4F9NIYDuySEw6xpCOzpsJeZuj12TZR6Jh
	a3KVBNMs8BEs30praIJZ08CWvwhUqHIcjRzYd9jIsWRzZBnNWO6XiToMcwwOgfFL
	rxXhv1fiJELjQVNSmD/JLJuuV9e2SKYU0u854=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jogbe97qRcmEbkzoLicO3NQs1agpO4ai
	aDJ9ZDQsr8K2mXl1LJZb+A045Qnnt0NfHupEVURU6XbhLK9pUugMeAV66gXHYdQy
	p70h1fu0X6HaesBN98TDgMwDSvMthglbOSkUHHY5ADTHfzpCjufEyqUK98QsCs6T
	NBuQI4wj9QM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DC967557;
	Fri,  6 Apr 2012 03:15:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7EAA7556; Fri,  6 Apr 2012
 03:15:08 -0400 (EDT)
In-Reply-To: <20120406054637.GA25301@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Apr 2012 01:46:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DF9B08E-7FB8-11E1-AEBB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194854>

Jeff King <peff@peff.net> writes:

> Junio, what do you think of building the git-manpages-* tarballs (and
> the git-manpages repo) with MAN_BASE_URL set to "http://some-official-place/"?
> As of now, they mention "file:///home/junio/...".

I think git-manpages repo already sets the base to the old k.org location
(see dodoc.sh in the 'todo' branch), but I forgot about that setting when
I cobbled together the tarball releasing script to be run on my home box
in a hurry. The releases used to be cut on a k.org machine and I initially
planned to stop generating the manpage/html tarballs when we lost shell
access to it, but some distro people demanded it, so...

I do not know how well things would behave if we set it to "git-htmldocs/"
as Jonathan suggests, but we will see what happens.

I think there is no need to patch any Makefile; the make variable is
designed to be overridable by the callers of make, so patches should go to
either 'dodoc.sh' or the tarball release scripts, which are not checked in
to the 'todo' branch yet, but I will do so if I remember ;-).

FWIW, here is the (updated) 'RelBuild' script.

-- >8 --
#!/bin/sh

version=$(git describe --exact) &&
label=$(echo "$version" | sed -e 's|^v||') &&
version=$(echo "$label" | sed -e 's|-|.|g') || exit

make clean && make dist &&

ASCIIDOC_NO_ROFF=YesPlease \
ASCIIDOC8=YesPlease \
MAN_BASE_URL="git-htmldocs/" \
make dist-doc || exit

# The above used to be
# MAN_BASE_URL="http://www.kernel.org/pub/software/scm/git/docs/"

files="
	git-$version.tar.gz
	git-htmldocs-$version.tar.gz
	git-manpages-$version.tar.gz
"

for file in $files
do
	test -f $file || exit
done

sha1sum $files | gpg --clearsign >git-$version.sign

ls -l git-$version.sign $files
