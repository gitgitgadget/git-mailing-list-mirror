From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Completion must sort before using uniq
Date: Sat, 24 Nov 2012 22:32:52 -0800
Message-ID: <7vtxsexkdn.fsf@alter.siamese.dyndns.org>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
 <CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
 <CAMP44s3qpr11JXi-znddAH2BWYbM_kp+nZnTa8CQgCzrBmfzmA@mail.gmail.com>
 <CAFj1UpHAqrNvpF+HAxJUPiWAiHbCn=7r1GDw3iMKy8FDW_-D_A@mail.gmail.com>
 <CAMP44s2bMub6T1YcUfsYWPQFU1bY4iU1WfSf+jFa7jSXAKTNaw@mail.gmail.com>
 <CAFj1UpH8h6c7xHuRG6F+pLy5YMvsJ0QdXsotCpLKnht0PsdiNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 07:33:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcVmA-0008Ur-CE
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 07:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844Ab2KYGcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 01:32:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab2KYGcy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 01:32:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A2EB6C20;
	Sun, 25 Nov 2012 01:32:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9yeVBaf6BE56q1Rz4nNxF43BUGY=; b=jkWdhd
	5u90kOcfBY6tQQGr6AG10o9CKVXbUZiilDr86XVQCPEka2PlpfLFSIbqM7zHymHf
	6tbbnaR5oADFAQ/6TgQAYZAqCQoZhzYJk7R+/D5X2GaVOVhqR/4bdxTEUrNbovHm
	HPD7Rr+dyeDV0n/quJUoYEJxjr3lSVvi1RvVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUmDkrOjp8HCH8WLKiSd8a1OUF6beemp
	/fjqYXxfzjF9m7ckDw1nTGFJsjybhKS3+TE6pDPsYwgPqlr1ZoYrxOXFz3QxjZXe
	Zi81LoEKrAp4tl18X4iEDnC3EPRIXFLgQGfbAooXRivnX+C7XGxaO04Yei62Kyy8
	k6j9fDOCuDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 279EB6C1F;
	Sun, 25 Nov 2012 01:32:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A67D6C1E; Sun, 25 Nov 2012
 01:32:53 -0500 (EST)
In-Reply-To: <CAFj1UpH8h6c7xHuRG6F+pLy5YMvsJ0QdXsotCpLKnht0PsdiNw@mail.gmail.com> (Marc
 Khouzam's message of "Fri, 23 Nov 2012 09:02:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F10E2402-36C9-11E2-81F8-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210334>

Marc Khouzam <marc.khouzam@gmail.com> writes:

> The user can be presented with invalid completion results
> when trying to complete a 'git checkout' command.  This can happen
> when using a branch name prefix that matches multiple remote branches.
>
> For example, if available branches are:
>   master
>   remotes/GitHub/maint
>   remotes/GitHub/master
>   remotes/origin/maint
>   remotes/origin/master
>
> When performing completion on 'git checkout ma' the user will be
> given the choices:
>   maint
>   master
> ...
> When dealing with 'git checkout mai', the list will be:
>   maint
>   maint

Wow, the description feels a tad repetitive for a one liner (it
describes "uniq -u" without pre-sort is wrong at least three times),
it would be better than no log message ;-)

I originally thought "uniq -u" was a misspelled "sort -u" when I
first saw your shorter version, but reading the code to see what is
fed to the command made it immediately obvious "sort | uniq -u" is
the right fix.  With the above explanation, you do not even need to
read the code to see what is fed to the command (it is explained ;-).

So, thanks for the fix.
