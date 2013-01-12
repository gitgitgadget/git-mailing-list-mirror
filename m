From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Sat, 12 Jan 2013 00:23:39 -0800
Message-ID: <7vpq1aizck.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org>
 <CAN8TAOvP_HX6BEK86aYoX-kVqWDmsbyptxTT2nk+fx+Ut1Tojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jardel Weyrich <jweyrich@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtwNs-0003jJ-Kt
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 09:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab3ALIXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 03:23:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab3ALIXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 03:23:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9964593D7;
	Sat, 12 Jan 2013 03:23:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q1xEwNyEPR6ciK7bd3vyuH5yTYQ=; b=keKkpL
	iOh/FhMRg8DW+GSP0BVXWIWj2dFB94BD/uXIEjrQW5rHUXwuyhXisNZdG7BmEPpM
	tG4XnHgt9OcdicyfFkMq/0FslwduPpDu7sepQxN4ytRRc151nM3c2NZkeoj8Kr7n
	Cwx0TDy8Li7gII4js26Yl06IBfQnd3zAbe1/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AVIO1YjiHrnkfOUJwjmdmf6KHEGlOVEp
	sj7wGT0Gu35zgIRA2SWdhhbfjTcpVJv1eI0K66H7qC6lfWB53i+4A3NAjE/X9XxK
	QRqYjDdn3nROTMEUk0aDHp7TUh5UUq6ie2xquzegDZf306hUhC/IgCceJbAKbrM7
	zQMSUdjZQq0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B68193D6;
	Sat, 12 Jan 2013 03:23:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07CBE93D4; Sat, 12 Jan 2013
 03:23:40 -0500 (EST)
In-Reply-To: <CAN8TAOvP_HX6BEK86aYoX-kVqWDmsbyptxTT2nk+fx+Ut1Tojg@mail.gmail.com> (Jardel
 Weyrich's message of "Sat, 12 Jan 2013 06:09:35 -0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F1EC144-5C91-11E2-B4C4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213276>

Jardel Weyrich <jweyrich@gmail.com> writes:

> Step 1:
>
> jweyrich@pharao:test_clone1 [* master]$ git remote -v
> origin /Volumes/sandbox/test (fetch)
> origin /Volumes/sandbox/test (push)
>
> jweyrich@pharao:test_clone1 [* master]$ git config -l | grep '^remote\.origin'
> remote.origin.url=/Volumes/sandbox/test
> remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
>
> Step 3:
>
> jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add
> --push origin /Volumes/sandbox/test_clone2
> origin /Volumes/sandbox/test (fetch)
> origin /Volumes/sandbox/test_clone2/ (push)
>
> jweyrich@pharao:test_clone1 [* master]$ git config -l | grep '^remote\.origin'
> remote.origin.url=/Volumes/sandbox/test
> remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
> remote.origin.pushurl=/Volumes/sandbox/test_clone2/

So "remote -v" is not lying (we only see one pushurl after Step 3
above) and "set-url" is not working correctly on your box in a way
that I cannot reproduce X-<.

> ...
> Is `remote.<remote_name>.pushurl` required for the primary URL as
> well?

What do you mean by "primary URL"?
