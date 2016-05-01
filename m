From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL
 handling code
Date: Mon, 2 May 2016 08:20:07 +0900
Message-ID: <20160501232007.GA18006@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-3-git-send-email-mh@glandium.org>
 <ee3d1928-38c5-372c-223f-bd50bfb14930@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 02 01:20:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax0ey-0008Dc-5H
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 01:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbcEAXUR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 19:20:17 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:37164 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbcEAXUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 19:20:15 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1ax0el-0004jj-Oe; Mon, 02 May 2016 08:20:07 +0900
Content-Disposition: inline
In-Reply-To: <ee3d1928-38c5-372c-223f-bd50bfb14930@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293217>

On Sun, May 01, 2016 at 03:37:24PM +0200, Torsten B=F6gershausen wrote:
> I skipped the dates and names (I was responsible for one regression)
> I hope this gives a half-correct overview,
> why I am reluctant to change any code in connect.c
> unless there is a fix for a real world problem.

I don't agree that connect.c should be left untouched because it's
fragile. On the contrary, if anything, it should be made less fragile.

And the more I look at it, the more I'm tempted to just change the
parse_connect_url function itself to do _all_ the parsing, instead of
having some code paths invoke get_host_and_port and some others invoke
get_port on top of that, for some effect that, when you look at the
code, you can't know what it's supposed to be. If anything, my attempts
at cleaning up the code, and partially failing are a demonstration that
the code *does* need some clean up.

> And even here, the test cases should be changed first (and reviewed) =
in an own commit.
> Marked as test_must_failure.
> The c-code can be changed in the next commit, and the TC are marked a=
s "test_expect_success"

What is the benefit from doing so?

> Back to another topic:
> If you want to support the native Git-support for native HG via hg-se=
rve,
> I will be happy to assist with reviews.
> Please, if possible, don't touch connect.c at all.
> (Beside the memory leak fix).
>=20
> It may be better to start with a real remote-helper and copy the code=
 from connect.c
> And, later, if there are common code paths, refactor stuff.

There *are* common code paths. Which is exactly why I'm trying to reuse
connect.c without copying it.

Mike
