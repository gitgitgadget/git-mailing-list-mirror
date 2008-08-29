From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 21:02:46 -0700
Message-ID: <7vwsi0a2op.fsf@gitster.siamese.dyndns.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
 <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com>
 <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
 <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
 <20080828145706.GB21072@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 06:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYvDL-0006qb-M8
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 06:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbYH2ECz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 00:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbYH2ECz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 00:02:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbYH2ECz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 00:02:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA32454B0B;
	Fri, 29 Aug 2008 00:02:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BB9D454B09; Fri, 29 Aug 2008 00:02:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A465F9A-757F-11DD-8B36-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94247>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > HTTP Redirects
>> > --------------
>> >
>> > If a POST request results in an HTTP 302 or 303 redirect response
>> > clients should retry the request by updating the URL and POSTing
>> > the same request to the new location.  Subsequent requests should
>> > still be sent to the original URL.
>> 
>> At the first reading I was confused because this seemed to contradict with
>> the server pinning that is done by the payload level redirect.
>
> This is meant to help load balancing initially target to a server.
> I think its also reasonable to honor a transport level redirect,
> much as we honor whatever route IP gives us (not that we have a
> lot of choice - or even want one at that level).

Yeah, I think understood what you are trying to achieve here after reading
the document twice.

I was just pointing out that the language (or presentation order) was
confusing to me and I needed to read these two sections twice to see the
difference between the two redirects.

>> Is there a way to detect bad clients that does not obey this rule without
>> server side states?
>
> No.  Is that really a concern though?

I was more concerned about a bad/broken client not giving up forever, and
not giving the server enough cue to give up, saying "I've conversed with
this guy long enough but haven't reached the conclusion yet --- there is
something wrong".  Even without server side states, if we were to trust
clients, we can add "this is Nth round" to the protocol to help the server
detect "long enough" part, but that somehow does not feel right.
