From: Junio C Hamano <gitster@pobox.com>
Subject: Re: To page or not to page
Date: Thu, 01 May 2008 23:19:49 -0700
Message-ID: <7vd4o5xm62.fsf@gitster.siamese.dyndns.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
 <20080502054508.GA28506@sigill.intra.peff.net>
 <20080502060930.GA1079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 08:20:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrodb-00029Z-JS
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 08:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037AbYEBGUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 02:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757930AbYEBGUG
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 02:20:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021AbYEBGUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 02:20:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78E291C91;
	Fri,  2 May 2008 02:20:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8659E1C8E; Fri,  2 May 2008 02:19:58 -0400 (EDT)
In-Reply-To: <20080502060930.GA1079@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 May 2008 02:09:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC756624-180F-11DD-8BF3-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80964>

Jeff King <peff@peff.net> writes:

> @@ -267,103 +270,103 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
>  	return 0;
>  }
>  
> +static struct cmd_struct commands[] = {
> +	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "annotate", cmd_annotate, RUN_SETUP },
> +	{ "apply", cmd_apply },
> +	{ "archive", cmd_archive },
> +	{ "blame", cmd_blame, RUN_SETUP },
> +	{ "branch", cmd_branch, RUN_SETUP },
> +	{ "bundle", cmd_bundle },
> +	{ "cat-file", cmd_cat_file, RUN_SETUP },
...
> +};
> ...
> @@ -380,6 +383,31 @@ static void handle_internal_command(int argc, const char **argv)
>  	}
>  }
>  
> +void set_command_pager(const char *cmd, int use_pager)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +		struct cmd_struct *p = commands+i;
> +		if (!strcmp(p->cmd, cmd)) {
> +			if (use_pager)
> +				p->option |= USE_PAGER;
> +			else
> +				p->option &= ~USE_PAGER;
> +			return;
> +		}
> +	}
> +}

Heh, I like it.  I briefly thought that pager.cat-file may wreak havoc on
scripts, but our pager machanism should be clever enough not to, and
cat-file is a valid variable name in the configuration file format ;-).
