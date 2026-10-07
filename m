Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A3497380
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375475; cv=none; b=h+oTpvqiBaGoNe5mo1P9C9kmwNif1fFU+SjGkoLq5AB0NhxoNW9vklzBk/WSOrpHjwgJvDCPNKtreza4E/Jb/fjIXkIHqKx1kzJFf9mq9BU837zhT269Qp5Y+wMGMySoWgLDz4mbOdmESLOjK6urHqdgTBXCVYI/Ny8vBZTqp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375475; c=relaxed/simple;
	bh=6KCGeS1ttZsyJOMSnH8uuNrIOLnxTgeSCnjOLufDrI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UEwJUBRzobcZcJi++bM7BZwEVb0H+icosx1Jl7oy10Z6MNZHwPgvFTVyeyw2PPmxiycQDd6U0oQvX6+X22i8nlDHPImEtRRb7rYWtWqAs3UBI0CLPC7nqlze7CDIGAuB8ley0pk/IjtUQXWzZ7nQ4g1qtJXaIO+UN3Ge/uJvf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tE/wMaaa; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tE/wMaaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791375462; x=1791980262;
	i=johannes.schindelin@gmx.de;
	bh=KAjIqxUnn3T6FcG0/HIS8+z/p7NQspPitJoU04Onwn8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tE/wMaaa8wGOKFRbVG/6LKSDpjkja6InXUx8n+L0ZquE0n+OWXr0SNrYLvCzdmtD
	 y5jwufrCmwM03BvXZBZdOeS2CrCt18mOB5Eo3FUWBVhwe40zevoGvFRx6XJ/qzRNQ
	 wX1TUz2fVcP/3hFjbURapWNUw3gc5E0rNQcvTp5vkN2mTYCHANjvMQe5Phc4a12lz
	 +PlAMtwDlq0bhygxmhc4Bl40nUB3F9RchWLRoRKcm85uL2cIYsXMI5NzRfHtARweq
	 6QQRQCHt61qDdHfwloT5dSaYiW6jgPifTLcQgsX/0Omuggo9Sf0ytgdd91KqEovbD
	 2Tq5dY+LCY94e6MVMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwXr-1xPezX1YuP-006z0t; Wed, 07
 Oct 2026 14:17:42 +0200
Date: Wed, 7 Oct 2026 14:17:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Chacon <scott@gitbutler.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] sha1dc-accel: vectorize the unavoidable-bitconditions
 check
In-Reply-To: <20260929112544.86511-3-scott@gitbutler.net>
Message-ID: <3d640489-5db4-5527-0ec1-c2abac7a2de3@gmx.de>
References: <20260929112544.86511-1-scott@gitbutler.net> <20260929112544.86511-3-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:CxPLOGgvPgpEGicxJ8TKo0d44Ctjb6+W1EVHyBlvuRIDAkW8WkA
 3C12fe5Rm8/6U/zC6YBanunftymg3mCzXDCbi3P4bZUnEhG2r4XzHZy9dr96cAOq7rC+p7R
 wCSTqg6JRIyKNff8hOrAk6upXmxb7Zm36qFWiqKz+Tph/QXBQ83mURnH2Ozc/xPGw405BAn
 voNUXQEFb93v3H9tt1Znw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I5/d+S/3O9Y=;pre9iyGPBgqJjVQiZB5QFgKe3pO
 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
 bcOehc+w==

Hi Scott,

On Tue, 29 Sep 2026, Scott Chacon wrote:

>  sha1dc-accel/ubc_check.c            | 1789 +++++++++++++++++++++++++++

This is quite large. And of course it's essentially a machine-assisted
translation of the Rust code, which itself is the output of the solver.

Assuming that we will not only want to be able to confirm the translation
easily, but also be able to adapt to future improvements in the Rust code
(e.g. if Sam finds another neat trick to dismiss even more candidates even
earlier), here is a Perl script to do precisely that:

-- snip --
#!/usr/bin/perl
# Convert the generated src/ubc_check/{scalar,sse2,avx2,neon}.rs files at
# https://github.com/srijs/sha1dc/tree/426b4afd to C table definitions.
# Usage: perl sha1dc-accel/generate-ubc-tables.pl sse2 < path/to/sse2.rs
# Output is tables only; retain ubc_check.c's declarations and MIT notice.
use strict;
use warnings;

my $form = shift // die "usage: $0 scalar|sse2|avx2|neon < form.rs\n";
my %prefix_count = (scalar => 70, sse2 => 26, avx2 => 16, neon => 20);
my %tail_count = (scalar => 151, sse2 => 97, avx2 => 77, neon => 137);
exists $prefix_count{$form} && !@ARGV or die "unknown form: $form\n";
local $/;
my $src = <STDIN> // die "empty input\n";
my ($prefix) = $src =~ /^fn prefix\([^\n]*\) -> u32 \{(.*?)^\}/ms;
defined $prefix or die "missing prefix()\n";
$prefix =~ s/\(([^()]*)\)\s+as\s+i32/$1/g;
$prefix =~ s/\b(\d+)u32\b/$1/g;
my (@out, @rows);

