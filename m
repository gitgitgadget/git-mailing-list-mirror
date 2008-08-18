From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/3] Cleanup of Branch command ready for verbose
	mode
Date: Mon, 18 Aug 2008 07:20:39 -0700
Message-ID: <20080818142039.GA9572@spearce.org>
References: <1219057305-9284-1-git-send-email-charleso@charleso.org> <1219057305-9284-2-git-send-email-charleso@charleso.org> <1219057305-9284-3-git-send-email-charleso@charleso.org> <48A97C23.8030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles O'Farrell <charleso@charleso.org>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 16:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV5cK-0005tZ-2T
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 16:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYHROUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 10:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYHROUl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 10:20:41 -0400
Received: from george.spearce.org ([209.20.77.23]:45229 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbYHROUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 10:20:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 167A538375; Mon, 18 Aug 2008 14:20:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48A97C23.8030103@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92709>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Charles O'Farrell wrote:
>> diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
> (...)
>> @@ -87,17 +91,27 @@ private void list() {
>>  		if (head != null) {
>>  			String current = head.getName();
>>  			if (current.equals(Constants.HEAD))
>> -				printHead("(no branch)", true);
>> -			for (String ref : new TreeSet<String>(refs.keySet())) {
>> -				if (isHead(ref))
>> -					printHead(ref, current.equals(ref));
>> +				addRef("(no branch)", head);
>> +			addRefs(refs, Constants.HEADS_PREFIX, !remote);
>> +			addRefs(refs, Constants.REMOTES_PREFIX, remote);
>
> We used to use (Constants.HEADS_PREFIX + '/') or  
> (Constants.REMOTES_PREFIX + '/') in such places, probably to handle  
> correctly jokes like refs named "refs/remotes_will_broke_your_code".

Yup.  I hate those constants because they are almost useless.
Almost anytime we need them, we really need to use instead
(Constants.FOO_PREFIX + '/').

> I've seen this expression so many times that I think it's right moment  
> to create another Constants.HEADS_PREFIX_SLASHED (same for tags,  
> remotes) or similar as this piece of this code is redundant in many  
> places. But wait, does anybody use pure ones without slashes? Maybe we  
> can just change existing constants.

Right.  It would be a nice cleanup to go through the existing users
and see if we cannot change the meaning of these.  But that's a
lot of code to change because you also have to delete the +'/'
we have everywhere.

> Beside of that detail, me (being just jgit developer) says that the  
> series looks good. Oh, and it's probably good to follow convention of  
> marking variables as final when they are final.

Yea, the series does look nice, except the prefix matching bug.

-- 
Shawn.
