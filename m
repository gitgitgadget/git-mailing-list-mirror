From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Sun, 09 Dec 2012 23:04:59 -0800
Message-ID: <7v38zecrqc.fsf@alter.siamese.dyndns.org>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
 <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
 <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 08:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThxQa-0000UM-2j
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 08:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab2LJHFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 02:05:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab2LJHFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 02:05:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9E8F77DC;
	Mon, 10 Dec 2012 02:05:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2KCwji1Uf+ftnGIIZKL37vk2n5s=; b=u+p5Ud
	vg6ywmIcjd4/V74veGrq0rwZzfV5XXKQrICC8oS6Kg/+jD6o1cBJVx6NVst7Kzyg
	bkt8lh88ms0pJEqqmzzlbk3o8oqP8IoJsoaIRl5O2iBBUaYNEQqfkOnbr/daT3jD
	9SS3E3ubV0yT1b+M84MpHiU4k5VeI4a8diYio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J39z2rAElRFUnw3rphB7WO4xcKYBac5T
	/60fck0VXaZMv+/z3lLdcNn1DBtczwlTxonz+rvHhsR2dLrVdXcf3H1Jmjiv5DEU
	hJnSxR4YHoUgVUoOlHuqTSOei6hOsLUe0VVj2iL8dqk/4lsaAeuUPOyKo+HE4D5N
	lccV2yqczYA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D2A77DB;
	Mon, 10 Dec 2012 02:05:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3783677D8; Mon, 10 Dec 2012
 02:05:01 -0500 (EST)
In-Reply-To: <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com> (Zoltan
 Klinger's message of "Sun, 9 Dec 2012 22:18:19 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA43F0E6-4297-11E2-8E2E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211252>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> Would like to get some more feedback on the proposed output in case of
>  (1) an untracked subdirectory with multiple files where at least one of them
>      cannot be removed.
>  (2) reporting ignored untracked git subdirectories
>
> Suppose we have a repo like the one below:
>   test.git/
>     |-- tracked_file
>     |-- untracked_file
>     |-- untracked_foo/
>     |     |-- bar/
>     |     |     |-- bar.txt
>     |     |-- emptydir/
>     |     |-- frotz.git/
>     |     |     |-- frotx.txt
>     |     |-- quux/
>     |           |-- failedquux.txt
>     |           |-- quux.txt
>     |-- untracked_unreadable_dir/
>     |     |-- afile
>     |-- untracked_some.git/
>           |-- some.txt
>
> $ git clean -fd
> Removing untracked_file
> Removing untracked_foo/bar
> Removing untracked_foo/emptydir
> Removing untracked_foo/quux/quux.txt
> warning: failed to remove untracked_foo/quux/failedquux.txt
> warning: failed to remove remove untracked_unreadable_dir/

"remove remove" is a typo, I presume.

> warning: ignoring untracked git repository untracked_foo/frotz.git/
> warning: ignoring untracked git repository untracked_some.git/

If you mean "we report the topmost directory and nothing about
(recursive) contents in it if everything is removed successfully"
(in other words, if we had subdirectories and files inside
untracked_foo/bar/ and we successfully removed all of them, the
above output does not change), it seems quite reasonable.

> Use git clean --force --force to delete all untracked git repositories

But I am not sure if this is ever sane.  Especially the one that
removes an embedded repository is suspicious.  "git clean" should
not ever touch it with or without --superforce or any other command.

I do not think trying to remove something that cannot be removed due
to filesystem permissions is sensible, either. We simply should treat
such a case a grave error and have the user sort things out, instead
of blindly attempt to "chmod" them ourselves (which may still fail).

Thanks.
