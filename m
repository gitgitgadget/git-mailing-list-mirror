Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8F17557
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237569; cv=none; b=Alni/YbE7VU2g4bz560VDgs4ICT3wC0TYAgCTEeflV+u72Rp4nq/BNwtINfbI1qQw2DthsQHZ+lj1eWN91+lZrhfpfz8Wte8ckOZqkJ9ZfjY+Ub7gRCuts9gLbUjKylLo4LAUldN1dExVkFl+xb+/k/kOz8ol3dX4RiWmzyXkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237569; c=relaxed/simple;
	bh=ExGh5QAmOCf3ybrh48+hx6U7CxLRjwt8bnGXW9yvEls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOweVoFGPlf3k9xYfGruZIzEVJOSvQMWnDqWRrx1VVs+/4P4lc72diXI5VDA2lNA61kckTK1xTOZE8F9ZeyCv+6c6sCMnP5yt1h+B9xzedYP3jEXtYnuQyfXspDtsAsac1Jki0goaokh9VtgmjJ/iRDSM7tFpQOYXvVk2aqch0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G5KYAf7U; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G5KYAf7U"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD3592FD09;
	Fri,  9 Aug 2024 17:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ExGh5QAmOCf3
	ybrh48+hx6U7CxLRjwt8bnGXW9yvEls=; b=G5KYAf7UJ7GnLw/kjhyIBKCHdyE5
	GvksON6xEv4VzcQIvycHNF6RpbkvuLK8GeuUQgrNNYrt4p7s740k5MGs+JYqnQxx
	A6tFjNU60+PZaW0jKwi8jhaI67FL97uitFTnfFVPxY9trz+pwjk2Gg2Kew1sEFAI
	+B03rH21HSjzsPI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D686A2FD08;
	Fri,  9 Aug 2024 17:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BCE6B2FD07;
	Fri,  9 Aug 2024 17:06:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,
  "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 3/3] send-email: teach git send-email option to
 translate aliases
In-Reply-To: <5ad39a07-a2d4-45d2-9b5d-0180cb903801@intel.com> (Jacob Keller's
	message of "Fri, 9 Aug 2024 12:51:45 -0700")
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
	<20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
	<xmqqttfufzkj.fsf@gitster.g>
	<328fb497-d16e-4af1-a816-7b4aeb531504@intel.com>
	<xmqq7ccpcx9e.fsf@gitster.g>
	<5ad39a07-a2d4-45d2-9b5d-0180cb903801@intel.com>
Date: Fri, 09 Aug 2024 14:05:59 -0700
Message-ID: <xmqqplqhbe4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2F70EA7C-5693-11EF-89BB-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jacob Keller <jacob.e.keller@intel.com> writes:

> We could try to implement scanning for options ourselves, but I wouldn'=
t
> want to break things like "--" to make it treat potential option-lookin=
g
> fields as aliases...

The appoach --dump-aliases takes is already broken with respect to
options that take or do not take an argument, if you really want to
scan, understand, and skip irrelevant options anyway, no?  The
separate, trimmed down %dump_aliases_options map cannot help you to
tell from the command line "git cmd --translate --foo bar" if
skipping just "--foo" gives you the alias-to-be-expanded "bar", or
"--foo" takes an argument that is "bar" and there is no alias left.

So I do not quite know how involved you want to go, but na=C3=AFvely, I
would have thought something along the lines of illustration below
is sufficient.

 git-send-email.perl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git c/git-send-email.perl w/git-send-email.perl
index 72044e5ef3..a7239698f8 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -747,6 +747,20 @@ sub is_format_patch_arg {
 	}
 }
=20
+# Now, if the user who wants --translate knows that the command will not
+# send any mails and the remainder of the command line are aliases to be
+# expanded, the user wouldn't have given useless other options to trigge=
r
+# any of the executable code before this point (like $suppress_cc{} hand=
ling)
+# that would be wasted.  So we just see if --translate is given and deal
+# with it here.
+
+if ($translate_alias) {
+	for (@ARGV) {
+		print "$_ =3D> $aliases{$_}\n";
+	}
+	exit(0);
+}
+
 # Now that all the defaults are set, process the rest of the command lin=
e
 # arguments and collect up the files that need to be processed.
 my @rev_list_opts;
