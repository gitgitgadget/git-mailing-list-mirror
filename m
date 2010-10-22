From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix handling of git-p4 on deleted files
Date: Fri, 22 Oct 2010 11:52:34 -0700
Message-ID: <7vpqv2kqkt.fsf@alter.siamese.dyndns.org>
References: <AANLkTimzN9ZGwQZ-pi6SMWGY9KS0fjmXu=1gjdfck=W-@mail.gmail.com>
 <AANLkTimHHbg1zVX+1L7Dwgj5VmMFdUZ5X_Vf6UK_26An@mail.gmail.com>
 <AANLkTikOXp7Tz3F0Of7Ua2N39Z1S22WKh0K_zJFLGa2K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Berg <merlin66b@gmail.com>
To: Andrew Waters <apwaters@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MjR-0005NW-1X
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab0JVSwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:52:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0JVSwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:52:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59387E14B3;
	Fri, 22 Oct 2010 14:52:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UvWZRYe8Mdve9Qta4UVMBWV9+eY=; b=C5BgnVe9IrjzeONHPppFRiu
	EThzKi7lFZ9Zfo4rK5vvK42e8r4rxxdEcTxeRZWhjPVQH82irFrjWiov/iYVfugc
	AYLTHTGO9sUGTWkDQboSZMMotYG4R0X1fysHy8kXu3PHNBHzbaeh/S4Cc1ZI9/jo
	BwbhEhRdfIGe7xH2JbM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mS1V6xBvZhG+4hBvOZY2D+prlrzXwzY+Z8zRnXzxmd++vGt/4
	1u6mCYUwMlNJmUwuKOlhDit5m9SEruJkBTB9XBc4nqUpolq5dAzV6JO3dNGL7TOS
	NqoBYkX8OpqfpdZ7jo0Z4AJe6yS8fUbIn8DBXuRwUWf9a/Jdg7S78CwLHc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22208E14B2;
	Fri, 22 Oct 2010 14:52:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A5B2E14B1; Fri, 22 Oct
 2010 14:52:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B84AAB4-DE0D-11DF-89E1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159731>

Andrew Waters <apwaters@googlemail.com> writes:

> On 22 October 2010 11:20, Thomas Berg <merlin66b@gmail.com> wrote:
>> Hi,
>>
>> On Mon, Oct 18, 2010 at 5:39 PM, Andrew Waters <apwaters@googlemail.com> wrote:
>>> When you submit changes containing deleted file the command 'p4 diff
>>> -du ...' includes diffs for deleted files. This causes the failure:
>>>
>>> open for read: <deleted file>: No such file or directory
>>> Command failed: p4 diff -du ...
>>
>> I'm a daily git-p4 user and noticed this problem too: 'git p4 submit'
>> fails for commits with deleted files, with recent Perforce verions.
>> The problem has been brought up earlier [1], but no patch has actually
>> submitted yet.

Thanks for a resend.  Will queue.

> Signed-off-by: Andrew Waters <apwaters@googlemail.com>
> ---
>  contrib/fast-import/git-p4 |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index c1ea643..04ce7e3 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -706,7 +706,9 @@ class P4Submit(Command):
>              submitTemplate = self.prepareLogMessage(template, logMessage)
>              if os.environ.has_key("P4DIFF"):
>                  del(os.environ["P4DIFF"])
> -            diff = p4_read_pipe("diff -du ...")
> +            diff = ""
> +            for editedFile in editedFiles:
> +                diff += p4_read_pipe("diff -du %r" % editedFile)
>
>              newdiff = ""
>              for newFile in filesToAdd:
> -- 
> 1.7.2.2
