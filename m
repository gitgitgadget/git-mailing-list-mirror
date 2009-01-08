From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 08 Jan 2009 00:36:17 -0800
Message-ID: <7vr63e42ke.fsf@gitster.siamese.dyndns.org>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Emily Ren" <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 09:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKqOd-00045n-6y
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 09:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbZAHIgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 03:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754716AbZAHIgX
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 03:36:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbZAHIgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 03:36:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 96D291C0FD;
	Thu,  8 Jan 2009 03:36:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D3D51C0FB; Thu, 
 8 Jan 2009 03:36:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6DE09942-DD5F-11DD-B824-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104900>

"Emily Ren" <lingyan.ren@gmail.com> writes:

> I want some person can clone my git repository, others can't clone my
> git repository. Is it realizable ? How to do it?

It depends on what transport these people come from.

On the local filesystem transport (either same host or network-mounted
filesystem), you do it the same way as you solve "how do I show these
files of mine on the local computer to some but not others".  Typically,
you place these group members in the same UNIX group, make the toplevel
directory of the hierarchy owned by the group, and "chmod g+rx,o=" it (and
make everything underneath group readable).  Setting core.sharedrepository
configuration variable would help maintain the group readability.

If they come over the http transport, you would solve it the same way as
you solve "how do I allow access to these files on my webserver to only
selected few?"  Probably .htaccess file in the toplevel directory will be
involved.

You can set up gitosis and have it serve your repository, and register
group members' SSH keys to gitosis.  It allows you to categorize these
users into different groups, and assign read-only or read-write access to
repositories.  When this is done, these people will be coming over the
"git over ssh" transport, i.e. git@your-host:/path/to/repository.git/
or its synonym ssh://git@your-host/path/to/repository.git/

The git-daemon transport deliberately omits authentication, and you cannot
restrict when they come over the git native transport using a URL like
git://your-host/repository.git

-jc
