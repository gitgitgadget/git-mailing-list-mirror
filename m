From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Tue, 30 Apr 2013 09:37:22 -0700
Message-ID: <7va9ogezzx.fsf@alter.siamese.dyndns.org>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
	<7vli8bu3ne.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:37:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDYv-00066n-Th
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751Ab3D3Qhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:37:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932723Ab3D3QhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 12:37:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D3E1A6B7;
	Tue, 30 Apr 2013 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ODcoYZrKZtKkcaBjH8z5fjGtyfg=; b=leWjfk
	4PMUXOgL19YLOPUnMKB3JSm8UWppJbZhXiKvbDonPILQiffqLVwQT8pp+4hPyeWx
	+AMeSfc/tbH3Ewijw1lUbcjgZpTamguTho9SFQGTEluNjCBxnNSFC+2Zr/TeqYMN
	32IX9TZmOmRGS/OuNC5VM02OO+rNkahRzpflQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Olmhn3iZTIHcB/01UKh5Kvp6Ef2BkJEE
	QoNZraVVgnAxZdl4hHgJVvi1UQVKq/yCVcrxQmqjfNg3SH3vhe1LAQDzt+Aso711
	SKUIsbM6hJifgU7CJXLXxkNF4JpKvv9j1ESeIXdzXiney/MQhhCwNZTHT9UtnDjt
	T88jWRfzzZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7E7A1A6B5;
	Tue, 30 Apr 2013 16:37:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45D681A6B1;
	Tue, 30 Apr 2013 16:37:24 +0000 (UTC)
In-Reply-To: <CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
	(John Szakmeister's message of "Tue, 30 Apr 2013 06:09:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C9238EA-B1B4-11E2-81E8-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222946>

John Szakmeister <john@szakmeister.net> writes:

>> When I added -c/--cc, I contemplated making -p imply --cc, but
>> decided against it primarily because it is a change in traditional
>> behaviour, and it is easy for users to say --cc instead of -p from
>> the command line.
>
> FWIW, security aside, I would've like to have seen that.  I find it
> confusing that merge commits that introduce code don't have a diff
> shown when using -p.  And I find it hard to remember --cc.  BTW,
> what's the mnemonic for it?  -p => patch, --cc => ?

Compact combined.

By the way, these options are _not_ about "showing merge commits
that introduce code", and they do not help your kind of "security".
As I repeatedly said, you would need "-p -m" for that.