sub table {
	my ($type, $name, $rows) = @_;
	push @out, "static const struct $type ${form}_$name\[\] = {\n",
		map("\t{ $_ },\n", @$rows), "};\n\n";
}

sub condition {
	my ($expr) = @_;
	$expr =~ s/[\s()]//g;
	$expr =~ s/&1$//;
	$expr =~ /\Aw\[(\d+)\](?:>>(\d+))?\^w\[(\d+)\]
		(?:>>(\d+))?(?:\^([01]))?\z/x
		or die "unknown condition: $expr\n";
	return [$1, $2 // 0, $3, $4 // 0, $5 // 0];
}

sub vector {
	my ($expr, $width) = @_;
	my @v;
	if ($expr =~ /(?:_mm(?:256)?_set1_epi32|vdupq_n_u32)\(([^()]*)\)/) {
		@v = ($1) x $width;
	} elsif ($expr =~ /(?:_mm(?:256)?_set_epi32)\(([^()]*)\)/
		|| $expr =~ /splat\(\[([^\]]*)\]\)/s) {
		@v = split /\s*,\s*/, $1;
	} else {
		die "unknown vector: $expr\n";
	}
	@v == $width or die "wrong lane count: $expr\n";
	for (@v) {
		s/^\s+|\s+$//g;
		/\A(?:0|1\s*<<\s*\d+|DV_I{1,2}_\d+_\d+_BIT
			(?:\s*\|\s*DV_I{1,2}_\d+_\d+_BIT)*)\z/x
			or die "unknown lane: $_\n";
		s/\b1\s*<</1u <</;
	}
	# The pinned x86 source lists logical step order, despite set_epi32.
	return "{ " . join(", ", @v) . " }";
}

