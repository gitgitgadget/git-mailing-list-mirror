From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Tue, 12 Feb 2013 17:53:22 +0000
Message-ID: <20130212175322.GC13501@farnsworth.metanate.com>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
 <7vehgmjsno.fsf@alter.siamese.dyndns.org>
 <20130212095340.GG2270@serenity.lan>
 <7v4nhhigp5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5K3A-0001pF-C7
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 18:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933551Ab3BLRxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 12:53:25 -0500
Received: from dougal.metanate.com ([90.155.101.14]:20362 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932151Ab3BLRxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 12:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=oa+TXVoclQc/NLoCc8mob6LYsMXf8mNLjlk+H1GKpuA=;
	b=E5CJGMOifNW72cAoIxam/2jpj3/wgblnYAjZ2ElfgxfC4NQiWqIbo8diWJ6Ky5iATg/9ZBBMg3fcPUDCkGqKnhfEurD8lO5G3KRN/sEpOuzDPo+ObZ30GhNDw2MpxE6DvZFmyMlb6HhEZ6XBh/eIOPwIqTWgRtbCNSxiNN7xP2xGScR8FDt3rdFa8VRBmZdWKYdl+ORDvsDRfVU5fibkQnwn6xT1h8vH0oYYNe7g/rvqb1UGnAkVsQfN3zet5J/XxA3RWV6AO31iFV3drg1jWzlU1tFV7uzkuIlUbxeEJnPvsfoupOKvPpuiVqYJMZsQ7ZCU/EsR4CSRd9tPDFNXmA==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1U5K2j-0006re-B9; Tue, 12 Feb 2013 17:53:21 +0000
Content-Disposition: inline
In-Reply-To: <7v4nhhigp5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216166>

On Tue, Feb 12, 2013 at 09:29:26AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > ... the following fixup is also needed to avoid relying on the shell
> > emitting a literal backslash when a backslash isn't followed by a known
> > escape character.
> >
> > -- >8 --
> >
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> > index cbe36bf..84bd525 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -947,7 +947,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
> >  	test_when_finished "git config --unset core.commentchar" &&
> >  	cat >comment-lines.sh <<EOF &&
> >  #!$SHELL_PATH
> > -sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
> > +sed -e "2,\$ s/^/\\\\\\\\/" "\$1" >"\$1".tmp
> >  mv "\$1".tmp "\$1"
> >  EOF
> >  	chmod a+x comment-lines.sh &&
> 
> Yeek.  If you used write_script with here-text that does not
> interpolate,
> 
> 	write_script remove-all-but-the-first.sh <<\EOF
> 	sed -e '2,$s/^/\\/'  <"$1" >"$1.tmp" &&
>         mv "$1.tmp" "$1"
> 	EOF
> 
> the above would be much more readable.

Yet another thing for me to learn about ;-)

Do you mean to use that outside the test case, so that the single quotes
work?  Or do I still need some level of escaping?

> I am not sure if I understand what you meant by "literal backslash
> blah blah", though.

It turns out that having this in the script works (in bash and dash
although I haven't checked what Posix has to say about it):

    sed -e "2,$ s/^/\\\/"

and is equivalent to:

    sed -e '2,$ s/^/\\/'

because backslashes that aren't recognised as part of an escape sequence
are not treated specially.


John
