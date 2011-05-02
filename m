From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 02 May 2011 12:30:33 -0700
Message-ID: <7vmxj4lx2e.fsf@alter.siamese.dyndns.org>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
 <BANLkTi=NOaWN56qBACoTE2WQWFM3rHXfWA@mail.gmail.com>
 <BANLkTikvYLKKj_Wd0EOxZh+vANxju4CV6Q@mail.gmail.com>
 <7v7ha9oxss.fsf@alter.siamese.dyndns.org>
 <BANLkTi=jABd5+_R-5SjhR163WV=TF1wbmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:30:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGypY-0007MN-9F
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab1EBTaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:30:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab1EBTap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:30:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31C8F447D;
	Mon,  2 May 2011 15:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vfiwru0/xK7yF48V4eu1NVWjd5M=; b=yHMBHO
	4JIH3ItjH8OdIf2sZP/busiAe4ckhbqS9ugs+MUmuyOlHiYguoDTN/POGGq4MfjL
	rcqsyJWeDkXJSxX4gwgaD31MFzxKDTrdZmdHW54otyrex926MilsCAjqYnH8ZzPo
	27m2pxVMbaYCKPq7iT+kNbfB+DxCZXXq1P8LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IoySeJSVgygkI04CSYwz/TDevAqLzUiX
	PUaMv1PgdexJ6kU6Yp3asmBzJ6YNqKWTASFR6HzCvRfM8IlGNr4NgVRN7ZdykCiH
	tnBRSk7AHobNs03gBYYecrwyfD+N2LrJT5R4lecBcRBho/MhkH7O86gJdz9OEb0M
	hGW/YyRb9lw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0082E447B;
	Mon,  2 May 2011 15:32:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 553CC4479; Mon,  2 May 2011
 15:32:38 -0400 (EDT)
In-Reply-To: <BANLkTi=jABd5+_R-5SjhR163WV=TF1wbmQ@mail.gmail.com> (Bert
 Wesarg's message of "Mon, 2 May 2011 21:14:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F304F258-74F2-11E0-84F9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172622>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> A build run will probably produce many warnings or errors (think of
> -j) for many files, so you need to handle more than one file. After
> the build run, you get a list of files which have warnings/errors,
> selecting one of the files will give you the original messages
> including the grep -@ output, from there you can select which message
> you want to consider opening in the editor, so grep -@ helps you in
> your decision what to open in your editor.

Now I got you talking ;-).

Wouldn't that workflow suggest that each invocation of -@ must be strongly
paired with each path?  After all, your hello.c having an error at line 100
does not have much to do with which lines in your goodbye.c are buggy.

Which has larger implications by opening a big can of worms.  Just a few
examples:

 - Should "git grep -@1 -@3 foo bar" show line 1 of foo and line 3 of bar,
   or should both lines 1 and 3 from both files be shown?  Why would
   anybody want to see line 3 of foo or line 1 of bar in such a case?

 - Later part of command line arguments on standard git command set are
   pathspecs, not necessarily individual paths.  You could for example say
   "git grep -@1 -@3 directory/". What should happen?  Should the first
   line of the first file in directory and the third line of the second
   file in directory be shown?  What would happen to the remaining files
   in the directory/?  You could replace "directory/" with "'*.c'".

   Perhaps use of -@ need to tighten the command line parsing to make sure
   that the user specified exact number of concrete filenames, not globs
   nor leading path prefixes, and otherwise error out?

I like "this range from this file, that range from that file" as a
concept.  It has far wider application than just in the context of "grep",
and I want to see us do it right from the beginning if we _were_ to design
it.  That is why I am poking this discussion to make sure I can solicit
deep enough thinking from people in the design phase.
