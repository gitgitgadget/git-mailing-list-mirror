From: John Keeping <john@keeping.me.uk>
Subject: Re: `git rev-parse --git-dir` relative to current working directory?
Date: Tue, 29 Mar 2016 11:50:14 +0100
Message-ID: <20160329105014.GA1578@serenity.lan>
References: <CAPZ477NfQ7pCiHQ3V42kZ1Cic5UPP03TCFPvABR_ugSZYEn4xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Tue Mar 29 13:02:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akrEQ-0000zO-A7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 12:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbcC2Ku3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 06:50:29 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55919 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680AbcC2Ku1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 06:50:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0338B866034;
	Tue, 29 Mar 2016 11:50:26 +0100 (BST)
X-Quarantine-ID: <hdIxjJZMg6rp>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hdIxjJZMg6rp; Tue, 29 Mar 2016 11:50:25 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4AC64CDA571;
	Tue, 29 Mar 2016 11:50:19 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAPZ477NfQ7pCiHQ3V42kZ1Cic5UPP03TCFPvABR_ugSZYEn4xg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290115>

On Tue, Mar 29, 2016 at 05:32:31AM -0500, Elliott Cable wrote:
> So, `git help rev-parse` [mentions the following][rev-parse], as of
> 2.8.0:
>=20
>     --git-dir
>        Show $GIT_DIR if defined. Otherwise show the path to the .git
>        directory. The path shown, when relative, is relative to the
>        current working directory.
>=20
> However, when inside a symlinked repository, this doesn't function as
> advertised:
>=20
>     $ ln -s a-symlink a-git-repo
>     $ cd a-symlink/.git/hooks
>     $ git rev-parse --git-dir
>     /Users/ec/Documents/a-git-repo/.git
>=20
> From my reading of that snippet of documentation (=E2=80=9CThe path s=
hown ... is
> relative to the CWD=E2=80=9D), I'd expect to receive `..`, not
> `/absolute/path/to/a-git-repo/.git`.
>=20
> Is the documentation incorrect, or is this a bug? (I'm hoping the
> latter: I'm trying to write git-scripting that is sensitive to symlin=
ks,
> i.e. retains the user's CWD without unintentionally resolving symlink=
s
> in their path during operation; and it'd be ideal if this were handle=
d
> as documented, saving me manual effort checking symlinks.)

The documentation seems correct to me, it just requires careful parsing=
;
I read it as:

	if the path printed it relative
	then it is relative to the current working directory

but it makes not claims about when a relative path will be printed (or
even if one ever will be, although in my testing the path is relative
only if $CWD can be stripped from the beginning of the path; in other
words only when no component of the relative path would be "../").
