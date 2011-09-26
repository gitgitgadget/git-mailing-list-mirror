From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Mon, 26 Sep 2011 16:16:55 -0700
Message-ID: <7v1uv228t4.fsf@alter.siamese.dyndns.org>
References: <20110926184739.GA11745@erythro.kitwarein.com>
 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
 <1317078667.5579.13.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mathstuf@gmail.com, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:17:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KQ3-0001WL-Le
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab1IZXQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 19:16:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab1IZXQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 19:16:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B42954627;
	Mon, 26 Sep 2011 19:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F+/8kBkiMjUd
	wpMDDbYVAIzeuDM=; b=xYt8RHXGpbUXIQpGSE1r7TsH009eb3DYmZq+kErYwFP1
	s8y4lJhBStG81blWt0mN4zUeEv/tKQe1IevREl/qkcEVqxaUp9QE+nA/bkU24mdy
	qnon6hUBzGLbhXUijYyBXtl8Dfbm+PCIiIq6n7jqaOgGsEzvuLhCgBMejcF4UxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fLhpB+
	VtoV4tdjhLapEzErt1uaWNjBlvJiX4h8IYhV2CYNS99rFOiYM1la6XvQzzM1+wU3
	tSCwtey6+cxMDMa3E4N72/5QWK/hgvObwcFN/nf/w/M2EWPim37DM9rsWB1kFIhX
	24Mj1obbyYLss0bLhNBa2+MISYVlz+tNFJRWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F774626;
	Mon, 26 Sep 2011 19:16:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 404204624; Mon, 26 Sep 2011
 19:16:57 -0400 (EDT)
In-Reply-To: <1317078667.5579.13.camel@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 27 Sep 2011 01:11:03
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A12989AA-E895-11E0-B4C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182184>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Mon, 2011-09-26 at 15:30 -0700, Junio C Hamano wrote:
>> Ben Boeckel <mathstuf@gmail.com> writes:
>>=20
>> > When the --prune and --tags options are given to git fetch togethe=
r, all
>> > non-tag refs are pruned because only tags are looked at and when p=
runing
>> > it appears as if the branches have disappeared and are therefore d=
eleted
>> > locally.
>>=20
>> I would call that a bug, and it is not limited to the use of "--tags=
". For
>> example, I suspect that
>>=20
>>     $ git fetch --prune origin refs/heads/master:refs/remotes/origin=
/master
>>=20
>> would prune remote tracking branches for "origin" other than "master=
".
>
> This should fix it (in a way). Let's agree that it's a bad idea and
> complain to the user.

That might be a reasonable short-term safety measure, but in the longer
term I think we should fix it properly. We are already learning "what a=
re
the refs the remote side currently has" from the transport and the righ=
t
fix ought to be to use that original information, not the version filte=
red
for the use of the primary objective of fetch, which is to only fetch w=
hat
the user asked for.
