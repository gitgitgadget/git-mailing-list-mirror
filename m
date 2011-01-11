From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 10:24:01 -0500
Message-ID: <4D2C7611.6060204@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino> <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino> <4D278930.7010100@cfl.rr.com> <20110107214907.GA9194@burratino> <20110107220942.GB10343@sigill.intra.peff.net> <4D27B33C.2020907@cfl.rr.com> <20110111054735.GC10094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 16:24:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcg4l-0000Ho-M3
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 16:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab1AKPXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 10:23:55 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:45913 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab1AKPXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 10:23:53 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=3jtQBdTzPyV+fq4oCU/u8ZPrJJGN11HvhaDVxyWhycI= c=1 sm=0 a=IkcTkHD0fZMA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=Uz8AtSd8N45dNJWDb3YA:9 a=BkpTXpaOqM8OJdE0aRIA:7 a=4j61ZZtaDHG3N279NzMb3GjXiCkA:4 a=QEXdDO2ut3YA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:1517] helo=[10.1.1.235])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id B3/6B-02631-7067C2D4; Tue, 11 Jan 2011 15:23:52 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110111054735.GC10094@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164953>

On 1/11/2011 12:47 AM, Jeff King wrote:
> Once you have fetched with that view, how locked into that view are you?
> Certainly you can never push to or be the fetch remote for another
> repository that does not want to respect that view, because you simply
> don't have the objects to complete the history for them.

If you want to fetch the original history, then it is as simple as git
--no-replace-objects fetch.  Unless of course, the upstream repository
actually removed the original history ( or you are pulling from someone
else who only pulled the truncated history ), possibly transplanting it
to a historical repository that they should refer you to in the message
of the replace commit.  Then you just fetch from there instead, and
viola!  You have the complete original history.

> I guess you can get the parent pointer from the real, "non-replaced"
> object and ask for it. But you can't ask for a specific commit, so for
> every such truncation, the parent needs to publish an extra ref (but
> _not_ make it one of the ones fetched by default, or it would nullify
> your original shallow fetch), and we need to contact them and find that
> ref.

Yes, either a new branch or separate historical repository could be
published to pull the original history from, or git would need to pass
the --no-replace-objects flag to git-upload-pack on the server, causing
it to ignore the replace and send the original history.
