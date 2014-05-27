From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/5] commit test: Use write_script
Date: Tue, 27 May 2014 15:42:23 -0700
Message-ID: <xmqqoayietdc.fsf@gitster.dls.corp.google.com>
References: <20140525062427.GA94219@sirius.att.net>
	<1401130586-93105-1-git-send-email-caleb@calebthompson.io>
	<1401130586-93105-4-git-send-email-caleb@calebthompson.io>
	<CAPig+cQt0mfBTChw8y=2Jg3rNsSr+neDCresptBafPDQixseXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Thompson <cjaysson@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 28 00:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpQ4m-0002sr-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 00:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaE0Wm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 18:42:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60125 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbaE0Wm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 18:42:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D447C1B3ED;
	Tue, 27 May 2014 18:42:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b9Vjaqky0zXWeOf0h8BE1UBepGE=; b=UbY8fB
	fQHcWTl3jo7/zG6fulC5o8HykivV4yehfsqvSY7aRYNi6uRQPnimDYx9M5p+fs5i
	9wUJYdoFhXAW7VwTVE5vUbYuVjVcdyZ+c+zwmy5MJPpKyHzkdFr/APMZnAw6V0kf
	2nTjsrO1CKhHtCN/f+LrdEuuDrxKxCwLf7XlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GN+O4r4jkHMliY4yC1oB5dc2bhuztL6n
	JpOHM+Oio8TGpFNrcq/ABZeT9k50pv4vSVxsczgjP6tBjWve4PBIHgZSB5MJ22ZW
	VD4E4TohUDy1uIMc6sbwfbYyZfp+G5EbDp+dUKJ0nI8KvYRJKYeQARfkN2U940gY
	R6hXSrEER74=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8FAE1B3EC;
	Tue, 27 May 2014 18:42:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 695371B3B6;
	Tue, 27 May 2014 18:42:24 -0400 (EDT)
In-Reply-To: <CAPig+cQt0mfBTChw8y=2Jg3rNsSr+neDCresptBafPDQixseXA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 27 May 2014 18:30:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C0AD196-E5F0-11E3-B4B4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250245>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> -cat >check-for-diff <<EOF
>> -#!$SHELL_PATH
>> -exec grep '^diff --git' "\$1"
>> +write_script check-for-diff <<-EOF
>> +       exec grep '^diff --git' "\$1"
>
> Food for thought:
>
> The original code used <<EOF since it needed $SHELL_PATH to be
> evaluated at script creation time, and took special care to escape $1
> in the 'grep' invocation since $1 should be evaluated only at script
> execution time.
>
> With the change to write_script(), nothing within the here-doc
> requires evaluation, yet you are still using the evaluating <<-EOF
> form (and manually escaping $1). The intent might be clearer if you
> switch to <<-\EOF which suppresses evaluation (and drop the manual
> escaping of $1).
>
> The same observation applies to the new write_script() invocation to
> create check-for-no-diff in patch 5.

Very good comments.  Thanks.
