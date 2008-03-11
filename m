From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 08:33:21 -0400
Message-ID: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 13:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ3gH-00063z-SA
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 13:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYCKMd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 08:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYCKMd1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 08:33:27 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:35711 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYCKMd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 08:33:26 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1449256rvb.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=y4MpeLWq7jktOXdIlN2O32Njmau5+r03MzbzRrr9K1M=;
        b=uojWBFe+pXOCF0svcOZP0EzievR5RGf2N8XBqf5leFbTCmEKE/EZR7yhDUqEKtGd8ekN6KntjoaYDh8AKNi1KHuIwP9+G1Ee/FGzn9+po1tdHkgpY25M3+9SGipCvg28Ce055AtLiR91PRjnzwcqVTfMFleomVar3y8RJW1kZns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NBP+AxKFOVrV6+JtmL8QqPb/GxIVlIWXpJW5iZxyKvpJSW8T4q75gG9SGie/Braubmh7gO3ZQjlzM0kl30o7rJZk2qctlgYFNugpSOfsk2zepm4gGYnApXvpsOJun88eR4HmYD/QUn0Io6A8qxDt42FnZJPNxN87GT13t6sYUnc=
Received: by 10.141.145.11 with SMTP id x11mr4119170rvn.215.1205238801825;
        Tue, 11 Mar 2008 05:33:21 -0700 (PDT)
Received: by 10.141.201.19 with HTTP; Tue, 11 Mar 2008 05:33:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76834>

Git Version: git-1.5.4.4

xs5-trd-p1.grn:warmstro> uname -a
SunOS xs5-trd-p1.grn.tudor.com 5.9 Generic_118558-38 sun4u sparc
SUNW,Sun-Fire-V240

looks like most errors below are related to tr.  The tr I'm using is in xpg4.

xs5-trd-p1.grn:warmstro> which tr
/usr/xpg4/bin/tr



xs5-trd-p1.grn:warmstro> sh t0021-conversion.sh -i -v
* expecting success:
        git config filter.rot13.smudge ./rot13.sh &&
        git config filter.rot13.clean ./rot13.sh &&

        {
            echo "*.t filter=rot13"
            echo "*.i ident"
        } >.gitattributes &&

        {
            echo a b c d e f g h i j k l m
            echo n o p q r s t u v w x y z
            echo '$Id$'
        } >test &&
        cat test >test.t &&
        cat test >test.o &&
        cat test >test.i &&
        git add test test.t test.i &&
        rm -f test test.t test.i &&
        git checkout -- test test.t test.i

tr: Bad string.
error: external filter ./rot13.sh failed 1
error: waitpid (async) failed
error: external filter ./rot13.sh failed
tr: Bad string.
error: external filter ./rot13.sh failed 1
error: waitpid (async) failed
error: external filter ./rot13.sh failed
tr: Bad string.
error: external filter ./rot13.sh failed 1
error: waitpid (async) failed
error: external filter ./rot13.sh failed
*   ok 1: setup

* expecting success:

        cmp test.o test &&
        cmp test.o test.t &&

        # ident should be stripped in the repository
        git diff --raw --exit-code :test :test.i &&
        id=$(git rev-parse --verify :test) &&
        embedded=$(sed -ne "$script" test.i) &&
        test "z$id" = "z$embedded" &&

        git cat-file blob :test.t > test.r &&

        ./rot13.sh < test.o > test.t &&
        cmp test.r test.t

tr: Bad string.
* FAIL 2: check


                cmp test.o test &&
                cmp test.o test.t &&

                # ident should be stripped in the repository
                git diff --raw --exit-code :test :test.i &&
                id=$(git rev-parse --verify :test) &&
                embedded=$(sed -ne "$script" test.i) &&
                test "z$id" = "z$embedded" &&

                git cat-file blob :test.t > test.r &&

                ./rot13.sh < test.o > test.t &&
                cmp test.r test.t

xs5-trd-p1.grn:warmstro>
