From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] git-remote-ext
Date: Thu, 30 Sep 2010 08:45:52 -0500
Message-ID: <20100930134552.GF4850@burratino>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Sep 30 15:50:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JWh-0003HE-JB
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab0I3NtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 09:49:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37997 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457Ab0I3NtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:49:00 -0400
Received: by eyb6 with SMTP id 6so719381eyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IedzFtrpjapt8u3ugwxr/KyzuVXcL2R0nL8S9O/ay28=;
        b=aWQ36UAd0a8kQZut+RV7tqCyYAsEuvTy7Eyt+2VyQnzKDbxGUNusPaa4ZWbYyrMKnP
         7g+tvYhvV0+tmF2+zULS/JLJz2SFNKITNBhAMjzn3yA6K63kq6RG9LaYCvxXNH2YLQFT
         l70xEOY4jSYOfESjCblT93O/Ixd397gtQRdkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GVYqT1vYU1McZ2BU9uZfMZGBydH2ABbYL63qocTzW3jJG7cQ4fUM1DTra45bPRityr
         PU/+Vuxdi1J7/AN4bHywtnZ65IX9z+KJZr0Q6a66ZbboYRqo4KJ+yp6C4h738To6g3xg
         Ss6R+OHIMV+YG4meBPHtllN8Y9P4XVTzJdPH0=
Received: by 10.213.13.135 with SMTP id c7mr4139447eba.14.1285854538699;
        Thu, 30 Sep 2010 06:48:58 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id a48sm14519616eei.18.2010.09.30.06.48.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:48:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285847579-21954-4-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157668>

Ilari Liusvaara wrote:

> This remote helper invokes external command and passes raw smart transport
> stream through it. This is useful for instance for invoking ssh with
> one-off odd options, connecting to git services in unix domain
> sockets, in abstract namespace, using TLS or other secure protocols,
> etc...

Tunneling, too (e.g., native git protocol passing through draconian
firewall), right?

>  Documentation/git-remote-ext.txt |   87 ++++++++++++++++++++++++++++++++++++++
>  Makefile                         |    1 +
>  builtin.h                        |    1 +
>  git.c                            |    1 +
>  4 files changed, 90 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/git-remote-ext.txt

Where is the implementation?

> +++ b/Documentation/git-remote-ext.txt
> @@ -0,0 +1,87 @@
> +git-remote-ext(1)
> +=================
> +
> +NAME
> +----
> +git-remote-ext - Bridge smart transport to external command.
> +
> +
> +SYNOPSIS
> +--------
> +"ext::<command>[ <arguments>...]" (as URL)

Maybe:

	git remote add nick "ext::<program>[ <arguments>...]"

as a concrete example.

> +
> +DESCRIPTION
> +-----------
> +This command uses specified command to connect to remote git server.

 - Most users won't invoke remote-ext directly, right?
 - Missing articles ('the' and 'a').
 - Missing formatting ('command' is passed on the command line).

So maybe:

	This remote helper uses the specified 'program' to connect
	to a remote git server.

> +
> +Between <command> and <arguments> (if present) is space. Also space
> +splits different arguments.

	Arguments should be separated by a single unescaped space.

Do I understand correctly?

> +
> +The following sequences have special meaning:

Missing article:

	... have a special meaning:

> +
> +'\ '::
> +	Don't interpret the space as command/argument separator.

'\ '::
	Literal space in 'program' or an argument.

> +
> +'\\'::
> +	Literal backslash

Missing period.

> +'\s' (as argument)::
> +	Replaced by short name (receive-pack, upload-pack, upload-archive)
> +	of service git wants to invoke.

'\s'::
	Name (receive-pack, upload-pack, or upload-archive) of the
	service git wants to invoke.  Can only be used as an entire
	argument (like "ext::foo \s", not "ext::foo BLAH\sBLAH"),

Is that right?

