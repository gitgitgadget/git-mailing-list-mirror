From: chris <jugg@hotmail.com>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 4 Feb 2014 05:13:17 +0000 (UTC)
Message-ID: <loom.20140204T055040-646@post.gmane.org>
References: <loom.20140204T030158-758@post.gmane.org> <CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 06:14:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAYKl-0007qN-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 06:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbaBDFNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 00:13:48 -0500
Received: from plane.gmane.org ([80.91.229.3]:38593 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbaBDFNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 00:13:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAYKJ-0007d9-IS
	for git@vger.kernel.org; Tue, 04 Feb 2014 06:13:39 +0100
Received: from 1-165-180-147.dynamic.hinet.net ([1.165.180.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:13:39 +0100
Received: from jugg by 1-165-180-147.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:13:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 1.165.180.147 (Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241511>

Duy Nguyen <pclouds <at> gmail.com> writes:
> On Tue, Feb 4, 2014 at 9:20 AM, chris <jugg <at> hotmail.com> wrote:
> > $ git push origin next
> > Counting objects: 56, done.
> > Delta compression using up to 4 threads.
> > Compressing objects: 100% (9/9), done.
> > Writing objects: 100% (9/9), 895 bytes | 0 bytes/s, done.
> > Total 9 (delta 8), reused 0 (delta 0)
> > Auto packing the repository for optimum performance.
> 
> This string only appears in versions before 1.8.0. It's longer after 1.8.0.
> 
> > To ssh://git <at> my.server.com/my_project
> >    3560275..f508080  next -> next
> > $ git config gc.auto
> > 0
> > $ git config gc.autopacklimit
> > 0
> > $ git --version
> > git version 1.8.5.3
> 
> but your client is after 1.8.0 so the string printed above is from the
> server side. "git config gc.auto" here does not matter. Run that
> command again on my.server.com.

Ok, so I can understand if the message is from the server.  I'll chalk up
never noticing it before to someone else always being the lucky one to
trigger it.

However, I question why I should even care about this message?  I'm going to
assume that simply it is a lengthy synchronous operation that someone felt
deserved some verbosity to why the client push action is taking longer than
it should.  Yet that makes me question why I'm being penalized for this
server side operation.  My client time should not be consumed for server
side house keeping.

An obvious fix is to disable gc on the server and implement a cron job for
the house keeping task.  However, as often the case one does not have
control over the server, so it is unfortunate that git has this server side
house keeping as a blocking operation to a client action.

> > So my question is, should gc.auto = 0 disable auto-packing from occurring on
> > git push and other non-gc commands?
> 
> Yes it should.

Thanks for the confirmation.

Regards,

Chris
