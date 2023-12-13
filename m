Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="od0EnED9"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872219B3
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:32:49 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D5ED32C3C;
	Wed, 13 Dec 2023 10:32:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LIiR1S4Wi62rdoDPYpyM9rs0xCtrFkXxXylwcs
	+hzwA=; b=od0EnED9bnIe87nPOHZK6sCpqxF910ohLniNYCsn4D8OrP9bbScTyy
	zsp2sT5pxKp8a+xf1UmZQ0eSRwDmyYrOynJJe5hm/qR9oIbwxr9ZKNVAItF/9tbx
	TcUUWwF/xAi42DjRDgJY8lggsoaKlv7FG7+yYz7XY5vkQeANPqHgY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 25B7732C3B;
	Wed, 13 Dec 2023 10:32:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5A2D32C3A;
	Wed, 13 Dec 2023 10:32:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Zhirov <azhirov1991@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Communication channel interruption
In-Reply-To: <71f2b28b-3e27-4773-8408-2f4c13757b73@gmail.com> (Alexander
	Zhirov's message of "Wed, 13 Dec 2023 12:54:30 +0300")
References: <71f2b28b-3e27-4773-8408-2f4c13757b73@gmail.com>
Date: Wed, 13 Dec 2023 07:32:44 -0800
Message-ID: <xmqqcyvanmn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DD2458F4-99CC-11EE-8412-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Alexander Zhirov <azhirov1991@gmail.com> writes:

> When cloning a repository from GitHub, I have a channel break,
> although the connection is stable. What could be the problem?
>
> # git clone https://github.com/Thinstation/thinstation.git
> Cloning into 'thinstation'...
> remote: Enumerating objects: 79839, done.
> remote: Counting objects: 100% (535/535), done.
> remote: Compressing objects: 100% (319/319), done.
> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
> CANCEL (err 8)
> error: 7473 bytes of body are still expected
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output

A guess in the dark without knowing Git version or platform on which
you are seeing this symptom, but it would help to read "What does
http.postBuffer really do?" in 

    $ git help faq

and then to ask Google about "RPC failed; curl 92", which would show
mainly two suggestions from various places.  Perhaps

    $ git -c http.version=HTTP/1.1 clone https://github.com/Thinstation/thinstation.git

may help?

