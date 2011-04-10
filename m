From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Sat, 09 Apr 2011 18:03:06 -0700
Message-ID: <7v39lqzzn9.fsf@alter.siamese.dyndns.org>
References: <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
 <4D9EDCEA.9010903@drmicha.warpmail.net> <20110408185924.GA25840@elie>
 <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
 <20110408194548.GA26094@elie>
 <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
 <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com>
 <20110409081108.GE13750@arachsys.com>
 <BANLkTim5DPjGjJ=SfnNfXpzCd6=PKnSs6g@mail.gmail.com>
 <20110410001518.GA6380@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Chris Webb <chris@arachsys.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 03:03:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8j41-00014g-5I
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 03:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab1DJBD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 21:03:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab1DJBDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 21:03:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C3E95F83;
	Sat,  9 Apr 2011 21:05:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M+43B2ukOlYzC2USKy01B7KZlms=; b=RLuFnD
	GP8n7lBcjPSr0WhzTS6YucXiiD0+S4o0XCP/JCyJ4qQESDBm5hJdtoqXSkgNZpWi
	X/XIwkMCc7FE9tXl7xyAr3y483nsTPwC5a0TXXWIqOd4hrgrh55IJzOHCWSNEvOg
	UIX5jbPzvFllRgR4Zx4velvI0N/aPMivydFac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pr3WRlhNzvnrCG3QxJ2epNYyl4UjoWzW
	skYXP0l9b9orOhOlqySBIcMBu3NX7++zjOAmM1NAS9tQrxob+jrpPzECAhs9Kk9x
	fCmhsomdHWT3Ab/2wfztycRCEvCVBa0CNaF8umIaGHfqHeRyz9lqDjuUwO/N08OA
	NKzKg5aO3Bs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A32225F80;
	Sat,  9 Apr 2011 21:05:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 057415F7B; Sat,  9 Apr 2011
 21:05:04 -0400 (EDT)
In-Reply-To: <20110410001518.GA6380@elie> (Jonathan Nieder's message of "Sat,
 9 Apr 2011 19:15:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 967260E8-630E-11E0-A629-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171228>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'd be worried about using a clean filter to store timestamps.
> Treating a file as changed whenever mtime changes could be confusing.
> Treating atime changes as content changes would be even stranger.

That is exactly why git does not store metainfo.  Storing auxiliary
information on commit objects or tree objects to help build or deploy
procedures is fine, but that kind of information should be stored
somewhere that the normal git operations would not care about.
