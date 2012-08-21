From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] t6300: test sort with multiple keys
Date: Tue, 21 Aug 2012 14:33:57 -0700
Message-ID: <7vobm4c4l6.fsf@alter.siamese.dyndns.org>
References: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org> <7vk3wuo0sa.fsf@alter.siamese.dyndns.org> <91678e1e50f23bdb2c3b2c5716f92d870a233e77.1345534654.git.draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3w5Q-00049S-23
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 23:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758577Ab2HUVeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 17:34:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758448Ab2HUVeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 17:34:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7641086FA;
	Tue, 21 Aug 2012 17:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SoS9a1E3OE29zGdK3hTmma7I8BQ=; b=S7tLQp
	g6NGoe5aQ+BkJh7SgipK0HhDDf4PzHsTzQwKeIeLTJB6Q4+s0rSIXkbIWBTPkjPP
	60sA3jhq9pGP8PTOxUge7PhIme35M3eFabDPZcwNTSKbrduoWwJtCVM/1r4guo2k
	OShZgY1mcE4zRYxMxNBUhP3H2Wr8bFx6BG5e8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WQjeolF3/jVisWzWME8aRpyyz8KjgXsw
	j5mxN+d8Jf5b+fzyAnU9GBO9+yRnhjO+xGn+AVDv5+3Pc7k8jys/FJFCLn4S2RdB
	TM+yMJ3JzK1eYClMR5tT7XhnGJjs6bTm1SfF4FNZslJR6xt5+gYSh48VYfC7iCsi
	dU/DYHG8EA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63CC986F9;
	Tue, 21 Aug 2012 17:33:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C730386F8; Tue, 21 Aug 2012
 17:33:58 -0400 (EDT)
In-Reply-To: <91678e1e50f23bdb2c3b2c5716f92d870a233e77.1345534654.git.draenog@pld-linux.org> (Kacper Kornet's message of "Tue, 21 Aug 2012 09:46:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAD6432C-EBD7-11E1-9383-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203990>

Kacper Kornet <draenog@pld-linux.org> writes:

> Documentation of git-for-each-ref says that --sort=<key> option can be
> used multiple times, in which case the last key becomes the primary key.
> However this functionality was never checked in test suite and is
> currently broken. This commit adds appropriate test in preparation for fix.
>
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>  t/t6300-for-each-ref.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Much nicer and concise.  It would have been even better if it didn't
have to depend on exact object names, but the existing tests already
depend on them, so it is not making things worse.

Thanks.  Will queue.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 1721784..a0d82d4 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -456,4 +456,14 @@ test_atom refs/tags/signed-long contents "subject line
>  body contents
>  $sig"
>  
> +cat >expected <<\EOF
> +408fe76d02a785a006c2e9c669b7be5589ede96d <committer@example.com> refs/tags/master
> +90b5ebede4899eda64893bc2a4c8f1d6fb6dfc40 <committer@example.com> refs/tags/bogo
> +EOF
> +
> +test_expect_failure 'Verify sort with multiple keys' '
> +	git for-each-ref --format="%(objectname) %(taggeremail) %(refname)" --sort=objectname --sort=taggeremail \
> +		refs/tags/bogo refs/tags/master > actual &&
> +	test_cmp expected actual
> +'
>  test_done
> -- 
> 1.7.12.rc3
