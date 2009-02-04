From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v3 4/9] unlink_entry(): introduce
 schedule_dir_for_removal()
Date: Wed, 04 Feb 2009 22:32:30 +0100
Organization: private
Message-ID: <86myd1zy4x.fsf@broadpark.no>
References: <cover.1233751281.git.barvik@broadpark.no>
 <5e00462034e14b628ad6744edc1fad7daee78c5c.1233751281.git.barvik@broadpark.no>
 <7vfxitorb7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 22:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUpO5-0006DY-Dc
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 22:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760564AbZBDVcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 16:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760639AbZBDVce
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 16:32:34 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:37202 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760622AbZBDVcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 16:32:33 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEK0089M96715A0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 22:32:31 +0100 (CET)
Received: from localhost ([80.203.29.216]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEK0047R966S270@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 22:32:31 +0100 (CET)
In-reply-to: <7vfxitorb7.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108439>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> Since the unlink_entry() function is called with alphabetically sorted
>> names, this new function end up being very effective to avoid
>> unnecessary calls to rmdir().  In some cases over 95% of all calls to
>> rmdir() is removed with this patch.
>
> I first feared that this will badly break D/F conflicting cases where we
> remove a file D/F that is the last remaining file in directory D and rely
> on the successful removal of the directory to create a file D, but the
> check_updates() function already is structured to allow this late removal
> easily.
>
> I think the patch is sensible modulo minor nits.

  Yes, if the 2 for-loop's inside check_updates() is rewritten into 1
  for-loop, then you could end up with such a conflict.  Should I add a
  comment about this inside check_updates()?

>  * The new global path_buf/path_len in unpack-trees.c are named too
>    generic.  It is not just a buffer anybody can use for anything, but
>    is used to keep track for a specific purpose of doing something, so
>    please name them after that something.

   Already done in v3 (this version), since the functions
   schedule_dir_for_removal() and remove_scheduled_dirs() is now
   implemented in the symlinks.c file, where I have made the following:

static struct removal_def {
	char path[PATH_MAX];
	int len;
} removal;

>  * "#define ALL_DIRS 0" is useless, given the way how the parameter to
>    do_remove_scheduled_dirs() is named;

  Ok, I can do a rebase of this patch (4/9) and resend the patches.

  -- kjetil
