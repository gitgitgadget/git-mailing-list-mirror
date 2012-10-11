From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rm and add, but not rename, of identical files
Date: Thu, 11 Oct 2012 09:53:12 -0700
Message-ID: <7v4nm17xxj.fsf@alter.siamese.dyndns.org>
References: <1349894347.32696.10.camel@drew-northup.unet.maine.edu>
 <7v1uh6atjl.fsf@alter.siamese.dyndns.org>
 <1349968240.32696.22.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMM0k-0008Ox-P9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 18:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab2JKQxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 12:53:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758839Ab2JKQxP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 12:53:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 086B694FA;
	Thu, 11 Oct 2012 12:53:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xMTB2Ele9L6M
	o3E4BRKXkRAJ1LY=; b=omVO1aSP3LTsaqTk5wgyT05sW3WeV4xpD3FjwFpBZQlM
	MzqxV/EDHpBwc7tbA7qjZj65tG3O57YBdmESolrlwlBhvm7tiT6jplwHVFISI5v5
	R1mAv9swGjKDJdjuSfrYFfULKNH8rtmIFXuUbZT/izXnck5BJaQM0hMTy5l5f4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N0UVNu
	H70iuIHG2v6f48d4bPc9pk64kuiTFM3x6UeVxDHuK5j4U5mnqKMJfml95CSf848e
	z3ZjyVvAPvBMI9tTj6/3z19ZQbwAErFhY7V7BAKnWWpuP7SoxlCJf5WJuA4xHUd+
	GX4dmGRgcHriTv6EaUVFEbD1+FaKwIrkAPa5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE7094F8;
	Thu, 11 Oct 2012 12:53:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50A3494F5; Thu, 11 Oct 2012
 12:53:14 -0400 (EDT)
In-Reply-To: <1349968240.32696.22.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Thu, 11 Oct 2012 11:10:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25CEF58C-13C4-11E2-895B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207487>

Drew Northup <drew.northup@maine.edu> writes:

> On Wed, 2012-10-10 at 14:47 -0700, Junio C Hamano wrote:
>> Drew Northup <drew.northup@maine.edu> writes:
>>=20
>> > # Untracked files:
>> > #   (use "git add <file>..." to include in what will be committed)
>> > #
>> > #       rc.d/rc2.d/S08iptables
>> > #       rc.d/rc3.d/S08iptables
>> > #       rc.d/rc4.d/S08iptables
>> > ...
>> > no changes added to commit (use "git add" and/or "git commit -a")
>> >
>> > It detects the changes as renames however=E2=80=95which in this ca=
se isn't
>> > appropriate:
>> >
>> > [root@drew-northup ~]# etckeeper vcs status
>> > # On branch master
>> > # Changes to be committed:
>> > #   (use "git reset HEAD <file>..." to unstage)
>> > #
>> > #       renamed:    rc.d/rc2.d/K92iptables -> rc.d/rc2.d/S08iptabl=
es
>> > #       renamed:    rc.d/rc3.d/K92iptables -> rc.d/rc3.d/S08iptabl=
es
>> > #       renamed:    rc.d/rc4.d/K92iptables -> rc.d/rc4.d/S08iptabl=
es
>> > #...
>>=20
>> Given that all of these six files have the same contents, I actually
>> am slightly impressed how well Git matched them up ;-).
>>=20
>> But more seriously, why do you have rc.d/rc2.d/S08iptables untracked
>> in the working tree but in the index to be committed?
>
> Missing steps in the mail body: etckeeper vcs add <File> & etckeeper =
vcs
> rm <File> commands. I pared it back to the absolute minimum.
>
> Is that what you're asking about?

Yes.  Without the "add" step, detecting the K92iptables that has
been moved to an untracked S08iptables as rename looked like a magic
(read: bug) to me, and that was why I asked.

Aren't K92iptables and S08iptables the same script with

  case "$1" in start) ... start thing ...;; stop) ... stop thing ...;; =
esac

in it?

On Debian, these S/K files appear directly under /etc without
intermediate rc.d level, and they are symbolic links to real files
in /etc/init.d/, so extrapolating from that knowledge and with a bit
of imagination that some systems might keep copies of these files
instead of linking to the same thing, I would actually find it
desireable to call the move from K92iptables to S08iptables a
rename, rather than reporting a removal and a addition of unrelated
files.
