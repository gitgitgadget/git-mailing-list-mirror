From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Sun, 21 Jul 2013 22:02:06 -0700
Message-ID: <7vli4zqjap.fsf@alter.siamese.dyndns.org>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
	<1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
	<51EAEA76.9060502@ramsay1.demon.co.uk>
	<7v7ggjshk7.fsf@alter.siamese.dyndns.org> <51ECA746.7040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 07:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V18GF-0001lw-Ni
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 07:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab3GVFCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 01:02:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab3GVFCK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 01:02:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F36502BFB9;
	Mon, 22 Jul 2013 05:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uBUy2XBBLbLvfACx8fhYHMjtW8o=; b=aM2LY+
	frhmZNEv8mA8Er6w60baF54R2TFl9vdJeTP0wEc4JGc+nfN5wlbVCBcwlfq8g9Be
	e6qjNBCyRhpQG4HMBhCZ8SSuoK701jWGJAwAzoNF9VpG3rTxYNtG/i8OXpdtFZfC
	jSt1mpPFJxsFWU40Mss2WFDNuJKMzNoD1WhLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CITZSxRRpoQ0IajMq+/Ym41SFAP5sPa5
	w1UVu4Ly8YQtYUrpnpOatyV3j172iYd7l5rdZYczULJx5TptLrzguG3WEIQ00Opa
	E3bbPlOLPvTMXdBGzYy2RRCO3CY6oZKDR2DhmFzTSDArkp00CzhlA94fvTTKDFk5
	N3Oo3IzyEyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E27852BFB8;
	Mon, 22 Jul 2013 05:02:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 071422BFB6;
	Mon, 22 Jul 2013 05:02:07 +0000 (UTC)
In-Reply-To: <51ECA746.7040702@gmail.com> (Mark Levedahl's message of "Sun, 21
	Jul 2013 23:30:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC07A3D4-F28B-11E2-B714-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230958>

Mark Levedahl <mlevedahl@gmail.com> writes:

> On 07/21/2013 05:56 PM, Junio C Hamano wrote:
> ...
>> There are only three possible ways going forward, I think:
>>
>>   (A) Drop Mark's patch, and do nothing else, because breakages of
>>       other people's programs are not fixed by Cygwin 1.7's improved
>>       filesystem support, and users still use those mode breaking
>>       programs written by others;
>>
>>   (B) Drop Mark's patch, and revert c869753e, because it is not the
>>       business of our project to sweep breakages of other people's
>>       tools under the rug by crippling our software; or
>>
>>   (C) Drop NO_TRUSTABLE_FILEMODE for _all_ versions of Cygwin,
>>       declaring that the spirit of c869753e to work around bugs in
>>       other people's software by crippling Git is justified, but that
>>       it is no longer necessary on Cygwin because people do not use
>>       such misbehaving third-party tools anymore.
>>
>> These three each rely on its own precondition; I suspect it is
>> likely that (A)'s is the most accurate description of the real world.
>
> Perhaps the simplest approach is to just defer to the judgement of the
> Cygwin project maintainers here.
>
> a) The Cygwin project has its stated objective of being as matching Linux.

That does not say much.  On Linux, third-party "native Windows
applications" that necessitated c869753e (Force core.filemode to
false on Cygwin., 2006-12-30) to help users is not an issue.  On
Cygwin, it still is.

> b) The Cygwin project has always shipped git binaries built without
> NO_TRUSTABLE_FILEMODE

That is a fair point.  So let's do this instead.

-- >8 --
From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] cygwin: stop forcing core.filemode=false

We force core.filemode=false since c869753e (Force core.filemode to
false on Cygwin., 2006-12-30), even when the repository is on a
filesystem on which Cygwin can give us trustable filemodes, because
many native Windows applications the users use to edit files in the
working tree tend to (re)create files with executable bit randomly
set or reset.  However, binary distribution of Git that is supplied
by the downstream project to its users has been built without this
consideration.

Drop NO_TRUSTABLE_FILEMODE from our default configuration so that
hand-compiled Git out of box will match theirs.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 7ac541e..779d06a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -163,7 +163,6 @@ ifeq ($(uname_O),Cygwin)
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
-- 
1.8.3.3-1030-g100bb15
