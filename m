From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Handling of non-UTF8 data in gitweb
Date: Tue, 06 Dec 2011 16:37:29 -0800
Message-ID: <7vehwhcj3q.fsf@alter.siamese.dyndns.org>
References: <201112041709.32212.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=BCrgen?= Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 01:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY5Vy-0008Sn-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 01:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab1LGAhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 19:37:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093Ab1LGAhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 19:37:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B387E67C9;
	Tue,  6 Dec 2011 19:37:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EHcPkpjmAWN79nfdJ/CC+tWQHDk=; b=nwnwZr
	6C9fNcdjdr2eVTAbECBYFm2DPNswKWrByLmllNH3iEoirfWlPvtyTm74kZlIB0/O
	8dqowlbe/5lR6e0lWcojFsVz2toA61ZcSV4KVpNKGLJdbnLnpfolLuVg9g6aUlcl
	ToEyo1g27fL09SFibB54/GTFHm8gMTKoIMTSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQm8FQDkqdqchIbGepH65hLup9ZS8wIl
	7e7bY0bQN0uEWd+1xaK/RVcWiE+GqwagD/kS36eX13JsOWuTqsfwo97g8iI6RedU
	Ol4whIOX94gOP02TGnLVyMeQm5SYzowqt2700tQmgdj1hob79WFwqbJFo52LyqQn
	yVBAqyT8WPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A96C067C8;
	Tue,  6 Dec 2011 19:37:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E3C867C7; Tue,  6 Dec 2011
 19:37:31 -0500 (EST)
In-Reply-To: <201112041709.32212.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 4 Dec 2011 17:09:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5C67636-206B-11E1-A5F6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186408>

Jakub Narebski <jnareb@gmail.com> writes:

> But doing this would change gitweb behavior.  Currently when 
> encountering something (usually line of output) that is not valid 
> UTF-8, we decode it (to UTF-8) using $fallback_encoding, by default
> 'latin1'.  Note however that this value is per gitweb installation,
> not per repository.

I think we added and you acked 00f429a (gitweb: Handle non UTF-8 text
better, 2007-06-03) for a good reason, and I think the above argues that
whatever issue the commit tried to address is a non-issue. Is it really
true?

> ... I guess
> it could be emulated by defining our own 'utf-8-with-fallback'
> encoding, or by defining our own PerlIO layer with PerlIO::via.
> But it no longer be simple solution (though still automatic).

Between the current "everybody who read from the input must remember to
call to_utf8" and "everybody gets to read utf8 automatically for internal
processing", even though the latter may involve one-time pain to set up
the framework to do so, the pros-and-cons feels obvious to me.
