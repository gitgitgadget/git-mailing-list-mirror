Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC536201279
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321409; cv=none; b=kUSX9v6pGxVdG2GTbZy3DL69CcqnwUaF/FGoWNXSdxnqAxWMQJrppC4Br2n2e2lOmiNL9GxyZ8/53r/XLP+zyDfQtQZ3UmP9T7eUtCFmEnuWQSCtOq1YJJJhgrPQ+X+7ORyRji3Q0VDlrG+TAbXADCJYBRUn2a+mVcP3KXeQLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321409; c=relaxed/simple;
	bh=lzOAhv7rxEBpoXzx2C4ev3aUxGKIfiDJtbhedDC9B1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q43ALP5ASXjfE9VMF44KYBI65Alm65jYC7OnVC8iggb6Ud1H0/HaFfC9xqQeMoK2JXadRatMApLG1T1Jt79fzdce/QBsx+zF4v7Xo9LM9/0NrYS19Pgnq+MNhazxF1fnyHj7c5wrGLeJS1H25vZtIGnCJRJDuqbAqNf9KkwdDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rohdewald.de; spf=pass smtp.mailfrom=rohdewald.de; dkim=pass (2048-bit key) header.d=rohdewald.de header.i=@rohdewald.de header.b=J9HfMgm2; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rohdewald.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rohdewald.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rohdewald.de header.i=@rohdewald.de header.b="J9HfMgm2"
Received: from [10.210.137.29] (p4fd4440a.dip0.t-ipconnect.de [79.212.68.10])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 96D3AE0F40;
	Sun, 24 Mar 2024 23:56:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rohdewald.de;
	s=uddkim-202310; t=1711320989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC/HdTGzKpQE4TnvRJt4dD5Jiozc/jKz8Zb4nPstMoU=;
	b=J9HfMgm2dtNV9fHWEHY9J/eXosH3ZvElfLi3zNnPOFHuL5YobCoIOmbxnknT9bjNAtFCq8
	4pLqbbnFN4x3C2aZQnr1Xa4XCoNkQ9WsDn7+Jyv6717v1L33ysulgeyLDSABSbqbFqMLA2
	t6EfsNSjUeV2cBPorl+NXSJBAZ3LxGrKXPEmOqbfl0Gt0adq+KEAJ1pz1dRCmyjDcLn4PA
	LqpWispsMgIIo1e/bU2lQ9hen2WbFw1X9D7ZrFjIOXpoZQiAMSdosLEp4d9gAiml/j9AS7
	RmeETRcXyRmN2pmlfFuorhEAVXNpcU3kTEIj1NzviRoyXUjg2KSFUSY97KSuGQ==
Message-ID: <7df26e3813ef76ee90c1fb02847bbb4b9bad630d.camel@rohdewald.de>
Subject: Re: segfault with git rebase --abort
From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Date: Sun, 24 Mar 2024 23:56:28 +0100
In-Reply-To: <xmqqle67pa7a.fsf@gitster.g>
References: <88a694de4a7f767613475ef1d19292a69eaccb07.camel@rohdewald.de>
	 <xmqqle67pa7a.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=wolfgang@rohdewald.de smtp.mailfrom=wolfgang@rohdewald.de

Am Sonntag, dem 24.03.2024 um 14:54 -0700 schrieb Junio C Hamano:
> Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:
>=20
> > git rebase -i
> >=20
> > git rebase --abort # boom
> >=20
> This thread _might_ be relevant.
>=20
> =C2=A0 https://lore.kernel.org/git/20240218114936.1121077-1-marcel@roethk=
e.info/
>=20
> The "might" is because the symptom is a sign of corruption of the
> rerere database but the discussion or the patch in there do not know
> how such a corruption happened in the first place.
>=20
> If you rebuild Git with Marcel's patch (there is v2 downthread, and
> we have been waiting for a v3) and it improves the situation, please
> do let us know.

Yes, the patch resolved my problem. Thanks a lot!

From the bash history below, this might be the sequence:

(git 2.39)

I think I forgot to remove one line of "<<<<<<< HEAD" before doing the firs=
t git add.

Because git rebase --abort then told me about the lockfile, the segfault pr=
obably
already happened with the second git rebase --continue.
and from then on all git rebase --abort segfaulted.

Oh - and I definitively did not mess around in .git

I do have a backup of the repo, so if you want me to look up things ...

git checkout master
git rebase -i
vi servertable.py
git add servertable.py  # here I probably left that <<<< HEAD line
git rebase --continue
vi servertable.py=20
git add servertable.py
git rebase --continue   # I think this already segfaulted
git status
df                      # plenty of free space
git rebase --abort
rm .git/MERGE_RR.lock


Since the patch is about rerere, I now did:

wrpc:~/tmp/kajongg (master|REBASE-i) git rerere status
src/servertable.py
wrpc:~/tmp/kajongg (master|REBASE-i) git rerere diff
error: Could not stat .git/rr-cache/a8ec6f624ee23ef2e37148a8172ebac3c6639f9=
3/preimage: No such file or directory
fatal: unable to generate diff for '.git/rr-cache/a8ec6f624ee23ef2e37148a81=
72ebac3c6639f93'

wrpc:~/tmp/kajongg/.git/rr-cache (GIT_DIR!|REBASE-i) ls -lrt | tail -3
drwxr-xr-x 2 wr wr 4096 Mar 24 16:19 e6c7ce944f313fa718cad6875d4ee784c09886=
8c
drwxr-xr-x 2 wr wr 4096 Mar 24 16:19 d0a20608fa0aafd2b234cce432ce7af567c1a9=
4a
drwxr-xr-x 2 wr wr 4096 Mar 24 16:43 a8ec6f624ee23ef2e37148a8172ebac3c6639f=
93
wrpc:~/tmp/kajongg/.git/rr-cache (GIT_DIR!|REBASE-i) ls -l a8ec6f624ee23ef2=
e37148a8172ebac3c6639f93/
total 0


--=20
mit freundlichen Gr=C3=BCssen

Wolfgang Rohdewald
