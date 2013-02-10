From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! graph: output padding for merge subsequent
 parents
Date: Sun, 10 Feb 2013 11:30:39 -0800
Message-ID: <7vliawt19c.fsf@alter.siamese.dyndns.org>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <20130210131647.GA2270@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?M?= =?utf-8?Q?icha=C5=82?= Kiedrowicz 
	<michal.kiedrowicz@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 10 20:31:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ccJ-00023W-Lv
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 20:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760473Ab3BJTat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2013 14:30:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755786Ab3BJTas convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2013 14:30:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59BD3BF9F;
	Sun, 10 Feb 2013 14:30:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xwOsw18rnWJJ
	jdVmoMAsakt4Wwg=; b=hAx0QQw4WPT6lRVFRNOiFrRZ33nCY0sZ4JEfPYCIkot5
	TV9emClds8Nd7Uiwt6dpFjpuEV9NoQ3ufOGzUaMms0HARoPOeQIvjeJSBKgLPG4a
	MmpHz7rkU4XnIB609deQXbL63C0I1U0txlf76cIY6vC4fKeqyEgXRlRQYwP128o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Udlvrc
	8oD8mRt2VnGBm7RFOoNxDzGIGF05JNIsoVMHQSYXUy2TTq5je40DqNuqD+TIDqXt
	5yzTQDblVDpEAdCtDvTJxIQoJSEj3GFabCv0Q2QCoJwH51x/73J0y36AsKCrAc/F
	FxyLPFSZSGebWwoYY6aTlQ1CT+6u0tlLUvYWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 283C1BF9B;
	Sun, 10 Feb 2013 14:30:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E2E8BF8B; Sun, 10 Feb 2013
 14:30:45 -0500 (EST)
In-Reply-To: <20130210131647.GA2270@serenity.lan> (John Keeping's message of
 "Sun, 10 Feb 2013 13:16:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E166296-73B8-11E2-A7F2-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215928>

John Keeping <john@keeping.me.uk> writes:

> Can you squash this into the first commit before you do?
>
> Matthieu is correct that the graph_is_commit_finished() check isn't
> needed in the loop now that we've pulled it out to be checked first -
> the value returned can't change during the loop.  I've left the early
> return out.
>
>  graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/graph.c b/graph.c
> index 2a3fc5c..56f970f 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -1237,7 +1237,7 @@ void graph_show_commit(struct git_graph *graph)
>  		shown_commit_line =3D 1;
>  	}
> =20
> -	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
> +	while (!shown_commit_line) {
>  		shown_commit_line =3D graph_next_line(graph, &msgbuf);
>  		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
>  		if (!shown_commit_line)

Is it correct to say that this essentially re-does 656197ad3805
(graph.c: infinite loop in git whatchanged --graph -m, 2009-07-25)
in a slightly different way, in that Micha=C5=82's original fix also
protected against the case where graph->state is flipped to
GRAPH_PADDING by graph_next_line() that returns false, but with your
fixup, the code knows it never happens (i.e. when graph_next_line()
returns false, graph->state is always in the GRAPH_PADDING state),
and the only thing we need to be careful about is when graph->state
is already in the PADDING state upon entry to this function?

Sorry for an overlong single sentence question ;-)

Thanks.
