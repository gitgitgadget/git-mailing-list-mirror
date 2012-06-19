From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: split prefix flags from GIT-CFLAGS
Date: Tue, 19 Jun 2012 16:58:07 -0700
Message-ID: <7vy5nix3ao.fsf@alter.siamese.dyndns.org>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200354.GC14714@sigill.intra.peff.net>
 <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
 <20120619210426.GA21838@sigill.intra.peff.net>
 <7vzk7zx9pz.fsf@alter.siamese.dyndns.org>
 <20120619233659.GA6621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh8JL-0004Ll-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab2FSX6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:58:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab2FSX6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:58:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9035B8F01;
	Tue, 19 Jun 2012 19:58:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u4ejPlgLeFEWM3eecUkxiYczGeA=; b=SABZ6m
	umvFzxphCxXXGOS8yERX1RGsncPMbO1bT1zcjPy4wyzq6QIOVjaXxHMhZuvjBe/A
	u39KhZsK+oftt5G5Vi77as3GWxmiwET+46TlJ6LZdqVI20lKwzZHDIAxCpzNe7EY
	sL8a7M/Dv9dSQDKLJaCsypAWtETJ+1MrI+iqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rs/sg3hG2TN32HPCbgg+5bdv0avEarAc
	OZLSgespVmyxuBpFVMcw7gIz0va0Brb69tokvYv5pWeBLFLbonY5VgNbSa0pbnxT
	gMMr9WbMMfVn3sAYOivwH9naPGqP3NfILlz8HAK/v7gactwiE8uhS0MA/KnqqD74
	Rh4uau8VvUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F7D8F00;
	Tue, 19 Jun 2012 19:58:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E08978EFD; Tue, 19 Jun 2012
 19:58:08 -0400 (EDT)
In-Reply-To: <20120619233659.GA6621@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 19:36:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EAD9F3E-BA6A-11E1-BDB7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200278>

Jeff King <peff@peff.net> writes:

> Of course, I am probably one of the few people in the world who actually
> wants to have 50 built versions of git on hand.

I have this script as "rungit" on my PATH and "rungit -l" shows 110+
variants.  So at least there are two ;-)

-- >8 --
#!/bin/sh
# Run various vintage of git

variant="${0##*/}" &&
: ${RUNGIT_BASE=$HOME/g} &&
case "$variant" in
rungit)
	case $# in 
	0)
		echo >&2 "which version?"
		exit 1
		;;
	esac
	variant=$1
	shift
	;;
esac &&
case "$variant" in
-l)
	for d in "$RUNGIT_BASE/"git-*/bin/git
	do
		d=$(basename ${d%/bin/git})
		d=${d#git-}
		d=${d#snap-}
		echo "$d"
	done
	exit
	;;
git-*)
	variant=${variant#git-} ;;
v[0-9]*)
	variant=snap-$variant ;;
esac &&
d="$RUNGIT_BASE/git-$variant" &&
if test -f "$d/bin/git"
then
	exec "$d/bin/git" "$@"
else
	echo >&2 "$variant: No such variant for $a"
	exit 1
fi
