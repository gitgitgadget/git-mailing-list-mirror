From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Thu, 23 Aug 2012 11:08:46 -0700
Message-ID: <7vd32h4h1t.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:09:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4bq1-00007m-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 20:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387Ab2HWSIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 14:08:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab2HWSIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 14:08:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94AB5947C;
	Thu, 23 Aug 2012 14:08:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WURZ5HNkEXAluBKVRM1913oVkcI=; b=MIhr7t
	NUWNd8ELh4oTPbLiBfiXjJH3+MeGrcnpO7nNxY1L/ykXaY4NU/Fkv94M1FfxjFlX
	oXTuFJXpYmKSJfCbZbLMOIzPIE13+arR+UzSpiyPFHv8Q1WLi3l6D64LVzRjzKHL
	FxbUoZjDTJSgqiX4lNxiigaOjBlivDYMm6BGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LM53XBHCrbxsokS7rlsTqo2TCx6a91m2
	0n914Vik3Ed5UBnLE4tLOWmhsJ5ZrRdaFTW9lWeJGbCY9CzhBKiALsS7K7cRjOSR
	zWOOaNl8unjBSyy5PLiYSuBRG5gDQTpP6AWEc6OK7baydXqIAiPESWWei6A4LTa2
	CiazmzXcz4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 814E6947B;
	Thu, 23 Aug 2012 14:08:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2DAE947A; Thu, 23 Aug 2012
 14:08:47 -0400 (EDT)
In-Reply-To: <878vd5k7uu.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 23 Aug 2012 16:20:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95D7B83E-ED4D-11E1-A268-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204163>

Thomas Rast <trast@student.ethz.ch> writes:

> At the very least it should be possible to change in_merge_bases() to
> not do any of the post-filtering; perhaps like the patch below.

I do not recall the details but the post-filtering was added after
the initial naive version without it that was posted to the list did
not work correctly in corner cases.  I wouldn't doubt that N*(N-1)
loop can be optimized to something with log(N), but I offhand find
it hard to believe "to not do any" could be correct without seeing
more detailed analysis.
