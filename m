Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48A197A6B
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000770; cv=none; b=uGD8+nw8S5fBSKc3qkCytMHer++HU6Hnfl9RykEdjjDe6n+sLOhRiMw5nl9SPg3J61jgLMCMrSDeiwLAqE45iu2Q4xb2bJs10BNXWVOoSG8X8X6aRkOlK4FVvnBavDXzFUTG2+hzjHhH+rCjVD+W7ddCxSa1fuieuE3n5Oy7woI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000770; c=relaxed/simple;
	bh=Jrr+w7qZo5G77MJwLxGpPSWhtH+vfjovPKMvMW8Do6s=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=GSnbIssNINX4NZvim8qXHzgZDE+OTAz/VhhR3m8PHXNpV2x4jx8SoBYJ8X9HvMlR3NSSJSjdss/0N4R/rUj31hWVsJvi9J2j4bQPAw43LJZ74jXcRaeXWMiXmPyEtY/hdnT7Jc5a+hohXZvlEZkbWxbaeZCEStIoX5wdJ3hN8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Rhp0t5sy; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Rhp0t5sy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=wpIwS3gzK/v619sH2UssG9uA2HIV6JDJfk5ypuqhocs=;
 b=Rhp0t5syseOEI9NYw7weHs9flOwS1YVAx/W5udAEy/brN6g9euJU2IhjeWN+uBbl6EdMqhFkR+v0
   CHMxCdgZBONCacfmjIX0u6z3q7+nT0HVJ7tOYDT74AFrDt3YsQ28dZWyPA2OlTpe/O2IGibYsaRf
   vSrsAGpiAqcfHmA8nuPNAYFiwrMM8ZhPKfpaU0p/kUsF87OZfdEJYpjWuhew67Qj0hjzrSGGjY6t
   O3KXdJ4Kxdha6YgQbGPiTOXupT+YJ18MSDbOBeLhkexRnA5LOWyo6EoOBEbkXrcyL8zdOHu+EXzo
   MxrDPKXdi63HhcxfDCiHb5PundHWl67xc0btxg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJM002246PRPM90@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 10 Sep 2024 20:39:27 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [RFC PATCH v2 0/2] set remote/HEAD with fetch
Date: Tue, 10 Sep 2024 22:37:12 +0200
Message-id: <20240910203835.2288291-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFxi86bPgRcegmbXIsY/P7lbwx4JNeZPF/hHo7CO58m8jRv1gYSgzOjKP2xP//n
 6TfHVxYFhd/f6MHZWCwHCtT2hqDCm6ulmMDaRDEeql69jwxjHXH+DP/j2s3batND
 2F6Kp/bDIzWla44ae2hHqeskTY7QSDf0QYlhE2FWSkPe8A9NcKu64xzSBo50EttA
 FGe9LY+q9Z4nFRwJAhTutqYsaS9zbqPrtmPVuImU7nYh7se849PFYyLvx5+sZWNt
 53dgMEfe+hwsGQjlWQH7o0nbSsSrej3c/XXb3ykcY9sY3eZgRsDzW4lNiT33xOvh
 dCMV+HnEAs4q9bSeHFpT8pUcGlnuAwFR13PdzyypEkG+Bvssq3DOc5xAD4ROAIgL
 X0ZiNLPgm3R3yQcUz026fZ+ijM1WY8uYOj+iBYQe6AjHieVcWLl+BHNgv4vGkOiC
 wKPHqXdt2wEeU5QkbyL0l63Poltc2guFRhQGu3bz3EWSzH3kBWGK25x5

Sorry for the noise, I managed to badly mess up receipients in the previous
thread so v2 is just fixing that ...

Hi,

these two patches attempt to solve the issue raised in
https://lore.kernel.org/git/D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com/

As a quick summary: `clone` sets `refs/remotes/[remote]/HEAD` while going init
-> remote add -> fetch does not, one has to manually run `remote set-head -a
[remote]`.

The first patch adds a `--set-head` flag to `fetch` and `remote update` which
runs `remote set-head -a` for us. Unfortunately, with the current behaviour of
set-head this will always print a message, even though a no-op fetch doesn't
print anything, and I think this is also confusing for people who do not care
about remote/HEAD, so the second patch removes the print if `set-head -a` is
a no-op (and actually makes it into a no-op, instead of just idempotent).

Another way could of course be duplicating some of the code from remote
set-head in fetch.c instead of calling directly, but it didn't look like an
anti-pattern in the code-base and it felt the best way to insure identical
behaviour between a `git fetch --all --set-head` and a 
`git fetch --all && git remote | xargs -i git remote set-head -a {}`.

What is missing for sure is:
- documentation
- tests (if needed)
- settings

For settings, my idea would be a fetch/remote.set_head that could take three values:
    * never
    * missing: run it only if the ref is missing, this setting would basically
      allow replicating the result of a clone
    * always (with the other patch, this would still be a no-op if it didn't change)

This would probably also require a --no-set-head flag, to disable an
always/missing setting. A --missing-set-head or something of the like also may
or may not make sense. Alternatively, only two behaviours might be enough
(missing and always) since clone already sort of does this.

I'm not sure if the general approach is fine or not, nor am I sure the code
itself is any good, but it "works on my computer" :) I'm also hoping that
I managed to read all the relevant parts for sending a patch.

Feedback would be highly appreciated!

Thanks,
Bence


Bence Ferdinandy (2):
  fetch: set-head with --set-head option
  set-head: do not update if there is no change

 builtin/fetch.c  | 29 ++++++++++++++++++++++++-----
 builtin/remote.c | 15 +++++++++++----
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.46.0

