Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B30CE7A8B
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 12:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjIWMcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjIWMco (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 08:32:44 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C8127
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 05:32:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7740c520847so219739885a.2
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695472358; x=1696077158; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHzgAumK5f1tSEbwCruunAzvwCWPW1FKuyahR//M4iw=;
        b=fHtXNmihs2/WvTOATqaMXCONt1oM9Z4Pn0MZsnXkzTYh7+JNJm/bsmIilfTQHMmwE4
         GfIplwWLASgridzUe77OxdczHg3+fkx7dNneIgHY1MTT4sdXd52lUkRL8yaE9kmL/q6P
         BpSbPjrIk/1NUob+dwndN9KdqWWKQjWeeRweQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695472358; x=1696077158;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHzgAumK5f1tSEbwCruunAzvwCWPW1FKuyahR//M4iw=;
        b=Af5GHRVRJUh4zIaas4Fb7880KbzJQYsLV6C+uZ3LJF4UyNnc1GUHqSBGqYpJAnzVN+
         3Uh6xyfNm5oecTsOWSfrlDU13CrSssgUtGJuoYP+P6ydKivQy51WIOA47lZdQ/7NN42f
         zZrYByWj8FwSKuPU2eFhw9SWNNG6zVjziPDLWdloW1ofGwMVzy9FYKc9LsN632d5hbtJ
         B6bN6fED36PPrbjveJsx5qg186FzKOvKgtPMFCisxKWCu+PHxLVU/dpDW7mhZZ/ZS8t1
         7VBcpc9nT4V1TPMPvIwO0ahKV57i1UkPzdx8nVVyjs/ztwwK8l/DIWEmyaecK5fCPCRr
         MeOw==
X-Gm-Message-State: AOJu0YyVJSjKTmWFcuzAiyurISPcYTWd62zv/bpL7drz/b4X1kGZ0NOE
        ElZUWrhbxfCHX6XIxxxOs3lDmJLctWlCwpWfstssSg==
X-Google-Smtp-Source: AGHT+IFjBJkuVrHMNJUz9CmTpS0V+nxumsB0LL93ZpRQek0i4dFBHSKeNmdHPqmxrECtHU7gXx3krw==
X-Received: by 2002:a05:620a:2f2:b0:770:fc39:25e4 with SMTP id a18-20020a05620a02f200b00770fc3925e4mr1953281qko.45.1695472357843;
        Sat, 23 Sep 2023 05:32:37 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a16a300b0076daaccb7f7sm452018qkj.135.2023.09.23.05.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 05:32:37 -0700 (PDT)
Date:   Sat, 23 Sep 2023 08:32:36 -0400
From:   'Ben Boeckel' <ben.boeckel@kitware.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ7a5FOHGNuHFif1@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
 <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
 <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 13:14:30 -0400, rsbecker@nexbridge.com wrote:
> There appears to be a merge at 446120fd88 which brings v9.3.0.rc0
> closer to HEAD than v9.3.0.rc1.

I'll also note that `.rc0` was added as a fix for the situation of
`.rc1` not being found properly. Without that, it finds `v9.2.6` as the
"closest" tag.

--Ben
