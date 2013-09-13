From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 22:53:54 -0700
Message-ID: <xmqq7gelmfm5.fsf@gitster.dls.corp.google.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
	<5231CBFA.3070806@web.de> <5231F839.3080208@kdbg.org>
	<xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com>
	<CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 07:54:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKMKR-00078i-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 07:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab3IMFx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 01:53:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54902 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab3IMFx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 01:53:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8A403DF01;
	Fri, 13 Sep 2013 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HB3woHYwOK7UykQvv6yAmbxL28M=; b=SbM6Zr
	fv94Gp3j2NjXoLrFyRnhQl8cx1g+jWoTE9GWb7cjcbnlduM4QzfxmJKeaYd9z7Qd
	S+3FquKh+CB4Y6yNviZ47gYmMx4soyAFx9N4cInNmmWTMqC8ZZlU/w1LyF7SXIC9
	FJydUtpwMidLOdaUPMlYv05QEG0hDUcni/cj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7mGPHd7MKqyG1a3GuEd4q4dQUtHllEH
	hQBUYVFlWm3dX7LNoQz+4SjJ6OfsnWBrf0Bk//N+jFPH7z4LNiZ6/mNoIXhYb7vb
	8Yoivz7vTzJTzSK15vwXoRROfi3u/CFhAne09O0G+Q6an94nJgLcgWXaHchi4W0z
	X6NMJK3ObUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB7093DEFD;
	Fri, 13 Sep 2013 05:53:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49F5F3DEF1;
	Fri, 13 Sep 2013 05:53:56 +0000 (UTC)
In-Reply-To: <CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com>
	(Jiang Xin's message of "Fri, 13 Sep 2013 12:55:10 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1320B34-1C38-11E3-A039-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234731>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/9/13 Junio C Hamano <gitster@pobox.com>:
>>
>> For systems that need POSIX escape hatch for Apollo Domain ;-), we
>> would need a bit more work.  When both path1 and path2 begin with a
>> double-dash, we would need to check if they match up to the next
>> slash, so that
>>
>>  - //host1/usr/src and //host1/usr/lib share the same root and the
>>    former can be made to ../src relative to the latter;
>>
>>  - //host1/usr/src and //host2/usr/lib are of separate roots.
>>
>> or something.
>
> But how could we know which platform supports network pathnames and
> needs such implementation.

Near the end of

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_12

is this:

    If a pathname begins with two successive <slash> characters, the
    first component following the leading <slash> characters may be
    interpreted in an implementation-defined manner, although more than
    two leading <slash> characters shall be treated as a single <slash>
    character.

Two points to note are

 (1) Only paths that begin with exactly two slashes are special.

 (2) As it is "implementation-defined", we are not even allowed to
     treat that //host1/usr/src and //host1/usr/lib as sharing "the
     same root", and make the former to ../src relative to the
     latter.

So in the strictest sense, we do not have to bother. As long as we
make sure we do not molest anything that begins with exactly two
slashes.
