From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] commit: make the error message on unmerged entries user-friendly.
Date: Wed, 06 Jan 2010 21:15:32 +0100
Message-ID: <vpqhbqz6lcr.fsf@bauges.imag.fr>
References: <1262783414-23101-1-git-send-email-Matthieu.Moy@imag.fr>
	<7veim3yx5o.fsf@alter.siamese.dyndns.org>
	<vpqtyuz86ny.fsf@bauges.imag.fr>
	<7v8wcbw14f.fsf@alter.siamese.dyndns.org>
	<vpqocl76mdo.fsf@bauges.imag.fr>
	<7vy6kbt2ww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 21:15:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NScIF-0001Ac-Th
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 21:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab0AFUPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 15:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552Ab0AFUPm
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 15:15:42 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57364 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932259Ab0AFUPl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 15:15:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o06KFV6J009852
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 21:15:32 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NScI0-0001AX-TR; Wed, 06 Jan 2010 21:15:32 +0100
In-Reply-To: <7vy6kbt2ww.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 06 Jan 2010 12\:05\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Jan 2010 21:15:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o06KFV6J009852
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1263413733.08195@CULki1Kwmr7SUxI2eyO7MA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136295>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> They'd use "pull", not merge. Anyway, I did it for commit, merge,
>> pull, revert, cherry-pick. I guess we covered the common cases.
>> The patch seems to have a lot of redundancies, but I think trying to
>> factor this into helper functions would be much more effort than the
>> few cut-and-paste that I had to do, since each instance is a slight
>> variant of each other ...
>
> I'd be more worried about longer term maintainability than one time
> expediency of producing your single patch to add these messages.  If the
> messages are cast in stone, we can just verify they are consistent _now_
> and forget about them, but I suspect not even you are perfect to predict
> that we won't come up with different/better ways to resolve and mark them
> resolved in the future and write a set of messages that won't have to
> change.

Sorry, I sent the message a bit too early. Re-reading the patch, there
were actually pieces to factor. There's still duplication between C
and shell, and sentences which are actually reworded from a place to
another.

OTOH, maybe this reveals some differences that should be eliminated.
For example, 'git cherry-pick' has no problem with
$GIT_DIR/MERGE_HEAD, while 'git merge' will immediately if it exists.
Maybe we should write a helper like
ensure_everything_is_ok_for_a_merge_or_die() called by both
cherry-pick and merge?

This time, patch actually follows ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
