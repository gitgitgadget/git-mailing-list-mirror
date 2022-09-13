Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB81ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIMSVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIMSU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:20:57 -0400
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C497511A07
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663090442; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=M2NszVsfWJPtjOv3IdajyNLZfjqkgiwMolC0CiWp43QEllfIdizkwDqdU9hgR07JfgrG07cZuKaVwsxCRJPLe2BysmCfFRR0JxSfLWmjn9Zx9Xp1scL9lgyZtZ3m4wrZLHqsmF88Uqh0WZZ9UdEfFChVoPoQ+oSJC14CHmPZrAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1663090442; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=2hvHTITcs+IToSErpyHEejXhSeJBQBDdOHYIekH52uw=; 
        b=aa2uwfx50Epd/uUj41Z9byJi3WGSnqRuz7Uvg2pr4hWtHwJkVkPnNwDaOScyn5GbtwRoaTgCGXqLlEX12+8OgRG6JAOf+Gh5tICn+Ln5v33/Lai7ELpvpCL1DuJr2ggXF8uip7dmHduUBQNcjkRxOhxBkGSZlNn9OC8ayBBUQuk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 166309044238017.033840350852415; Tue, 13 Sep 2022 10:34:02 -0700 (PDT)
Date:   Tue, 13 Sep 2022 10:34:02 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "git" <git@vger.kernel.org>, "hanwen" <hanwen@google.com>
Message-ID: <18337ea407a.10c144c52599576.4708941661785569426@elijahpepe.com>
In-Reply-To: <xmqqbkrjb75g.fsf@gitster.g>
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com> <xmqqbkrjb75g.fsf@gitster.g>
Subject: Re: [PATCH] reftable: pass pq_entry by address
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
 > Do we have any hard guidance like "do not pass an data item whose
 > size is larger than 64 bytes" in our coding guidelines?  If not,
 > make sure that the reference to 64 bytes does not look like one.
While we don't have hard guidance like that, putting an object that exceeds 64 bytes on the stack is dangerous.

 > In any case, wouldn't it make sense to make the "we pass reference
 > not because we want to let the callee modify the value, but because
 > the callee deep in the callchain wants to copy the contents out of
 > it" parameter a pointer to a constant? 
Yes. I overlooked that making this change. Feel free to make that change, otherwise I'll do it myself.
