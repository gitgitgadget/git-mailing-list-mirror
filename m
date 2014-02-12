From: David Kastrup <dak@gnu.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 20:15:24 +0100
Message-ID: <87ppms87n7.fsf@fencepost.gnu.org>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	<87y51g88sc.fsf@fencepost.gnu.org>
	<CAHOQ7J_pg6Nqc5TdU9OA81=d+ZG_JpLFQ5-eFLY3uW8CuAQrUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 20:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDfHP-0002EZ-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbaBLTP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:15:27 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:56696 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbaBLTP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:15:26 -0500
Received: from localhost ([127.0.0.1]:55737 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDfHJ-0001zv-AS; Wed, 12 Feb 2014 14:15:25 -0500
Received: by lola (Postfix, from userid 1000)
	id EDCE4E047A; Wed, 12 Feb 2014 20:15:24 +0100 (CET)
In-Reply-To: <CAHOQ7J_pg6Nqc5TdU9OA81=d+ZG_JpLFQ5-eFLY3uW8CuAQrUQ@mail.gmail.com>
	(Stefan Zager's message of "Wed, 12 Feb 2014 11:02:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242014>

Stefan Zager <szager@chromium.org> writes:

> On Wed, Feb 12, 2014 at 10:50 AM, David Kastrup <dak@gnu.org> wrote:
>
>> Really, give the above patch a try.  I am taking longer to finish it
>> than anticipated (with a lot due to procrastination but that is,
>> unfortunately, a large part of my workflow), and it's cutting into my
>> "paychecks" (voluntary donations which to a good degree depend on timely
>> and nontrivial progress reports for my freely available work on GNU
>> LilyPond).
>
> I will give that a try.  How much of a performance improvement have
> you clocked?

Depends on file type and size.  With large files with lots of small
changes, performance improvements get more impressive.

Some ugly real-world examples are the Emacs repository, src/xdisp.c
(performance improvement about a factor of 3), a large file in the style
of /usr/share/dict/words clocking in at a factor of about 5.

Again, that's with an SSD and ext4 filesystem on GNU/Linux, and there
are no improvements in system time (I/O) except for patch 4 of the
series which helps perhaps 20% or so.

So the benefits of the patch will come into play mostly for big, bad
files on Windows: other than that, the I/O time is likely to be the
dominant player anyway.

If you have benchmarked the stuff, for annoying cases expect I/O time to
go down maybe 10-20%, and user time to drop by a factor of 4.  Under
GNU/Linux, that makes for a significant overall improvement.  On
Windows, the payback is likely quite less because of the worse I/O
performance.  Pity.

-- 
David Kastrup
