From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: Use get_sha1_committish instead of read_ref in init_notes()
Date: Wed, 17 Jun 2015 18:35:11 +0200
Message-ID: <CALKQrgfR7AwJ1XY2iPHBAssk_2uKGUJC=J-r7bJVSKaiosc5gw@mail.gmail.com>
References: <1434503731-26414-1-git-send-email-mh@glandium.org>
	<xmqq1thb58i8.fsf@gitster.dls.corp.google.com>
	<20150617094036.GA536@glandium.org>
	<xmqqsi9q4b46.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:20:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5H0h-0006St-9X
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796AbbFQRUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 13:20:14 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:50837 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757758AbbFQRUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 13:20:08 -0400
X-Greylist: delayed 2689 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2015 13:20:08 EDT
Received: from mail-yh0-f53.google.com ([209.85.213.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Z5GJ3-000Ls5-OX
	for git@vger.kernel.org; Wed, 17 Jun 2015 18:35:17 +0200
Received: by yhak3 with SMTP id k3so37667683yha.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 09:35:11 -0700 (PDT)
X-Received: by 10.129.72.194 with SMTP id v185mr7694756ywa.20.1434558911732;
 Wed, 17 Jun 2015 09:35:11 -0700 (PDT)
Received: by 10.37.96.4 with HTTP; Wed, 17 Jun 2015 09:35:11 -0700 (PDT)
In-Reply-To: <xmqqsi9q4b46.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271873>

On Wed, Jun 17, 2015 at 5:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> > I'm tempted to make init_notes itself do the check, based on the value
> > it is given for a "read_only" argument.
>
> Yeah, that would be one sensible way to go after making sure that
> everything goes thru this interface.

Agreed. Furthermore, consider adding the read_only flag (or however
you choose to encode it internally) to struct notes_tree, so that the
API functions that _manipulate_ notes trees can immediately bail out
when used on a read-only tree (i.e. we want them to fail as early as
possible).

> > On the other hand, some commands
> > do their ref resolving themselves already.
>
> Again, as long as they do not bypass the "read-only" safety you are
> suggesting to add to init_notes(), that is OK.

Agreed. An alternative to adding a simple read_only flag argument is
to modify the const char *notes_ref argument into two separate
arguments: const char *notes_treeish, and const char *update_ref,
where the latter should be NULL for read-only trees. That said,
currently the logic for actually updating notes ref lives outside the
notes.h API (see commit_notes() in notes-utils.h/c), so there might be
room for more consolidation/refactoring here...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
