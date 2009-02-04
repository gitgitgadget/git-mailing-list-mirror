From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 4/9] unlink_entry(): introduce
 schedule_dir_for_removal()
Date: Wed, 04 Feb 2009 12:55:24 -0800
Message-ID: <7vfxitorb7.fsf@gitster.siamese.dyndns.org>
References: <cover.1233751281.git.barvik@broadpark.no>
 <5e00462034e14b628ad6744edc1fad7daee78c5c.1233751281.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUons-0000BL-Sw
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbZBDUzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbZBDUzb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:55:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbZBDUza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:55:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A91C09600C;
	Wed,  4 Feb 2009 15:55:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9B8F296001; Wed,
  4 Feb 2009 15:55:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27F0D92E-F2FE-11DD-B2C1-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108435>

Kjetil Barvik <barvik@broadpark.no> writes:

> Since the unlink_entry() function is called with alphabetically sorted
> names, this new function end up being very effective to avoid
> unnecessary calls to rmdir().  In some cases over 95% of all calls to
> rmdir() is removed with this patch.

I first feared that this will badly break D/F conflicting cases where we
remove a file D/F that is the last remaining file in directory D and rely
on the successful removal of the directory to create a file D, but the
check_updates() function already is structured to allow this late removal
easily.

I think the patch is sensible modulo minor nits.

 * The new global path_buf/path_len in unpack-trees.c are named too
   generic.  It is not just a buffer anybody can use for anything, but
   is used to keep track for a specific purpose of doing something, so
   please name them after that something.

 * "#define ALL_DIRS 0" is useless, given the way how the parameter to
   do_remove_scheduled_dirs() is named;
