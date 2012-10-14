From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reflog delete HEAD@{1} HEAD@{2} caught me by surprise...
Date: Sat, 13 Oct 2012 21:49:33 -0700
Message-ID: <7vlif91wv6.fsf@alter.siamese.dyndns.org>
References: <20121013220855.24116.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 06:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGC0-0001oU-V2
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 06:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab2JNEth convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 00:49:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab2JNEtg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 00:49:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82496157;
	Sun, 14 Oct 2012 00:49:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UmCVrsvSNSFB
	3vg00wI19tkqnoM=; b=iu/TX2HdSLfyWbdwtWdcvkmMizNOo5dGtJ8Xt2cYOoWb
	iVEPMyzVy7kHTwt65z1ceCozfQ96jIinbq6DjwfkpwtWaKntnH/QrnEg7f/X/uBx
	Ez2INv/AFW5aEbLMcs5EElLi0v/aHrxl2Oz8M9IDcMQ8vvhDAO9HAC0nh+V4IW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t4F7ZV
	646LY5Ug4Je8Q5Sf8ICXEBFMfIP363qHMMt25G0u5yY+ZaVYy7jXaNL+jfpGqG0X
	RGB6KRo1YsheHHe7HNmcHXQ3GmTKyeEg9CN+qvtpB9DPb/gvB7GaITlzpsnp9mMC
	iTz1KLw16nehG6QD5MXYJOOO+M3FfZj10z1ds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C552B6156;
	Sun, 14 Oct 2012 00:49:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 204BD6154; Sun, 14 Oct 2012
 00:49:34 -0400 (EDT)
In-Reply-To: <20121013220855.24116.qmail@science.horizon.com> (George
 Spelvin's message of "13 Oct 2012 18:08:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D306628-15BA-11E2-A22D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207609>

"George Spelvin" <linux@horizon.com> writes:

> Try the following commands in an empty directory:
> (I'm using the bash extention for {1..5}.)
>
> git init
> for i in {1..5}; do git commit -m "Commit $i" --allow-empty; done
> git reflog
> 	bc93e06 HEAD@{0}: commit: Commit 5
> 	e14f92d HEAD@{1}: commit: Commit 4
> 	ac64d8e HEAD@{2}: commit: Commit 3
> 	287602b HEAD@{3}: commit: Commit 2
> 	183a378 HEAD@{4}: commit (initial): Commit 1
> git reflog delete HEAD@{{1,2}}
> git reflog
> 	bc93e06 HEAD@{0}: commit: Commit 5
> 	e14f92d HEAD@{1}: commit: Commit 3
> 	287602b HEAD@{2}: commit (initial): Commit 1
>
> Er...I meant to delete Commit 3 from the reflog, not Commit 2.

Yeah, I've never tried to delete more than one with one command,
but I am not surprised a naa=C3=AFve implementation removes the first,
and then removes the second in the resulting list.

> To delete single entries from the reflog, use the subcommand "delete"
> and specify the _exact_ entry (e.g. "`git reflog delete master@{2}`")=
=2E
>
> You may delete multiple reflog entries with one delete command,
> _however_ they are processed one at a time, so earlier deletes will c=
ause
> renumbering that will affect later ones.  To delete reflog entries @{=
2}
> and @{3}, the command would be either "`git reflog delete @{3} @{2}`"=
,
> or "`git reflog delete @{2} @{2}`".

I would actually call that behaviour a bug.  Perhaps it should grab
all the command line arguments first, group them per the ref the
reflog entries are based on, and expire _all_ reflog entries from
the same reflog in one go?

Until that happens, it may make sense to error it out when more than
one entries are given from the command line, at least for the same
ref.
