From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/6] connect: remove get_port()
Date: Mon, 2 May 2016 06:43:22 +0900
Message-ID: <20160501214322.GA13916@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-2-git-send-email-mh@glandium.org>
 <e1056272-8c0e-0a0b-2295-4653a47cf86f@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 01 23:43:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awz9L-0004Jh-FE
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 23:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbcEAVnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 17:43:31 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34234 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbcEAVna (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 17:43:30 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1awz98-0003jU-VA; Mon, 02 May 2016 06:43:22 +0900
Content-Disposition: inline
In-Reply-To: <e1056272-8c0e-0a0b-2295-4653a47cf86f@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293215>

On Sun, May 01, 2016 at 12:10:09PM +0200, Torsten B=F6gershausen wrote:
> On 2016-05-01 08.02, Mike Hommey wrote:
> > get_port() is only used as a fallback when get_host_and_port() does=
 not
> > return a port. But get_port() does the same search as
> > get_host_and_port(), except get_host_and_port() starts from the end=
 of
> > the host, respecting square brackets for ipv6 addresses, and get_po=
rt(),
> > operating after get_host_and_port(), works on a modified host strin=
g
> > that has square brackes removed if there were any.
> typo: brackets.
> >=20
> > I cannot think of any legal host:port string that would not have a =
port
> > returned by get_host_and_port() *and* have one returned by get_port=
().
> > So just remove get_port().
> >=20
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> Does this pass the test-suite ?
> It doesn't pass here, t5601:
>=20
> not ok 39 - bracketed hostnames are still ssh
> #
> #               git clone "[myhost:123]:src" ssh-bracket-clone &&
> #               expect_ssh "-p 123" myhost src
> #
> not ok 40 - uplink is not treated as putty
> #
> #               copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
> #               git clone "[myhost:123]:src" ssh-bracket-clone-uplink=
 &&
> #               expect_ssh "-p 123" myhost src
> #
> not ok 41 - plink is treated specially (as putty)
> #
> #               copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
> #               git clone "[myhost:123]:src" ssh-bracket-clone-plink-=
0 &&
> #               expect_ssh "-P 123" myhost src
> #
> not ok 42 - plink.exe is treated specially (as putty)
> #
> #               copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
> #               git clone "[myhost:123]:src" ssh-bracket-clone-plink-=
1 &&
> #               expect_ssh "-P 123" myhost src
> #
> not ok 43 - tortoiseplink is like putty, with extra arguments
>=20

sigh. I was assuming all the relevant cases were tested in t5500, but
apparently they aren't.

Mike
