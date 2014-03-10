From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 20:56:12 +0100
Message-ID: <87bnxd96ar.fsf@fencepost.gnu.org>
References: <531D9B50.5030404@alum.mit.edu>
	<CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
	<20140310155230.GA29801@sigill.intra.peff.net>
	<87k3c2820l.fsf@fencepost.gnu.org>
	<20140310194247.GA24568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6JZ-0006fp-RP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbaCJT41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:56:27 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:47405 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbaCJT4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:56:25 -0400
Received: from localhost ([127.0.0.1]:46441 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WN6JE-0001Fs-0V; Mon, 10 Mar 2014 15:56:24 -0400
Received: by lola (Postfix, from userid 1000)
	id 10B39E05E7; Mon, 10 Mar 2014 20:56:12 +0100 (CET)
In-Reply-To: <20140310194247.GA24568@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2014 15:42:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243803>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 10, 2014 at 05:14:02PM +0100, David Kastrup wrote:
>
>> [storing refs in sqlite]
>>
>> Of course, the basic premise for this feature is "let's assume that our
>> file and/or operating system suck at providing file system functionality
>> at file name granularity".  There have been two historically approaches
>> to that problem that are not independent: a) use Linux b) kick Linus.
>
> You didn't define "suck" here, but there are a number of issues with the
> current ref storage system. Here is a sampling:
>
>   1. The filesystem does not present an atomic view of the data (e.g.,
>      you read "a", then while you are reading "b", somebody else updates
>      "a"; your view is one that never existed at any point in time).

If there are no system calls suitable for addressing this problem that
fundamentally concerns the use of the file system as a file-name
addressed data store, I don't see why "kick Linus" would not apply here.

>   2. Using the filesystem creates D/F conflicts between branches "foo"
>      and "foo/bar". Because this name is a primary key even for the
>      reflogs, we cannot easily persist reflogs after the ref is
>      removed.

That actually sounds more like "kick Junio" territory (the wonderful
times when "kick Linus" could achieve almost anything are over).  To
wit: this sounds like a design shortcoming in Git's use of filesystems,
not something that is actually inherent in the use of files.

>   3. We use packed-refs in conjunction with loose ones to achieve
>      reasonable performance when there are a large number of refs. The
>      scheme for determining the current value of a ref is complicated
>      and error-prone (we had several race conditions that caused real
>      data loss).

Again, that sounds like we are talking about a scenario that is not a
problem of files inherently but rather of Git's ways of managing them.

> Those things can be solved through better support from the filesystem.
> But they were also solved decades ago by relational databases.

Relational databases that are not implemented on raw storage managed by
database servers will still map their operations to file operations.

> But they are also a proven technology for solving exactly the sorts of
> problems that some people are having with git. I do not see a reason
> not to consider them as an option for a pluggable refs system.

But I think it would be wrong to try solving "2." above at the database
level when its actual problem lies with the reference->filename mapping
scheme.

-- 
David Kastrup
