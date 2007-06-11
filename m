From: Scott Lamb <slamb@slamb.org>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 14:20:43 -0700
Message-ID: <466DBCAB.8090006@slamb.org>
References: <20070608202236.GJ25093@menevado.ms.com> <200706111656.33696.simon@lst.de> <81b0412b0706110844i12ebe52m21735815cc06effa@mail.gmail.com> <200706112042.16331.simon@lst.de> <20070611201232.GA4649@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxrJn-0003SR-U7
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 23:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbXFKVUv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbXFKVUv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 17:20:51 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:54811 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbXFKVUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 17:20:50 -0400
Received: from slamb-mac.dhcp.2wire.com (slamb-mac.vpn.slamb.org [172.16.0.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 62D55980D1;
	Mon, 11 Jun 2007 14:20:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070611201232.GA4649@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49886>

Alex Riesen wrote:
> Simon Hausmann, Mon, Jun 11, 2007 20:42:12 +0200:
>> On Monday 11 June 2007 17:44:04 Alex Riesen wrote:
>>> On 6/11/07, Simon Hausmann <simon@lst.de> wrote:
>>>> *plug* You could try with git-p4 from http://repo.or.cz/w/fast-export.git
>>>> . It should be just a matter of calling
>>>>
>>>>         git-p4 clone //depot/path
>>> Can I suggest you add a target directory mapping to your tool?
>>> Something like:
>>>
>>>   git-p4 clone //depot/project/path [libs/project/path] [rev-range]
>> I'm not sure I understand the libs/project/path part, ...
> 
> Your client contains the mappings. It defines how the pathnames on the
> p4 server relate to that on your computer. In the example above file
> from the depot path //depot/project/path can be found in the directory
> of the p4 client in the subdirectories libs/project/path.

git-p4 doesn't even use a p4 client, so the result is simply as it was 
on the server. It just does a "p4 print" on depot paths.

>> Han-Wen implemented also support for importing multiple depot paths at the 
>> same time (and tracking them in one git branch).
> 
> And where does he put the depot paths? As they are in depot? How does
> this corelate to the setups done by genuine P4 users (the poor souls)
> where the mappings are not always 1-to-1 right from the root? Or you
> haven't got any?

Could you give a concrete example of what you have and what you are 
trying to produce?

> 
>> The environment I'm working in is not too big and fairly liberal and 
>> reasonably disciplined.
> 
> You must be very strange environment indeed. Carefully balanced.

Not that strange. My company's setup is pretty simple, too. The project 
I'm working on just uses has each branch under 
"//depot/project/BRANCH/...". Maybe your environment is the odd one?

>>> And, BTW, don't you have a small problem with filenames with
>>> spaces and quoting?
>> I'm not aware of any problems. For example in our depot we have filenames with 
>> spaces in them and they appear just fine in my git import. Did you run into 
>> any specific case? It could very well be that there's a bug somewhere that 
>> I'm just not hitting myself, so I'm curious :)
> 
> No, I just looking at the source. Does python have some magic for
> running programs with system() when passed a format string? Like here:
> 
>         for f in filesToAdd:
>             system("p4 add %s" % f)
>         for f in filesToDelete:
>             system("p4 revert %s" % f)
>             system("p4 delete %s" % f)
> 
> BTW, sometimes you quote the names, but obviously wrong (think about
> filenames containing double quotes):
> 
>                 system("p4 edit \"%s\"" % path)
>                 editedFiles.add(path)

No, there's no magic. I can't imagine how these could work properly with 
complex filenames. They also don't do any checking of return values. I'm 
planning on sending in patches to make git-p4 use the Python subprocess 
module to do this better (as I did for git-p4import.py). It might take 
me a while to get to that item on my todo list, though - rather busy at 
work right now.

-- 
Scott Lamb <http://www.slamb.org/>
