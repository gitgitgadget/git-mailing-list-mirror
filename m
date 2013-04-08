From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 08 Apr 2013 06:58:07 -0700
Message-ID: <7vhajh15w0.fsf@alter.siamese.dyndns.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin> <20130408000658.GG27178@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEyM-0003oz-Up
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935982Ab3DHN6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 09:58:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935482Ab3DHN6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 09:58:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C68141E3;
	Mon,  8 Apr 2013 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cgGmIFrSO3OmIW19MaPg5DrOToY=; b=lUMgZ8
	85cpajTkst/OP/J2Zjggch3eiIl5ja63X003VPNOxSnf86qp0DheYLYym2sO70uy
	r02SAqTCwuAsxeO4G2BQyWy8OiRST2G9tehCUt/tEmV8VweZK9OaR3T9iQufWP8g
	JOJU9gseDq9LxcOw37BjHTvNb5eVbLdMpDBhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VE6OZJioi1zHCxFTDe8+3NQAN/cuH3/s
	cLTrRe19U7iAbrZendjO6//LRhdNH2d7NdMKGhOWltshDokWjMtuCblzUwqDAWbz
	J/OgqG4hkcuUATLhGE85e+vUDK/HAQsP3/VK1Ywm/i1ucO3ALDOjmfHgW7VeIwNg
	WSTAt7CsLv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FC32141E2;
	Mon,  8 Apr 2013 13:58:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B710141E0; Mon,  8 Apr
 2013 13:58:09 +0000 (UTC)
In-Reply-To: <20130408000658.GG27178@pug.qqx.org> (Aaron Schrab's message of
 "Sun, 7 Apr 2013 20:06:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 586332D4-A054-11E2-BD3D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220425>

Aaron Schrab <aaron@schrab.com> writes:

> At 16:48 -0700 07 Apr 2013, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> Do not report an argument to clone's --reference option is not a local
>>> directory.  Nothing checks for the actual directory so we have no way to
>>> know if whether or not exists.  Telling the user that a directory doesn't
>>> exist when that isn't actually known may lead him or her on the wrong
>>> path to finding the problem.
>>
>>I don't understand the above explanation.  Could you give an example?
>
> I originally noticed this while trying to use a submodule as a
> reference repository.

I do agree that it would be nice to dereference .git gitfile when we
deal with --reference argument, but you do not want to use in-tree
repository of a submodule working tree.  What happens when you have
to check out a version of the containing superproject that did not
have the submodule you are borrowing from?  The directory will
disappear, leaving the borrowing repository still pointing at it
with its .git/objects/info/alternates file, no?
