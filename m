From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test that the 'rebase -i' "reword" command always
 cherry-picks a commit.
Date: Mon, 22 Mar 2010 13:46:38 -0700
Message-ID: <7vd3yw84pd.fsf@alter.siamese.dyndns.org>
References: <4BA11B23.4090801@xiplink.com>
 <1269285942-17496-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 21:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtoWp-00023y-O0
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 21:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab0CVUqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 16:46:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259Ab0CVUqw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 16:46:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CC02A4376;
	Mon, 22 Mar 2010 16:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O096GjCkpqAE9qHMOnRNbVTtLvc=; b=Pe4Ni6
	HTdT+YKjRvZKC8uXV5lGrbA+Rx2r9HixaW/DsCVkoW/PjykzEY31F/UJXy6OLJNj
	sMlNBeBIuq0PNr4dlPb4dSPTp+CYGYoJ4BnZ2ufdQscmDn1XWKaBLdWG1OEOPSti
	akAevyjdunm77O9GkmAKPy8/BnrJsiscj4WIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VcJNt8PbHpVRWvJP1gtG0h9ZZhxa3IuF
	AqNM1KTBhE8VoFnJEnS/pHZjPMtksWi2bX4O9cKqm2GTBolpul3X3ydABD+XmfEo
	3mzQCLP4eqer9N2k1yVBKeqgLFHsS3wmaBvExvWkctrSjBQW4+c8yKrv0W0kfnoH
	dVwD53fCVNw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D3AA436E;
	Mon, 22 Mar 2010 16:46:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0D4AA4365; Mon, 22 Mar
 2010 16:46:40 -0400 (EDT)
In-Reply-To: <1269285942-17496-1-git-send-email-marcnarc@xiplink.com> (Marc
 Branchaud's message of "Mon\, 22 Mar 2010 15\:25\:42 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0792C766-35F4-11DF-BE3E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142968>

Marc Branchaud <marcnarc@xiplink.com> writes:

> In particular, "reword" should cherry-pick a reworded commit even if the
> commit's message is unchanged.
>
> This behaviour provides a way to deal with a situation that can arise when
> a merge had to be reverted.  Added an addendum to revert-a-faulty-merge.txt
> describing the situation and how to use "reword" to handle it.
> ---
>
> Is this more acceptable than adding --no-ff to rebase--interactive?
>
> I wasn't sure how to integrate the new text into revert-a-faulty-merge.txt.
> I went with an addendum, but I'm open to other approaches.

The addendum looked readable, but I am a bit puzzled.  "rebase -i --no-ff"
already exists, and is probably a more natural way to do this than saying
"reword" but not rewording anything, no?

I would actually say "rebase -f P" would be even easier and clearer,
especially as...

> ...
> +However, you could avoid these problems if you recreated the entire branch,
> +including commit A:
> +
> + P---o---o---M---x---x---W---x
> + |\         /
> + | A---B---C   <-- old branch
> + \
> +  A'---B'---C' <-- entirely recreated branch
> +
> +Now you can merge A'-B'-C' into the mainline branch without worrying about
> +first reverting W.
> +
> +But if you don't actually need to change commit A, then you need some way to
> +recreate it as a new commit with the same changes in it.

... this part seems to talk about working around the tendency of 'rebase -i'
to fast-forward.
