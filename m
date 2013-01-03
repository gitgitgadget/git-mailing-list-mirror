From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Thu, 03 Jan 2013 14:33:09 -0800
Message-ID: <7vzk0pvqvu.fsf@alter.siamese.dyndns.org>
References: <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
 <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
 <20130103083712.GC32377@sigill.intra.peff.net>
 <7vehi2xote.fsf@alter.siamese.dyndns.org>
 <20130103202343.GA4632@sigill.intra.peff.net>
 <7vip7evwdo.fsf@alter.siamese.dyndns.org>
 <20130103203606.GA8188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 23:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqtLv-0000zE-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 23:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab3ACWdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 17:33:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941Ab3ACWdM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 17:33:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6353A7C0;
	Thu,  3 Jan 2013 17:33:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gz237Og4ZwMK9FC6j1aiJ9ROdbg=; b=sWCtuE
	/0nVtY7wenDTjiRFwk8IMJLImKWxrPX1QuIYHFoVwESpfpdN4wrW6u0Hls+A0zXB
	nyaxlCeSt8iwcetgfSYDqxuVHq3W0U/p6Klv83ZBXLiA4zq61jDubNIB9Y5PI8p2
	89F5DLLiIb8Ev33zwytZYF6M0WIjm+5OigE3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uVHcX4FDf0KDuT5t5IKPEVkpe/S83wic
	6Q6RUIFOedYlEqEPng7RqJ44o3hjFihtoV/rYo5tcQDbQc5NNuH5RPG0GF3Lyt0e
	q956qfnvnvbOUWKas7GXk0OMq7yz5au5J/C1gQ/TUfmS5sftvypGDaP+VuPvLD4e
	9nJ9aetpA4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B745EA7BF;
	Thu,  3 Jan 2013 17:33:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DE5AA7BD; Thu,  3 Jan 2013
 17:33:11 -0500 (EST)
In-Reply-To: <20130103203606.GA8188@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Jan 2013 15:36:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DFB8788-55F5-11E2-80D9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212618>

Jeff King <peff@peff.net> writes:

> Oh, I agree it's insane to try to carry through unmerged entries. I'm
> just concerned that not all code paths are careful enough to check.

I would actually be surprised if some code path do assume somebody
might give them an index with conflicting entries in it and guard
against it.  We have been coding under the "index must exactly match
the second tree when three-way unpack_trees() begin" requirement
since day one.  An conflicted entry will appear as "index and HEAD
not matching" and will cause reject_merge() early in threeway_merge()
anyway, no?
