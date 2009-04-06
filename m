From: Sam Vilain <sam@vilain.net>
Subject: Re: GPG signing for git commit?
Date: Mon, 06 Apr 2009 18:05:38 +1200
Message-ID: <49D99BB2.2090906@vilain.net>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Chow Loong Jin <hyperair@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 08:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqhzf-0002ew-G2
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 08:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbZDFGF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 02:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZDFGF6
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 02:05:58 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:56083 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbZDFGF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 02:05:57 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 7E0C021CBF5; Mon,  6 Apr 2009 18:05:39 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 4625421CB7D;
	Mon,  6 Apr 2009 18:05:39 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115769>

Linus Torvalds wrote:
> On Sat, 4 Apr 2009, Chow Loong Jin wrote:
>   
>> It crossed my mind that currently git commits cannot actually be
>> verified to be authentic, due to the fact that I can just set my
>> identity to be someone else, and then commit under their name.
>>     
>
> You can't do that.
>
> Well, you can, but it's always going to be inferior to just adding a tag. 
>
> The thing is, what is it you want to protect? The tree, the authorship, 
> the committer info, the commit log, what?
>   
[...]
> Btw, there's a final reason, and probably the really real one. Signing 
> each commit is totally stupid. It just means that you automate it, and you 
> make the signature worth less. It also doesn't add any real value, since 
> the way the git DAG-chain of SHA1's work, you only ever need _one_ 
> signature to make all the commits reachable from that one be effectively 
> covered by that one. So signing each commit is simply missing the point. 
>
> IOW, you don't _ever_ have a reason to sign anythign but the "tip". The 
> only exception is the "go back and re-sign", but that's the one that 
> requires external signatures anyway.
>
> So be happy with 'git tag -s'. It really is the right way.
>   

Linus I agree with these points - I'd just like to point you to the new
mirror-sync design document. Under Documentation/git-mirror-sync.txt on
http://github.com/samv/git/tree/mirror-sync - and an implementation plan
outlined in Documentation/git-mirror-sync-impl.txt

This system allows for *pushes* to be signed and in general laying the
foundation for knowing that commits are authentic without the intrusion
into the refs/tags/* space that making lots of signed tags would imply.
The idea is to put 'packed-refs' contents (or a moral equivalent) in tag
bodies. It is really a new type of object, but it's sufficiently similar
to a tag that I thought I'd just go and go with that design for now.
Anyway if you're curious take a look, otherwise wait for the formal
submission once I've got something better together...

Sam
