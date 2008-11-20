From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 14:06:13 +0100
Message-ID: <492560C5.5070308@op5.se>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:07:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39Fp-0005i5-H4
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbYKTNGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYKTNGO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:06:14 -0500
Received: from mail.op5.se ([193.201.96.20]:56216 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbYKTNGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:06:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8FB4D1B8005E;
	Thu, 20 Nov 2008 14:01:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Mn0F+hjHO8D; Thu, 20 Nov 2008 14:01:17 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 0E10F1B80053;
	Thu, 20 Nov 2008 14:01:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081120112708.GC22787@ravenclaw.codelibre.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101419>

Roger Leigh wrote:
> On Wed, Nov 19, 2008 at 05:18:16PM +0100, Christian MICHON wrote:
>> On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
>>> Would it be possible for git to store the mtime of files in the tree?
>>>
>>> This would make it possible to do this type of work in git, since it's
>>> currently a bit random as to whether it works or not.  This only
>>> started when I upgraded to an amd64 architecture from powerpc32,
>>> I guess it's maybe using high-resolution timestamps.
>>>
>> beside the obvious answer it comes back often as a request, it is
>> possible in theory to create a shell script which, for each file
>> present in the sandbox in the current branch, would find the mtime of
>> the last commit on that file (quite an expensive operation) and apply
>> it.
> 
> Surely this is only expensive because you're not already storing the
> information in the tree; if it was there, it would be (relatively)
> cheap?

No, it's because git is *snapshot* based and doesn't care about anything
but contents. Storing filestate information in the tree would be a
backwards incompatible change that would require a major version change.

Caring about meta-data the way you mean it would mean that

  git add foo.c; git commit -m "kapooie"; touch foo.c; git status

would show "foo.c" as modified. How sane is that? Or should we introduce
a new concept for altered metadata only? "metafied"? So what do we do
when the next user whizzes along and wants support for full acl's? And
what do we do when Windows (or some other bizarre system) add some sort
of extension so we have to have different types of ACL support on both
systems? Kablooie and welcome to interoperability hell.

>  You could even compare the old and new trees to see if you
> needed to touch a file at all.
> 

We already do that by matching the SHA1 hash for the index entries.
Only content that is actually different between to branches are altered
upon checkout (which is why it's so damn fast when you're using topic-
branches properly).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
