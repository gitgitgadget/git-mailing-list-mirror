Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4013AA38
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243088; cv=none; b=oByWXsL4jJHhKjQsADvH9YqzthtDH6HGHibPuda2F1gBH9K3Bdsihh3pwbU/2QqNpsdisQ5rOmupy9f7r+8HZQFtjQMKmQFFbNg5HnVuUsuE7asV3uuqoRx+KG4VvqtrVwlUvdhp1EX+Bem3ZQdG4GVhfL/c1Bxk51gPIxB7Rps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243088; c=relaxed/simple;
	bh=gfE1DFGt2OoRBLXvZUc0k7LYhwwFG2t8NXulyIT+1L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsFDjHJeNNbo+Ei6WF/2wqmWiicZWFHW4YkSL06bAaQe8LgRavp+O7bpJzuAuhDlNMLHrVQyOnVASo0JH0zECUWt0s37Ga68siRzx0LF0A2vpzNa31X5GIE8TITSJhWxc+2JyTwirIZbzM0QyzvhZz3w7F9MyD7/2RHB1BdEMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so15133596d6.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243085; x=1723847885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veTlnKgibPlQfoVl7a3XxXGU8Wkwr1E4zzrF/Y7JEgI=;
        b=OYSIdNUnPnrVeUWRlJTJbkpHVCNV2w08VdI5niewUdqnge8Wxbd4pPRIhcA49HShjA
         nPNvrafkkDYzW8JBcGSvQfOpfKBJCWlTsa6GWtAZuyZwOHwRrGPK2rwBpNODpiKYT7M2
         g+9GmxAXI+zG/uWqVQbDOBRdunT6hDtPRtdb5BnBLMdwhY+g8KYL89f5Ws8rDPRhIQhh
         pwDU+5mbb44AmBfTC4G/zTRUJqaqjj9LhwxFg5ybZN1rQcjST7SHFtebfthnSkOJKkCD
         Uj1BvPlWKhpkFNBC95fII8kSY+NTI/1Avs0jRrVGtgVek3G/Jjj+TSyWIvBC6/TRohzL
         rC/w==
X-Gm-Message-State: AOJu0YwH7qvd281kz6CJPfSGNgTV6347c34wZyqIgc8Uw870qtXWbpWr
	xqqDLbvmozxrLxXmiUPLt5GIfsdZbYWcc13UPJ/bxVgpsVIbCi+gy4dwuKbo7c8VKzuVlSMn5zT
	3V8KelwBa6Ecs4xMX6eg1p/VgM8Q=
X-Google-Smtp-Source: AGHT+IHeo2eFRVDPLyTUMj1C1RCH5kha6fEXj7L22P2UXlBqSz8PZRrp4czpz9v7jOO0g65FW3OSm7tmiXe6wvwJeZ4=
X-Received: by 2002:a05:6214:5b02:b0:6b9:299b:94ba with SMTP id
 6a1803df08f44-6bd78efbaa9mr39034886d6.46.1723243084796; Fri, 09 Aug 2024
 15:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv8099vms.fsf@gitster.g>
In-Reply-To: <xmqqv8099vms.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 9 Aug 2024 18:37:52 -0400
Message-ID: <CAPig+cRYOe7dQg7qwHmHZW9WfVGJ68wWSQHikz-v+_ZhhTkG3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] remerge-diff: lazily prpare temporary objdir on demand
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, blanet <bupt_xingxin@163.com>, 
	Xing Xin <xingxin.xx@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 6:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> remerge-diff: lazily prpare temporary objdir on demand

s/prpare/prepare/

> It is error prone for each caller that sets revs.remerge_diff bit
> to be responsible for preparing a temporary object directory and
> rotate it into the list of alternate object stores, making it the
> primary object store.
>
> Instead, remove the code to set up and arrange the temporary object
> directory from the current callers and implement it in the code that
> runs remerge-diff logic.  The code to undo the futzing of the list
> of alternate object store is still spread across the callers, but we
> will deal with it in future steps.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
