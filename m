From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Mon, 05 Nov 2007 13:57:53 -0500
Message-ID: <1194289073.13968.16.camel@hinata.boston.redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	 <1194017589-4669-2-git-send-email-krh@redhat.com>
	 <1194017589-4669-3-git-send-email-krh@redhat.com>
	 <1194017589-4669-4-git-send-email-krh@redhat.com>
	 <20071103150637.GA11172@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 19:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip79g-0004wi-CR
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 19:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXKES6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 13:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbXKES6U
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 13:58:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXKES6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 13:58:19 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA5Iw0Q2028131;
	Mon, 5 Nov 2007 13:58:00 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA5Iw0L2001725;
	Mon, 5 Nov 2007 13:58:00 -0500
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA5Ivx7N019302;
	Mon, 5 Nov 2007 13:57:59 -0500
In-Reply-To: <20071103150637.GA11172@atjola.homenet>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63534>

On Sat, 2007-11-03 at 16:06 +0100, Bj=C3=B6rn Steinbrink wrote:
> On 2007.11.02 11:33:09 -0400, Kristian H=C3=B8gsberg wrote:
> > +	if (all && interactive)
> > +		die("Cannot use -a, --interactive or -i at the same time.");
>=20
> Shouldn't that be "if (all && (interactive || also))"?

The shell script just has

case "$all,$interactive,$also,$#" in
*t,*t,*)
        die "Cannot use -a, --interactive or -i at the same time." ;;

which doesn't seem to care about the value of $also.  As far as I
understand git commit, it doesn't make sense to pass any of -a, -i, -o
or --interactive at the same time so I guess I could join the checks

        if (also && only)
                die("Only one of --include/--only can be used.");
        if (all && interactive)
                die("Cannot use -a, --interactive or -i at the same
time.");

into something like

	if (also + only + all + interactive > 1)             =20
		die("Only one of --include/--only/--all/--interactive can be used.");

Does that sound right?

Kristian
