Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718759B48
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711225030; cv=none; b=ddvKaMDuXoXJGSbzy1isLYigyWLS8UZ57DGeMRsiLrlBbdynx8xgBSPy+iAs2mE6+b+4kC94UfmQUSZ+W6kVq7upgXGIfEPZgtN+Ij4GrJ6q6zLxWf3cJR/3tQykG9Tjbaeoq4Ay49GIDSg+7JBnP5MxD8KIwWQYlz3V0JGk84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711225030; c=relaxed/simple;
	bh=fkr52tfVJcpYGUM4d01GKfEYJMIFba+7QSYtcK13uqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PylsTjozdvBa/uV9iEKgkENXalDo/PacxXfX+NVNNYiLwAdwBAgm6ECVfuEp69VQpraaAaEgCzhiMGWYE13j9GKcLueS+w/DJWZ463xKPq5wyb9nH7ISJ5F9EOfB208aVJ8ip6eC+yx5IdK9eGO4JSw0zCIdVEPsos4qK4TiQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=jJC3RbT5; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="jJC3RbT5"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42NKGm5o014644
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 23 Mar 2024 21:16:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711225009; bh=fkr52tfVJcpYGUM4d01GKfEYJMIFba+7QSYtcK13uqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jJC3RbT5Fu2oJtWuQdkcW+qdDpKbxf2pJUc7eVF4z7trXZBvF/66tMqMT1TIG+jV2
	 PcS+douSuimsZFjDGqN6VWJH7L6Arx9Dh6vOFu+vi9qeWcoq5QNpG1LZgMl/usCSwW
	 uZiiFgTUFCL4Mrn1/TxWDfeGGvPN/TatV6UkQr80=
From: Dirk Gouders <dirk@gouders.net>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v2 5/5] MyFirstObjectWalk: add stderr to pipe processing
In-Reply-To: <bwm73ljwyva36idgouda53qlm7hefkpnt7nomlc5d3c2zje47g@cwkt4dtmx7le>
	(Kyle Lippincott's message of "Sat, 23 Mar 2024 12:48:35 -0700")
References: <cover.1710840596.git.dirk@gouders.net>
	<64c36dbf16108353635a7315a3bd5eb60f2aa92e.1710840596.git.dirk@gouders.net>
	<bwm73ljwyva36idgouda53qlm7hefkpnt7nomlc5d3c2zje47g@cwkt4dtmx7le>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 23 Mar 2024 21:16:42 +0100
Message-ID: <ghcyrkzot1.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kyle Lippincott <spectral@google.com> writes:

> On Tue, Mar 19, 2024 at 12:23:15PM +0100, Dirk Gouders wrote:

>> -$ GIT_TRACE=1 ./bin-wrappers/git walken | head -n 10
>> +$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | head -n 10
>>  ----
>>  
>>  Take a look at the top commit with `git show` and the object ID you printed; it
>> @@ -875,7 +875,7 @@ of the first handful:
>>  
>>  ----
>>  $ make
>> -$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
>> +$ GIT_TRACE=1 ./bin-wrappers git walken 2>&1 | tail -n 10
>
> I think there's a second issue here: this should be `./bin-wrappers/git`, right?

Oh yes, that is a second issue -- thank you very much for spending the
time to look at this series.

Dirk

