From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] builtin/symbolic-ref.c: add option to fall back to
 normal ref
Date: Mon, 27 Feb 2012 14:21:26 -0800
Message-ID: <7v1upf6hp5.fsf@alter.siamese.dyndns.org>
References: <1330380536-9647-1-git-send-email-jk@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Feb 27 23:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28wo-00082W-U9
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab2B0WVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 17:21:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341Ab2B0WV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 17:21:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAFE17C47;
	Mon, 27 Feb 2012 17:21:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QyYXqmvyat3E
	AG4ZF3DFbk3RC1M=; b=RHkuVSdTDtEHQbkwGptRT9Z2OklmkzrkDZqkVuH/aDXm
	UeFMZVwHmLFQQsmfMlRWUPJVJTVOggP9gJmi7XlEwLSxdsXhDHKN05Vpat0NRfex
	Zxm5uSffo1e2a8X76ssjKTHGkXnAdEQ43j7+uqE5UJ2LDGImLNzm4vrMrSjc5xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YWQC99
	5SgUKGawfrbQDZZBvj6/yDeXIHDb5kdrmBSkujvBjeyBPEAUPkSBbRWDpva5Y+pX
	U6mZGq0OGw9qK8oAz1SK0ky7LD7GwPuA117LnaEsvepnvDQsSCRmb/00pIXX6icm
	TbMMxvfM2lnW1+dNh9uuCwL7rl6qQe1Lh41UM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3AC67C45;
	Mon, 27 Feb 2012 17:21:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 365C77C42; Mon, 27 Feb 2012
 17:21:28 -0500 (EST)
In-Reply-To: <1330380536-9647-1-git-send-email-jk@jk.gs> ("Jan =?utf-8?Q?K?=
 =?utf-8?Q?r=C3=BCger=22's?= message of "Mon, 27 Feb 2012 23:08:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6483C482-6191-11E1-AEC4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191684>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Frequently, people want to determine the current value of HEAD in
> scripts. However, there is no tool that can always output it, since "=
git
> symbolic-ref" will fail if HEAD isn't currently a symref, and other
> tools (e.g. "git rev-parse --symbolic-full-name") will also fail in
> one of HEAD's possible modes.

What is "the current value of HEAD"?

The symbolic-ref command is there for people who _care_ about the
distinction between a HEAD that points at a branch and a HEAD that poin=
ts
directly at a commit.  There is no room for the command to "fall back"
anywhere, as that will only introduce an unnecessary ambiguity to the
command whose sole purpose is to be able to tell them apart.

If the caller does not need to know if the HEAD is detached or not, and
wants to know what commit it points at, why is it insufficient to just =
use
rev-parse, e.g. "git rev-parse --verify HEAD"?
