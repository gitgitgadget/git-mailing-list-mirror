From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/14] pull: set reflog message
Date: Mon, 18 May 2015 21:27:36 +0200
Organization: gmx
Message-ID: <390e789e8f84122d52185f22e6e798f2@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-11-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:27:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQhV-00053j-0V
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbbERT1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:27:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:51168 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471AbbERT1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:27:39 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LqALY-1ZPLfl0fzc-00dna3; Mon, 18 May 2015 21:27:37
 +0200
In-Reply-To: <1431961571-20370-11-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:12DffSLufnbCI6DEdlejySfFoVfKmEE/990nPgkIHZpI5BqQM4q
 hoyzhOCX4RdIvzk4JSKUkw4h6K0n8MLFBVd5G2oB5U1HgJz+MBwrLZZX65MOhMY+vHEJ4Dk
 tZYmbqNQ3geZ/zlhECAsMAxa1FTBF5AXy+AEseGWQqQ+ZT0W/Bd1aLE7flP3bPBLFXxd4f8
 hZrz00LnZZAk7iy/rJ53w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269312>

Hi Paul,

On 2015-05-18 17:06, Paul Tan wrote:

> diff --git a/builtin/pull.c b/builtin/pull.c
> index ba2ff01..81e31a1 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -212,6 +212,26 @@ static void argv_push_force(struct argv_array *arr)
>  }
>  
>  /**
> + * Sets the GIT_REFLOG_ACTION environment variable to the concatenation of argv
> + */
> +static void set_reflog_message(int argc, const char **argv)
> +{
> +	int i;
> +	struct strbuf msg = STRBUF_INIT;
> +
> +	for (i = 0; i < argc; i++) {
> +		strbuf_addstr(&msg, argv[i]);
> +		strbuf_addch(&msg, ' ');
> +	}
> +
> +	strbuf_rtrim(&msg);

Since this is not performance critical code, I would be slightly in favor of simplifying thusly:

/* Join the argument list, separated by spaces */
for (i = 0; i < argc; i++)
	strbuf_addf(&msg, "%s%s", i ? " " : "", argv[i]);

Just a suggestion,
Dscho
