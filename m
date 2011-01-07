From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Fri, 07 Jan 2011 17:09:33 -0500
Message-ID: <4D278F1D.4020706@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino> <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino> <4D278930.7010100@cfl.rr.com> <20110107214907.GA9194@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:04:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKQQ-0004IC-FP
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1AGWEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:04:39 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:33067 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1AGWEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:04:39 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=pepdxKapwHuwCZNFD5uob2wvham6E+RljB0uXw08FdQ= c=1 sm=0 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=Qd2z2ZvcPVxy0eGD1OMA:9 a=pDW2Wkk0yEMgoBvtxTIA:7 a=Wv_8MX8jHI4eXR8zx22LwCu-n-wA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:3389] helo=[10.1.1.235])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 2D/2A-19545-5FD872D4; Fri, 07 Jan 2011 22:04:38 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110107214907.GA9194@burratino>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164771>

On 1/7/2011 4:49 PM, Jonathan Nieder wrote:
> No, it doesn't work that way.  Imagine for a moment that each commit
> object actually contains all of its ancestors.  That isn't precisely
> right but in a way it is close.
> 
> To change the ancestry of a commit, you really do need to change its
> name.  If you disagree, feel free to try it and I'd be glad to help
> where I can with the coding if the design is sane.  Deal?

That's why a replace record seems to be the perfect solution.  The
original record still references the old history, but you ignore it in
favor of the replacement, which does not.  Thus you have a choice; you
ignore the replacement and use the original with the full history
attached, or you respect the replacement and the history is truncated.

As long as git-upload-pack respects the replacement, then new checkouts
will ignore the old history.  You could then create a new historical
branch that points to the parent commit of the replaced one, and tell
people to fetch that branch to get the old history, or pass
--no-replace-objects over the wire to git-upload-pack.
