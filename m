From: Bernt Hansen <bernt@norang.ca>
Subject: Re: [PATCH] receive-pack: Initialize PATH to include exec-dir.
Date: Sun, 02 Mar 2008 23:21:25 -0500
Organization: Norang Consulting Inc
Message-ID: <87ve44cu9m.fsf@gollum.intra.norang.ca>
References: <20080303040843.GA27185@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, srp@srparish.net, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 06:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW2tg-0003dF-8c
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 06:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYCCFGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 00:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYCCFGy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 00:06:54 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54400 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYCCFGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 00:06:49 -0500
X-Greylist: delayed 2717 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Mar 2008 00:06:49 EST
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1JW2B9-0006NX-HZ; Mon, 03 Mar 2008 04:21:31 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+JOdBE87oTpjl5UtJRw6n5
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id m234LQs8008716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Mar 2008 23:21:27 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id m234LQTg022342;
	Sun, 2 Mar 2008 23:21:26 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id m234LP9t022341;
	Sun, 2 Mar 2008 23:21:25 -0500
In-Reply-To: <20080303040843.GA27185@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Mon\, 3 Mar 2008 05\:08\:43
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75883>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> 511707d (use only the $PATH for exec'ing git commands) made it a
> requirement to call setup_path() to include the git exec-dir in PATH
> before spawning any other git commands. git-receive-pack was not yet
> adapted to do this and therefore fails to spawn git-unpack-objects if=
 that
> is not in the standard PATH.
>
> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> ---
>  receive-pack.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/receive-pack.c b/receive-pack.c
> index a971433..f83ae87 100644
> --- a/receive-pack.c
> +++ b/receive-pack.c
> @@ -471,6 +471,8 @@ int main(int argc, char **argv)
>  	if (!dir)
>  		usage(receive_pack_usage);
> =20
> +	setup_path(NULL);
> +
>  	if (!enter_repo(dir, 0))
>  		die("'%s': unable to chdir or not a git archive", dir);
> =20
> --=20
> 1.5.4.3.1.g3b5b4
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Tested by: Bernt Hansen <bernt@norang.ca>
