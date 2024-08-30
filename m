Received: from hu-is-mx-01.gaijin.team (hu-is-mx-01.gaijin.team [213.163.39.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94333CD1
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.163.39.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045961; cv=none; b=j5bZ6iyRMEIwG/qJd7wXYcmgtmEfGzih7BLBEHOzocdAKoTZBVpbyVbmc/QcRr+8eMKuyoJUqSuoayYMEG1MFs2jFmYTesBSx46PA3UywON/WI0FCj5L92g27iztnJ8GQyrWfsQz1pnAguD/WvpaMGG7zsSdZ+tVCK315bOktqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045961; c=relaxed/simple;
	bh=4qYy+JIA+4/LV2CRkUFFeuWmsFza7UYxLKVnzUty9PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FQjlTW+M+B+mw9c0fqrsk5oroGHhOrzLCwFEWIv1YvryTofBjyBPxXcZbOUeJaBJA1+YqOb1mkxoc/OZdN5kQmfhJN17g0SD0lJhVehI4Q49zySo2MLZ2JNIJNRgcopvbcK+7FWsTN0nr6zYflZIbSMZBK+qMdSnrQNIBktgF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team; spf=pass smtp.mailfrom=gaijin.team; dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b=ABWKSMak; arc=none smtp.client-ip=213.163.39.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaijin.team
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b="ABWKSMak"
Message-ID: <fe9d19fa-661d-4358-aa0a-ea419c419266@gaijin.team>
DKIM-Filter: OpenDKIM Filter v2.11.0 hu-is-mx-01.gaijin.team 3D51738A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaijin.team; s=mail;
	t=1725045957; bh=jngkiu0FuaBDHtTvLvVMkCCXj/gS29/NSzqmpUXEjTo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ABWKSMakVx+6PgvGxf9qwqzKiE8tDDPCt+kw2o/1/bRX7+GLau/nW7LbS/eqOuxt5
	 z5uwxQz8yFj8bmSZ0vCAioNh5cSOfEdiBJX4MEjQ2ushvOQ7IciCyLBD/Da7Df3AKF
	 5bblsC8AoOthFgwZbvBpcpXXvd2ny0BpI+vP2Whc=
Date: Fri, 30 Aug 2024 22:25:56 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Committing crimes with NTFS-3G
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <ZtEWvQOwLPgjIFks@tapette.crustytoothpaste.net>
 <3eda2715-3b44-469e-85d5-f25504212928@gaijin.team>
 <ZtHe8Vi9aRmY-UMI@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Roman Sandu <r.sandu@gaijin.team>
In-Reply-To: <ZtHe8Vi9aRmY-UMI@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The stat output for a random file in the root of the repository is as 
follows:
```
   File: <CENSORED>
   Size: 91876     	Blocks: 184        IO Block: 4096   regular file
Device: 259,2	Inode: 4630629     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/romasandu)   Gid: ( 1000/romasandu)
Access: 2024-08-29 17:41:04.855126300 +0300
Modify: 2024-08-29 17:41:04.855609000 +0300
Change: 2024-08-29 17:41:04.855609000 +0300
  Birth: -
```
Maybe lack of a birth stat is what drives git crazy?

My git version is 2.43.0, which is the one from the Ubuntu 24.04 repo.

Neither `core.trustctime` nor `core.checkStat minimal` (nor a 
combination of them) help.


On 8/30/24 18:02, brian m. carlson wrote:
> On 2024-08-30 at 12:52:05, Roman Sandu wrote:
>> Yes, I am aware that the index will be fully refreshed on the first run of
>> status. That is completely acceptable. But that is not what I am observing,
>> it is being refreshed on every single run of `git status`!
>>
>> After running stat before and after a status, the sha256 is identical. Both
>> for files and for folders. Maybe Windows has somehow corrupted the index
>> with its negative aura which makes git invalidate it on every single run?
>> Are there tools in git to diagnose the reason for the index's cache being
>> invalidated?
> 
> It would still be helpful to see the output of the `stat` command, since
> that would tell us useful things about what's causing Git to think the
> data has changed.  For example, some systems lack certain timestamp
> granularity, which can break Git when compiled in certain ways.
> 
> You can see if setting `core.trustctime` to false fixes it, and you can
> also try `core.checkStat` to `minimal` as well.  You should try them in
> that order to see if they fix things.
> 
> Also, what version of Git are you using?  Is it the one in Ubuntu 24.04,
> or the one from the git-core PPA, or a different one?

