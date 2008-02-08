From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH 3/4] git.el: Check for existing buffers on revert.
Date: Fri, 08 Feb 2008 15:54:34 +0100
Message-ID: <8763wzwlat.fsf@wine.dyndns.org>
References: <87r6fporp3.fsf@wine.dyndns.org> <87ve4zzfkl.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:55:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNUdl-0000DN-DU
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623AbYBHOyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbYBHOyu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:54:50 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:56710 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbYBHOyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:54:49 -0500
Received: from adsl-89-217-38-111.adslplus.ch ([89.217.38.111] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JNUcf-00089s-OG; Fri, 08 Feb 2008 08:54:44 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 928C71E7143; Fri,  8 Feb 2008 15:54:34 +0100 (CET)
In-Reply-To: <87ve4zzfkl.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	08 Feb 2008 17:30:02 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73098>

Sergei Organov <osv@javad.com> writes:

> What's the point? What if I do want to have modified buffer and still
> revert the on-disk file? Why git-revert cares to the level of
> prohibiting this?
>
> Besides, it's inconsistent with the rest of Emacs, I think, as in
> similar situations Emacs usually allows to either save the buffer(s), do
> not save the buffer(s) and continue, or abort operation (I suppose using
> (save-some-buffers) call, though I didn't check). See, for example, how
> (compile) behaves when some of buffers are not saved.

It's modeled on the vc-revert behavior, but yes, it could also prompt
whether to discard changes; prompting to save doesn't make sense if you
are about to throw away the changes. I think reverting the file on disk
without changing the buffer is confusing: either you want to discard the
changes, and you want to discard the buffer changes too, or you want to
keep your changes, and reverting the file on disk doesn't make sense
since the revert will be undone as soon as you save the buffer.

> In fact I believe the way PCL-CVS handles this, and that was implemented
> in my earlier patch, is superior compared to this patch. An addition of
> save-some-buffers call won't hurt either, but IMHO is not very useful in
> the specific case of git-revert.
>
> BTW, what definitely lacks (save-some-buffers) call is git-commit, as it
> silently commits on-disk state of a file when corresponding buffer is
> modified.

This could certainly be done, though it would have to be smarter than
a simple (save-some-buffers), I find it very annoying when compile
prompts to save a bunch of unrelated files.

-- 
Alexandre Julliard
julliard@winehq.org
