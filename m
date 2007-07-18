From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 13:40:57 +0200
Message-ID: <vpqejj6c52u.fsf@bauges.imag.fr>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707181121520.14781@racer.site>
	<86tzs2m1h7.fsf@lola.quinscape.zz>
	<Pine.LNX.4.64.0707181218090.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 13:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB7uJ-0005V4-31
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 13:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994AbXGRLlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 07:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXGRLlT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 07:41:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:39759 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760777AbXGRLlS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 07:41:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6IBevq4010344
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 13:40:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IB7tp-0005Et-Qq; Wed, 18 Jul 2007 13:40:57 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IB7tp-0006jU-OQ; Wed, 18 Jul 2007 13:40:57 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, David Kastrup <dak@gnu.org>,  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0707181218090.14781@racer.site> (Johannes Schindelin's message of "Wed\, 18 Jul 2007 12\:24\:46 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 18 Jul 2007 13:40:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52854>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > We do not track permissions of directories at all.
>> 
>> Ok, this seems like something that should be done as well, even if we
>> can stipulate at first that a directory should have rwx for the user
>> in question if you hope to track it.
>
> No, no, no.  It should not be tracked.  It is the responsibility of the 
> _user_ to set it to something sane, be that by a umask or by sticky 
> groups, or by setting the permissions of the parent directory.
>
> It is _nothing_ we want to put into the repository.  That is the _wrong_ 
> place to put it.

I'm not sure it's wrong to be able to track permissions, but it's
definitely wrong to track them by default.

GNU Arch had some permission tracking, and I got hit by it several
times. You have several things you might have wanted to track:

* read/write for the user. But I can't imagine a case where you
  wouldn't want to be able to read and write your own files.

* permissions for group. But that doesn't make any sense when several
  persons work on the same project, and don't share the same
  /etc/group.

* permissions for others. But that, again, doesn't make sense when
  several persons work on the same project with different setups. I
  sometimes work at home, where I'm basically the only user, I don't
  care at all about permissions for others. At work, it's totally
  different, since it's a big NFS shared by all the lab. And I might
  very well disclose my work to the rest of the lab, and work with
  someone who do not want to do so.

* Execute bit. This one is relevant. Indeed, it's more a kind of
  metadata than really a permission (you can still execute the file
  with /lib/ld-linux.so.2 /path/to/file or such kind of things).

Using GNU Arch, I got the cases in real life of a project in which
some files had group read permission, some other not, because they
were created by developers having different umask. Worse than this, I
got some group-writable files in my $HOME without noticing it, which
is basically a security hole.

-- 
Matthieu
