From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tools: fread does not return negative on error
Date: Mon, 22 Jun 2009 17:34:31 +0200
Message-ID: <20090622153431.GA18466@elte.hu>
References: <4A3FB09D.9050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Roel Kluin <roel.kluin@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 17:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIlXo-0005yZ-6n
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 17:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242AbZFVPej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 11:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbZFVPej
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 11:34:39 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49419 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbZFVPei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 11:34:38 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1MIlXZ-0007eG-4S
	from <mingo@elte.hu>; Mon, 22 Jun 2009 17:34:40 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 661753E22B0; Mon, 22 Jun 2009 17:34:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A3FB09D.9050903@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.2.5
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0300]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122045>


* Roel Kluin <roel.kluin@gmail.com> wrote:

> size_t res cannot be less than 0. fread returns 0 on error.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this correct? please review.
> 
> diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
> index eaba093..376a337 100644
> --- a/tools/perf/util/strbuf.c
> +++ b/tools/perf/util/strbuf.c
> @@ -259,7 +259,7 @@ size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
>  	res = fread(sb->buf + sb->len, 1, size, f);
>  	if (res > 0)
>  		strbuf_setlen(sb, sb->len + res);
> -	else if (res < 0 && oldalloc == 0)
> +	else if (res == 0 && oldalloc == 0)
>  		strbuf_release(sb);
>  	return res;

This comes straight from Git's strbuf.c so i've Cc:-ed the Git list.

Roel, did you get some compiler warning that made you look at this 
code?

	Ingo
