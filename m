From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed,  4 Jan 2012 16:55:33 +0100
Message-ID: <1325692539-26748-1-git-send-email-drizzd@aon.at>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:04:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTJw-0001qP-82
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab2ADQEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:04:04 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:8299 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756127Ab2ADQEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:04:02 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id E17CDCDF89;
	Wed,  4 Jan 2012 17:04:51 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187925>

Thanks for your review. Please find fixes in reply to this email. In
order to better show individual changes I have not squashed them into
one commit. For upstream, you will probably want to squash patches 3-6
into patch 2. Patch 2 is the same as the one once queued as part of
cb/daemon-permission-errors.

[PATCH 1/6] t5550: repack everything into one file
[PATCH 2/6] daemon: add tests
[PATCH 3/6] avoid use of pkill
[PATCH 4/6] explain expected exit code
[PATCH 5/6] t5570: everything into one file
[PATCH 6/6] chmod: use lower-case x

On Tue, Jan 03, 2012 at 11:34:08AM -0800, Junio C Hamano wrote:
> >> +
> >> +LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'8121'}
> 
> In lib-httpd.sh, LIB_HTTPD_PORT is defined in a similar way, but that is
> always overridden by the users and the convention there is to use the test
> numbers (cf. "git grep LIB_HTTPD_PORT t/"), which should be followed here
> as well.

This you already fixed in the version previously queued and is contained
in [PATCH 2/6] daemon: add tests.

> I am not very keen on the "lib-daemon.sh", GIT_TEST_DAEMON, etc. naming to
> pretend as if "git daemon" will forever be the only daemon we will ever
> ship, by the way.  We might one day want to add an inotify daemon, a
> daemon for the git-pubsub protocol or somesuch.

Are you saying that the name "daemon" is too general, and it should
instead be "lib-git-daemon.sh" and GIT_TEST_GIT_DAEMON? Or do you
mean that it is not general enough and it should be called
lib-networking.sh and "GIT_TEST_NETWORKING"?

Either way, I have no preference here. Feel free to change any way you
like.

> >> +	# kill git-daemon child of git
> >> +	say >&3 "Stopping git daemon ..."
> >> +	pkill -P "$DAEMON_PID"
> 
> How portable is this one (I usually do not trust use of pkill anywhere)?

I read that it is supposed to be more portable than skill or killall.
But I have no way to research this. I have implemented a workaround
using only 'ps' and 'kill' in [PATCH 3/6] avoid use of pkill.

> >> +  wait "$DAEMON_PID"
> >> +  ret=$?
>       # Please comment what 143 is on this line.
> >> +  if test $ret -ne 143

Fixed in [PATCH 4/6] explain expected exit code.

> >> +	 git --bare repack &&
> 
> As the later tests assume there will be only one pack, don't you want at
> least "-a" and possibly "-a -d" here?

Fixed in

 [PATCH 1/6] t5550: repack everything into one file,
 [PATCH 5/6] t5570: repack everything into one file.

> I find the use of cap X here dubious; it makes your intention unclear.
> 
> Are you interested in the current status of 'x' bits on that directory, or
> are you more interested in dropping the executable/searchable bits from
> the directory no matter what its current status is (rhetorical: I fully
> expect that the answer is the latter)?

For directories, upper-case X does not have that meaning. The status is
always overwritten, irrespective of the current status. I wanted to
emphasize the fact that I am changing 'searchable' bits.  But since that
does not seem to have the desired effect, I changed it to lower-case in
[PATCH 6/6] chmod: use lower-case x.

Clemens
