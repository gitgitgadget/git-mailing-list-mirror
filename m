From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG (maybe)] git rev-parse --verify --quiet isn't quiet
Date: Thu, 04 Sep 2014 10:57:44 -0700
Message-ID: <xmqq1trruv3b.fsf@gitster.dls.corp.google.com>
References: <loom.20140904T131954-274@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 19:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPbI8-0002AJ-75
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 19:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbaIDR5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 13:57:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53499 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673AbaIDR5q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 13:57:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A9DE36C49;
	Thu,  4 Sep 2014 13:57:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2kyZ8xYV21HX
	f+MSEcjPsAF4KiY=; b=jzKcC7zUDeO5LPUHE6g9obu9lCBERU5gqAKjsb64y26u
	5xi0the49MSiXyDQqdXdFYBPwCbfq66cTwXeNZI2a75Rdg09fy44e+n+pJkgxawx
	o6/oG/MFIJNNnwjQdDhYzBoeuG+IWAPLp45iqxUgi5KN0A099wH9uSpN8drwxio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bMFiHY
	rqjnMe/7oOLYkbROZZO/CUQg97G7G1bz4N8fx3/deiCsdc+SZfcxv//aITDWxPuJ
	16K3UsiheUxa+/qdjiOsQ7W8EXC66nfD1Ooe+NJVcGpj3FthlaoWNuYwylD4bQbS
	+hCpJ6m5amjHRTAMQEVXlFIY6QeQxsEtLTykc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F95836C48;
	Thu,  4 Sep 2014 13:57:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C6F9E36C47;
	Thu,  4 Sep 2014 13:57:45 -0400 (EDT)
In-Reply-To: <loom.20140904T131954-274@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Thu, 4 Sep 2014 11:20:45 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9A99C08-345C-11E4-BD54-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256455>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> I noticed this while writing a small script for myself:
>
>     $ git rev-parse --verify --quiet '@{u}'
>     fatal: No upstream configured for branch 'local'
>
> The functions that get run when rev-parse does its thing all return a
> pointer to a strbuf, return the length of the modified buf or somethi=
ng
> to that effect. However get_upstream_branch() calls die() which write=
s
> to stderr unconditionally.

I would suspect that this may be fine.

"rev-parse --verify" makes sure the named object exists, but in this
case @{u} does not even name any object, does it?

> On a related note:
>
>     $ git branch origin/master
>     $ git rev-parse --verify --quiet origin/master
>     warning: refname 'origin/master' is ambiguous.
>     7c07808349fd0fc2c61a169833eeb55163cf3df4  =20

And this warning is in the same vein, I would suspect.
