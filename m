From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression in git-gui since 2c5c66b... Merge branch
 'jp/get-ref-dir-unsorted
Date: Mon, 17 Oct 2011 10:22:47 -0700
Message-ID: <7v4nz7o7mg.fsf@alter.siamese.dyndns.org>
References: <4E9B1E32.7030101@gmail.com>
 <7vfwispi8u.fsf@alter.siamese.dyndns.org> <4E9B8719.1090203@gmail.com>
 <4E9BA39B.709@alum.mit.edu> <4E9BFE66.5070906@gmail.com>
 <4E9C2F3C.7080405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 17 19:22:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFqtu-0004Pv-6H
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 19:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742Ab1JQRWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 13:22:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab1JQRWx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 13:22:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E46D5D79;
	Mon, 17 Oct 2011 13:22:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oGmphGPdBG2fIz7GGnE7L2awj/U=; b=oLu3Vv
	wArODAidPCAcmEOk9x26k2aIDGkb5mmBYXikrdBvAMyNlYrXvi2R9ADPjuhEOYF6
	NlKmajvcn9JCiSFnkor4qyDZhej+EqBtaL+z2V448095cYRx00qwtA0DS1azS01v
	wQ/waKM4zO8/f2RgAUhu05rO168n00FKaXNrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uuC6fe/gJmS/ggakaz2l2UE3WQg8TH32
	KprbIPxOrliAH0ZBzZU0khlUorqepmC739vp1W7lEdJ5KbPG3TRwLf3Bm6CyNXQ5
	zbEb/nw+L5V3MU510nMT0hHLgf0icJTRs+ZH85mPnUCfsj3vxByZD3TVZPFei/kf
	9GdEY99d54M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85D1C5D77;
	Mon, 17 Oct 2011 13:22:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A9945D76; Mon, 17 Oct 2011
 13:22:52 -0400 (EDT)
In-Reply-To: <4E9C2F3C.7080405@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 17 Oct 2011 15:35:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4BD018C-F8E4-11E0-98B6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183800>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> static int resolve_gitlink_packed_ref(char *name, int pathlen, const
> char *refname, unsigned char *result)
> {
> 	int retval = -1;
> 	struct ref_entry *ref;
> 	struct ref_array *array = get_packed_refs(name);
>
> 	ref = search_ref_array(array, refname);
> 	if (ref != NULL) {
> 		memcpy(result, ref->sha1, 20);
> 		retval = 0;
> 	}
> 	return retval;
> }
>
> The problem is that the parameter "name" is not NUL-terminated.  The old
> code turned it into a (NUL-terminated) filename via
>
>     strcpy(name + pathlen, "packed-refs");
>
> but the new code passes it (unterminated) to get_packed_refs()

Thanks for digging this through before I got to it. Very much appreciated,
and sorry or the mismerge (incidentally this was why I wanted to merge
early these two topics that tried to improve different things that
happened to touch the same part of the code, as I knew such a merge was
risky and needed plenty time before it hits released versions).
