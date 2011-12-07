From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Wed, 7 Dec 2011 09:12:54 +0100
Message-ID: <201112070912.54766.trast@student.ethz.ch>
References: <cover.1322830368.git.trast@student.ethz.ch> <4EDE9BBA.2010409@lsrfire.ath.cx> <4EDE9ED1.8010502@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:13:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCcg-0007yB-3l
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab1LGIM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 03:12:57 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:11054 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100Ab1LGIM4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 03:12:56 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 09:12:53 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 09:12:55 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4EDE9ED1.8010502@lsrfire.ath.cx>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186442>

Ren=E9 Scharfe wrote:
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 47ac188..e981a9b 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -228,8 +228,9 @@ OPTIONS
>  	there is a match and with non-zero status when there isn't.
> =20
>  --threads <n>::
> +	Run <n> search threads in parallel.  Default is 8 when searching
> +	the worktree and 0 otherwise.  This option is ignored if git was
> +	built without support for POSIX threads.
[...]
> -		nr_threads =3D (online_cpus() > 1) ? THREADS : 0;
> +		nr_threads =3D (online_cpus() > 1 && !list.nr) ? THREADS : 0;

It would be more consistent to stick to the pack.threads convention
where 0 means "all of my cores", so to disable threading the user
would set the number of threads to 1.  Or were you trying to measure
the contention between the worker thread and the add_work() thread?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
