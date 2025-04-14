Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D58479
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744590186; cv=none; b=nfX9QoLO9BFBsywDw+LdzxRtZrYUQ5I+iXRiItdz/zwyvvlEM/NJ8SnjKeExWq0Xkx4s9l1NSGIztOs+WHl6o7mpWe/0vi9G+3mihHgY8kdl1tO5F1JFqpy9GQDKHllI4wRY58NBdopn4fgDIWzABC31d+enrx4MWeMpMxjFXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744590186; c=relaxed/simple;
	bh=lskoU1nokLpEu+lJn9SXY2NE51TtuCiHa9/yzVVynaU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVl/VXkD42ittrOLK/iE2XGf/V9b4Dhz4Xu/cqT2pNNaaqrjxgiyKdwniBvSkhhWx/WvNoq2LJYUxqRyMXBuCTGhRF2t+EcCde5RWzzu+GTujl0H0sCUeo+O9LbRCgUTatMDWfBQXLPdebmkxheJqct6+Wg5hScjR3Oxh2cs0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=DK1RqxfJ; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="DK1RqxfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1744590182; bh=lskoU1nokLpEu+lJn9SXY2NE51TtuCiHa9/yzVVynaU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=DK1RqxfJGG8nz6TNU4u/6qM6valCWVOelRn1Tto5GbJd9XKlm1u7H8rDhugPKQfrj
	 szkQnGM5L7RnBd+AfqNSWYAC6x1loWhdlRwgeUZSl6SS3fa36QVc4FidgOdPqGRwRv
	 ZOff/hiK6pT7o6taqb4WQET3F9pnoATwg0sZ1YJSuf01+O70K6qSw+0KH4LzfDh/UJ
	 f/qPP0U9vGcN+f32W5v0RhS5+Pg9G0JRY4i/6h0x5opnD8VL7GRH8O8NKZJ5NHTgEQ
	 lpFLoCK0o7MhGx1M1dKMXdlSS2n0IRp0Xf6ENmhHb8330bIiTxOcxhTc73phbL2S7r
	 uwrMWT0PZrdgw==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id 7183C1120180; Mon, 14 Apr 2025 02:23:02 +0200 (CEST)
Date: Mon, 14 Apr 2025 00:23:02 +0000
From: Klaus Frank <vger.kernel.org@frank.fyi>
To: sandals@crustytoothpaste.net, git@vger.kernel.org
Subject: Re: How to gpg signed email patches?
Message-ID: <0709104c-c951-42be-9300-a0aa9f9eea6c@frank.fyi>
Reply-To: git@vger.kernel.org
User-Agent: Mozilla Thunderbird
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
 <Z_xAOmQm0e_WE2Dd@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Language: de-DE, en-US-large, en-US
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_xAOmQm0e_WE2Dd@tapette.crustytoothpaste.net>

On 2025-04-14 00:52:42, brian m. carlson wrote:
> On 2025-04-13 at 19:17:26, Klaus Frank wrote:
>> Hi,
>>
>> I don't think Git supports this out of the box.  The proper way to do
>> this would be via PGP/MIME, since clearsigning the patches would result
>> in them not applying properly (due to the dashes being escaped).
But if "git am" would support pgp clearsigning it could just easily 
reverse that, no?
But I've to admit I didn't fully look into all of the escape rules and their
reversability yet. Is RFC 4880 Section-7 the correct one for clearsign
and RFC 3156 Section-5 the correct one for PGP/MIME?
>> More notably, I've had problems applying patches that are signed using
>> PGP/MIME because `git am` doesn't seem to understand how to extract the
>> data in all cases (maybe it does in some cases, but I haven't tested).
>> As a practical matter, signing PGP/MIME requires that the enclosing body
>> be encoded as either quoted-printable (recommended) or base64 (not
>> recommended because plain text as base64 tends to be a sign of spam)
>> because that prevents breakage from intervening mail servers and
>> that can introduce some trickiness in extracting the text without
>> parsing the MIME structure.
>>
>> I know that Git definitely does not know how to verify those signatures,
>> though, so many people would end up not verifying them.

Yea, then better just not include them for now.
Including them sounds like a shitty move towards or better
against the other developers. Kinda but not quite maliciouse compliance
style. :/

>> The discussion on the list in the past has generally not been in favour
>> of this approach, since the assumption is that the patch is accepted
>> based on whether it is good or not and not whether it is authentic.  I
>> acknowledge that there are workflows where authenticity is useful,
>> though, so I would not be opposed to seeing patches to implement this,
>> but I'm afraid that it has yet to be implemented.
That may be, however the signature also shows if it has been damaged
in transit and that is at least in my eyes a very valuable information.
(And maybe in the near future to mandate everyone signs (or even
encrypt) their contributions in order to easily ban "vibe coders")
>> An alternative approach, which has also been discussed (and which I
>> might end up sending a patch for at some point), is including committer,
>> signature, and base commit data in email headers to allow reconstructing
>> the exact commit with a valid signature.  Whether the maintainer chooses
>> to keep that signature is of course up to them, but this would allow
>> the commit to be verified using the normal mechanism.

That sounds also good compared to what I scetched up so far.
This is what I was thinking about btw (nothing special really):

On the sender side:
1. "git format-patch"/"git send-email" sees that the commit{s} is/are 
signed or it was executed with an explicit flag to sign (similar to 
git-commit "-S[<key-id>], --gpg-sign[=<key-id>], --no-gpg-sign")
2. Either "git format-patch":
  a. Somehow embedds the commit signature as plain text [Your suggestion].
  b. Does "gpg --sign --clear-sign --include-key-block" the entire 
email (Or [rfc4880#section-7]).
  c. When "--inline" is specified {multipart message} it creates a 
detached signature ("gpg --sign --detach-sign --include-key-block 
--armor") and attach it as a 3rd "application/pgp-signature" part to the 
multipart-message (or [RFC3156#Section-5] instead of literally "just" 
attaching an additional .sig file to the mail)
3. Send the mail
Also "git format-patch" propably should support these gpg commandline 
properties: `--homedir`, `--keyring`, `--primary-keyring`, 
`--refresh-keys`, `--armor`, `--no-armor`.

On the receiver side when running e.g. "git am":
On a mail without a signature
=> Fallback to current behaviour accept (maybe have an optional 
configurable warning message). And have an option to enforce signatures 
(fail if enforced and missing).
On a mail with a signature:
a. If nothing else specified default to e.g. `gpg --verify --batch 
--auto-key-import --auto-key-retrieve --tofu-default-policy="auto" 
--trust-model="tofu+pgp"` (marginally trust all keys and build a web of 
trust; Maybe on a dedicated gpg-homedir/keyring)
b. If operating on the users generic gpg-homedir/keyring or explicitly 
specified use `--tofu-default-policy="unknown"` instead of "auto". This 
will still import and validate keys from the signatures [depending on 
user system config also from keyserver, ldap, ... but disabled by 
default] but any key the user didn't touch themselves will be considered 
"unknown" trusted and therefore won't be used for extending the web of 
trust.
c. also have flags for these gpg commandline properties: `--homedir`, 
`--keyring`, `--primary-keyring`, `--refresh-keys`.
d. maybe also add pgp-encryption support (to also accept e.g. patches 
for zero days?). All that would be needed for that is "git am" would 
have to tell gpg to try to decript the message and similar "git 
format-patch" would need one to encrypt.


Sincerely,
Klaus Frank

