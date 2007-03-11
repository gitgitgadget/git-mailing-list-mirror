From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prepare_packed_git(): sort packs by age and localness.
Date: Sat, 10 Mar 2007 19:07:13 -0800
Message-ID: <7vps7gxyu6.fsf@assigned-by-dhcp.cox.net>
References: <7vtzwsy0lb.fsf@assigned-by-dhcp.cox.net>
	<20070311023422.GE10343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 04:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQEP4-0000hz-68
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 04:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbXCKDHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 22:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbXCKDHQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 22:07:16 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46746 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932765AbXCKDHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 22:07:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311030715.RLFS24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Mar 2007 22:07:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZF7D1W00U1kojtg0000000; Sat, 10 Mar 2007 22:07:14 -0500
In-Reply-To: <20070311023422.GE10343@spearce.org> (Shawn O. Pearce's message
	of "Sat, 10 Mar 2007 21:34:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41899>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> When accessing objects, we first look for them in packs that
>> are linked together in the reverse order of discovery.
>> 
>> Since younger packs tend to contain more recent objects, which
>> are more likely to be accessed often, and local packs tend to
>> contain objects more relevant to our specific projects, sort the
>> list of packs before starting to access them.  In addition,
>> favoring local packs over the ones borrowed from alternates can
>> be a win when alternates are mounted on network file systems.
>
> ACK.  But...
>  
>> diff --git a/cache.h b/cache.h
>> @@ -431,6 +432,7 @@ extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
>> +void rearrange_packed_git(void);
>
> Is that really necessary to make public?

The next patch in the series was going to sort in a different
order (giving it a parameter to control the sort order) that is
more suitable while repacking, but it seems that the patch is
not needed.
