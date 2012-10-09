From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout error
Date: Tue, 09 Oct 2012 16:47:12 -0700
Message-ID: <7v626jdx8f.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
 <m2lifg7zsj.fsf@igel.home>
 <CAB9Jk9CZ8d=8ugYs7XHXs84Kj9xJmTHZyZ2J0hU66OBS7YDZTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 01:47:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLjWI-0007ex-D9
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 01:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab2JIXrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 19:47:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab2JIXrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 19:47:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2CC38B75;
	Tue,  9 Oct 2012 19:47:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3lHE76tp3vKy2SHdDrxptxBQ7yc=; b=e8+epV
	UpVZz38n5ykUUL6d1JWzrEG3ip+Abm03DYwknM+GCNmsxeUQLwe1NKJbiflbohw3
	xe3FtYUdHOUV4jOmRa5ILd7Foe+6TOZ7X+k75lKikvB1DiRcHssHO2qITyENLso2
	gl5rXElWmA1d67HgDIGZLdTBsVy44ARQz0WdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gheKjR2TFwfypXhl1LKAHh+ncSKhXhSI
	0QpLrz75E0D9ZRl7QiJafeYWJ3E8ihHs0jOqBjvrq69SEDopQ0C/yyXHljRIdLXL
	T6vBC4P7ixUQC6CORryhwl0ogGz1WP9qNtzEe8a6hPz1/0bOensBHiIaIUVvqHil
	JXT1W56oYWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A2D8B74;
	Tue,  9 Oct 2012 19:47:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3F508B73; Tue,  9 Oct 2012
 19:47:13 -0400 (EDT)
In-Reply-To: <CAB9Jk9CZ8d=8ugYs7XHXs84Kj9xJmTHZyZ2J0hU66OBS7YDZTg@mail.gmail.com> (Angelo
 Borsotti's message of "Wed, 10 Oct 2012 01:25:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A694496A-126B-11E2-AF1B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207355>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> The man page describes --track and --no-track as "options". 

But the problem you observed is *not* about --track or --no-track.
It is about the "-b <branchname>" option.

You used the -b option that requires an argument, and as that
argument, you gave a string "--no-track", as if you wanted to create
a branch whose name is "--no-track".  After these words on the
command line are understood, there are two other arguments left on
the command line, which is an syntax error as far as "git checkout"
is concerned.

Again, this is asked-and-answered recently, and 

    http://thread.gmane.org/gmane.comp.version-control.git/204397

has resulted in a leading to b6312c2 (checkout: reorder option
handling, 2012-08-30), which is in v1.8.0-rc0 and onwards.  You
should get an error message that is a lot less confusing:

    $ git checkout -b --no-track topic remotes/origin/master
    fatal: '--no-track' is not a valid branch name.
