From: David Kastrup <dak@gnu.org>
Subject: Re: Performance problem, long run of identical hashes
Date: Mon, 10 Dec 2007 17:14:08 +0100
Message-ID: <85lk82plwv.fsf@lola.goethe.zz>
References: <9e4733910712100707i66e185bofe22805b8e0ba4d8@mail.gmail.com>
	<alpine.LFD.0.99999.0712101037270.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1loA-0001yW-1p
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbXLJQsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbXLJQsT
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:48:19 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:53320 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXLJQsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:48:18 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1J1lnk-0003eA-Fh; Mon, 10 Dec 2007 11:48:16 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E1F581C4CE33; Mon, 10 Dec 2007 17:14:08 +0100 (CET)
In-Reply-To: <alpine.LFD.0.99999.0712101037270.555@xanadu.home> (Nicolas
	Pitre's message of "Mon, 10 Dec 2007 10:45:49 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67734>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 10 Dec 2007, Jon Smirl wrote:
>
>> Running oprofile during my gcc repack shows this loop as the hottest
>> place in the code by far.
>
> Well, that is kind of expected.
>
>> I added some debug printfs which show that I
>> have a 100,000+ run of identical hash entries. Processing the 100,000
>> entries also causes RAM consumption to explode.
>
> That is impossible.  If you look at the code where those hash entries 
> are created in create_delta_index(), you'll notice a hard limit of 
> HASH_LIMIT (currently 64) is imposed on the number of identical hash 
> entries.

Well, impossible is a strong word to use with respect to code: bugs are
possible.  However, we have the assertion

	assert(packed_entry - (struct index_entry *)mem == entries);

in create_delta_index and that makes a pretty strong guarantee that the
culling of hash entries should be effective.  So at least the overall
_number_ of entries should be consistent.  If there is a bug, it might
be that they get garbled or something.

It is also not clear how this could cause an explosion of RAM
consumption in the loop.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
