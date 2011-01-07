From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Fri, 07 Jan 2011 14:43:14 -0500
Message-ID: <4D276CD2.60607@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbI8l-0001aO-2n
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab1AGTiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 14:38:16 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:32879 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab1AGTiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:38:15 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=uESSSoDEku2quKX/oFXS2Smn5+55LTFcWFr5T5T8nFs= c=1 sm=0 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=4tIPoHUA3evdjH-uq00A:9 a=fEkBBM25pZaRG94aukhjX7vVzeoA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:2849] helo=[10.1.1.235])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 45/80-07087-6AB672D4; Fri, 07 Jan 2011 19:38:15 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110106213338.GA15325@burratino>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164747>

On 1/6/2011 4:33 PM, Jonathan Nieder wrote:
> Therefore if you want clients to be able to choose between a minimal
> history and a larger one to save bandwidth, it has to work like this
> 
>  - to get the minimal history, fetch _without_ any replacement refs
>  - to get the full history, fetch the replacement refs on top of that.
> 
> because an additional reference can only increase the number of
> objects to be downloaded.

This seems backwards.  The original commit links to its parent and
therefore, the full history trail going back.  The reason you add the
replacement record is to get rid of that parent link, thus truncating
the history.  Therefore, if you fetch the original record that still has
the reference to its parent, and not the replacement record, you end up
with the full history.  Ergo, to get only the truncated history, you
must fetch the replacement record, and pay attention to it to stop
fetching commits older than the truncation point.

>  3. Use "git filter-branch" to make that history a reality (branch
>     "simpler").  Remove the replacement refs.

Isn't the whole purpose of using replace to avoid having to use
filter-branch, which throws out all of the existing commit records, and
creates an entirely new commit chain that is slightly modified?

>  4. Use "git replace" to graft back on the pieces you cauterized.
>     Publish the result.

If you are going to use filter-branch, then what do you need to replace?
 And publishing the result of a replace seems to have no effect, since
other people do not get the replace ref when they clone.

>  5. Perhaps also run and publish "git replace big simpler", so
>     contributors of branches based against the old 'big' can merge
>     your latest changes from 'simpler'.  Encourage contributors to
>     use 'git rebase' or 'git filter-branch' to rebase their
>     contributions against the new, simpler history.

Again, the entire point of replace seems to be to AVOID having to go
through the hassle of having to rebase or filter-branch.  Isn't that
exactly how you would accomplish this before replace was added?
