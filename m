Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4F28641E
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670860; cv=none; b=BobcSEsKw3kWSDcEhH/gHllY8v8KIwyrRMbBqkujbtgnf3KRdoCqXYTwJGCVKzV1qm5DvaVvln0u4ee1PSpKkwvKFCH3GwiY8TlvyaF6sdG2j73O0Yp0ic4TFAXq0p9uaJ0r3Nk/12NiBjhTGVWj6LdmqVkZXgp332PcPBxli7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670860; c=relaxed/simple;
	bh=l47MSXSP9+lis5rTGJHXZw3i0q2DO+l7eLUmBtd55jc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=BO18t5c9jDZCn6fCbZuzV5tQPXR8rGMeKhKrF30dWdisUJkye8nb7DvU7wvv2FLZ12ICX20N1j3K1qylHwBZeY8jpWwf8vvq/1wxyXP1+cLNnP2bS3NrF/kp4S9qdU+nKnBHT1o37zwWJk6s1iFLaDExl1GbwO9F3eq6BqvQ5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqLtQYGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqLtQYGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776670857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9jh/STLJe4e99VrBzEgIDCjpjJ2A2MME7myO4LRw6/w=;
	b=YqLtQYGh6nBEUXtB7SMOeo/yy5ZT/uY91NqgtStYSyxLawmS1KrJV43jHbf6vq3+pb9DFf
	gKgUmToaMTBIAC6Tyb359ecTEJacD/w8SEQ7iUfY31Ba0SEJgiAOZzt5l8EFXBPT2qLY8C
	8YcJ2C4NLnSw6PQ/UVEgHA3rDUuT3XQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-f8sPLmHlOuaCNu7wQIiKxQ-1; Mon,
 20 Apr 2026 03:40:55 -0400
X-MC-Unique: f8sPLmHlOuaCNu7wQIiKxQ-1
X-Mimecast-MFC-AGG-ID: f8sPLmHlOuaCNu7wQIiKxQ_1776670854
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB6DB19560A7;
	Mon, 20 Apr 2026 07:40:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 250593000C15;
	Mon, 20 Apr 2026 07:40:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: git@vger.kernel.org
cc: dhowells@redhat.com, brauner@kernel.org, netfs@lists.linux.dev
Subject: git, network filesystems and is_path_owned_by_current_uid()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1005890.1776670851.1@warthog.procyon.org.uk>
Date: Mon, 20 Apr 2026 08:40:51 +0100
Message-ID: <1005891.1776670851@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

Can git's is_path_owned_by_current_uid() be made to check to see if the
filesystem is a network filesystem (9p, afs, ceph, cifs, nfs, maybe orange?)
before deciding that you're not allowed to do a command because your UID
doesn't match?

One way to do this would be to check the filesystem type returned by statfs:

	statfs(".", {f_type=AFS_FS_MAGIC, ...

Alternatively, we could add a statx() attribute flag in the kernel to indicate
that the uid/gid is from a separate set of IDs (or fabricated entirely) and
cannot by directly compared against system IDs.

Thanks,
David

