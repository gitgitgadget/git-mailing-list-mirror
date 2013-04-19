From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] submodule: drop the top-level requirement
Date: Fri, 19 Apr 2013 09:45:54 -0700
Message-ID: <7vmwsu31vh.fsf@alter.siamese.dyndns.org>
References: <cover.1365539059.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
	<7vfvyn4g46.fsf@alter.siamese.dyndns.org>
	<20130419074632.GC2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Apr 19 18:46:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTERp-0000Mn-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031154Ab3DSQp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:45:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030840Ab3DSQp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 12:45:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC0C15D58;
	Fri, 19 Apr 2013 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KQzaNUxmIa9Dc9zI8t2Tf9tqXeQ=; b=xwWwhc
	z4ZN1gcjtSgfoaPjkoebwd/F/lpaTJhrOcLOqIX+hZ7iRneg2rAXBaA/eMbIUHIr
	TUBokPQLIUyl+FAHqw87LEEMX44QnrveYDXHIVm+5l0cLY9R4QiJXUmA29G5eztR
	+ZjHWbp9zmXtXHV3TJylmQtFObUV0W+YVl44E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J6wBbDU7/IYO/c/G63/jlUCCRB26351b
	eruFK3pBtGzo7IUTyi1lRYa/0i8iBwlUsP7RsrveLMJhewhB02Sh24N2DsovHY7V
	vb/xNMxnXlrm/9BMwwb2t62Zex/ailZum+ziJOKcjqhUJ85aS0WNdDsJV3qwyaIG
	api62hh/bRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83DE015D56;
	Fri, 19 Apr 2013 16:45:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5398415D4E;
	Fri, 19 Apr 2013 16:45:56 +0000 (UTC)
In-Reply-To: <20130419074632.GC2278@serenity.lan> (John Keeping's message of
	"Fri, 19 Apr 2013 08:46:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B4982DC-A910-11E2-AEBC-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221777>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Apr 18, 2013 at 03:40:41PM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > +relative_path ()
>> > +{
>> > +	local target curdir result
>> > +	target=$1
>> > +	curdir=${2-$wt_prefix}
>> > +	curdir=${curdir%/}
>> > +	result=
>> > +
>> > +	while test -n "$curdir"
>> > +	do
>> > +		case "$target" in
>> > +		"$curdir/"*)
>> > +			target=${target#$curdir/}
>> > +			break
>> > +			;;
>> > +		esac
>> 
>> Could $curdir have glob wildcard to throw this part of the logic
>> off?  It is OK to have limitations like "you cannot have a glob
>> characters in your path to submodule working tree" (at least until
>> we start rewriting these in C or Perl or Python), but we need to be
>> aware of them.
>
> I think the use of "#" instead of "##" saves us here because even with a
> wildcard in $curdir the case statement matches literally, 

If you have curdir=a*b and target=adropb/c/d/e, the chopping itself

	target=${target#$curdir/}

would happily chop "adropb/" from the target, but because the dq
around "$curdir/"* in the case arm label enforces that target must
literally match curdir followed by a slash, we do not even come to
the chomping part.

I still have not convinced myself that it is impossible for somebody
more clever than I to craft a pair of target and curdir that breaks
it, though.  (target="a*b/c/d", curdir="a*b") is correctly chopped,
so that is not it.
