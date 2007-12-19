From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 11:48:23 +0000
Message-ID: <20071219114823.GA28273@hashpling.org>
References: <20071219105752.GA23932@hashpling.org> <23306E3C-24F1-4626-A956-02531644B786@wincent.com> <20071219113617.GA26520@hashpling.org> <CA30F61D-4AE1-4100-A632-20B5587EB4D0@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xPw-0004qn-MF
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXLSLs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXLSLs3
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:48:29 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:58207 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbXLSLs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:48:28 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1J4xPV-0000Cv-LN; Wed, 19 Dec 2007 11:48:25 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBJBmN3E028566;
	Wed, 19 Dec 2007 11:48:23 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBJBmN2C028565;
	Wed, 19 Dec 2007 11:48:23 GMT
Content-Disposition: inline
In-Reply-To: <CA30F61D-4AE1-4100-A632-20B5587EB4D0@wincent.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68894>

On Wed, Dec 19, 2007 at 12:43:12PM +0100, Wincent Colaiuta wrote:
> El 19/12/2007, a las 12:36, Charles Bailey escribi=F3:
>=20
> >
> >I agree completely, but all the generated scripts output hard coded
> >paths so it would seem inconsistent not to qualify the path in this
> >case too.
>=20
> It's not hard-coded, it's dynamic. Witness:
>=20

It's *output* hardcoded, it's dynamic during script generation.

A raw 'perl' in a shell script is dynamic during script run.


> $ make PERL_PATH=3D/Volumes/Clon/usr/bin/perl
> $ head -1 git-add--interactive
> #!/Volumes/Clon/usr/bin/perl -w
>=20
> > Would  @@PERL_PATH@@perl -p -e work, do you know?
>=20
> I don't think so, but judging from the following section of the =20
> Makefile, I think @@PERL@@ would. Why don't you give it a try?
>=20
> $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
>         $(QUIET_GEN)$(RM) $@ $@+ && \
>         sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>             -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>             -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>             -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
>             -e 's|@@HTMLDIR@@|$(htmldir_SQ)|g' \
>             $@.sh >$@+ && \
>         chmod +x $@+ && \
>         mv $@+ $@
>=20

git-instaweb is treated specially, so the answer is 'no, not yet', but
I have a patch on the way.

Charles.
