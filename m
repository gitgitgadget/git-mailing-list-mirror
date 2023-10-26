Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899E646
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mWja+1wl"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8438B187
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698292321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eerzbgeNl4Zc5hgUZFGSJIL7DuEghFJCp8bwkgF47fM=;
	b=mWja+1wlCPuIJygF/Xil2rhCkY1t3y7qXY0VAYz8p+0mVJxP7+krvw0iuaNdfiG6em4dOK
	qNv4kvqqEVUFZ81PZX0JHTqE7Y0fobeWhadDUxOZ3k7PG1/SjKg8e+K3ifip+2pDOZMa0a
	4K6lUZ0a8BT7swnpie783v+GoOPms4aYEO+t1JvQ6DZpe8cqaXYqoHf/Xo6he7rGDxZdJs
	IFZbVQznFwUHGlNaEhiHN2aqAlA+kZBzPyE8eKbxuhyy/Jnq8vEii+V3F5flCkOQdPUlPo
	ZznpiTzGoV1d4qlYCs5JXnprIbzQWSxKfHwx0m38KzrD7QsjKC+S697r3X2rrA==
Date: Thu, 26 Oct 2023 05:52:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: emilyshaffer@google.com, git@vger.kernel.org, Emily Shaffer
 <nasamuffin@google.com>, Sheik <sahibzone@gmail.com>
Subject: Re: [PATCH v2] bugreport: reject positional arguments
In-Reply-To: <CAPig+cT4G9vdu+se9Fbbs0TRCyPoAYFgVtkSwph_U=sWf-kQ9g@mail.gmail.com>
References: <CAPig+cQtoEpTDK1U5R+wUD4qovFtpcx6+zyOQE-SAYp5SE2q2Q@mail.gmail.com>
 <20231026005542.872301-1-nasamuffin@google.com>
 <CAPig+cT4G9vdu+se9Fbbs0TRCyPoAYFgVtkSwph_U=sWf-kQ9g@mail.gmail.com>
Message-ID: <8c82a138faa28a3c5d15a52b1d9c2c0f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-26 05:43, Eric Sunshine wrote:
> On Wed, Oct 25, 2023 at 8:55 PM <emilyshaffer@google.com> wrote:
>> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
>> @@ -126,6 +126,12 @@ int cmd_bugreport(int argc, const char **argv, 
>> const char *prefix)
>> +       if (argc) {
>> +               if (argv[0])
>> +                       error(_("unknown argument `%s'"), argv[0]);
>> +               usage(bugreport_usage[0]);
>> +       }
> 
> Can it actually happen that argc is non-zero but argv[0] is NULL? (I
> don't have parse-options in front of me to check.) If not, then the
> extra `if (argv[0])` conditional may confuse future readers.

According to https://stackoverflow.com/a/2794171/22330192 it can't, but 
argv[0] can be a zero-length string.
