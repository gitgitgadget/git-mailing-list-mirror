Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C91E481
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466529; cv=none; b=tEGHtICPdUdhwN1Ib6bM0GspANkwqaUda6zskgAI6lWdXpj96u9nw1V3CqANJqyM24nOab8QfTTt83tittLcDO4OuVFRq588m9dEOIHEzG3G/oWsKOh3xoEVGtWuMZPD3x7IvWliTXlYdhQypGWmwlXdCOm6G11tib07FN9mJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466529; c=relaxed/simple;
	bh=Ea51hSfh7yqM5Ug2eSgWBk+VHaTrhh8pM+8VXQF+EXw=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pT8GfY5ziqhtOpi1KqRCWH3I50PdRDw3ECud0zN1vRyIoSSUJ1JsEyvRgzNyDpnPL1Su4amvjtMBf3O0q9xIGa8F+GE7FrUHLTTp6Qo7tjQ+29vacXVGcuCyvbZM1R+fFLOEItEbBpf0yW0Z8GBeivPvHwzWRFd+voVK3RjWQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 44NC7IX41996901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 12:07:18 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?UTF-8?Q?'Pawe=C5=82_Bogus=C5=82awski'?=" <pawel.boguslawski@ib.pl>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <ed79092c-c37d-4e4c-aae9-af68cd8c20a0@ib.pl> <Zk5pDZ1gTcyrGfUk@tapette.crustytoothpaste.net> <293afb32-99b1-4562-b339-7862698ef00f@ib.pl>
In-Reply-To: <293afb32-99b1-4562-b339-7862698ef00f@ib.pl>
Subject: RE: Cloning does not work on available download bandwidth changes
Date: Thu, 23 May 2024 08:07:13 -0400
Organization: Nexbridge Inc.
Message-ID: <036f01daad09$c279e410$476dac30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHzfkqn/jveDKVmTZvO0po2Z/QLcQJ66NFCAhttT++xTY+UAA==

On Wednesday, May 22, 2024 6:58 PM, Pawe=C5=82 Bogus=C5=82awski wrote:
>W dniu 22.05.2024 o 23:52, brian m. carlson pisze:
>
>> On 2024-05-22 at 15:02:51, Pawe=C5=82 Bogus=C5=82awski wrote:
>>> Started to clone big git repo on not-too-fast, _stable_ VDSL link =
(up
>>> to 20mbps down)...
>>>
>>>      $ git clone https://github.com/googleapis/google-api-go-client
>>>      Cloning into 'google-api-go-client'...
>>>      remote: Enumerating objects: 644446, done.
>>>      remote: Counting objects: 100% (6922/6922), done.
>>>      remote: Compressing objects: 100% (2904/2904), done.
>>>      Receiving objects:   0% (3859/644446), 20.82 MiB | 1.01 MiB/s
>>>
>>> ...and then started to watch a VOD movie on same link; when VOD
>>> buffers data, eats almost all available down bandwidth and leaves
>>> only about 100 kB/s for git...
>>>
>>>      Receiving objects:   1% (7111/644446), 44.49 MiB | 130.00 KiB/s
>>>
>>> ...and when VOD stops buffering and whole bandwith is available for
>>> git again, git transfer starts to grow...
>>>
>>>      Receiving objects:   1% (7660/644446), 50.56 MiB | 575.00 KiB/s
>>>
>>> ...but finally git throws an error
>>>
>>>      error: 181 bytes of body are still expected5 MiB | 1015.00 =
KiB/s
>>>      fetch-pack: unexpected disconnect while reading sideband packet
>>>      fatal: early EOF
>>>      fatal: index-pack failed
>>>
>>> or sometimes:
>>>
>>>      error: RPC failed; curl 92 HTTP/2 stream 5 was not closed =
cleanly:
>>> CANCEL (err 8)
>>>      error: 6109 bytes of body are still expected
>>>      fetch-pack: unexpected disconnect while reading sideband packet
>>>      fatal: early EOF
>>>      fatal: fetch-pack: invalid index-pack output
>>>
>>> No such problems when downloading bigger file (i.e. linux kernel
>>> source) with wget or curl instead of git clone (wget/curl transfer
>>> drops to about
>>> 100 kB/s when VOD buffers and increases to full speed when VOD is =
not
>>> transferring and transfer finishes successfully).
>>>
>>> Sounds like a bug in git; should not throw an error on available
>>> download bandwidth changes as wget and curl do and should not =
require
>>> any params tuning (to stop users flooding bugtrackers).
>> I don't believe this is a bug in Git.  The problem here is a network
>> issue of some sort that's causing the connection to be interrupted or
>> dropped.  This is very common, but the possible causes are many.
>>
>> A lot of times we see this it's some sort of proxy, and that can be a
>> non-default antivirus or firewall or TLS MITM device, but that's
>> usually on Windows, and you're using Debian.  It can also be just a
>> bad connection, poor traffic management by your ISP, or a flaky
>> wireless or wired network card.
>>
>> My _guess_ about what's happening here is poor traffic management:
>> because video is typically flagged as low-latency in DSCP, some =
device
>> on the path is prioritizing it to the exclusion of all other traffic,
>> which is causing the Git connection to be dropped.  I have no proof =
of
>> this, though.
>
>Try to run
>
>git clone https://github.com/googleapis/google-api-go-client
>
>and limit interface speed somehow i.e.
>
>tc qdisc add dev eth0 root handle 1: htb default 12 tc class add dev =
eth0 parent 1:1
>classid 1:12 htb rate 20kbps ceil 20kbps tc qdisc add dev eth0 parent =
1:12 netem
>delay 1000ms
>
>and after a while restore speed with i.e.
>
>tc qdisc del dev eth0 parent 1:12 netem delay 1000ms
>
>I tried this in Debian 11 and  git 2.30.2 died with:
>
>error: 5723 bytes of body are still expected MiB | 920.00 KiB/s
>fetch-pack: unexpected disconnect while reading sideband packet
>fatal: early EOF
>fatal: index-pack failed

I have tried this from my home ISP. It does a little throttling but =
sustained between 5-6 MiB/s for most of the transfer. We have seen =
related issues around ISP throttling that causes connections to drop for =
very large repositories. However, in the test I just ran, both git and =
https are happy to complete.

$ git clone https://github.com/googleapis/google-api-go-client
Cloning into 'google-api-go-client'...
remote: Enumerating objects: 644446, done.
remote: Counting objects: 100% (6922/6922), done.
remote: Compressing objects: 100% (2904/2904), done.
remote: Total 644446 (delta 3722), reused 6567 (delta 3445), pack-reused =
637524
Receiving objects: 100% (644446/644446), 1.46 GiB | 7.45 MiB/s, done.
Resolving deltas: 100% (392971/392971), done.
Updating files: 100% (1372/1372), done.

$ git version
git version 2.43.0

Have you tried using SSH to do the clone? Assuming you have your public =
key registered on GitHub: git clone =
ssh://git@github.com/googleapis/google-api-go-client

This runs about slightly slower.

$ git clone ssh://git@github.com/googleapis/google-api-go-client
Cloning into 'google-api-go-client'...
remote: Enumerating objects: 644446, done.
remote: Counting objects: 100% (6922/6922), done.
remote: Compressing objects: 100% (2911/2911), done.
remote: Total 644446 (delta 3720), reused 6563 (delta 3438), pack-reused =
637524
Receiving objects: 100% (644446/644446), 1.46 GiB | 6.31 MiB/s, done.
Resolving deltas: 100% (392969/392969), done.
Updating files: 100% (1372/1372), done.


