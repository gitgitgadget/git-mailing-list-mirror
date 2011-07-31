From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 10/18] revert: Don't create invalid replay_opts in parse_args
Date: Sun, 31 Jul 2011 14:31:25 +0200
Message-ID: <201107311431.26187.chriscool@tuxfamily.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com> <1311736755-24205-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 14:31:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnVBO-0005eF-Fe
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 14:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab1GaMbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 08:31:37 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42060 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab1GaMbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 08:31:36 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C7D86A617B;
	Sun, 31 Jul 2011 14:31:28 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1311736755-24205-11-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178247>

On Wednesday 27 July 2011 05:19:07 Ramkumar Ramachandra wrote:
>
> +static void verify_opt_compatible(const char *me, const char *base_opt,
> ...) +{
> +	const char *this_opt;
> +	va_list ap;
> +	int set;
> +
> +	va_start(ap, base_opt);
> +	while ((this_opt = va_arg(ap, const char *))) {
> +		set = va_arg(ap, int);
> +		if (set)
> +			die(_("%s: %s cannot be used with %s"),
> +				me, this_opt, base_opt);
> +	}
> +	va_end(ap);
> +}

Question: returning in the middle of va_start() - va_end() may not be ok with 
some compilers, but I don't know how safe it is to exit()?

> +	/*
> +	 * Sequence of picks finished successfully; cleanup by
> +	 * removing the .git/sequencer directory
> +	 */
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "%s", git_path(SEQ_DIR));
> +	remove_dir_recursively(&buf, 0);
>  	return 0;
>  }

The "strbuf_reset(&buf)" is not needed. But a "strbuf_release(&buf)" could be 
added before the return.

Thanks,
Christian.
