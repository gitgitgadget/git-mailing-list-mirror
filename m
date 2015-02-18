From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Wed, 18 Feb 2015 10:40:07 -0800
Message-ID: <xmqqtwyj2hdk.fsf@gitster.dls.corp.google.com>
References: <54BD3D14.90309@web.de>
	<20150122200702.GA96498@vauxhall.crustytoothpaste.net>
	<54C17429.1090403@web.de>
	<20150122234117.GD96498@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:41:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9Yq-00023s-Kz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbbBRSlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Feb 2015 13:41:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753665AbbBRSkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 13:40:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23F0136C91;
	Wed, 18 Feb 2015 13:40:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Gh4K7FfiarFq
	7eEwKnHubJzF7Xs=; b=Bd9xm9YFOcOtDHZbmeR+WUNWiL5m/ZRo1gM/5O3uJM8/
	36PMiB3685f1F1iN1sAlKc6YmPOFP7Mp0mGzv95XAulVixw0mM45stiZCh7vAU2U
	SGSTG/ex3zckuHrHiEltDxG9dfW38ZxEaNlC/KqYl5CFd9u/rHGL7MsXBebo1Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nxNgaG
	G6rwwLxRMm/N41juWO9Uny1u50kmUeOiF+yo20F7Iam8QDHNH+sliXYp8iI2hc1w
	1FsUhvCbDma/rrCQ4RvtKsZSqlLowwv/oBP46a/azy1/KELTNYX7cogEnCllI2ON
	n9doddiu7cuiYF/G0sARzghoYDzVN3wbb8cK8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BB4B36C90;
	Wed, 18 Feb 2015 13:40:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9867036C8E;
	Wed, 18 Feb 2015 13:40:08 -0500 (EST)
In-Reply-To: <20150122234117.GD96498@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 22 Jan 2015 23:41:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9047D166-B79D-11E4-8E88-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264039>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Thu, Jan 22, 2015 at 11:05:29PM +0100, Torsten B=C3=B6gershausen w=
rote:
>>We want to support ssh://bmc@2001:470:1f05:79::1/git/bmc/homedir.git/
>>   because e.g. the Git shipped with Debian (1.7.10.4) (and a lot of
>> other installations) supports it.
>
> I understand that this used to work, but it probably shouldn't have
> ever been accepted.  It's nonstandard, and if we accept it for ssh,
> people will want it to work for https, and due to libcurl, it simply
> won't.
>
> I prefer to see our past acceptance of this format as a bug.  This is
> the first that I've heard of anyone noticing this (since 2013), so it
> can't be in common usage.
>
> If we accept it, we should explicitly document it as being deprecated
> and note that it's inconsistent with the way everything else works.

I was reviewing my Undecided pile today, and I think your objection
makes sense.

Either of you care to update documentation, please, before I drop
this series and forget about it?

Thanks.
