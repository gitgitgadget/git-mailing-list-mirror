From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Thu, 17 Oct 2013 15:38:36 -0700
Message-ID: <xmqqzjq7wmj7.fsf@gitster.dls.corp.google.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
	<89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
	<xmqqmwm71ysp.fsf@gitster.dls.corp.google.com>
	<B690713F-6FF1-46A7-85A7-C92303BBAF0E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 00:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWwDL-0001aa-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 00:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab3JQWij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 18:38:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab3JQWij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 18:38:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B9614BC02;
	Thu, 17 Oct 2013 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W+knmtKR2bsud0J+8DCZu519tFU=; b=r7IlTj
	/9gZysMwk6+Xu34oAzvsjJl4kWeQoAakwrfxF2fctkqr2PNChfujwSu3bujAlaBm
	T5vzY8jb0Bhi8122eQ4VPngtCjA5dHrqpMXyma69ReVQfaNGDjipHR7dbjwUbKaY
	WrOtzi+iOYaXrnppfSb96UWyAQICu7hGU8/FY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Egsi9IrZs9gRmZFcUzdOkjfr1htUJdtX
	DNRtAw/vtjIK9HvqGmMaLPw17VGCJibuSJmN5AjNigQ9vhziJwKnifuNeRvoOGwV
	Bk9Qibe3RZ5Ge0UlNpaFrM6xWUZ+rYq2uQ+alyDBCr/Kg38Xp13LAJKplYoIBsGt
	HeuTBKVpJp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B9104BC00;
	Thu, 17 Oct 2013 22:38:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D62244BBF6;
	Thu, 17 Oct 2013 22:38:37 +0000 (UTC)
In-Reply-To: <B690713F-6FF1-46A7-85A7-C92303BBAF0E@gmail.com> (Yoshioka
	Tsuneo's message of "Fri, 18 Oct 2013 01:08:33 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD42A060-377C-11E3-BBE9-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236331>

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> In the "[PATCH v7]", I changed to keep filename part of suffix to handle
> above case, but not always keep directory part because I feel totally
> keeping all part of long suffix including directory name may cause output like:
>     …{… => …}…ongPath1/LongPath2/nameOfTheFileThatWasMoved 
> And, above may be worse than:
>    ...{...ceDirectory => …ionDirectory}.../nameOfTheFileThatWasMoved
> I think.

I am not sure if I agree.

Losing LongPath2 part may be more significant data loss than losing
a single bit that says the change is a rename, as the latter may not
quite tell us what these two directories were anyway.
