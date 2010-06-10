From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Thu, 10 Jun 2010 21:55:55 +0200
Message-ID: <20100610195555.GA20759@pvv.org>
References: <20100604005603.GA25806@progeny.tock> <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock> <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com> <20100607085947.GA3924@pvv.org> <Pine.GSO.4.63.1006071726170.22466@shipon.roxen.com> <20100607195013.GA27362@pvv.org> <Pine.GSO.4.63.1006081731550.22466@shipon.roxen.com> <20100609140327.GA19828@pvv.org> <Pine.GSO.4.63.1006091943100.22466@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 21:56:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMnrG-0006u2-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 21:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759649Ab0FJT4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 15:56:04 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:41636 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759403Ab0FJT4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 15:56:01 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OMnr1-0006TC-8F; Thu, 10 Jun 2010 21:55:55 +0200
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1006091943100.22466@shipon.roxen.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148915>

On Wed, Jun 09, 2010 at 08:04:34PM +0200, Henrik Grubbstr=F6m wrote:

> Ok, so the expanded-keywords file in the example should show up as =20
> modified in relaxed mode as well, but be cleaned if the modified =20
> attributes file is added to the index? Or only after being committed?

Not before being committed, since you would otherwise have to add all
other files before adding .gitattributes, but I am not sure even that
is sufficient reason to claim the files are unmodified (see case 3 belo=
w).

I think we agree on the following:

If there is a discrepancy between .gitattributes and the contents in
the repository, the following should be true:

git checkout -f (or git reset --hard)
git status -> ALWAYS report modified files in strict mode
sleep 1
touch *
git status -> NEVER report modified files in relaxed mode


The case I think you are asking about above is the following in
"relaxed" mode:

echo "something that causes a discrepancy" >> .gitattributes
git status -> MODIFIED (1)
git add .gitattributes
git status -> MODIFIED (2)
git commit -m "bad commit"
git status -> ???????  (3)    <<-- Do you want this to be CLEAN?
git reset --hard (or git checkout -f)
sleep 1
touch *
git status -> CLEAN    (4)

1 and 4 should be uncontroversial and 2 I think is necessary because
you should be able to git add in several steps. Whether 3 should be
clean or modified I'm not so sure about, I think that it would make it
more likely to get the repo normalized properly if it was still seen
as modified there.

- Finn Arne
