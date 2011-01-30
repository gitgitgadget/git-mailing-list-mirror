From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sat, 29 Jan 2011 22:51:05 -0800
Message-ID: <7voc6yc2au.fsf@alter.siamese.dyndns.org>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
 <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 30 07:51:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjR8Y-0003Bi-QV
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 07:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab1A3GvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 01:51:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1A3GvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 01:51:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E29E32074;
	Sun, 30 Jan 2011 01:52:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K3rs6N4g5zJNIhf2GRey0orBRUE=; b=hfsgyX
	0FJ/E68d73lGg5GJkbqJHLj+/FwTz6S8ctu1bKa2ZItgWEErpve3pbeOHcgJggWo
	ndY6sKsEJviJ5USCkoQU01w8NBE6ha+xaGhrn7CNUGTxZpTvCJl4gCMKYfAaS0Q6
	IN+dN9IgAQA3LTCxTjEbHlF1MbnxZccZ1FD0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bc2Fc4KGFexaxfZzOlpX01xb/yiQotCf
	D/UwTJVaGl3YcIpQRXQCkdgZeNNghtQl+B2ghOjgnhmm86OmI/C9dgcGbuAc2MRN
	B2vbPFau5M/fBi26WGTxrj9vkanLWlRw8IX/vEL0KeaXVzq/vRGEQ9d2vwG/68Fy
	h/ZkeQ8Sud0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BD4C2072;
	Sun, 30 Jan 2011 01:52:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0BD772071; Sun, 30 Jan 2011
 01:51:57 -0500 (EST)
In-Reply-To: <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 (Shawn Pearce's message of "Fri\, 28 Jan 2011 17\:32\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 726ACAD0-2C3D-11E0-B33B-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165680>

Shawn Pearce <spearce@spearce.org> writes:

> I fully implemented the reuse of a cached pack behind a thin pack idea
> I was trying to describe in this thread.  It saved 1m7s off the JGit
> running time, but increased the data transfer by 25 MiB.  I didn't
> expect this much of an increase, I honestly expected the thin pack
> portion to be well, thinner.  The issue is the thin pack cannot delta
> against all of the history, its only delta compressing against the tip
> of the cached pack.  So long-lived side branches that forked off an
> older part of the history aren't delta compressing well, or at all,
> and that is significantly bloating the thin pack.  (Its also why that
> "newer" pack is 57M, but should be 14M if correctly combined with the
> cached pack.)  If I were to consider all of the objects in the cached
> pack as potential delta base candidates for the thin pack, the entire
> benefit of the cached pack disappears.

What if you instead use the cached pack this way?

 0. You perform the proposed pre-traversal until you hit the tip of cached
    pack(s), and realize that you will end up sending everything.

 1. Instead of sending the new part of the history first and then sending
    the cached pack(s), you send the contents of cached pack(s), but also
    note what objects you sent;

 2. Then you send the new part of the history, taking full advantage of
    what you have already sent, perhaps doing only half of the reuse-delta
    logic (i.e. you reuse what you can reuse, but you do _not_ punt on an
    object that is not a delta in an existing pack).
