From: Junio C Hamano <junkio@cox.net>
Subject: Re: needs merge
Date: Sat, 07 Jan 2006 02:28:47 -0800
Message-ID: <7voe2ol4bk.fsf@assigned-by-dhcp.cox.net>
References: <200601070332.36654.len.brown@intel.com>
	<200601070357.13954.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 11:28:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvBJb-00056w-PE
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 11:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWAGK2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 05:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbWAGK2t
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 05:28:49 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52948 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932343AbWAGK2s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 05:28:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107102638.VZHF17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 05:26:38 -0500
To: Len Brown <len.brown@intel.com>
In-Reply-To: <200601070357.13954.len.brown@intel.com> (Len Brown's message of
	"Sat, 7 Jan 2006 03:57:13 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14250>

Len Brown <len.brown@intel.com> writes:

> however, when i then merged that branch into another there seem to
> be some phantom conflicts on the very same files.

First of all, does the final merge result look correct, without
conflict markers?  I've slurped from your tree and tried the
merge myself and it seems that both branches and the merge
result of these branches have the conflicting path the same way,
so I think it did the right thing for you, but I am just trying
to make sure.

> Do I understand all this output to mean that git attempted two
> different merges, and discarded the 1st attempt in favor of the second?

Not really.  This is Fredrik's "recursive" merge in action.

acpica (ed03f4) is merged into test (e3627f), but these two
branches have criss-cross merge history and there are two
equally valid common ancestors, 0aec63 and ed349a.

What it did was first to find a merge between these two common
ancestors, during which it found conflicting merge on those
paths.

It then used this merge result (with conflict markers still in
them!) as the "virtual common ancestor" to merge the ed03f4 and
e3627f commits; because both branches have resolved the
conflicting part the same way earlier, this three-way merge
cancels out the part that are marked with conflict markers in
the virtual common ancestor (this is the cutest part of Fredrik
merge algorithm).
