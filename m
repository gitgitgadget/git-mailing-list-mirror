From: Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: Question on git clone
Date: Thu, 06 Oct 2005 15:56:31 -0400
Message-ID: <4345816F.1080003@adaptec.com>
References: <4343F480.30501@adaptec.com> <7v64sbyk5e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 21:58:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENbr3-0004cT-OE
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 21:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVJFT4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 15:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVJFT4e
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 15:56:34 -0400
Received: from magic.adaptec.com ([216.52.22.17]:13442 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751337AbVJFT4e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 15:56:34 -0400
Received: from redfish.adaptec.com (redfish.adaptec.com [162.62.50.11])
	by magic.adaptec.com (8.11.6/8.11.6) with ESMTP id j96JuXc21233;
	Thu, 6 Oct 2005 12:56:33 -0700
Received: from rtpe2k01.adaptec.com (rtpe2k01.adaptec.com [10.110.12.40])
	by redfish.adaptec.com (8.11.6/8.11.6) with ESMTP id j96JuXg10299;
	Thu, 6 Oct 2005 12:56:33 -0700
Received: from [10.110.10.142] ([10.110.10.142]) by rtpe2k01.adaptec.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 6 Oct 2005 15:56:33 -0400
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64sbyk5e.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 06 Oct 2005 19:56:33.0423 (UTC) FILETIME=[0D2FF9F0:01C5CAB0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9779>

On 10/05/05 12:59, Junio C Hamano wrote:
> Luben Tuikov <luben_tuikov@adaptec.com> writes:
> 
> 
>>Cannot get remote repository information.
>>Perhaps git-update-server-info needs to be run there?
> 
> 
> Because HTTP support in git-fetch chooses not to trust the
> directory index the HTTP server may spit out, and relies solely
> on having info/refs file available there for discovering refs.
> 
> It is debatable if HTTP support in git-fetch should fall back on
> discovery using "wget -r" like Cogito does, when the info/refs
> file is not found.  I've written about this once on this list --
> I demonstrated what you would see if you do "wget -r" against
> git.git/refs/ on kernel.org; you will see why I do not think it
> is necessarily a better approach.

Thanks Junio for the reply.

I looked and indeed info/refs was ug+r while it should've been
a+r.  That fixed it.

Thanks again,
	Luben


> 
> Not doing refs discovery using directory index forces the owner
> of an HTTP reachable repository to create info/refs by running
> update-server-info.  This is a good thing -- it trains him to
> behave.
> 
> update-server-info does not just create info/refs. It also
> creates another file objects/info/packs, which is needed for
> fetching over a commit walker if the repository is packed.
> AFAIK, even if you are using Cogito, you would not succeed
> pulling from a repository that is packed and does not have this
> file.
> 
> There was a discussion about helping Cogito's tag-tracking.  The
> downloading side needs to know if any new tag available on the
> other side refers to a commit on the branches the downloader
> tracks, without pulling everything that tag object refers to
> first.  One way to help achieving this has been offered, which
> would involve adding a bit more information to info/refs, to say
> what object each tag refers to.  It could be done on the client
> side, but it is far simpler if this kind of help is given on the
> server side.
> 
> I anticipate in the future we may need to have more auxiliary
> files, or to add more information to existing auxiliary files,
> that summarize what the repository has for downloaders, and 
> code to do so would be added to update-server-info, so the
> repository owner needs to learn to run only one command.
> 
> 
> 
