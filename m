From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: branch --contains is unbearably slow [Re: [PATCHv2] Warnings before rebasing -i published history]
Date: Tue, 12 Jun 2012 00:08:14 +0200
Message-ID: <87bokp8ptd.fsf@thomas.inf.ethz.ch>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<87r4tmhy12.fsf_-_@thomas.inf.ethz.ch>
	<7vvcix7rim.fsf@alter.siamese.dyndns.org>
	<87vcix8pz5.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	<git@vger.kernel.org>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCmZ-0006a8-K0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab2FKWIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 18:08:18 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:40042 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab2FKWIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:08:16 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 12 Jun
 2012 00:08:14 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 12 Jun
 2012 00:08:15 +0200
In-Reply-To: <87vcix8pz5.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Tue, 12 Jun 2012 00:04:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199744>

Thomas Rast <trast@student.ethz.ch> writes:

>> But
>>
>>     $ time git branch -r --contains next
>>       github2/next
>>       gph/next
>>       ko/next
>>       repo/next
>>
>>     real    0m3.853s
[...]
> I'll get rid of all this cruft now, but this command doesn't scale in
> the direction I'm abusing it :-)

BTW, my original point still stands: at nearly 4s per invocation of
'branch -r --contains', the loop as written by Lucien

> +add_remoterefs () {
> +	while read -r command sha1 message
> +	do
> +		printf '%s\n' "$command $sha1 $message"
> +		git branch -r --contains "$sha1" >"$1.branch"
[...]
> +	done >"$1.published" <"$1"
> +	cat "$1.published" >"$1"
> +	rm -f "$1.published" "$1.branch"
> +}

is unusable in your repository, too.  Which is a real pity, it's a nice
idea.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
