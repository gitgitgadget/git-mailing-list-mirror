From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable git clone?
Date: Wed, 02 Mar 2016 09:57:18 -0800
Message-ID: <xmqqk2lk4vb5.fsf@gitster.mtv.corp.google.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
	<xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
	<20160302164906.GB13732@x>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org, sarah@thesharps.us, viro@zeniv.linux.org.uk
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 18:57:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abB1l-0002J0-6T
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbcCBR5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 12:57:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755109AbcCBR5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 12:57:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8D4C473B7;
	Wed,  2 Mar 2016 12:57:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IRfmk3pgY1Jg0QsJTmgu61hcCPo=; b=vzE3DB
	juShoYSMEGii9oPD1gMPqwnDnTKdH69HNkulcAb+SvmiZKbn3HxdgNoTwlwMNiOL
	7tiQDHNODpQ7bxV9ungHE8ydLARI97DMkjpjXl38/LhPCewBdWiF+ha1v2Ni/KR3
	cUd8k7g2br6K7U9ucZBJ3GDxabyfoLmSUUPbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HjOkOfjdUhsEH6x5vTQsOdAACS27hxh/
	pKHPyCZErregAP55DcLUEXBbueD+w8PmhPCfShDdurIK8PJdUyKpJj5Kw8HyFiXk
	U6xMxljstqGuhnaN4+gyrMLu3I46kvCLOxyoDskUeaNMKoaPJHpzg+jEnzZMF/Xx
	F9VRwcYbrxc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEFDB473B6;
	Wed,  2 Mar 2016 12:57:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 446B0473B5;
	Wed,  2 Mar 2016 12:57:20 -0500 (EST)
In-Reply-To: <20160302164906.GB13732@x> (Josh Triplett's message of "Wed, 2
	Mar 2016 08:49:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3593E2B4-E0A0-11E5-9D92-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288139>

Josh Triplett <josh@joshtriplett.org> writes:

> That does help in the case of cloning torvalds/linux.git from
> kernel.org, and I'd love to see it used transparently.
>
> However, even with that, I still also see value in a resumable git clone
> (or git pull) for many other repositories elsewhere,...

By "transparently" the statement you are responding to meant many
things.

"git clone" of course need to be updated on the client side, but
things like "git repack" that is run on the server end may start
producing extra files in the repository, and updated "git daemon"
and/or "git upload-pack" would take these extra files as a signal
that the material produced during the last repack is usable for
bootstrapping a new clone with "wget -c" equivalent.  So even if you
are not yet automatically offloading to CDN, such a set of updates
on the server side would "transparently" enable the resumable clone
for all repositories elsewhere when deployed and enabled ;-)
