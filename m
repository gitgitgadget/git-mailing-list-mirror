From: Tim Olsen <tim@brooklynpenguin.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Thu, 21 Jan 2010 11:37:17 -0500
Message-ID: <4B5882BD.3090908@brooklynpenguin.com>
References: <hj7abm$5vc$1@ger.gmane.org> <7vocko3802.fsf@alter.siamese.dyndns.org> <4B577C3F.7040608@brooklynpenguin.com> <7vtyugzabq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 17:38:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY02i-0003FO-7L
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab0AUQh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108Ab0AUQh4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:37:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:55844 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab0AUQhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:37:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NY02Q-000353-N3
	for git@vger.kernel.org; Thu, 21 Jan 2010 17:37:42 +0100
Received: from nyc01.limewire.com ([38.108.107.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 17:37:42 +0100
Received: from tim by nyc01.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 17:37:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nyc01.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
In-Reply-To: <7vtyugzabq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137670>

Junio C Hamano wrote:
> Tim Olsen <tim@brooklynpenguin.com> writes:
>> Breakpoint 8, write_tree_from_memory (o=0x7fffffffd560) at
>> merge-recursive.c:210
>> (gdb) list
>> 205				struct cache_entry *ce = active_cache[i];
>> 206				if (ce_stage(ce))
>> 207					output(o, 0, "%d %.*s", ce_stage(ce),
>> 208					       (int)ce_namelen(ce), ce->name);
>> 209			}
>> 210			return NULL;
>> 211		}
>> 212	
>> 213		if (!active_cache_tree)
>> 214			active_cache_tree = cache_tree();
>> (gdb)
> 
> Are you saying write_tree_from_memory() is returning NULL?  That probably
> means that in the recursive (i.e. the step that first merges multiple
> common ancestors into one) case the merge is getting conflicts.  Do you
> see these "There are unmerged index entries" output?

write_tree_from_memory() is returning NULL.  Stepping through the
execution in gdb shows it returning NULL at line 210.

I do not see any output, however:

$ git merge origin/deployed
Segmentation fault
$

> In the recursive case (i.e. o->call_depth is non-zero), process_renames()
> and process_entry() are supposed to be forcing the conflicts resolved,
> recording the contents with conflict markers if necessary, before the
> control gets to that point, so it clearly is a bug very specific to the
> recursive merge implementation.

Setting breakpoints on process_renames() and process_entry() shows that
they are being executed.  Is there anything I can gather from their
execution that would help you?

Tim
