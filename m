From: Junio C Hamano <gitster@pobox.com>
Subject: Re: non-ascii filenames issue
Date: Sun, 05 Apr 2009 12:29:00 -0700
Message-ID: <7vfxgmrjb7.fsf@gitster.siamese.dyndns.org>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>
 <20090405100127.GA12126@home>
 <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
 <76718490904050923j105e383dsf650afa0a0687858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Teemu Likonen <tlikonen@iki.fi>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqY3K-0004V3-0a
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbZDET3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbZDET3L
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:29:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601AbZDET3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:29:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C451CACB;
	Sun,  5 Apr 2009 15:29:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 90F36CAC8; Sun, 
 5 Apr 2009 15:29:01 -0400 (EDT)
In-Reply-To: <76718490904050923j105e383dsf650afa0a0687858@mail.gmail.com>
 (Jay Soffian's message of "Sun, 5 Apr 2009 12:23:35 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0750D2C0-2218-11DE-9880-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115685>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Sun, Apr 5, 2009 at 6:51 AM, John Tapsell <johnflux@gmail.com> wrote:
>> Unfortunately not, because for some absolutely crazy reason
>
> Bzzt. http://article.gmane.org/gmane.comp.version-control.git/50830

I do not think the message gives enough information on the issue, as "a
pathname is a slash separated sequence of path components terminated with
a NUL, and a path component is an uninterpreted sequence of bytes
excluding NUL and slash" is simply a UNIX tradition the original git
design took as _given_, so the "some absolutely crazy reason" comment does
not even deserve refuting.

There is _no_ reason, crazy or otherwise.  If you start from "a pathname
is an uninterpreted sequence of bytes" tradition, it is a design parameter
and "how things are", and you simply do not argue with them.  And the
message you quoted doesn't, either.

	Side note: I am not saying that we should not ever change that
	particular design parameter.  I am just explaining why 50830 is
	not a good counterargument to quote against the "some absolutely
	crazy reason" accusation.

> And, as always, patches welcomed.

Before patches, you need a sound design and justification.

At least you need to consider the following (the early ones are easier):

 - Do we unify them to some canonical encoding internally and do the
   matching in the canonical space?   What's the internal representation
   (presumably UTF-8)?

 - How should a user tell the pathname conversion rules between the
   internal repreasentation and the filesystem representation to git?  A
   config variable per a repository?

 - How should this interact with patch+apply dataflow (including "rebase"
   without -i/-m)?  Should pathnames in diffs be in canonical form?

 - How should this interact with case challenged and/or unicode corrupting
   filesystems such as NTFS and HFSplus whose creat(), readdir(), and
   stat() contradict with each other?

 - What should happen when the pathname in the canonical representation
   recorded in the history cannot be externalized on a particular
   filesystem?  Does it gracefully degenerate and give some escape hatch,
   and if so how?
