From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Tue, 03 May 2011 08:01:05 -0700
Message-ID: <7v4o5bkevi.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org>
 <7vaag01gdl.fsf@alter.siamese.dyndns.org>
 <BANLkTimfT87-vV0GCvsVmRJ6nBZt7jSkkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 17:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHH6U-0007wu-Ib
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 17:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab1ECPBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 11:01:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab1ECPBT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 11:01:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D29782FB1;
	Tue,  3 May 2011 11:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A9yyptaNva5mZvfxmCdgt3wID7k=; b=hjtxmW
	FPx//oUMHuavDrCtKynvwYYTJ52dlP+zPgJwKXWG71Qw8vgcsMbIVrpqrqygKBkZ
	GB9H5/ZTK1dLuydKPR2A7pvLPHXaBs1iAbYtW0l7d7SIc3fvYCyamxv+YD2x9sY0
	uWki1X6Tz5q9fiTPDC1+unlC7a8AWXfyFwJ1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=crm1OMrvD5yd1po3vOWE9UhyMyGrHEWj
	DBcPzU44SJz0OaKd0jvJFnjYV8UkjBxbswdK5ri2miYiYGF+rL1AagCKOLzgzSm2
	rgKJaPTjz26oWzGiVkKoemCTDTHG0IfF4DSDMM4bXokQGEUQZrjxatWy9KVXQlP6
	emoou7dAk7I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 889162FB0;
	Tue,  3 May 2011 11:03:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 10EB42FAF; Tue,  3 May 2011
 11:03:10 -0400 (EDT)
In-Reply-To: <BANLkTimfT87-vV0GCvsVmRJ6nBZt7jSkkw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 3 May 2011 14:52:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 797B389E-7596-11E0-9BD5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172662>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I need someone to enlighten me again. Why do we need ":" for "no
> pathspec" when we can simply specify no pathspec for the same effect?

Futureproofing.  Currently "log" family defaults to "tree-wide" when there
is no pathspec, but imagine what happens when a command like "log" that
knows how to simplify history defaults to "current directory".  You cannot
override it by "git that-cmd :/", which would give it a single tree-wide
pathspec, not "no pathspec".  It will still cull empty commits.
