From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [ANNOUNCE] GIT 1.5.2.2
Date: Sun, 17 Jun 2007 12:30:37 +0200
Organization: SelfOrganizing
Message-ID: <200706171230.37659.arekm@maven.pl>
References: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 12:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzsOg-0003Q5-0j
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 12:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802AbXFQKyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 17 Jun 2007 06:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757824AbXFQKyH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 06:54:07 -0400
Received: from main.carme.maven.pl ([193.239.45.138]:30019 "EHLO
	main.carme.maven.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794AbXFQKyG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 06:54:06 -0400
X-Greylist: delayed 1396 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2007 06:54:06 EDT
Received: from chello087207214234.chello.pl ([87.207.214.234] helo=[192.168.0.149])
	by main.carme.maven.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <arekm@maven.pl>)
	id 1Hzs1r-0004az-W7; Sun, 17 Jun 2007 12:30:44 +0200
User-Agent: PLD Linux KMail/1.9.7
In-Reply-To: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50348>

On Sunday 17 of June 2007, Junio C Hamano wrote:
> The latest maintenance release GIT 1.5.2.2 is available at the
> usual places:
>
>   http://www.kernel.org/pub/software/scm/git/
>
>   git-1.5.2.2.tar.{gz,bz2}			(tarball)
>   git-htmldocs-1.5.2.2.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.5.2.2.tar.{gz,bz2}		(preformatted docs)
>   RPMS/$arch/git-*-1.5.2.2-1.$arch.rpm	(RPM)

Should git testsuite (make test) go without any problem? (I'm asking be=
cause=20
some projects have test suites where some tests are expected to fail).

I have 4 failures on amd64/linux and this git release:

* FAIL 11: compare delta flavors

                perl -e '
                        defined($_ =3D -s $_) or die for @ARGV;
                        exit 1 if $ARGV[0] <=3D $ARGV[1];
                ' test-2-$packname_2.pack test-3-$packname_3.pack

[...]

* FAIL 16: corrupt a pack and see if verify catches
        cat test-1-${packname_1}.idx >test-3.idx &&
             cat test-2-${packname_2}.pack >test-3.pack &&
             if git-verify-pack test-3.idx
             then false
             else :;
             fi &&

             : PACK_SIGNATURE &&
             cat test-1-${packname_1}.pack >test-3.pack &&
             dd if=3D/dev/zero of=3Dtest-3.pack count=3D1 bs=3D1 conv=3D=
notrunc seek=3D2=20
&&
             if git-verify-pack test-3.idx
             then false
             else :;
             fi &&

             : PACK_VERSION &&
             cat test-1-${packname_1}.pack >test-3.pack &&
             dd if=3D/dev/zero of=3Dtest-3.pack count=3D1 bs=3D1 conv=3D=
notrunc seek=3D7=20
&&
             if git-verify-pack test-3.idx
             then false
             else :;
             fi &&

             : TYPE/SIZE byte of the first packed object data &&
             cat test-1-${packname_1}.pack >test-3.pack &&
             dd if=3D/dev/zero of=3Dtest-3.pack count=3D1 bs=3D1 conv=3D=
notrunc seek=3D12=20
&&
             if git-verify-pack test-3.idx
             then false
             else :;
             fi &&

             : sum of the index file itself &&
             l=3D`wc -c <test-3.idx` &&
             l=3D`expr $l - 20` &&
             cat test-1-${packname_1}.pack >test-3.pack &&
             dd if=3D/dev/zero of=3Dtest-3.idx count=3D20 bs=3D1 conv=3D=
notrunc seek=3D$l=20
&&
             if git-verify-pack test-3.pack
             then false
             else :;
             fi &&

             :

[...]

* FAIL 18: fake a SHA1 hash collision
        test -f .git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67 =
&&
             cp -f      .git/objects/9d/235ed07cd19811a6ceb342de82f190e=
49c9f68=20
\
                        .git/objects/c8/2de19312b6c3695c0c18f70709a6c53=
5682a67
* FAIL 19: make sure index-pack detects the SHA1 collision
        git-index-pack -o bad.idx test-3.pack
* failed 4 among 19 test(s)


--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
