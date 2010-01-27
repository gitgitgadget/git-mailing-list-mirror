From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 12:22:16 -0800
Message-ID: <7vk4v3pabr.fsf@alter.siamese.dyndns.org>
References: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <alpine.LNX.2.00.1001271335140.14365@iabervon.org>
 <20100127185927.GA22630@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaEPK-00080O-AW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 21:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab0A0UW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 15:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635Ab0A0UW3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 15:22:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0A0UW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 15:22:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F49A94E1D;
	Wed, 27 Jan 2010 15:22:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E44cjSASbMY6hLv14HdlBpj04j8=; b=P+jycU
	izkZZtfH8PPcjK+JShd8OELmtr1WIwCt2+QD4nOk3/vSaClWwdYvyaem0TliBNN/
	o8iVrIjUCW5mPKr9ThfPigvSeRzPdt3UhrPLYkdhF8bf3FAJjh50C9mPpu+y+KC5
	usbOFc8+LcR4xW1ZkAamRCIUZtyXaRda51hT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2oT8KdnnVed5itbRTs0pF5rFXYwkuYT
	jSLUIW2SummITMtIY9mXPu5qWW2srspgdGYVLDXR4tHb/AxFi79RhVawj4eRy9F1
	K+IbGUiufBPhss5e4kv7reASyjnas4oI6RLfAY+CdqIwRIfoVuzMM7UewQ9CaEoX
	YH4UEoRutFI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FF2A94E18;
	Wed, 27 Jan 2010 15:22:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B9E994E15; Wed, 27 Jan
 2010 15:22:18 -0500 (EST)
In-Reply-To: <20100127185927.GA22630@Knoppix> (Ilari Liusvaara's message of
 "Wed\, 27 Jan 2010 20\:59\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD716FEA-0B81-11DF-AF5B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138194>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Wed, Jan 27, 2010 at 01:39:00PM -0500, Daniel Barkalow wrote:
>> On Wed, 27 Jan 2010, Ilari Liusvaara wrote:
>> >  
>> >  	if (!remote)
>> >  		die("No remote provided to transport_get()");
>> >  
>> >  	ret->remote = remote;
>> > +	helper = remote->foreign_vcs;
>> 
>> Needs to be "helper = remote ? remote->foreign_vcs : NULL", for the same 
>> reason that the test below had been "remote && remote->foreign_vcs".
>
> Few lines above that:
>
>      if (!remote)
>              die("No remote provided to transport_get()");

Perhaps we would want this micro-clean-up on top then.

-- >8 --
Subject: transport_get(): drop unnecessary check for !remote

At the beginning of the function we make sure remote is not NULL, and
the remainder of the funciton already depends on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/transport.c b/transport.c
index 87581b8..3846aac 100644
--- a/transport.c
+++ b/transport.c
@@ -921,7 +921,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->remote = remote;
 	helper = remote->foreign_vcs;
 
-	if (!url && remote && remote->url)
+	if (!url && remote->url)
 		url = remote->url[0];
 	ret->url = url;
 
