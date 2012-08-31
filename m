From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: git blame shows wrong "Not commited yet" entries
Date: Fri, 31 Aug 2012 10:58:42 -0700
Message-ID: <7vmx1bndt9.fsf@alter.siamese.dyndns.org>
References: <7v7gsgqd4w.fsf@alter.siamese.dyndns.org>
 <1055159053.19198.1345536909730.JavaMail.ngmail@webmail24.arcor-online.net>
 <303882026.440710.1346315214352.JavaMail.ngmail@webmail08.arcor-online.net>
 <1672779223.499907.1346418462641.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:59:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7VUb-0007mf-R5
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 19:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab2HaR6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 13:58:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378Ab2HaR6p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 13:58:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6E5C97EF;
	Fri, 31 Aug 2012 13:58:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5TthguW6ssxJWoCCrM5QlHdqOXU=; b=Icsm7d
	4tW4u19vtPdJKNB+iYGLtpzfE1LyTlNZfemPXvXjPFlOgh73Cl5aIRopKmqc/tC0
	TEFmML/3MztuQVMoV0l90nX0VqumoNshyosyZda+ebzy5pI2xEE0WYIVpAPM+h66
	UFMKXA+CNLHo+/7YhXir/BL+gJ1h20MODFDYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rWvnagJN2DwFkRo57zSzAuJRrFL8CbcD
	URKapfu+AeyB7uCIQGsI6uhxTTmo+r3L6jVaAZJKSrmq/n6Aj9bHbTu3oq0Q8dZt
	Y86dTnxkleWDx0HZy4a+sqIRgvbiRZNHu5BzeSV0lzq5VSROmR+DWSpZGSG3vrQy
	rqmihRfN4EA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4BAC97EE;
	Fri, 31 Aug 2012 13:58:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E7B597EC; Fri, 31 Aug 2012
 13:58:44 -0400 (EDT)
In-Reply-To: <1672779223.499907.1346418462641.JavaMail.ngmail@webmail08.arcor-online.net>
 (Thomas Ackermann's message of "Fri, 31 Aug 2012 15:07:42 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8154531A-F395-11E1-BE39-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204597>

Thomas Ackermann <th.acker66@arcor.de> writes:

> The man-page for git-config says:
> "core.ignorecase
> If true, this option enables various workarounds to enable git to
> work better on filesystems that are not case sensitive, like FAT.
> For example, if a directory listing finds "makefile" when git
> expects "Makefile", git will assume it is really the same file,
> and continue to remember it as "Makefile"."
>
> So "various workarounds" does _not_ mean that _all_ filenames are
> processed modulo upper/lower case, or?

Keywords in that paragraph include "various" (not all) and "better"
(not perfectly), and the most important one is "when git expects".

When running "git add file.txt" with "File.txt" in the index, git
expects "File.txt", but the ignorecase logic makes git assume they
are the same, and add content from "file.txt" as "File.txt".

And "git blame $path" probably should expect $path is something that
appear in the tree of HEAD; apparently it does not.

Patches welcome.
