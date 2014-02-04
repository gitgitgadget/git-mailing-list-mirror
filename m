From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Tue, 04 Feb 2014 10:37:24 -0800
Message-ID: <xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
	<xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
	<xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
	<20140204163400.GA20436@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 04 19:37:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAksH-0006Vy-Fd
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 19:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbaBDSh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 13:37:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbaBDSh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 13:37:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A5068412;
	Tue,  4 Feb 2014 13:37:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KDR/WUFcjg/ALgdmjKvAGWoDiag=; b=qeguux
	/fcbY4Pd7Zl/EdE1C9LMpixEmolZyJiCAlFM6Wu8SwmF11bgk55XLJl+ioM7b3mg
	x1wvmyxi8WzKjL3z1tIz+0GnzDwJnaxbuQQPMeGVeRAWJ3ct+WMIQQ3uDM9ViZ6d
	aAdS2f8JsvJ8q4t1ITTavIsYEnLf8rqQhQZYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HRaZpFMzRhmak4dHykIyEIZrSldYXDJR
	9ZJsQVqILqt+2Ypo65DfjwT46+qPiIQzNkUoZVK5ERpcTPWje2UOdOHb5HJQAwBm
	o8IDRq0yHVh9+ZY7aFjCiU2nzFGEMFvbMbvPQR2n63Cj16JSvXaDC7LmM7+/B7Gc
	rmfrFG/Q44A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C166C68411;
	Tue,  4 Feb 2014 13:37:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBB8D6840E;
	Tue,  4 Feb 2014 13:37:25 -0500 (EST)
In-Reply-To: <20140204163400.GA20436@tugrik.mns.mnsspb.ru> (Kirill Smelkov's
	message of "Tue, 4 Feb 2014 20:34:00 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 64C50D94-8DCB-11E3-ACB3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241538>

Kirill Smelkov <kirr@mns.spb.ru> writes:

>> if we did not want to reinvent the whole tree walking thing, which
>> would add risks for new bugs and burden to maintain this and the
>> usual two-tree diff tree walking in sync.
>
> Junio, I understand it is not good to duplicate code and increase
> maintenance risks....
> Instead I propose we switch to the new tree walker completely.

I am not fundamentally opposed to the idea. We'll see what happens.
