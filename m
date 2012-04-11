From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Wed, 11 Apr 2012 16:49:14 -0700
Message-ID: <7v1untj0cl.fsf@alter.siamese.dyndns.org>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
 <CAMP44s2EunUabZdU23e+jYnBrWtBmhZeqt9yR+wV3X9HZhd7hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI7IB-0005yd-5U
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080Ab2DKXtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 19:49:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965020Ab2DKXtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 19:49:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00AD55CD4;
	Wed, 11 Apr 2012 19:49:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=rapD66+YGv5VenTB4p2uarTx4f4=; b=fS252LeLYq4kKZFGVXBi
	0kRv+GX+ZEvbv+TnY7lt3TORjTa1nox29O5SbVGOaho+SklsQSyrfPcimTU1NWZc
	9RqkBNgB7yJaxepHvzIIOtdwlcWASRWRtiwi28jjE+s7pKVYuUXkxjvJDVRMQg8v
	t19I5x9acZg3Bw6BOJQqyIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KFSUlh7oLnlC8E4Hu5TYR/BAjAnTuH4VTOk1NZo44aLiQV
	GDWxtX/kci2B7FuM5AdM7SejAHxgnEoEOkKPHvNOvgF3wdYnEagGCdRmq3stKEXF
	5vuww1WB5iiXtZY8sGwjtjQv1stBxK2s6rJHZ8gm3M4YpsfSmFHyEZne+baZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB0CC5CD3;
	Wed, 11 Apr 2012 19:49:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 761C75CD2; Wed, 11 Apr 2012
 19:49:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F23DB5FA-8430-11E1-A883-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195285>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Apr 8, 2012 at 7:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> What shell do you use on your system as /bin/sh (or if you use SHELL_PATH
>> in the Makefile to override it, what do you use)?
>
> /bin/sh is a symlink to bash on my system, and although bash defines
> POSIXLY_CORRECT, the tests pass just fine. I even tried to run /bin/sh
> --posix.

It really depends on what's in contrib/git-completion.bash and what you
test.  

For example, if a (possibly future) version of completion script had lines
like these (taken from 6486ca6d7):

	__some_function ()
        {
		...
                while read key value; do
                        ...
                done < <(git config -z --get-regexp ...
		...
	}

invoking "bash --posix" would have failed like this:

        $ bash --posix
        bash-4.1$ _a ()
        > {
        >   while read x; do
        >     echo "* $x"
        >   done < <(echo a; echo b)
        bash: syntax error near unexpected token `<'

Perhaps the "initial tests" you posted, together with the version of the
completion script we happen to have near 'master', didn't have any
construct that gives a visible failure like the above, but that is just by
dumb luck and is not a reason for us to be complacent and not to be
careful.

The early part of your re-roll (i.e. v2) seems to be done carefully to
make sure we run the script in full-fledged bash, from a quick glance.

Thanks.
