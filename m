From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc and worktrees
Date: Fri, 03 Jun 2016 09:45:01 -0700
Message-ID: <xmqqvb1qp6gi.fsf@gitster.mtv.corp.google.com>
References: <574D382A.8030809@kdbg.org>
	<CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
	<20160531221415.GA3824@sigill.intra.peff.net>
	<574EA364.60408@alum.mit.edu>
	<xmqqbn3l0wkv.fsf@gitster.mtv.corp.google.com>
	<574F0983.5030108@alum.mit.edu>
	<xmqqmvn4y9zq.fsf@gitster.mtv.corp.google.com>
	<574FB126.4090805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:55:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sDh-00007w-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 18:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbcFCQpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 12:45:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752764AbcFCQpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 12:45:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1041F1FD9C;
	Fri,  3 Jun 2016 12:45:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYIpKaygUDcV9DJB5zDq20DQtKo=; b=oRzCIU
	MNvTN6PJD2Wsn4ZeqJVBjy8cKqG5PdvCQV6YHTf4SP1xDQSpn2CoBtDGf7CVOqJ7
	d7x/O0AcyOwbjjhQmQ2xhiKhGH01abanfOyprZCrVsjl7vxN/9yt3/HEiwk2mMbS
	hoMdpdiEoMcyG4nuhNjB9G1q2hXD12jLgA4CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XugGZdcFGhA7Kh/iXpWMdakfeaX8/16x
	jNTrfc+2SrNFj4ccZ5GlkEvwQZjtU/1xJdReSnKQwN/Vy6Rr/mTy2cmc4tnuioS8
	zDqZFx/8h4vYjd49kN6LTTI1+AEbyKkvoWI2lxNfweGgj9aPF9B70/CbDI2OfohR
	dMXJhlsyt80=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07E901FD9B;
	Fri,  3 Jun 2016 12:45:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A0B91FD99;
	Fri,  3 Jun 2016 12:45:03 -0400 (EDT)
In-Reply-To: <574FB126.4090805@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 2 Jun 2016 06:08:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 850858EA-29AA-11E6-BD78-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296345>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/01/2016 09:39 PM, Junio C Hamano wrote:
>> ...
> I think I would represent the logical store of a worktree repo as
> follows. First, ...
> ...
>> Up to this point, I am all for your "separate physical stores are
>> composited to give a logical view".  I can see how multi-worktree
>> world view fits within that framework.
>> 
>>  * With pluggable ref backend, we may gain yet another "physical
>>    reference store" possibility, e.g. one backed by lmdb.  If it
>>    supports symrefs, a repoitory may use lmdb backed reference store
>>    without the traditional two.
>> 
>>    But it is unclear how it would interact with the multi-worktree
>>    world order.
>
> Since you could plug-and-play different ref_stores in the above scheme,
> I don't see any problem here.
>
>     def get_logical_ref_store() {
>         local_ref_store = get_local_ref_store(git_dir)
>         if (is_linked_repo) {
>             common_ref_store = get_ref_store(common_dir)
>             return worktree_ref_store(local_ref_store,
>                                       common_ref_store)
>         } else {
>             return local_ref_store;
>         }
>     }
>
> get_ref_store() would read the git config to decide what the ref store
> to use for the specified repository, which itself might be an
> lmdb_ref_store or an overlay_ref_store(loose_ref_store, packed_ref_store).

Sounds all sensible.  Thanks.
