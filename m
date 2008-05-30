From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 13:28:04 -0700
Message-ID: <7vd4n3k04r.fsf@gitster.siamese.dyndns.org>
References: <483C4CFF.2070101@gmail.com>
 <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com>
 <200805301202.25368.jnareb@gmail.com> <4840166C.3030903@gmail.com>
 <20080530150713.GG593@machine.or.cz> <48401CFF.4020702@gmail.com>
 <20080530153822.GH593@machine.or.cz>
 <b77c1dce0805300904o5b4363efkc4591fc820164bf7@mail.gmail.com>
 <1212173779.26045.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri May 30 22:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BLh-00060R-5u
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYE3UgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYE3UgY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:36:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYE3UgY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:36:24 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 May 2008 16:36:24 EDT
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D946E229D;
	Fri, 30 May 2008 16:28:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7BA71229C; Fri, 30 May 2008 16:28:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F00AA42C-2E86-11DD-903A-CF5E14B48E85-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83332>

"J.H." <warthog19@eaglescrag.net> writes:

> On Fri, 2008-05-30 at 18:04 +0200, Rafael Garcia-Suarez wrote:
>> 2008/5/30 Petr Baudis <pasky@suse.cz>:
>> >
>> > Wow, and here I was wondering if requiring at least 5.6 was not too
>> > liberal. ;-) I believe 5.8 is the newest possible candidate though, it
>> > is still too widespread; e.g. Debian-wise, many servers run on Etch and
>> > are going to stay there even for quite some time after Lenny gets
>> > released. Heck, I still have accounts on plenty of Sarge machines. ;-)
>> > (Sarge seems to have Perl-5.8.4.)
>> 
>> I think 5.8.2 is a good _minimum_ perl to support. Before that one,
>> Unicode support is next to null (5.6 and below) or too buggy, and
>> gitweb needs that.

> I would agree - lets try and shoot for 5.8 as a baseline minimum (there
> are lots of people who are slow to upgrade, and it would be nice to be
> able for them to make use of newer gitweb's on things like Centos / RHEL
> 4

I do not think it is unreasonable to require recent Perl for a machine
that runs gitweb, as it is not something you would run on your "customer
site that needs to be ultra sta(b)le" nor on your "development machine
that needs to run the same version as that ultra sta(b)le customer
installation."  In other words, gitweb is primarily a developer tool, and
you can assume that people can afford to have a dedicated machine they can
update its Perl to recent version.

However, introducing dependency on 5.8 to any and all Git.pm users may
have a much wider impact.  Right now, these "use Git":

    git-add--interactive.perl
    git-cvsexportcommit.perl
    git-send-email.perl
    git-svn.perl

If you are doing development for some customer application whose end
product needs to land on a machine with a pre-5.8 Perl, it is conceivable
that you may pin the Perl running on that development machine to that old
version, say 5.6.  Introducing 5.8 dependency to Git.pm in such a way that
"use Git" from these fail might make these people somewhat unhappy.
