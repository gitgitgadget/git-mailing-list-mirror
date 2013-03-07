From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Thu, 07 Mar 2013 19:14:38 +0200
Message-ID: <5138CAFE.2010602@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi> <1362601978-16911-2-git-send-email-kevin@bracey.fi> <7vlia0nj0i.fsf@alter.siamese.dyndns.org> <513830AD.10302@bracey.fi> <7vd2vboepi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 19:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDfeC-0000O1-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336Ab3CGSeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:34:06 -0500
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:58025 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759683Ab3CGSeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:34:03 -0500
X-Greylist: delayed 4759 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2013 13:34:03 EST
Received: from mail178.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 85368FFACF4
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 18:25:57 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 7 Mar 2013 19:14:42 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 7 Mar 2013 19:14:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
In-Reply-To: <7vd2vboepi.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 14627410116434366686
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217606>

On 07/03/2013 09:23, Junio C Hamano wrote:
> If p4merge GUI labels one side clearly as "theirs" and the other 
> "ours", and the way we feed the inputs to it makes the side that is 
> actually "ours" appear in p4merge GUI labelled as "theirs", then I do 
> not think backward compatibility argument does not hold water. It is 
> just correcting a longstanding 3-4 year old bug in a tool that nobody 
> noticed.

It's not quite that clear-cut. Some years ago, and before p4merge was 
added as a Git mergetool, P4Merge was changed so its main GUI text says 
"left" and "right" instead of "theirs" and "ours" when invoked manually.

But it appears that's as far as they went. It doesn't seem any of its 
asymmetric diff display logic was changed; it works better with ours on 
the right, and the built-in help all remains written on the theirs/ours 
basis. And even little details like the icons imply it (a square for the 
base, a downward-pointing triangle for their incoming stuff, and a 
circle for the version we hold).

> For people who are very used to the way p4merge shows the merged
> contents by theirs-base-yours order in side-by-side view, I do not
> think it is unreasonable to introduce the "mergetool.$name.reverse"
> configuration variable and teach the mergetool frontend to pay
> attention to it.  That will allow them to see their merge in reverse
> order even when they are using a backend other than p4merge.
>
> With such a mechanism in place, by default, we can just declare that
> mergetool.p4merge.reverse is "true" when unset, while making
> mergetool.$name.reverse for all the other tools default to "false".
> People who are already used to the way our p4merge integration works
> can set mergetool.p4merge.reverse to "false" explicitly to retain
> the historical behaviour that you are declaring "buggy" with such a
> change.

I like this idea as a user - having made this change to p4merge, it does 
throw me when I decide to attempt a particularly tricky merge with bc3 
instead, and get the other order. The user config options you suggest 
sound good to me.

For completion on this idea, I'd suggest difftool.xxx.reverse, to allow 
the orientation for 0- and 1-revision diffs to be chosen - allow the 
implied working tree version to be on the left or right. That would 
allow "ours-theirs" order, which some would view as being more 
consistent with the "ours-base-theirs" default for mergetool.

Would it be going too far to also have "xxxtool.reverse" to choose the 
global default? Then the choice hierarchy would be "xxxtool.xxx.reverse 
if set" > "optional inbuilt tool preference" > "xxxtool.reverse if set" 
 > "false". So the user could request a global swap, except that they'd 
have to explicitly override any tools that have a preferred orientation.

My only reservation is that I assume it would be implemented by swapping 
what's passed in $LOCAL and $REMOTE. Which seems a bit icky: 
$LOCAL="a.REMOTE.1234.c". On the other hand, $LOCAL and $REMOTE are 
already not very meaningful names for difftool... Maybe we should change 
to using $LEFT and $RIGHT, acknowledging the existing difftool 
situation, and that the user can now swap merges too.

I'd be happy to prepare a fuller patch on this sort of basis.

Kevin
