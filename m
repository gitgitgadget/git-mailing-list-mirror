From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 00:36:11 +0200
Message-ID: <87obqueyas.fsf@thomas.inf.ethz.ch>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 00:36:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJBa0-00035v-SS
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 00:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab2DNWgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 18:36:23 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:45583 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756481Ab2DNWgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 18:36:22 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Sun, 15 Apr
 2012 00:36:17 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (213.55.184.208) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 15 Apr
 2012 00:36:18 +0200
In-Reply-To: <1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 15 Apr 2012 00:43:00 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [213.55.184.208]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195527>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>  # __gitcomp_1 requires 2 arguments
>  __gitcomp_1 ()
>  {
> -	local c IFS=' '$'\t'$'\n'
> +	local c s IFS=' '$'\t'$'\n'
>  	for c in $1; do
>  		case "$c$2" in
> -		--*=*) printf %s$'\n' "$c$2" ;;
> -		*.)    printf %s$'\n' "$c$2" ;;
> -		*)     printf %s$'\n' "$c$2 " ;;
> +		--*=* | *.) s="" ;;
> +		*)          s=" " ;;
>  		esac
> +		echo "$c$2$s"
>  	done
>  }

Sorry for not noticing earlier, but...

I did a double take at the change to 'echo'.  I'm guessing from the
patch that $c$2$s is never just '-e' or some other option taken by the
bash version[1] of echo.  But can you be sure?  Do you know off hand
whether '-nbogus' complains, treats the -n as usual and prints 'bogus',
or echoes '-nbogus'[2]?  Are you sure future bash versions won't break
this?


Also, I can't help but complain about your commit messages (again).
Compare with Jonathan's in 4/5.  His patch is all of a one-line(!)
change

 			--exec-path
+			--exec-path=

yet his commit message is two paragraphs worth of explanations why the
changed behavior is more helpful than what we had before.

On the other hand, your commit message for the above says only

  completion: simplify __gitcomp_1

However, your patch is actually two different changes:

1. the refactoring of the partial command: printf %s$'\n' "$c$2
2. the change to echo

The latter is not in any way explained or justified by your (total
absence of a) commit message.


Footnotes: 
[1]  POSIX states that echo "shall not support any options" and "shall
not recognize the -- argument", but we have printfs all over the code
base because option support is extremely inconsistent

[2]  Spoiler: it prints -nbogus literally

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
