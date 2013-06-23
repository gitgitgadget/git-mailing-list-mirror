From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-daemon: have --no-syslog
Date: Sat, 22 Jun 2013 23:21:03 -0700
Message-ID: <7v38s9jqk0.fsf@alter.siamese.dyndns.org>
References: <20130622174122.GA6496@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 23 08:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqdg0-0001ko-Fj
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 08:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778Ab3FWGVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 02:21:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab3FWGVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 02:21:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58AC525928;
	Sun, 23 Jun 2013 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dDLtvyQ+cXi45wW4/jozaupgLb0=; b=sqmFzx
	WZsZMdXOpT1XH2UozFWtgexZ8nCDKan98QiajZsyvBZEX7mMwTf796TWvWf8Sl5k
	Fgh8tSyAIa3sEYq2+tvFpqpFrHXlv6W//C75fP3w+zCDeUOAk5UWZPr43ojrMbgM
	WLY5cmvYeI7g6QtDhmZS2l5EPjplBXoRDiMs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eP+ca7/+tch0nvQp3VG4DU7ONWeWeUVl
	KgDbwGSw1egPEkrBbwoSmYygyDFDkLmg34a014niVvWictpY0nvq30sRQx6Q6FWz
	bYl45xlafhzgy/qJdU3Zi3wDzT82uD0MWvpxAuaN1ubnTeERZfClOGas8xB6Qx61
	4hIse8C4Fec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F09325927;
	Sun, 23 Jun 2013 06:21:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E44A25926;
	Sun, 23 Jun 2013 06:21:06 +0000 (UTC)
In-Reply-To: <20130622174122.GA6496@inner.h.apk.li> (Andreas Krey's message of
	"Sat, 22 Jun 2013 19:41:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 164A9A90-DBCD-11E2-BA75-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228721>

Andreas Krey <a.krey@gmx.de> writes:

> Some people run inetds that collect stderr of the spawned programs.
> Give them 'git-daemon --inetd --no-syslog' to keep error output
> on stderr.
>
> Signed-off-by: Andreas Krey <a.krey@gmx.de>
> ---

Are there examples of other daemon programs outside Git that have
this particular support to help such inetd implementations?

I would like to know how widely this kind of workaround is done, and
also what they call the option, as a quick sanity check.

Thanks.

>  Documentation/git-daemon.txt |  4 ++++
>  daemon.c                     | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index 223f731..007d3fc 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -113,6 +113,10 @@ OPTIONS
>  	Log to syslog instead of stderr. Note that this option does not imply
>  	--verbose, thus by default only error conditions will be logged.
>  
> +--no-syslog::
> +	Disable the implicit --syslog of --inetd and --deatch, thus keeping
> +	error output on stderr.
> +
>  --user-path::
>  --user-path=<path>::
>  	Allow {tilde}user notation to be used in requests.  When
> diff --git a/daemon.c b/daemon.c
> index 6aeddcb..2f5d5bf 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1196,7 +1196,6 @@ int main(int argc, char **argv)
>  		}
>  		if (!strcmp(arg, "--inetd")) {
>  			inetd_mode = 1;
> -			log_syslog = 1;
>  			continue;
>  		}
>  		if (!strcmp(arg, "--verbose")) {
> @@ -1207,6 +1206,10 @@ int main(int argc, char **argv)
>  			log_syslog = 1;
>  			continue;
>  		}
> +		if (!strcmp(arg, "--no-syslog")) {
> +			log_syslog = -1;
> +			continue;
> +		}
>  		if (!strcmp(arg, "--export-all")) {
>  			export_all_trees = 1;
>  			continue;
> @@ -1263,7 +1266,6 @@ int main(int argc, char **argv)
>  		}
>  		if (!strcmp(arg, "--detach")) {
>  			detach = 1;
> -			log_syslog = 1;
>  			continue;
>  		}
>  		if (!prefixcmp(arg, "--user=")) {
> @@ -1309,6 +1311,12 @@ int main(int argc, char **argv)
>  		usage(daemon_usage);
>  	}
>  
> +	if ((inetd_mode || detach) && log_syslog == 0)
> +		log_syslog = 1;
> +
> +	if (log_syslog == -1)
> +		log_syslog = 0;
> +
>  	if (log_syslog) {
>  		openlog("git-daemon", LOG_PID, LOG_DAEMON);
>  		set_die_routine(daemon_die);
> @@ -1337,7 +1345,7 @@ int main(int argc, char **argv)
>  		die("base-path '%s' does not exist or is not a directory",
>  		    base_path);
>  
> -	if (inetd_mode) {
> +	if (inetd_mode && log_syslog) {
>  		if (!freopen("/dev/null", "w", stderr))
>  			die_errno("failed to redirect stderr to /dev/null");
>  	}
