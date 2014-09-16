From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 02/35] api-lockfile: expand the documentation
Date: Tue, 16 Sep 2014 13:25:25 -0700
Message-ID: <20140916202525.GB29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:25:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzJd-0007oh-IL
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbaIPUZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:25:29 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:51150 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbaIPUZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:25:28 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so516304pde.41
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EottNTbOXfAzdYFGVyDNG8nKcWF2EGpLLqnJc5aXu2o=;
        b=LacXSa7v8BQdPATY9/SGyBJi6RFDG0XZ9LPqMKCcQkve/NTjLaJVxY8fzUYYcZsQTz
         lJNtoNTOPoi56JijSxKg9GRMsJIqvMkD4sEogfhAB6I9bBZJ4wV9sT52PsVb06ND2FHC
         Sg6nOlVJz8oN/fQUWXjesw1dqWFaJz+1eG3Qo6Z5qgvX5blW42hTjwH4fwtuKwx6EKEv
         pOaObfcmFcBbpCU6PDCLfHoMBU9Fd7AuVTHbc7oqVhVacZBvHtyFXXkffyQICv2adfI0
         KfH1VYEAnO3GuKZsmdGnFLgpCROS+PZoMdx7VBeQgklzlPhQULglmaSC1dp+dTooikRv
         9qkg==
X-Received: by 10.66.154.234 with SMTP id vr10mr53021052pab.44.1410899128329;
        Tue, 16 Sep 2014 13:25:28 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id bf2sm13418221pbb.13.2014.09.16.13.25.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:25:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-3-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257183>

Michael Haggerty wrote:

> Document a couple more functions and the flags argument as used by
> hold_lock_file_for_update() and hold_lock_file_for_append().

Thanks.

[...]
> --- a/Documentation/technical/api-lockfile.txt
> +++ b/Documentation/technical/api-lockfile.txt
> @@ -28,9 +28,39 @@ hold_lock_file_for_update::
>  	the final destination (e.g. `$GIT_DIR/index`) and a flag
>  	`die_on_error`.  Attempt to create a lockfile for the
>  	destination and return the file descriptor for writing
> -	to the file.  If `die_on_error` flag is true, it dies if
> -	a lock is already taken for the file; otherwise it
> -	returns a negative integer to the caller on failure.
> +	to the file.  The flags parameter is a combination of
> ++
> +--

Context: this document has structure

	lockfile API
	============

	Explanation of purpose (nice!).

	The functions
	-------------

	Quick descriptions of each of the four functions
	`hold_lock_file_for_update`, `commit_lock_file`,
	`rollback_lock_file`, `close_lock_file`.

	Reminder about lifetime of the lock_file structure.

	Description of cleanup convention (thou shalt either
	commit or roll back; if you forget to, the atexit
	handler will roll back for you).

	Long warning about the harder use cases.  The above
	"thou shalt" was a lie --- you can also
	close_lock_file if you know what you're doing
	[jn: why is that function part of the public API?].

What's nice about the existing structure is that you can get
a sense of how to use the API at a glance.  Would there be a
way to add this extra information while preserving that property?

E.g.:

	lockfile API
	============

	Nice brief explanation of purpose ("is this the API
	I want to use?"), as before.

	Calling sequence
	----------------

	The caller:

	* Allocates a variable `struct lock_file lock` in the bss
	section or heap.  Because the `lock_file` structure is used
	in an `atexit(3)` handler, its storage has to stay
	throughout the life of the program.  It cannot be an auto
	variable allocated on the stack.

	* Attempts to create a lockfile by passing that variable and
	the filename of the final destination (e.g. `$GIT_DIR/index`)
	to `hold_lock_file_for_update` or `hold_lock_file_for_append`.
	+
	If the `die_on_error` flag is true, git dies if a lock is
	already taken for the file.

	* Writes new content for the destination file by writing to
	`lock->fd`.

	When finished writing, the caller can:

	* Close the file descriptor and rename the lockfile to
	its final destination by calling `commit_lock_file`.

	* Close the file descriptor and remove the lockfile by
	calling `rollback_lock_file`.

	* Close the file descriptor without removing or renaming
	the lockfile by calling `close_lock_file`.

	If you do not call one of `commit_lock_file`,
	`rollback_lock_file`, and `close_lock_file` and instead
	simply `exit(3)` from the program, an `atexit(3)` handler will
	close and remove the lockfile.

	You should never call `close(2)` on `lock->fd` yourself~
	Otherwise the ...

	Error handling
	--------------

	Functions return 0 on success, -1 on failure.  errno is?
	isn't? meaningful on error.

	... description of unable_to_lock_error and unable_to_lock_die
	here ...

	Flags
	-----

	LOCK_NODEREF::

		Usually symbolic links in the destination path are
		resolved and the lockfile is created by adding ".lock"
		to the resolved path.  If `LOCK_NODEREF` is set, then
		the lockfile is created by adding ".lock" to the path
		argument itself.

What is the user-visible effect of that flag?  When would I want
to pass that flag, and when wouldn't I?

	LOCK_DIE_ON_ERROR::

		If a lock is already taken for the file, `die()` with
		an error message.  If this option is not specified,
		trying to hold a lock file that is already taken will
		return -1 to the caller.

Sensible?
Jonathan
