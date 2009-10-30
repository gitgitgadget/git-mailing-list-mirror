From: Klaus Ethgen <Klaus@Ethgen.de>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 21:01:48 +0100
Message-ID: <20091030200148.GD10671@ikki.ethgen.de>
References: <20091030173838.GB18583@coredump.intra.peff.net> <7vaaz8lleg.fsf@alter.siamese.dyndns.org> <20091030194333.GA4551@coredump.intra.peff.net> <20091029233458.GA32764@ikki.ethgen.de> <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org> <20091030165903.GA10671@ikki.ethgen.de> <20091030173838.GB18583@coredump.intra.peff.net> <20091030182331.GC10671@ikki.ethgen.de> <20091030184155.GC19901@coredump.intra.peff.net> <20091030190552.GA3528@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
Cc: 553296@bugs.debian.org, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xfj-0005O3-1f
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbZJ3UB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756185AbZJ3UB4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:01:56 -0400
Received: from toomai.ethgen.de ([85.10.201.50]:56523 "EHLO toomai.ethgen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756129AbZJ3UBz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 16:01:55 -0400
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
	by toomai.ethgen.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <klaus@ethgen.de>)
	id 1N3xfR-0006v6-Ey; Fri, 30 Oct 2009 21:01:49 +0100
Received: from klaus by ikki.ket with local (Exim 4.69)
	(envelope-from <klaus@ikki.ethgen.de>)
	id 1N3xfQ-0004CV-S6; Fri, 30 Oct 2009 21:01:48 +0100
Content-Disposition: inline
In-Reply-To: <20091030194333.GA4551@coredump.intra.peff.net> <20091030190552.GA3528@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131742>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Jeff,

Am Fr den 30. Okt 2009 um 20:05 schrieb Jeff King:
> On Fri, Oct 30, 2009 at 02:41:55PM -0400, Jeff King wrote:
> 
> > >    6. Revert the patch and rework it so that it will only have effect if
> > >       there is no -i option on the command line. (That is similiar to a
> > >       mix of 3 and 4.)
> > 
> > Yeah, that would actually be the least invasive change, and would keep
> > "-i" just as it is. If we do anything except a simple, I think your (6)
> > makes the most sense.

Ok.

> > Let me see if I can make a patch.

Fine, thanks.

> -	Show ignored files in the output.
> -	Note that this also reverses any exclude list present.
> +	Show only ignored files in the output. When showing files in the
> +	index, print only those matched by an exclude pattern. When
> +	showing "other" files, show only those matched by an exclude
> +	pattern.

Hmmm... I do not see that much difference. But that might be justified
by my bad English.

> --- a/t/t3003-ls-files-exclude.sh
> +++ b/t/t3003-ls-files-exclude.sh
> @@ -29,4 +29,12 @@ test_expect_success 'add file to gitignore' '
>  '
>  check_all_output
>  
> +test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
> +	echo content >other-file &&
> +	git add other-file &&
> +	echo file >expect &&
> +	git ls-files -i --exclude-standard >output &&
> +	test_cmp expect output
> +'
> +
>  test_done

Do that fit? shouldn't it be "test_cmp other-file output"? "git ls-files
- -i --exclude-standard" should show the files in the index that are also
in the exclude list. And you only add other-file to the index. And
shouldn't there be also a "echo other-file > .gitignore"?

Regards
   Klaus
- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEVAwUBSutGLJ+OKpjRpO3lAQqmZwgAi7DqPorAdp0dZtgMpgzCsrWTJx5xb/dv
voQ4K5pYmxG1PgLb8zY7ywIvcG36uakCGvwgFQxsLzSgg0hRO1UsQ8XFVqSPp62X
evsZ/On5LYHY3xz+Fl0cPM5oomtqY+ZmHAd5syj4oh6hSHM8J93RuQzGEfMshtrQ
NUfAbAVmjuA5d4Cl/SLNUvoLE6M6O3YGkCGKXA9aPQcker6W+nODExJgTqyh4RHK
ATfbPC6+VJGUPfjVGmrqHVW8LOb/wP7grEBMaHvGpP/ysh4FHjy6HtXLhyPSRES/
KpsMG5g0dF0dbS0qBgrIck+6cifiHNlAbxc5LF7tydFBMnRAmjDyeA==
=7JTn
-----END PGP SIGNATURE-----
