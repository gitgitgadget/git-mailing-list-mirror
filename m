From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 12:41:11 -0700
Message-ID: <7v1w2l1ew8.fsf@gitster.siamese.dyndns.org>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
 <m33an1josg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBasq-0002XI-D3
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbYFYTl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbYFYTl2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:41:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbYFYTl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:41:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C239F1BDD1;
	Wed, 25 Jun 2008 15:41:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E6A221BDCC; Wed, 25 Jun 2008 15:41:19 -0400 (EDT)
In-Reply-To: <m33an1josg.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 25 Jun 2008 12:30:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2A59192-42EE-11DD-BABD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86329>

Jakub Narebski <jnareb@gmail.com> writes:

> "Avery Pennarun" <apenwarr@gmail.com> writes:
>
>> Hi all,
>> 
>> Using git 1.5.6.64.g85fe, but this applies to various other versions
>> I've tried.
>> 
>> I have a git repo with about 17000+ files in 1000+ directories.  In
>> Linux, "git status" runs in under a second, which is perfectly fine.
>> But on Windows, which can apparently only stat() about 1000 files per
>> second, "git status" takes at least 17 seconds to run, even with a hot
>> cache.  (I've confirmed that stat() is so slow on Windows by writing a
>> simple program that just runs stat() in a tight loop.  The slowness
>> may be cygwin-related, as I found some direct Win32 calls that seem to
>> go more than twice as fast... which is still too slow.)
>
> Which git version do you use? Does it have the following configuration
> variable (also available as command option):
>
>   status.showUntrackedFiles::
>         By default, linkgit:git-status[1] and linkgit:git-commit[1] show
>         files which are not currently tracked by Git. Directories which
>         contain only untracked files, are shown with the directory name
>         only. Showing untracked files means that Git needs to lstat() all
>         all the files in the whole repository, which might be slow on some
>         systems. So, this variable controls how the commands displays
>         the untracked files. Possible values are:
>
>         - 'no'     - Show no untracked files
>         - 'normal' - Shows untracked files and directories
>         - 'all'    - Shows also individual files in untracked directories.

That's on 'master' progressing forward to eventually become 1.6.0.
