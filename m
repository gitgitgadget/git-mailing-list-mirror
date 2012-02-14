From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Tue, 14 Feb 2012 10:40:04 -0800
Message-ID: <7vaa4l8diz.fsf@alter.siamese.dyndns.org>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org> <20120213203709.GA31671@ecki>
 <7vhayuctwm.fsf@alter.siamese.dyndns.org> <20120214092048.GC1762@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Feb 14 19:40:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxNIW-000094-FC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 19:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab2BNSkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 13:40:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab2BNSkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 13:40:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC345FD9;
	Tue, 14 Feb 2012 13:40:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDmTGmAonBdLFVXb+vrdlgFJzqU=; b=w0pv9w
	VgVfMJcszf7SenDVMET8FvcYxLu7uOM8eSKQBlsX5FXNLjkkjJYVrcTM3w6ULEmW
	kuXHFZn6wWw7AsnIM4WxA5lSG4ophlxfNX0NtuH/JaEi6zst2MTb4C6uI5VfNuSv
	87TUDaHBiphmRXhaKowiMLtSDKnVEWoIUDA/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EQP6TDZlAaA47IixQ2AxmZfWRKLy0/5v
	l6wQ7392SouET9nlTxLl0grSzQDdHQyQ/W67lnBJVcTlHj410ksxbwinTuuY3J2Y
	my3jC4qBGerkL8vF8C9kFL+CJ8KKcA84MKpIRKu77NXuwgAlytElKZjXrJVZub2N
	zBHANr1P8FM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5F5E5FD8;
	Tue, 14 Feb 2012 13:40:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37C835FD6; Tue, 14 Feb 2012
 13:40:06 -0500 (EST)
In-Reply-To: <20120214092048.GC1762@ecki> (Clemens Buchacher's message of
 "Tue, 14 Feb 2012 10:20:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5075C02C-573B-11E1-A6DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190732>

Clemens Buchacher <drizzd@aon.at> writes:

> On Mon, Feb 13, 2012 at 01:20:25PM -0800, Junio C Hamano wrote:
>> Clemens Buchacher <drizzd@aon.at> writes:
>> 
>> >> Erm,... do you really need the alias if you add git-p4 in a directory on
>> >> your $PATH?
>> >
>> > With recent git versions, this has stopped working.
>> 
>> Erm, I am confused.
>
> Looks like in my case it did not work because I had a PATH entry with a
> '~' in it. It probably stopped working for me because I moved some
> executables around.
>
> It's not a regression (I just tried with 1.6.0 and I get the same
> result).  And dash does not apply tilde expansion to PATH either.

I do not think tilde in $PATH is expanded by exec*p family to begin with,
so it is not "dash" but POSIX, I would think.  It is bash that is harming
other programs, by trying to be more helpful, encouraging this user
mistake to add ~ literally on the PATH.

You can see it in action below.

$ cd /var/tmp
$ cat >execlptest.c <<\EOF
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

int main(int ac, const char **av)
{
	int status = execlp("xyzzy", "xyzzy", NULL);
	printf("execlp returned %d (errno = %d, %s)\n",
	       status, errno, strerror(errno));
	return 0;
}
EOF
$ gcc -o execlptest execlptest.c
$ cat >/home/junio/junk/xyzzy <<\EOF
#!/bin/sh
exec lp test
EOF
$ chmod +x /home/junio/junk/xyzzy
$ PATH=/usr/bin:/bin
$ export PATH
$ /var/tmp/execlptest 
execlp returned -1 (errno = 2, No such file or directory)
: notice the sq pair around the value on the next line
$ PATH='/usr/bin:/bin:~/junk'; export PATH; echo "$PATH"
/usr/bin:/bin:~/junk
$ /var/tmp/execlptest 
execlp returned -1 (errno = 2, No such file or directory)
$ xyzzy
exec lp test
$ echo $BASH_VERSION
4.1.5(1)-release
