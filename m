From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-add: -s flag (silently ignore files)
Date: Mon, 01 Oct 2012 11:32:03 -0700
Message-ID: <7v8vbqcacc.fsf@alter.siamese.dyndns.org>
References: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, olaf@sofd.de
To: Olaf Klischat <olaf.klischat@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 20:32:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIkmz-0002Ly-4z
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 20:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab2JAScJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 14:32:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab2JAScH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 14:32:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7914D80C1;
	Mon,  1 Oct 2012 14:32:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCnCS52QG5Ig7l1s4r8YIdC4jSo=; b=Dxwnte
	GKMpLcdaBfY9pFtz1RPO2teS/Q8VLUh9kDNrvdyxfHFjm+I8pBlLTTxoaXdHnLTS
	HN/pAC18EalZK+Q92BpM6gSFsZR4l2PweH2C2wkrbMqKGC97i5nI7ohEMmtSH4Yo
	TE3dxr5V2i/DA7PAlFrrRsTD97sc3UnmbF07g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QxC4XbSBGooU9MNbOmI4luAvYaFTks8t
	zFIsMmUEfCh/6RR+kpjn4YFqlBgLt4P6mtzwq0IkK503JLVtb680EqIIW7apqTBw
	Xq4F44OaVNdLwFsHqRpUIWbMpSyKO0QvjydoC8Fi6rMBjhb5Guw4fDiu2Ac3qbcH
	GSpTcmIaHSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57E2780C0;
	Mon,  1 Oct 2012 14:32:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A526380BD; Mon,  1 Oct 2012
 14:32:04 -0400 (EDT)
In-Reply-To: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
 (Olaf Klischat's message of "Mon, 1 Oct 2012 09:14:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C7098D8-0BF6-11E2-9B44-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206755>

Olaf Klischat <olaf.klischat@gmail.com> writes:

> ... scenarios where you want to feed the file list into git add
> via find or other external commands (`find .... | xargs git add'),
> which you wouldn't want to carefully tune...

Can you explain this kind of thing in the actual commit log message
when you reroll (if you will do so)?

I also cannot help but find that `scenario` an artificially made-up
one.  The description did not feel convincing enough, even if it
were in the proposed commit log message, to justify such an option.

A few questions.

 - What were the kind of patterns useful in the above `find` in your
   real life example?

 - The use of `find` means giving pathspecs from the command line,
   e.g. "git add foo/ \*.rb", wouldn't have been sufficient. Are
   there something we could improve this in more direct way?

 - Why was it too cumbersome to add the idiomatic

	\( -name '*.o' -o -name '*~' \) -prune -o

   or something like that in front of whatever patterns were used?

 - Perhaps a filter that takes a list of paths and emits only the
   ignored paths (or only the unignored paths) would be a more
   generic approach?  You could feed the output from `find` to such
   a filter, and then drive not just "git add" but other commands
   that take paths if you solved it that way.
