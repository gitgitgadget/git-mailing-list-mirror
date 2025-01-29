Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366015B54C
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137042; cv=none; b=eI1cmQiSXpnORIdQ3bqBZ45Sj7/qSJw84AnqRnPP02cLoZc6wZT1YzyXLEfoYIL4crPDrss42+B0ubAHnrozcvCNglUH+8KIYBVVvtwGQCv7xJrLEEBOnRkWVs8zhN2vfE9hz4EGSBmmbt8TQtyvFhMdcHHfRVAjF7z4y3zKZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137042; c=relaxed/simple;
	bh=tIEvkwLTAqjGiBdIhRFIzSKr2n3e/jYtcyd+g3WhniE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKuOrvB+JpLKMq+KMp2E96UTsEd0YYzpZoW2wq1KPHLH09LXfloZLXqCcsUfJei8u9yIo4pAMKhouud1XfQWHJ/p7nlD+C8w/RJuW3EVdf1aVC6opBZ5OtMKj9puZvpdeaxoY9JUo+t6RH5YHKIezQKSTEcYp/jNn6GQ+sFtm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4YjZ890g2lz7QSDN
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 08:50:33 +0100 (CET)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4YjZ804FzCzRnmS;
	Wed, 29 Jan 2025 08:50:24 +0100 (CET)
Message-ID: <c0ee472a-5ce6-4e2e-8922-65927f07029c@kdbg.org>
Date: Wed, 29 Jan 2025 08:50:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] compat: consistently resolve headers via project
 root
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Edward Thomson <ethomson@edwardthomson.com>,
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
 <20250128-pks-reftable-drop-git-compat-util-v2-15-c85c20336317@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-15-c85c20336317@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.01.25 um 09:28 schrieb Patrick Steinhardt:
> diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
> index c2afcbe6c8..68c9fd7363 100644
> --- a/compat/fsmonitor/fsm-health-darwin.c
> +++ b/compat/fsmonitor/fsm-health-darwin.c
> @@ -1,7 +1,7 @@
>  #include "git-compat-util.h"
> +#include "compat/fsmonitor/fsm-health.h"
>  #include "config.h"
>  #include "fsmonitor-ll.h"
> -#include "fsm-health.h"
>  #include "fsmonitor--daemon.h"
>  
>  int fsm_health__ctor(struct fsmonitor_daemon_state *state UNUSED)

The use of double-quotes

  #include "fsm-health.h"

very clearly indicates "this file is expected to be in the same
directory as the file that is including it". On the other hand,

  #include <fsm-health.h>

would state "this file is to be found somewhere on the include paths,
but not in the directory of the including file".

Therefore, changes like this one, where the new path only points back to
the same directory where the including file is, are very much
undesirable. The unpatched form is preferable.

Depending on the desired goal, is it perhaps better to use <> brackets
more liberally?

-- Hannes

