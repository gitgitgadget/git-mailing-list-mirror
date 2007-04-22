From: Junio C Hamano <junkio@cox.net>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 12:03:39 -0700
Message-ID: <7vy7kkmdtg.fsf@assigned-by-dhcp.cox.net>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
	<7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
	<7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
	<7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221422250.28339@xanadu.home>
	<7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221431430.28339@xanadu.home>
	<alpine.LFD.0.98.0704221144250.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 21:03:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfhLc-00031L-Qx
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 21:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965662AbXDVTDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965673AbXDVTDl
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 15:03:41 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57767 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965662AbXDVTDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 15:03:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422190338.NIQA1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 15:03:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qK3f1W00F1kojtg0000000; Sun, 22 Apr 2007 15:03:39 -0400
In-Reply-To: <alpine.LFD.0.98.0704221144250.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 22 Apr 2007 11:54:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45268>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Apr 2007, Nicolas Pitre wrote:
>> 
>> Well, actually there is no point making pack files writable.  If they're 
>> modified, they get corrupted.
>> 
>> Here's the fix I wanted to propose:
>> 
>> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
>> index c72e07a..85c6e6e 100644
>> --- a/builtin-pack-objects.c
>> +++ b/builtin-pack-objects.c
>> @@ -1786,11 +1786,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>>  		if (rename(pack_tmp_name, tmpname))
>>  			die("unable to rename temporary pack file: %s",
>>  			    strerror(errno));
>> +		chmod(tmpname, 0444);
>
> I think this is wrong (as is Junio's). I think we should still honor the 
> repository permission setting, and default to honoring umask.
>
> So I think that if the user has a umask that says "nobody else can read", 
> then we should *not* make it world readable (unless the 
> "shared_repository" thing is set to override it, of course).

I obviously agree, but as a tentative measure, I'll push out
0644 version anyway.
