From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/4] git check-ref-format --print
Date: Mon, 12 Oct 2009 14:06:21 -0700
Message-ID: <7veip8e302.fsf@alter.siamese.dyndns.org>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock> <20091012053141.GD11106@progeny.tock>
 <20091012143922.GL9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDf-0002of-3Z
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbZJLVHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758161AbZJLVHR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162AbZJLVHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:07:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51D5D56670;
	Mon, 12 Oct 2009 17:06:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qqzrJEPzcRS8HSBIB5+x4jhy41E=; b=Y1PEX1bcZR5f4GepnYMl7xu
	Yqnk0vrHjpd/a4UCQnooK1QGLDwo8cTZ6NZnJsEc+MmT19qHOFM0SS+2Kyy2W6wg
	Diq1jnbFYdomfSvXRGp19FJmWb5SPOMFoJxKFo+Pclmml224G8zOzZiYbBxsiuQE
	XPRaPl90FGrwGeZkU/2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=clmCTcjnROVeF51yI9IRPm7CKyQPhzJq9EXSFVCiSj2y5fW0/
	o28uSCNmH/zQLdeNPHbvK+R0TqqvfJUMv/gTyZLQwNThTWVACD78+SA1/vSBVVo9
	6vBlFTw8xSvKcqJyOFwQHXgv08YQoqTA6YuXQiVPANp0oIcO1WgIDADQas=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1560556668;
	Mon, 12 Oct 2009 17:06:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1030956664; Mon, 12 Oct
 2009 17:06:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C3D53B6-B773-11DE-9D8D-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130070>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> +valid_ref_normalized 'heads/foo' 'heads/foo'
>> +valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
>> +invalid_ref_normalized 'foo'
>> +invalid_ref_normalized 'heads/foo/../bar'
>> +invalid_ref_normalized 'heads/./foo'
>> +invalid_ref_normalized 'heads\foo'
>
> What about '/refs/heads/foo'?  Shouldn't that drop the leading /?
>
> I actually had someone enter that into Gerrit Code Review once,
> exposing a bug I have yet to fix that permits that as a valid
> branch name.  *sigh*
>
> FWIW, I think this is heading in the right direction.  Rather
> than teaching the UIs how clean up a name, give us a tool to
> do the normalization and validation, and let us call it when
> we get user input.

I understand that you prefer the latter between "there is no tool; the
caller is responsibile to make sure it feeds us canonical representation"
and "there is a tool that makes a slightly malformed string into canonical
form for the callers to use before calling us."  And that would be my
preference between these two as well.

But that is based on the current behaviour of accepting slightly malformed
and silently making it canonical.  If we throw a third alternative,
Jonathan's original patch, that did "we reject malformed string", in the
mix, what would be your preference?

I moderately favour the "tool to canonicalize is given, and it would be a
bug for the caller not to use it" approach this series takes primarily
because that approach won't break scripts that do something like this to
make a new branch, optionally grouped by the owner (e.g. 'sp/smart-http'
or 'next'):

	owner=$1 topic=$2
	branch=$owner/$topic
        git branch "$branch"

This currently works as expected as long as it does not later try to
compare for-each-ref output with "refs/heads/$branch" and expects a match.
With the third approach, the optional username grouping becomes mandatory
for such a script, as 'git branch' will error out.  To keep the grouping
still optinal, such a script needs to be written perhaps like:

	if test -z "$2"
        then
		branch="$1"
	else
        	branch="$1/$2"
	fi

and that would be a hassle for the scripters, but this _could_ be a kind
of backward incompatible tightening we might want to consider for 1.7.0,
as somebody suggested earlier.

But now I have spelled this out, I do not see much upside for rejecting,
and more importantly, I think it would be an independent issue.  We can
reject or just keep normalizing silently, and a tool to show the
normalized name would be useful and necessary regardless of that.
