From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Log and History Simplification
Date: Mon, 17 Dec 2012 11:53:24 -0800
Message-ID: <7vvcc0lakr.fsf@alter.siamese.dyndns.org>
References: <CAE116wxTY0sFh5nZwGEYRz=gJwXgFEj8Nvwh41RCYH4vgYCqSQ@mail.gmail.com>
 <CACsJy8BsL03zr_wGZH5kqS0NaMfPKct2T7_62jstxRB4c_FudQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dinesh Subramani <dinesh.subramani@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkgkz-00081X-97
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 20:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab2LQTx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 14:53:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067Ab2LQTx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 14:53:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B61591C2;
	Mon, 17 Dec 2012 14:53:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8zsueLCHV1l4fLl6AGwpAGq1Skg=; b=NPXTMz
	ablXL5fly+DMkU492G4FwwdVwaWvFM+Z5ogH+usYT/ODHIhITYWpY5oudAj0kYIC
	uAt4shGxDMPnCUNABIxdADHIFlxchHYoRlY4RahmXkbDDwYWNMtMGnxIagCZ1ihE
	//0IBTAdtL5Bl3Ux+0a1ljdRPiggK2jdHLrrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N24Ij5PCpjCF1yU9HfEGfdVuEqcYIKET
	0DF/CvEW/GRIy7YoIITdq/gGnryu/zyYSONlWc1QjB9ArBWvTTZDTs/piVi+W3uc
	4cGFC6FIIxjWHwfhODqZMKzCMiAsvATjcKbUb22YwySYaNh1+kjKuxq09eU4MXg2
	T6JU368mFuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88E1791C1;
	Mon, 17 Dec 2012 14:53:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E58E991BF; Mon, 17 Dec 2012
 14:53:25 -0500 (EST)
In-Reply-To: <CACsJy8BsL03zr_wGZH5kqS0NaMfPKct2T7_62jstxRB4c_FudQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 17 Dec 2012 18:49:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BB50A70-4883-11E2-8597-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211695>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Dec 17, 2012 at 6:33 PM, Dinesh Subramani
> <dinesh.subramani@gmail.com> wrote:
>> I am using the below command :
>>
>> git log --stat --decorate=full --since=<date>
>>
>> Can you please let me know if the above command will list all the
>> commits and would not skip any of the commits due to History
>> Simplification. Any help would be very useful.
>
> If my memory is still functioning, history simplification only takes
> place when you specify pathspec. The above command does not have
> pathspec, so no history simplification.

Think of the pathspec limiting as asking to choose commits by one
criteria (i.e. touches paths in a way that matters in the result),
like any other commit limiting criteria like "--grep" (i.e. asks to
choose commits that has the given string in its message).

With something like --author or --grep, we would need to look at
each individual commmit to decide if it matches the criteria.  With
pathspec, when we look at a single-parent commit, we inspect it to
decide if it matches the criteria of touching the specified paths.

When we are looking at a merge commit, however, if one of the
parents match the result at all the paths that match the given
pathspec, we know any and all commits on the other side branches do
not matter in the result, hence we can omit them by not even having
to follow that parent ancestry.

If you mention --full-history in your answer, it will be perfect ;-)
