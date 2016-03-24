From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Thu, 24 Mar 2016 09:50:48 -0700
Message-ID: <xmqq8u17akgn.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
	<1458820579-31621-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sbeller@google.com, mehul.jain2029@gmail.com,
	sandals@crustytoothpaste.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:54:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj8Wn-0004JE-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758159AbcCXQyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 12:54:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757824AbcCXQuv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 12:50:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2D734BA8E;
	Thu, 24 Mar 2016 12:50:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/JnmxrSssohz
	fp83mkFAUtQQ2eo=; b=AbHcrf+VOjFiB4cOTD0v7wn7Bg/M0N2lDFCZfqDBXkjX
	5Ba27cvxfaB9Z1y0Ftf+Px457sfvAjD2t3aGg/TXjXtZnv9VvzdvF2g8CdmuJtxo
	HqG/JPJOtaepEFXAIiQ+nSLB5aHdnz9ESz4b8/wr/igLnZVSW55EgaRCoIBUkls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=L8ugDs
	sONRH5+8vL+wFnib5+GDZjhDN0I3gS4wtyYZCGf03x4btzOPYz8UJXiAzbwaMUPJ
	0eIPJo0eJ6SKc1zd8emyvnGAAPU3Hxuv0PtbxwhiEeoOemHZVlZZHMHvIkjcESDp
	gEjsImlkH+ax5ZwE12REhcwo4hArycGw0JUtk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA4284BA8D;
	Thu, 24 Mar 2016 12:50:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5EDBE4BA8C;
	Thu, 24 Mar 2016 12:50:49 -0400 (EDT)
In-Reply-To: <1458820579-31621-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 24
 Mar 2016 18:56:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8FE8E6FA-F1E0-11E5-857C-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289760>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>> On Wed, Mar 23, 2016 at 11:55 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> The include/exclude mechanism does use wildmatch() but does not use
>>> the pathspec mechanism (it predates the pathspec machinery that was
>>> made reusable in places like this).  We should be able to
>>>
>>>     $ cd d/e/e/p/d/i/r
>>>     $ git apply --include=3D:/ ../../../../../../../patch
>>>
>>> to lift this limitation.  IOW, we can think of the use_patch() to
>>> include only the paths in the subdirectory we are in by default, bu=
t
>>> we can make it allow --include/--exclude command line option to
>>> override that default.
>
> I went with a new option instead of changing --include.

It might be a "workable" band-aid, but would be an unsatisfying UI
if it were the endgame state.  You do not say "git grep --whole" (by
the way, "whole" is a bad option name, as you cannot tell "100% of
*what*" you are referring to--what you are widening is the limit
based on the location in the directory structure, so the option name
should have some hint about it, e.g. "full-tree" or something) and
this command will become an odd-man-out.

I haven't thought things through, but thinking out aloud a few
points...

  An existing user/script may be working in a subdirectory of a huge
  working tree and relies on the current behaviour that outside world
  is excluded by default, and may be passing --exclude to further
  limit the extent of damage by applying the patch to a subset of
  paths in the current directory that itself is also huge.  And that
  use case would not be harmed by such a change.

  On the other hand, an existing user/script would not be passing an
  "--include" that names outside the current subdirectory to force
  them to be included, because it is known for the past 10 years not
  to have any effect at all.

So a better alternative may be to conditionally disable the "Paths
outside are not touched regardless of --include" logic, i.e. we
exclude paths outside by default just as before, but if there is at
least one explicit "--include" given, we skip this "return 0".

That way, we do not have to commit to turning --include/--exclude to
pathspec (which I agree is a huge change in behaviour that may not
be a good idea) and we do not have to add "--full-tree" that is only
understood by "apply" but not other commands that operate on the
current directory by default.

I agree that the "excluded because the path is outside cwd" should
be reported just like we show notices when applying a hunk with
offset, and that the "excluded because the path is outside cwd"
should be documented.
