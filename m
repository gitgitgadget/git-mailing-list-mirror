From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH] git-send-email.perl: Deduplicate "to:" and "cc:" entries
 with names
Date: Sat, 20 Nov 2010 14:47:15 -0800
Message-ID: <4CE84FF3.2070906@pcharlan.com>
References: <1290272809.27951.30.camel@Joe-Laptop>	 <m2mxp3zr88.fsf@igel.home> <1290286877.31117.15.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 23:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJwDl-00079q-OK
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 23:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab0KTWrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 17:47:45 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:43581 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab0KTWro (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 17:47:44 -0500
Received: from homiemail-a47.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 20D8A17B848
	for <git@vger.kernel.org>; Sat, 20 Nov 2010 14:47:44 -0800 (PST)
Received: from homiemail-a47.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a47.g.dreamhost.com (Postfix) with ESMTP id 936CD284063;
	Sat, 20 Nov 2010 14:47:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=K6DBp21u1kaenAeTB24MDIDSqEETzBDz5kWjuQfZ8CoY/um6GwpI82xzcPJKT
	0bYuwI3mkzxn6FoHT5z8CN3e7KHmkyVUOFHDWA9r3LXXeEefelCLJpZgUEhQpJwR
	ACtLAaY9JfYQDLTUByr19tgji/lxhZvI4useo9nBggpVU0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=a8Oj
	CrGhaeJBPzWUXKZa95E92S0=; b=gOad3kdo5tpHHp7XqWb6lT+MtCTIF72YD8SF
	eO3dDY8Cvc3enRJR6Jk+1lT4MhFUbAeQxJgQfY1iCikF9cL9g6203szLG6tCfCN/
	nMoNs6/xXjcaEZdwzV3dmCx4ESNi2akZNhvZMSnQQhqe13qBdLE7s6iVwrkzsMfE
	P64hbrw=
Received: from [192.168.1.12] (213.133-78-65.ftth.swbr.surewest.net [65.78.133.213])
	(Authenticated sender: pete@tento.net)
	by homiemail-a47.g.dreamhost.com (Postfix) with ESMTPA id 4DF5928405C;
	Sat, 20 Nov 2010 14:47:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1290286877.31117.15.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161845>

On 11/20/2010 01:01 PM, Joe Perches wrote:
> On Sat, 2010-11-20 at 21:15 +0100, Andreas Schwab wrote:
>> Joe Perches <joe@perches.com> writes:
>> > diff --git a/git-send-email.perl b/git-send-email.perl
>> > index f68ed5a..1ae5fbf 100755
>> > --- a/git-send-email.perl
>> > +++ b/git-send-email.perl
>> > @@ -960,7 +960,7 @@ sub maildomain {
>> >  sub send_message {
>> >  	my @recipients = unique_email_list(@to);
>> >  	@cc = (grep { my $cc = extract_valid_address($_);
>> > -		      not grep { $cc eq $_ } @recipients
>> > +		      not grep { $cc eq $_ || $_ =~ /<${cc}>$/ } @recipients
>>                                                     /<\Q${cc}\E>$/
> 
> Why are \Q and \E useful here?
> extract_valid_address provides an unadorned email address.
> I've now tested with and without, both seem to work properly.

Because email addresses can contain characters (e.g., '+') that you don't want the regular expression to treat specially.
