From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 03/11] grep: show --debug output only once
Date: Fri, 14 Sep 2012 10:11:54 -0700
Message-ID: <7vmx0s5y1x.fsf@alter.siamese.dyndns.org>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
 <53e193b5c4ab329baf469ff20549839fa3088d97.1347615361.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:12:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCZQy-0004X9-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 19:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab2INRL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 13:11:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2INRL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 13:11:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 112E089F9;
	Fri, 14 Sep 2012 13:11:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e4ycX64pd9+7NcHVoJuCZRodITo=; b=XZ/OSp
	JyrsAhdZAAGs+daeQLtmoYOH70MKpHtG81aUQqXoTRV9FOOJKMqjWyWeAAa2uaEL
	MBDvubAJDUZ9ujp4POHgAL/EIHDYGd82i/42d89of7NIArLeNFHkXGFg1uH0DsIu
	DUfquEJuVlRYaBFoewEfi0L931IipoMa4DjAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JoeJkGyWilWczTY0WasrQ3wGxoZuYe46
	YLETQhqhgzwv/su4AplakVrxbs7rlrlteuk4SJwN1zxuSqnDFL1O8XEXp1UP4eMT
	6468SjMFdVjGcHefJaojxeHPzenXqE53o5MTXr2zMX2L4v/E5TBJ3Vgtpz3RmUjt
	ECts9PMKyvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F387989F7;
	Fri, 14 Sep 2012 13:11:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72F9189F6; Fri, 14 Sep 2012
 13:11:55 -0400 (EDT)
In-Reply-To: <53e193b5c4ab329baf469ff20549839fa3088d97.1347615361.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 14 Sep 2012 11:46:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48E81412-FE8F-11E1-B523-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205506>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When threaded grep is in effect, the patterns are duplicated and
> recompiled for each thread. Avoid "--debug" output during the
> recompilation so that the output is given once instead of "1+nthreads"
> times.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/grep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8aea00c..a7e8df0 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -209,6 +209,7 @@ static void start_threads(struct grep_opt *opt)
>  		int err;
>  		struct grep_opt *o = grep_opt_dup(opt);
>  		o->output = strbuf_out;
> +		o->debug = 0;
>  		compile_grep_patterns(o);
>  		err = pthread_create(&threads[i], NULL, run, o);

Makes sense; thanks.
