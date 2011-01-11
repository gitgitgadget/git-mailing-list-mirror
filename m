From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 13:42:52 -0500
Message-ID: <4D2CA4AC.8060005@cfl.rr.com>
References: <20110106213338.GA15325@burratino> <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino> <4D278930.7010100@cfl.rr.com> <20110107214907.GA9194@burratino> <20110107220942.GB10343@sigill.intra.peff.net> <4D27B33C.2020907@cfl.rr.com> <20110111054735.GC10094@sigill.intra.peff.net> <20110111065244.GB8631@burratino> <4D2C7948.6080304@cfl.rr.com> <20110111182225.GE15133@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:42:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcjAp-0003UN-8S
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191Ab1AKSmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:42:23 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:42753 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab1AKSmW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 13:42:22 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=Inhw+Jdt7z1D3BivGPfn2aw54OvUEJw5lAn/booRZkE= c=1 sm=0 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=hU-Yyvw0tki6ssvcTOYA:9 a=BFH5EFavrNcAStdg3KYA:7 a=JK7ssGyVhr9PNAdhTKRmwOFSJcsA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:2298] helo=[10.1.1.235])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id A0/87-13137-784AC2D4; Tue, 11 Jan 2011 18:42:21 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110111182225.GE15133@burratino>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164971>

On 1/11/2011 1:22 PM, Jonathan Nieder wrote:
>> 1)  Those tracking your repo don't have breakage when they next fetch
>> because the chain of commits they were tracking has been destroyed and
>> replaced by a completely different one.
> 
> This does not require transport respecting replacements.  Just start
> a new line of history and teach "git pull" to pull replacement refs
> first when requested in the refspec.

That's what I've been saying.  My statement that you quote above is
stating why git replace is better than git filter-branch.

>> 2)  It is obvious when a replace has been done, and the original is
>> still available.  This is good for auditing and traceability.  Paper
>> trails are good.
> 
> With the method you are suggesting, others do _not_ always have the
> original still available.  After I fetch from you with
> --respect-hard-replacements, then while I am on an airplane I will
> have this hard replacement ref staring at me that I cannot remove.

They may not have it in their local repository, but it is clear that
there IS an original history, and the replace record comment should tell
them from where they can fetch it, and those tracking the repository
before the replace was added already have it.

Using filter-branch on the other hand, is a sort of dirty hack that
violates the integrity constrains normally in place, and can leave you
with a history that has no indication that there ever was more.

> If the original goes missing or gets corrupted on the few machines
> that had it, the hard replacement ref is permanent.

I think it goes without saying that if you loose part of the repository,
and there are no other copies, then you have lost part of the repository.

> If the modified history is much shorter than the original (as in the
> use case you described), would building it really take so much CPU and
> I/O?  Moreover, is the extra CPU time to keep checking all the
> replacements on the client side worth saving that one-time CPU time
> expenditure on the server?

It would take more than just inserting the replace record.  I'm not sure
what you mean by "keep checking all the replacements on the client side".