> +'\S' (as argument)::
> +	Replaced by long name (git-receive-pack, git-upload-pack,
> +	git-upload-archive) of service git wants to invoke.

'\S'::
	Long name (git-receive-pack, ...

Does this really mean "name + 'git-'", or does it respect the
fetch-pack --upload-pack et al options?

> +'\G<repository>' (as argument)::
> +	This argument will not be passed to command. Instead, git will send
> +	in-line git:// service request for <repository>. Default is not to
> +	send in-line request.

'\G<repository>'::
	This argument will not be passed to 'program'. Instead, ...

Huh?  What is an in-line git://service request?

> +'\V<host>' (as argument)::
> +	Set the vhost used in in-line git:// service request. Default is
> +	to omit vhost.

Likewise.

> +ENVIRONMENT VARIABLES:
> +----------------------
> +
> +$GIT_EXT_SERVICE (passed to command)::
> +	Initialzed to long name of service git wants to invoke.

The existing manual pages tend to use 'italics' and leave out the $
here.

Maybe the environment passed to the command deserves its own section?
Just nitpicking.

s/Initialzed/Initialized/?  s/long name/the long name/? etc.

> +EXAMPLES:
> +---------

Maybe some introductory text would help.  E.g:

	This remote helper is transparently used by git when
	you use commands such as "git fetch <URL>" where <URL>
	begins with `ext::`.  Examples:

> +"ext::ssh -i /home/foo/.ssh/somekey user@host.example \S \'foo/repo'"::
> +	Use  /home/foo/.ssh/somekey as key when connecting to host.example
> +	and request repo foo/repo.

Probably worth mentioning this avoids adding a nickname and stanza
for this remote in ~/.ssh/config?

An address doesn't really request anything on its own.  Maybe saying
what they point to would be clearer?

	Represents a repository accessible at host.example:foo/repo
	when connecting as user "user" with private key "~foo/.ssh/somekey".

> +"ext::socat -t3600 - ABSTRACT-CONNECT:/git-server \G/somerepo"::
> +	Connect to git:// server named '/git-server' in abstract namespace
> +	and request '/somerepo' from it.

	Represents a repository with path /somerepo accessible over
	git protocol at Unix-domain socket address "/git-server".

> +"ext::git-server-alias foo \G/repo"::
> +	Connect to wherever 'git-server-alias foo' connects to and send
> +	git:// request there for '/repo'.

	Represents a repository with path /repo accessed using the
	helper program "git-server-alias foo".  The path to the
	repository and type of request are not passed on the command
	line but as part of the protocol stream, as usual with git://
	protocol.

> +"ext::git-server-alias foo \G/repo \Vfoo"::
> +	Connect to wherever 'git-server-alias foo' connects to and send
> +	git:// request there for '/repo' using vhost 'foo'.

	Represents a repository with path /repo accessed using the
	helper program "git-server-alias foo".  The hostname for the
	remote server passed in the protocol stream will be "foo"
	(this allows multiple virtual git servers to share a
	link-level address).

> +"ext::git-ssl foo.example /bar"::
> +	Connect to whatever repo 'git-ssl foo.example /bar' goes.

	Represents a repository accessed using the helper program
	"git-ssl foo.example /bar".  The type of request can be
	determined by the helper using environment variables (see
	above).

> --- a/Makefile
> +++ b/Makefile
[...]
> --- a/builtin.h
> +++ b/builtin.h
[...]
This boilerplate looks good, but where's the command?

> --- a/git.c
> +++ b/git.c
> @@ -374,6 +374,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "receive-pack", cmd_receive_pack },
>  		{ "reflog", cmd_reflog, RUN_SETUP },
>  		{ "remote", cmd_remote, RUN_SETUP },
> +		{ "remote-ext", cmd_remote_ext, 0 },
>  		{ "remote-fd", cmd_remote_fd, 0 },

The style of surrounding entries is to leave off the "0" where it can
be inferred like this.

Thanks for a pleasant read.
