From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] run_builtin(): save "-h" detection result for
 later use
Date: Thu, 21 Oct 2010 15:57:30 -0700
Message-ID: <7vsjzzrw6d.fsf@alter.siamese.dyndns.org>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 00:57:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P944v-0004p8-33
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab0JUW5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 18:57:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab0JUW5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 18:57:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B39AE001B;
	Thu, 21 Oct 2010 18:57:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=LHMxvPG1JbdKGCGSsTfB9dYN8
	gc=; b=j9KQx387/T+dDspxT65gLbVnH8GT2kdIMdTc+KjeH0gHasjIZ8XQ13cP5
	pG0W6jEp5L12lc741EBTlagz0A+0hkpzK4CJnnRB+incxR36mQG0Z8uVFrKXiZyk
	Qp3XibhBxmcOs0h8t/f2R/XR2FtOfxMefaen2Dol6NceCs8P9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EW7+vkw977ETaojqc0L
	heCAasXT69IAEDEYxMTZZ8xg6MYRU6BJMBp1h6YFWdgvNG/s+A+tbKIsMxEz6X7t
	CkTOSi2zhZ5JJRgYqkWQplvBK1zMw4s+rgmhH6eIASS4Eq1GlU4QBrKcvvxWWhs+
	2v1GUIhUBVDpkuCSdM08RmwQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E2CE001A;
	Thu, 21 Oct 2010 18:57:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5271FE0017; Thu, 21 Oct
 2010 18:57:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 989FEDF0-DD66-11DF-856F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159585>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> When run_builtin() sees "-h" as the first argument, it assumes:
>
>  - this is the call for help usage
>  - the real git command will only print help usage then exit
>
> So it skips all setup in this case.  Unfortunately, some commands do
> other things before calling parse_options(), which is often where the
> help usage is printed.  Some of those things may try to access the
> repository unnecessarily. If a repository is broken, the command may
> die() before it prints help usage, not really helpful.

What does die() message say in that case?  If it says "your repository =
is
broken", that may be more useful than giving a help message.  I dunno.

> Demonstrating "git foo -h" fails depends on individual commands and
> is generally difficult to do. Instead GIT_TRACE is used to check
> if a command does set repo. If it does, it is supposed to fail if
> repo setup code chokes.

Hmm, I am not sure I understand this one.  If you are interested in
changing the behaviour of these commands when run with "-h" in a corrup=
t
repository, perhaps you can deliberately corrupt the test repository in
the trash directory you start with, and run these commands there, no?
=46or a good measure, you could use CEILING_DIRECTORIES to make sure th=
e
tests do not climb up to the project repository.
