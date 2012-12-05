From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC Optionally handle symbolic links as copies
Date: Wed, 05 Dec 2012 15:51:41 -0800
Message-ID: <7vd2yojbw2.fsf@alter.siamese.dyndns.org>
References: <1354747575-89277-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:52:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgOl7-00040q-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 00:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab2LEXvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 18:51:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab2LEXvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 18:51:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D151A4B6;
	Wed,  5 Dec 2012 18:51:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wKixn18Vgdw/oggn8NH0LxAAs2I=; b=ukSfjz
	S5SkmHERjx1ZS8+9uxF93/JamQ126Uw0iatrxcf3wmgue8G8Zff4dg7nuWYXJ4cA
	aKT1mxt4GyvnkawEvhxmVeLgljI2ETXNI+f1jGyjk/OCYjwg5wK+vMCv7Bb4wYEw
	6lzno8exDc5SsL6ky9PpElG6pt6Hr2MQ4NTWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+VzI8blZwwmQ/THfLGYtlDOIY5cuNvX
	4ShAyos+lKExmsnTA4TNN7/+dqK8y9+1kopubv0+9m/Wr2vtf02ust2gOZ1PR01H
	884dw2nVYkl+OBx+vjlfOMXzI/NO+OIPIj5+eE70iHw9U0/P+pFUccoDVCOi3urj
	G46J2Ob/N+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC3FA4B5;
	Wed,  5 Dec 2012 18:51:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3A52A4B0; Wed,  5 Dec 2012
 18:51:42 -0500 (EST)
In-Reply-To: <1354747575-89277-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Wed, 5 Dec 2012 23:46:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B843EE02-3F36-11E2-B4CE-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211147>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> If core.symlinks is set to copy then symbolic links in a git repository
> will be checked out as copies of the file it points to.

That all sounds nice on surface when the primary thing you care
about is to fetch and check out other people's code and extract it
to the working tree, but how well would that work on the checkin
side?  What happens if I check out a symlink that points at a file
(either in-tree or out-of-tree), make some changes that do not
involve the symlink, and before I make the commit, an unrelated
change is made to the file the symlink is pointing at?

> - git status - when do we report a diff. 
> 	- After checkout we should probably not
> 	- if the "linked" files change?

Yeah, exactly.

> 	- if a change in the copied directory chsnges

That, too.

> 	- if a file in the copied diretory is added/removed
> 	- update, should we update the copied structure automatically
> 	  when the link target changes

I personally do not think this is worth it.  It would be very useful
on the export/checkout side, so it may make sense to add it to "git
archive", though.
