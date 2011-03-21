From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Mon, 21 Mar 2011 22:34:31 +0100
Message-ID: <4D87C467.3090907@morey-chaisemartin.com>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <7v1v254ma7.fsf@alter.siamese.dyndns.org> <7vhbb1320t.fsf@alter.siamese.dyndns.org> <4D87B51A.4060609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:41:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1mr3-0007GX-3Y
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 22:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab1CUVlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 17:41:32 -0400
Received: from 63.mail-out.ovh.net ([91.121.185.56]:45084 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754399Ab1CUVlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 17:41:31 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2011 17:41:30 EDT
Received: (qmail 7561 invoked by uid 503); 21 Mar 2011 22:21:41 -0000
Received: from b9.ovh.net (HELO mail189.ha.ovh.net) (213.186.33.59)
  by 63.mail-out.ovh.net with SMTP; 21 Mar 2011 22:21:41 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 21 Mar 2011 23:34:48 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO ?10.0.2.12?) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 21 Mar 2011 23:34:47 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <4D87B51A.4060609@web.de>
X-Ovh-Tracer-Id: 14156783955579625399
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.500006/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169673>

On 21/03/2011 21:29, Jens Lehmann wrote:
> 
>>  - Update should refrain from touching the submodule itself. It may want
>>    to recurse into the submodule of the unmerged one, but people involved
>>    in submodule work should think things through;
> 
> I don't think recursing would make any sense here. It might be unknown
> to what commit the sub-submodules should be updated to if their commits
> differ in the unmerged branches. So I'd vote for not recursing at all in
> this case (which is what your patch does).
> 

After a bit of thinking about the way we use git at my company, there is something that could be done here. It may be completely useless for most people (or maybe even stupid and feel free to enlighten me!)
We work with continuous integration on two level of git (1 integration which only has submodules and lots of source repositories).
The usual thing when a user want to push its diff is:
- commit in the submodules on his branch
- Update the submodules refs in the integration repo on his branch
- Pull master 
- See there are conflicts
- Blindly pull master in all the conflicted submodules. Push the merge
- Commit in the integration repo and pray it works !

Although in the scheme git submodule update by itself does not make much sense. What people actually do is pretty much a git submodule update --merge of the conflicting SHA1 for each submodule.

For the moment we used either ruby scripts or a list of commands that users blindly follows without understanding much of it, and seeing something like that (there's probably a nicest way to do it) in git would be great.

>>  - Status does not have anything to report for an unmerged submodule. It
>>    may want to recurse into the submodule of the unmerged one, but people
>>    involved in submodule work should think things through; and
> 
> I do think status does have something to report here. First its job is to
> list all submodules, so currently unmerged submodules should show up too,
> and then it tells the user something about the state of the submodule. So
> I would propose to print a line for the submodule starting with a special
> character that tells the user the submodule has a merge conflict. We
> could e.g. use a '*' here (additionally to '-' for uninitialized and '+'
> for those submodules where the HEAD differs from the commit recorded in
> the superproject).
> 
Being a big user of __git_ps1, my brain now considers '*' has uncached diff and '+' has cached diff. I'd rather have something as 'U' that stands outs. But I like the idea any way !

Nicolas Morey-Chaisemartin
