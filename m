Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925211DDC5
	for <git@vger.kernel.org>; Thu,  2 May 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714682591; cv=none; b=jeWIk5FsEbN6IPKj9w0hBSC4VJTzVghdkfx15c74LMF2xTFVptR5iBX5gaJj2qDtqpGUcftmBpaD3YaWQqJV4aMXg1LFoearhHad2tElIZefKDCxLCOUHJdbJshjGmRDDmXSviRqlE1rhxDYtcvqnwYkXftcgChsclIeljFJnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714682591; c=relaxed/simple;
	bh=NTXjgre4G9PdXFD3JF6ZU13DZgC+m99p38Yt4a2ExiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ccd3BpiUt8Q40Q/S8X5wNCp7xYZSjYHXb+KB3c1ebZX085T/T8PZhxscr12DQImUQTOdGPLdC6oYL64FrH4jawx2cbzSj+VHQyM4Gbrl6BjBHvXz9WAWdndpRJi9T1xXpK0oWNmlgdBfbU0l7OyfjGcotnPmF0L9PuaDd4vBdck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p6T2plD9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p6T2plD9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E57C3214A;
	Thu,  2 May 2024 16:43:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NTXjgre4G9PdXFD3JF6ZU13DZgC+m99p38Yt4a
	2ExiI=; b=p6T2plD9T5yuHnQTyjG7k8BODvup0Kk2mtlekJho2Jpxxs9S537o7d
	auqzs8pn3vYAVQ12kFMwORPLkrXgBsN4r1a2fHl2wZ5dH7+WA05wMabj0Q/cnTP2
	IBJiasctyy4CK6YH5CBd2h9pGl/PUtcZD4ZGLnK2ZTijg4FpEzznM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1798D32149;
	Thu,  2 May 2024 16:43:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 841FD32148;
	Thu,  2 May 2024 16:43:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johan Walles <johan.walles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Chunk header @@@ counts wrong?
In-Reply-To: <CAKtyTbevS7W-X4qoO=uPnHmXCEtKhqycD8DZZY-oK-z0p4CEAQ@mail.gmail.com>
	(Johan Walles's message of "Thu, 2 May 2024 18:51:47 +0200")
References: <CAKtyTbevS7W-X4qoO=uPnHmXCEtKhqycD8DZZY-oK-z0p4CEAQ@mail.gmail.com>
Date: Thu, 02 May 2024 13:43:04 -0700
Message-ID: <xmqqmsp8c5d3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 943ED864-08C4-11EF-9C26-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johan Walles <johan.walles@gmail.com> writes:

> Are these counts produced by git 2.44.0 correct, and in that case how?
>
> The header says "@@@ -6,6 -6,60 +6,60 @@@", meaning "six rows in v1,
> sixty in v2 and sixty in the merge result".
>
> I think v2 contains 57 lines, but git says 60. What am I missing?

> I'm counting:
> * 6 space-space (context) lines
> * 51 plus-space (new to v1 but already in v2) lines

I think you failed to count three lines in v2 and merge result, they
look like "<<< HEAD" "======" ">>> 8eec118"; new to v1 but already
in v2 lines are 54, not 51, no?

> * 3 plus-plus (new to both v1 and v2) lines
>
> Doesn't this mean that v2 contains 57 (51 plus-space + 6 context) lines?
>
> Why does git say that v2 contains 60 lines?
>
> Originally reported here: https://github.com/walles/riff/issues/63
>
>   Regards /Johan
>
> "
> diff --cc ansible/roles/zfsbootmenu/tasks/main.yaml
> index 73fa864,08648fa..0000000
> --- a/ansible/roles/zfsbootmenu/tasks/main.yaml
> +++ b/ansible/roles/zfsbootmenu/tasks/main.yaml
> @@@ -6,6 -6,60 +6,60 @@@
>         - zfsbootmenu
>       state: present
>
> ++<<<<<<< HEAD
> ++=======
> + - name: Create ESP mdadm config
> +   template:
> +     src: mdadm.conf.j2
> +     dest: /etc/mdadm.conf
> +     owner: root
> +     group: root
> +     mode: 0644
> +   when: esp_mdadm_array is defined
> +
> + - name: Install dropbear
> +   xbps:
> +     pkg:
> +       - dropbear
> +       - mkinitcpio-dropbear
> +     state: present
> +
> + - name: Create dropbear directory
> +   file:
> +     path: /etc/dropbear
> +     owner: root
> +     group: root
> +     mode: 0755
> +     state: directory
> +
> + - name: Create dropbear keys
> +   command:
> +     cmd: /usr/bin/dropbearkey -t {{ item }} -f
> /etc/dropbear/dropbear_{{ item }}_host_key
> +     creates: /etc/dropbear/dropbear_{{ item }}_host_key
> +   loop:
> +     - rsa
> +     - ecdsa
> +     - ed25519
> +
> + - name: Create dropbear authorised keys
> +   template:
> +     src: authorized_keys.j2
> +     dest: /etc/dropbear/root_key
> +     owner: root
> +     group: root
> +     mode: 0644
> +     lstrip_blocks: true
> +
> + - name: Create dropbear config
> +   template:
> +     src: dropbear.conf.j2
> +     dest: /etc/dropbear/dropbear.conf
> +     owner: root
> +     group: root
> +     mode: 0644
> +     lstrip_blocks: true
> +
> ++>>>>>>> 8eec118 (fixup! ansible/roles/zfsbootmenu: add role)
>   - name: Create zfsbootmenu config
>     template:
>       src: config.yaml.j2
> * Unmerged path ansible/host_vars/foo.yaml
> "
