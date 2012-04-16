From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Mon, 16 Apr 2012 10:26:40 -0400
Message-ID: <4F8C2C20.6080300@xiplink.com>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com> <20120413200721.GA3549@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJmtC-00041x-UI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 16:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab2DPO0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 10:26:40 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:46911 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab2DPO0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 10:26:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp4.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 5990A3A06D9
	for <git@vger.kernel.org>; Mon, 16 Apr 2012 10:26:38 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp154.ord.emailsrvr.com (smtp154.ord.emailsrvr.com [173.203.6.154])
	by smtp4.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 3D5963A06D2
	for <git@vger.kernel.org>; Mon, 16 Apr 2012 10:26:38 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id D846E190301;
	Mon, 16 Apr 2012 10:26:02 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp17.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 814F619030E;
	Mon, 16 Apr 2012 10:26:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <20120413200721.GA3549@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195636>

On 12-04-13 04:07 PM, Jonathan Nieder wrote:
> marcnarc@xiplink.com wrote:
> 
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -293,14 +293,18 @@ static int update_local_ref(struct ref *ref,
>>  		const char *msg;
>>  		const char *what;
>>  		int r;
>> -		if (!strncmp(ref->name, "refs/tags/", 10)) {
>> +		if (!prefixcmp(ref->name, "refs/tags/")) {
> 
> This part is just a clean-up, right?

Yes.

It seems most of the code in fetch.c uses prefixcmp(), so I thought I'd use
it for my patch.  But then I thought it looked weird for one check to use
strncmp() and the other to use prefixcmp().

After a cursory search for strncmp() and strcmp() in fetch.c, I think this is
the only place where prefixcmp() should've been used but wasn't.

It didn't seem worth making an extra patch for this change, but I've happy to
break it out if that's what folks want.

>>  			msg = "storing tag";
>>  			what = _("[new tag]");
>>  		}
>> -		else {
>> +		else if (!prefixcmp(ref->name, "refs/heads/")) {
>>  			msg = "storing head";
>>  			what = _("[new branch]");
>>  		}
>> +		else {
>> +			msg = "storing ref";
>> +			what = _("[new ref]");
>> +		}
> 
> Neat.  I like it, for what it's worth.

Thanks!

		M.
