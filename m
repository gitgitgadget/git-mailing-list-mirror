From: chris <jugg@hotmail.com>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 4 Feb 2014 08:59:45 +0000 (UTC)
Message-ID: <loom.20140204T094437-148@post.gmane.org>
References: <loom.20140204T030158-758@post.gmane.org> <CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com> <loom.20140204T055040-646@post.gmane.org> <87r47jxp6k.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 10:00:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAbrb-0004kK-Jw
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 10:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbaBDJAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 04:00:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:47198 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaBDJAK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 04:00:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAbrU-0004hX-5N
	for git@vger.kernel.org; Tue, 04 Feb 2014 10:00:08 +0100
Received: from 1-165-180-147.dynamic.hinet.net ([1.165.180.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 10:00:08 +0100
Received: from jugg by 1-165-180-147.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 10:00:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 1.165.180.147 (Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241517>

David Kastrup <dak <at> gnu.org> writes:
> chris <jugg <at> hotmail.com> writes:
> > Duy Nguyen <pclouds <at> gmail.com> writes:
> >> On Tue, Feb 4, 2014 at 9:20 AM, chris <jugg <at> hotmail.com> wrote:
> >> > $ git push origin next
> >> > Counting objects: 56, done.
> >> > Delta compression using up to 4 threads.
> >> > Compressing objects: 100% (9/9), done.
> >> > Writing objects: 100% (9/9), 895 bytes | 0 bytes/s, done.
> >> > Total 9 (delta 8), reused 0 (delta 0)
> >> > Auto packing the repository for optimum performance.
> 
> > However, I question why I should even care about this message?  I'm going to
> > assume that simply it is a lengthy synchronous operation that someone felt
> > deserved some verbosity to why the client push action is taking longer than
> > it should.  Yet that makes me question why I'm being penalized for this
> > server side operation.  My client time should not be consumed for server
> > side house keeping.
> 
> Your "client time" is not consumed: this is not a busy wait.  Git server
> processes are synchronous: they are initiated and completed under the
> control of a client.  That means that if you run a batch script
> executing a number of commands in a client, it will not saturate the
> server with half-finished processes and/or will refuse to honor requests
> because the repository is locked.

I'm slightly confused by your response.  You say "client time" is not
consumed, but then go on to say that git server processes are synchronous to
avoid build up from batched client requests.  I expect you took "client
time" to have some specific technical meaning, while I simply meant that the
client command did not return until the server completed its own house keeping.

But I do think we are on the same page otherwise in that the client command
is blocked until the server process completes.

That said I would naively assume that a server side house keeping operation
that does not get invoked with every client request be a nice candidate for
asynchronous handling without any need to tell the client about it.

Regards,

Chris
