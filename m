From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please support add -p with a new file, to add only part of the
 file
Date: Tue, 10 Jan 2012 10:32:20 -0800
Message-ID: <7vpqer9znv.fsf@alter.siamese.dyndns.org>
References: <20120109105134.1239.39047.reportbug@leaf>
 <20120109204721.GC23825@burratino> <87ty43fy7f.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>, <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:32:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkgUn-0006hb-Kp
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab2AJScY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:32:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110Ab2AJScX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:32:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1EC6923;
	Tue, 10 Jan 2012 13:32:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6hQAk9a4+JV6mW5hRJvL5f9pN8Y=; b=tI4R2m
	8qAxeTsmz/WKljZb+1PBR8QXkEbHNkokI4Od7gdmnxZxv5DgRkuxqSHWgEYG3uuh
	8vSYiGauHwyKedlZ6e+VjZqVgHBmR2ia+B2UwzwuHBJ1JRMpGjqdhXBfOsaAjEgT
	jWYgoAmLdTsgX+VjI0Lh8UgCMc3RHOt+xcHRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VP2raDXfx9Sd5UXR8peqTesdorcGpPYm
	2Dau3gaA0K0Jj9UmoJVLE3YGDRqJFsYio+WuJ/lTwrAMHSNuGaJS2tk0bjZHKv8g
	zz2yxmBs5O+KjZh80oURoxl4CeEUpe++QGiXZf5gfWP8ZXFybkNJMDkW8LfG99B6
	zl+SWr7q51g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C56166922;
	Tue, 10 Jan 2012 13:32:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41A3E6921; Tue, 10 Jan 2012
 13:32:22 -0500 (EST)
In-Reply-To: <87ty43fy7f.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 10 Jan 2012 15:07:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F76052E-3BB9-11E1-B6A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188276>

Thomas Rast <trast@student.ethz.ch> writes:

> A not-so-proper solution might of course start by looking at which files
> are untracked, and only run the 'git add -N' immediately before patch
> application.

Isn't the real issue that we mistakenly gave an impression that "add -p"
is the primary interface to the users, and forgot to tell them about the
more general "add -i", which "add -p" is a small subset of?

Even if you start with "add -N", there won't be individual "hunks" you can
pick and choose from diffing emptiness and the whole new file, so you end
up using "edit hunk" interface.

Whatever you do, you should aim to make it easier to use than

	$ cp newfile.c newfile.c-saved
        $ edit newfile.c ;# delete all the things you do not want for now
        $ git add newfile.c
        $ mv newfile.c-saved newfile.c

Personally, I think it is a very tall order to tweak "add -p / edit"
interface to make it easier to use than the above four command sequence,
the second one among which is the most time and braincell consuming part
of the process, especially when "add -p / edit" gives you has to be
unnecessarily distracting by having '+' prefix.
