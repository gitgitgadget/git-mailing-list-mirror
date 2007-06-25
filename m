From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: DWIM ref names for push/fetch
Date: Mon, 25 Jun 2007 19:45:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706251937470.11026@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0706241808550.4740@iabervon.org>
 <7v3b0gq4id.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706242234250.4740@iabervon.org>
 <7vodj4o973.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706251216210.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 20:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2tZf-0002iM-G6
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 20:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbXFYSp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 14:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXFYSp6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 14:45:58 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:60191 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752020AbXFYSp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 14:45:57 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0402BAD589
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 19:45:54 +0100 (BST)
Received: (qmail 16787 invoked by uid 103); 25 Jun 2007 19:45:54 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3517. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.034751 secs); 25 Jun 2007 18:45:54 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 25 Jun 2007 19:45:54 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0706251216210.4740@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50912>

On Mon, 25 Jun 2007, Daniel Barkalow wrote:

> On Sun, 24 Jun 2007, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>>
>>> I was actually thinking exclusively of the matching of strings like "HEAD"
>>> or "origin/next" or "master" to refs from the list of available refs. It
>>> seems to me like the push code does a better job of handling the same
>>> sorts of things that get_sha1() handles.
>>>
>>> In particular, the handling of "refs/my/funny/thing" is really wrong: it
>>> gets treated as refs/heads/refs/my/funny/thing.
>>
>> git-parse-remote.sh::canon_refs_list_for_fetch() seems to say
>> otherwise, though.
>>
>>  - When unspecified, or explicitly spelled HEAD, take HEAD;
>>  - Anything that begins with refs/, use it as is;
>>  - Anything that begins with heads/, tags/, remotes/, assume
>>    it is a branch, a tag, or a tracking branch;
>>  - Otherwise assume a branch;
>>
>> So I suspect refs/my/funny/thing is covered by the second rule.
>
> Ah, okay. I think a few bits got lost somewhat in Julian's translation to
> C. I agree with the first three rules there, and with the last rule being
> the last rule, and sticking more things in between those sets is easy
> enough.

Just for the record as it were, the difference between my C code and 
git-parse-remote.sh is simply that commit 96f12b5 changed the shell script 
behaviour after I had already started, and translating the code to C was 
hard enough without also trying to track a moving target.

Effectively Daniel is working slightly in the past, and has spotted the 
same issue that Alex has already fixed.

Mea Culpa.  Sorry.

>
>> But I do agree "otherwise assume a branch" part has huge room
>> for improvement.  Especially...
>>
>>> I think that "origin/next"
>>> should also be assumed to be refs/remotes/origin/next instead of
>>> refs/heads/origin/next, at least if you have refs/remotes/origin/ and not
>>> refs/heads/origin/.
>>
>> ... I think that makes perfect sense -- the code should
>> interpret your example as a request to start using a new
>> tracking branch refs/remotes/origin/next.
>
> Currently, it doesn't even notice if you've got the tracking branch
> already. Should it have some rule to prefer things that exist over things
> that don't?
>
> When refs/remotes/origin/next doesn't exist, should it require that
> refs/remotes/origin/ already exist?

It should at least require that a remote called origin exists perhaps?

-- 
Julian

  ---
<rcw> those apparently-bacteria-like multicolor worms coming out of
       microsoft's backorifice
<rcw> that's the backoffice logo
