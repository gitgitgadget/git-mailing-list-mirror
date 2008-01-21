From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 21 Jan 2008 14:05:01 -0800
Message-ID: <7v1w8aygvm.fsf@gitster.siamese.dyndns.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
	<47946F67.5060601@gbarbier.org>
	<7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>
	<47947399.3000507@gbarbier.org>
	<7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801211212010.5731@racer.site>
	<7vejcbx795.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0801211539320.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Gr=C3=A9g?= =?utf-8?Q?oire?= Barbier 
	<devel@gbarbier.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4m9-000771-B5
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYAUWFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYAUWFY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:05:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbYAUWFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 17:05:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C73322364;
	Mon, 21 Jan 2008 17:05:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19F642361;
	Mon, 21 Jan 2008 17:05:13 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801211539320.13593@iabervon.org> (Daniel
	Barkalow's message of "Mon, 21 Jan 2008 16:30:40 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71357>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 21 Jan 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > IMHO it is safer to disable it for curl < 7.0xa -- even if it affects a 
>> > number of distros -- than to give the illusion that it works, when it does 
>> > not.
>> >
>> > As for fixing it in the non-MULTI case, I have a hunch that Mike's 
>> > cleanups will help that, but that this is a 1.5.5 feature.
>> >
>> > So, I would like to read in the ReleaseNotes something like this:
>> >
>> > -- snip --
>> > Support for pushing via HTTP was broken with curl versions prior to 7.16, 
>> > so we disabled it for now.  However, it is likely that a major cleanup of 
>> > the http transport code -- scheduled after the release of git 1.5.4 -- 
>> > will be supported with more curl versions.
>> > -- snap --
>> 
>> That's tempting but I suspect that it might be a wrong approach.
>> 
>> I think two important questions are:
>> 
>>  * Do we know that the current code is broken for everybody, or
>>    just broken for the majority of people who do nontrivial
>>    things?
>> 
>>  * Is the code in 1.5.3.8 any better?  IOW, did we make it worse
>>    during 1.5.4 cycle?
>
> I believe that the move to transport.c didn't change anything except 
> cleaning up linking conflicts and moving the dispatch by URL method code. 
> I suppose something could have gotten messed up in dealing with the 
> linking conflicts, but I don't think it actually did.

Ok, so copying 1.5.3.8 http-push to include in 1.5.4 would not
make it work, it sounds like.  Then I guess Dscho's notice (and
the same notice with disabling http-push without MULTI in
1.5.3.9) would be the sane thing we should do in the short term.
