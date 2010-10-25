From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 01/18] rev-parse: add --internal-cwd and
 --internal-git-dir for tests
Date: Mon, 25 Oct 2010 07:04:00 +0700
Message-ID: <AANLkTimfDVPFK7y-bkg-QYsTyHKdoxmvZxzzt36w95r5@mail.gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
 <1287922310-14678-2-git-send-email-pclouds@gmail.com> <20101024154005.GB31764@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 02:04:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAY7-0007Up-VF
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab0JYAEX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 20:04:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37340 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0JYAEW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Oct 2010 20:04:22 -0400
Received: by wyf28 with SMTP id 28so2769834wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FKunW5DHlDtZIYM9EA6cOOpZAcgVDT9v/WhSrnoieEQ=;
        b=tquUzhlyUu8EGN6XLva5dYJ9l3z0QDifmUcjNHfwUpgqF7a8hei5YUf0nibfX2sbuq
         msvI/IA+dqtW8GCkNM7nvU1UwnPdppH2io9HNV4CR8ue5CgRsoCowzRFTssfh4cWCkUP
         HzZQEWDHLzfdsH9vlbROuCObM4FbULpjapYMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k/WaRuPUhDA+cobbEjsq7iMBOsmLyKtfmDF/ychfPeCFn04JyqH7hZSGV7aS3FvL2U
         XbEoE8UVVgkguqjYYV1zNjiuOMp7ki0IlDqlgG2R7PEUr73c1d+sdBlrpsKCA3k3Is2X
         VPhdd8WX5Y/NGIPpsjKHBtHU15JM6P00hDbUQ=
Received: by 10.216.140.37 with SMTP id d37mr2229329wej.31.1287965060880; Sun,
 24 Oct 2010 17:04:20 -0700 (PDT)
Received: by 10.216.241.138 with HTTP; Sun, 24 Oct 2010 17:04:00 -0700 (PDT)
In-Reply-To: <20101024154005.GB31764@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159896>

2010/10/24 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> --internal-cwd is obvious, no way else to expose it for testing.
>>
>> --internal-git-dir is introduced because --git-dir prepares its outp=
ut
>> suitable for scripting. For tests, it must be exactly what git store=
s.
>
> Hmm. =C2=A0Forget this is used in tests, would it make sense to do th=
is
> with trace_printf, at the end of setup, as in your earlier patch?

trace_printf surely does. But "the end of setup" is unclear. As of
now, setup ends when setup_* function _and_ setup_git_env() are
called. There are cases that setup_* finishes without calling
setup_git_env(), or setup_git_env() is called way before setup_* is
finished.

> I think it might: just like the exec: lines provide context about wha=
t
> command is being traced, such trace: cwd: lines would make it clearer
> what paths that are being output might be referring to.

Also prefix them all with "setup:", something like

setup: git_dir: ../.git
setup: work_tree: /my/git/worktree
setup: cwd: /my/git/worktree
setup: prefix: sub/

would be easy to be grepped from GIT_TRACE, to read and to test_cmp.

> Returning to the topic of tests, is it possible to get at these
> variables using an external command that is run by git? =C2=A0pre-com=
mit
> hook, maybe. =C2=A0Testing of other symptoms is also possible, as in
> Fr=C3=A9d=C3=A9ric's example.

Why do hooks need these? git_dir, prefix are already accessible via
--git-dir, --show-prefix, --show-toplevel. Current cwd can be
determined with --is-inside-work-tree: if it returns true, current cwd
is worktree root, otherwise it is original cwd.
--=20
Duy