if ($form eq "scalar") {
	while ($prefix =~ /mask\s*&=\s*(.*?);/sg) {
		my ($expr, $dvs) = $1 =~ /\A(.*?)\s*\|\s*!\(([^()]*)\)\s*\z/s;
		defined $dvs or die "unknown scalar prefix\n";
		$expr =~ s/\s//g;
		my ($bits, $want);
		if ($expr =~ /\A(.*)\.wrapping_sub\(1\)\z/s) {
			($bits, $want) = ($1, 0);
		} elsif ($expr =~ /\A\(0\)\.wrapping_sub\((.*)\)\z/s) {
			($bits, $want) = ($1, 1);
		} else {
			die "unknown scalar mask: $expr\n";
		}
		my $c = condition($bits);
		$c->[4] = $want;
		$dvs =~ s/\s+/ /g;
		push @rows, "{ " . join(", ", @$c) . " }, $dvs";
	}
	table("ubc_prefix_cond", "prefix_conds", \@rows);
} else {
	my $width = $form eq "avx2" ? 8 : 4;
	my %want = (
		"_mm_and_si128(miss,bits)" => 1,
		"_mm_andnot_si128(miss,bits)" => 0,
		"_mm256_and_si256(miss,bits)" => 1,
		"_mm256_andnot_si256(miss,bits)" => 0,
		"vqsubq_u32(bits,set)" => 1,
		"vminq_u32(set,bits)" => 0,
	);
	while ($prefix =~ /\{\s*(let near =.*?)\}/sg) {
		my $g = $1;
		$g =~ s/\s//g;
		my ($lo, $hi, $x, $test, $dvs, $acc) = $g =~
			/\Alet near = load::<(\d+)>\(w\);\s*
			let far = load::<(\d+)>\(w\);\s*let x = (.*?);\s*
			let (?:tested|set) = (.*?);\s*
			(?:let miss = [^;]*;\s*)?let bits = (.*?);\s*
			acc[01] = \w+\(acc[01],\s*(.*?)\);\s*\z/sx;
		defined $acc or die "unknown vector group: $g\n";
		$x =~ s/(?:_mm(?:256)?_xor_si(?:128|256)|veorq_u32)/xor/g;
		$x =~ s/(?:_mm(?:256)?_srli_epi32|vshrq_n_u32)/shr/g;
		$x =~ s/\s//g;
		$x =~ /\Axor\((?:shr\(near,(\d+)\)|near),
			(?:shr\(far,(\d+)\)|far)\)\z/x
			or die "unknown vector XOR: $x\n";
		my ($ls, $hs) = ($1 // 0, $2 // 0);
		$acc =~ s/\s//g;
		exists $want{$acc} or die "unknown predicate: $acc\n";
		push @rows, join(", ", $lo, $ls // 0, $hi, $hs // 0,
			$want{$acc}, vector($test, $width),
			vector($dvs, $width));
	}
	table("ubc_group$width", "groups", \@rows);
}
@rows == $prefix_count{$form} or die "wrong prefix count\n";

if ($form ne "neon") {
	for my $key ("CHECKS", "SPANS") {
		my ($n, $body) = $src =~ /static\s+TAIL_$key:[^\n]*;
			\s*(\d+)\]\s*=\s*\[(.*?)^\];/msx;
		defined $body or die "missing TAIL_$key\n";
		my @tuples = $body =~ /\((\d+(?:\s*,\s*\d+)*)\)/g;
		@tuples == $n && $n == ($key eq "CHECKS" ?
			$tail_count{$form} : 32) or die "wrong tail count\n";
		table($key eq "CHECKS" ? "ubc_cond" : "tail_span",
			"tail_" . lc($key), \@tuples);
	}
} else {
	my @dv;
	my ($tail) = $src =~ /^fn tail\([^\n]*\) -> u32 \{(.*?)^\}/ms;
	defined $tail or die "missing tail()\n";
	$tail =~ s/\s//g;
	while ($tail =~ /if mask & DV_I{1,2}_\d+_\d+_BIT != 0 \{\s*
		let fail = (.*?);\s*out &= !(?:fail|\(fail << (\d+)\));/sgx) {
		my ($expr, $d) = ($1, $2 // 0);
		$d < 32 && !defined $dv[$d] or die "duplicate/invalid DV\n";
		$expr =~ s/[\s()]//g;
		$expr =~ s/&1$// or die "unknown tail mask\n";
		$dv[$d] = [map { join(", ", @{condition($_)}) }
			split /\|/, $expr];
	}
	my (@checks, @spans);
	for my $d (0 .. 31) {
		my $c = $dv[$d] // [];
		push @spans, scalar(@checks) . ", " . scalar(@$c);
		push @checks, @$c;
	}
	@checks == $tail_count{$form} or die "wrong NEON tail count\n";
	table("ubc_cond", "tail_checks", \@checks);
	table("tail_span", "tail_spans", \@spans);
}
print @out;
-- snap --

This Perl script reproduces the tables (although with different
formatting, and without the inline comments, I verified it with
`--patience --color-words="[A-Za-z0-9_]+|."`).

As is my rule, I only offer code that I wrote with AI assistance if the
output is close enough to what I would have written myself if I had the
time (and wouldn't need to take care of my arm muscles' health), and this
Perl script is no exception. My first draft would probably have used less
informative (or no) error messages, and I only learned about that `//`
operator during this session.

With all that out of the way, I would like to ask to include this script
in the patch (or in a follow-up patch) so that the lengthy `ubc_check.c`
file's tables can be validated/regenerated independently.

> diff --git a/sha1dc-accel/ubc_check.c b/sha1dc-accel/ubc_check.c
> new file mode 100644
> index 0000000000..f95b799f9d
> --- /dev/null
> +++ b/sha1dc-accel/ubc_check.c
> @@ -0,0 +1,1789 @@
> [...]
> +static uint32_t neon_prefix(const uint32_t *w)
> +{
> +	uint32x4_t acc = vdupq_n_u32(0);
> +	uint32x2_t folded;
> +	size_t i;
> +
> +	UNROLL_TABLE
> +	for (i = 0; i < ARRAY_SIZE(neon_groups); i++) {
> +		const struct ubc_group4 *g = &neon_groups[i];
> +		uint32x4_t lo = vld1q_u32(w + g->lo);
> +		uint32x4_t hi = vld1q_u32(w + g->hi);
> +		uint32x4_t dvs = vld1q_u32(g->dvs);
> +		uint32x4_t set, fail;
> +
> +		lo = vshlq_u32(lo, vdupq_n_s32(-(int32_t)g->lo_shift));
> +		hi = vshlq_u32(hi, vdupq_n_s32(-(int32_t)g->hi_shift));
> +		set = vtstq_u32(veorq_u32(lo, hi), vld1q_u32(g->test));
> +		/*
> +		 * The DVs of the lanes where the bit is not g->want. Each lane
> +		 * of set is all ones or zero, so a saturating subtraction keeps
> +		 * dvs where the bit is clear, and min keeps it where it is set.
> +		 */
> +		fail = g->want ? vqsubq_u32(dvs, set) : vminq_u32(set, dvs);

While this code is correct, I think it is slightly misleading: depending
on `want`, it either subtracts `set` from `dvs`, or takes the minimum. But
that only happens to be what is desired because each lane of `set` is all
ones or all zero. What we actually want is to mask either those lanes or
everything but those lanes, i.e. `dvs & ~set` or `dvs & set`,
respectively. That would be:

		fail = g->want ? vbicq_u32(dvs, set) : vandq_u32(dvs, set);

This has no speed impact nor does it produce a "more correct" result, but
it might improve readability a bit.

I haven't looked very closely whether there are similar issues elsewhere
(it is relatively tedious for me to learn all this NEON stuff on the go,
this is all new to me). If you're familiar with NEON, it might be
worthwhile looking for similarly "correct but misleading" statements.

But then, the proof lies in the pudding, as they say, and the code is
probably good enough as-is.

Ciao,
Johannes

