From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH maint] builtin-merge.c: fix memory under-allocation
Date: Thu, 09 Oct 2008 09:15:02 -0500
Message-ID: <rKU9r5196P_JTKZZkb10yo7uwH_n_7KAuyX6RMOa9jc@cipher.nrlssc.navy.mil>
References: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil> <20081009001727.GP536@genesis.frugalware.org> <0LPLRUZaEHuEZTri_v38ySJHqYAhrfOpOkyUviUH9eOrx8IXBEAzYA@cipher.nrlssc.navy.mil> <7vmyheowcr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 16:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnwKp-0004H8-Rw
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 16:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbYJIOQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 10:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbYJIOQg
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 10:16:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52384 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbYJIOQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 10:16:35 -0400
Received: by mail.nrlssc.navy.mil id m99EF2uL008119; Thu, 9 Oct 2008 09:15:03 -0500
In-Reply-To: <7vmyheowcr.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 09 Oct 2008 14:15:02.0887 (UTC) FILETIME=[6BDB8F70:01C92A19]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97851>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> I didn't mean to imply that the memory under-allocation
>> was caused by a change in variable type in this case. Re-reading my commit
>> message, maybe it sounds like that.
> 
> Yeah, it does.  I was scratching my head and had to read the patch three
> times until I got it (yes, I am especially slower than usual today, as the
> reason I am reading mails right now is because I am jetlagged and cannot
> sleep).

If it's not too late, maybe this would make a better commit message:

--->8---
builtin-merge.c: allocate correct amount of memory

Fix two memory allocation errors which allocate space for a pointer rather
than enough space for the structure itself.

This:

    struct commit_list *parent = xmalloc(sizeof(struct commit_list *));

should have been this:

    struct commit_list *parent = xmalloc(sizeof(struct commit_list));
    
But while we're at it, change the allocation to reference the variable it is
allocating memory for to try to prevent a similar mistake, for example if the
type is changed, in the future.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
